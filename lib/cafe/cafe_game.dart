import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';

import '../app/theme/app_colors.dart';
import '../config/cafe_config.dart';
import '../engine/cafe_customer.dart';
import '../engine/cafe_floor_plan.dart';
import '../engine/cafe_layout.dart';
import '../engine/customer_flow.dart';
import '../pixel/sprite_atlas.dart';
import 'actors/barista_component.dart';
import 'actors/customer_component.dart';
import 'camera_fit.dart';
import 'edit/edit_mode_controller.dart';
import 'edit/placement_ghost.dart';
import 'cafe_bridge.dart';
import 'world/cafe_room_layer.dart';
import 'world/machine_component.dart';
import 'world/scene_effects.dart';

class CafeGame extends FlameGame {
  CafeGame({
    required this.atlas,
    required this.catalog,
    required this.service,
    required this.bridge,
    required CafeRoom room,
    required List<LayoutItem> items,
    Random? random,
  }) : _random = random ?? Random(),
       _roomLayer = CafeRoomLayer(
         atlas: atlas,
         catalog: catalog,
         room: room,
         items: items,
       ) {
    flow = _newFlow(room, items);
  }

  final SpriteAtlas atlas;
  final CafeCatalog catalog;
  final ServiceConfig service;
  final CafeBridge bridge;
  final Random _random;
  final CafeRoomLayer _roomLayer;
  late CustomerFlow flow;
  EditOverlay? _editOverlay;
  final Map<int, CustomerComponent> _customers = {};
  final List<BaristaComponent> _workers = [];
  late final BaristaComponent _player;
  late final MachineComponent _machine;
  List<String> drinks = const [];
  double arrivalSeconds = 6;
  double autoServeSeconds = 8;
  int _npcBaristas = 0;
  bool _vipBarista = false;
  bool _loaded = false;

  CafeRoom get room => _roomLayer.room;

  bool get isEditing => _editOverlay != null;

  Iterable<CustomerComponent> get customerComponents => _customers.values;

  int get visibleWorkers => _workers.length;

  @override
  Color backgroundColor() => AppColors.backgroundBottom;

  @override
  Future<void> onLoad() async {
    camera.viewfinder.anchor = Anchor.topLeft;
    world.add(_roomLayer);
    world.add(_machine = MachineComponent(atlas: atlas, cell: room.machine));
    world.add(
      _player = BaristaComponent(
        atlas: atlas,
        station: room.playerStation,
        machine: room.machine,
      ),
    );
    _loaded = true;
    _rebuildWorkers();
    bridge.attach(this);
    _fitCamera(size);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    if (isLoaded) _fitCamera(size);
  }

  void _fitCamera(Vector2 viewSize) {
    if (viewSize.x <= 0 || viewSize.y <= 0) return;
    final fit = CameraFit.compute(
      viewWidth: viewSize.x,
      viewHeight: viewSize.y,
      cols: room.cols,
      rows: room.rows,
    );
    camera.viewfinder
      ..zoom = fit.scale.toDouble()
      ..position = Vector2(-fit.offsetX, -fit.offsetY);
  }

  void configureStaff({required int npcBaristas, required bool vip}) {
    if (npcBaristas == _npcBaristas && vip == _vipBarista) return;
    _npcBaristas = npcBaristas;
    _vipBarista = vip;
    flow.setBaristaCount(npcBaristas + (vip ? 1 : 0));
    if (_loaded) _rebuildWorkers();
  }

  bool isVipWorker(int index) =>
      _vipBarista && index == flow.baristas.length - 1;

  void _rebuildWorkers() {
    for (final worker in _workers) {
      worker.removeFromParent();
    }
    _workers.clear();
    final stations = room.baristaStations;
    for (var i = 0; i < flow.baristas.length; i++) {
      final vip = isVipWorker(i);
      final station = vip ? stations.last : stations[i % stations.length];
      final worker = BaristaComponent(
        atlas: atlas,
        station: station,
        machine: room.machine,
        outfit: vip ? BaristaComponent.vipOutfit : 'base',
      );
      _workers.add(worker);
      world.add(worker);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    final events = flow.update(
      dt,
      spawning: !isEditing,
      drinks: drinks,
      arrivalSeconds: arrivalSeconds,
      autoServeSeconds: autoServeSeconds,
    );
    for (final event in events) {
      bridge.handleFlowEvent(event);
    }
    _syncCustomers();
    _player.showPlayer(isBrewing: bridge.isBrewing);
    var anyWorkerBrewing = false;
    for (var i = 0; i < _workers.length && i < flow.baristas.length; i++) {
      final worker = flow.baristas[i];
      _workers[i].showWorker(worker);
      if (worker.isBusy && worker.progress >= 0.25 && worker.progress < 0.75) {
        anyWorkerBrewing = true;
      }
    }
    _machine.brewing = bridge.isBrewing || anyWorkerBrewing;
  }

  void _syncCustomers() {
    final alive = {for (final customer in flow.customers) customer.id};
    for (final id in _customers.keys.toList()) {
      if (!alive.contains(id)) _customers.remove(id)?.removeFromParent();
    }
    for (final customer in flow.customers) {
      final component = _customers.putIfAbsent(customer.id, () {
        final created = CustomerComponent(
          atlas: atlas,
          customer: customer,
          drinkIconId:
              service.drinkById(customer.drinkId)?.iconSpriteId ??
              'drink_espresso',
          onTapped: bridge.onCustomerTapped,
        )..customerPatienceSeconds = service.patienceSeconds;
        world.add(created);
        return created;
      });
      component.sync();
    }
  }

  CustomerFlow _newFlow(CafeRoom room, List<LayoutItem> items) => CustomerFlow(
    config: service,
    plan: CafeFloorPlan.build(
      room: room,
      items: items,
      catalog: catalog,
      laneLength: service.queueCapacity,
    ),
    random: _random,
  )..setBaristaCount(_npcBaristas + (_vipBarista ? 1 : 0));

  void applyLayout(CafeRoom room, List<LayoutItem> items) {
    resetCafe();
    final resized = room.cols != this.room.cols || room.rows != this.room.rows;
    _roomLayer.rebuild(room, items);
    flow = _newFlow(room, items);
    _editOverlay?.grid.resize(room);
    if (resized && isLoaded) _fitCamera(size);
  }

  void setEditing(EditModeController? controller) {
    _editOverlay?.removeFromParent();
    _editOverlay = null;
    if (controller == null) return;
    resetCafe();
    final overlay = EditOverlay(
      atlas: atlas,
      catalog: catalog,
      controller: controller,
      onHide: _roomLayer.hide,
      room: room,
    );
    _editOverlay = overlay;
    world.add(overlay);
  }

  void resetCafe() {
    flow.clear();
    for (final component in _customers.values) {
      component.removeFromParent();
    }
    _customers.clear();
  }

  late final SceneEffects effects = SceneEffects(
    atlas: atlas,
    world: world,
    viewfinder: camera.viewfinder,
  );

  void showServe(
    CafeCustomer customer, {
    required String gainText,
    required String? perfectText,
    required bool shake,
    required bool reduceMotion,
  }) => effects.serve(
    customer,
    gainText: gainText,
    perfectText: perfectText,
    shake: shake,
    reduceMotion: reduceMotion,
  );

  void showLost(CafeCustomer customer) => effects.lost(customer);
}
