import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

import '../config/economy_config.dart';

import '../core/bignumber/big_number.dart';
import '../engine/cafe_customer.dart';
import '../engine/cafe_layout.dart';
import '../features/game/game_cubit.dart';
import '../features/game/game_state.dart';
import '../pixel/palette_set.dart';
import 'cafe_game.dart';
import 'scene_look.dart';
import 'world/cafe_room_layer.dart';
import 'edit/edit_mode_controller.dart';

class PlayerOrder extends Equatable {
  const PlayerOrder({
    required this.customerId,
    required this.drinkId,
    this.ready = false,
  });

  final int customerId;
  final String drinkId;
  final bool ready;

  PlayerOrder readied() =>
      PlayerOrder(customerId: customerId, drinkId: drinkId, ready: true);

  @override
  List<Object?> get props => [customerId, drinkId, ready];
}

typedef StaffSetup = ({
  int npc,
  bool vip,
  List<String> drinks,
  int managers,
  int appeal,
});

class CafeBridge {
  CafeBridge({required this.cubit}) : editor = EditModeController(cubit: cubit);

  final GameCubit cubit;
  final EditModeController editor;
  final ValueNotifier<PlayerOrder?> playerOrder = ValueNotifier(null);
  String Function(BigNumber amount) formatGain = _plainGain;
  String perfectLabel = '';
  bool reduceMotion = false;
  CafeGame? _game;
  StreamSubscription<GameState>? _subscription;
  StaffSetup? _staff;
  CafeLayout? _layout;
  SceneLook? _look;

  static String _plainGain(BigNumber amount) => amount.toJson();

  bool get isBrewing {
    final order = playerOrder.value;
    return order != null && !order.ready;
  }

  void attach(CafeGame game) {
    _game = game;
    _layout = cubit.state.cafeLayout;
    _onState(cubit.state);
    _subscription = cubit.stream.listen(_onState);
  }

  void _onState(GameState state) {
    _syncLayout(state);
    _syncStaff(state);
    _syncLook(state);
  }

  void _syncLook(GameState state) {
    final game = _game;
    if (game == null) return;
    final look = lookOf(game, state);
    if (look == _look) return;
    final first = _look == null;
    _look = look;
    game.applyLook(look, celebrate: !first);
  }

  SceneLook lookOf(CafeGame game, GameState state) {
    String setOf(CosmeticConfig? cosmetic) =>
        cosmetic?.paletteSetId ?? PaletteCatalog.baseSet;
    final floor = cubit.cosmeticsRules.equipped(
      state.cosmetics,
      CosmeticType.floor,
    );
    final wall = cubit.cosmeticsRules.equipped(
      state.cosmetics,
      CosmeticType.wall,
    );
    final sign = cubit.cosmeticsRules.equipped(
      state.cosmetics,
      CosmeticType.sign,
    );
    final light = cubit.cosmeticsRules.equipped(
      state.cosmetics,
      CosmeticType.light,
    );
    final slots = cubit.engine.config.cosmetics.outfitSlots;
    String outfit(String slot) =>
        setOf(cubit.cosmeticsRules.outfitFor(state.cosmetics, slot));
    final tint =
        game.atlas.palettes.resolve(
          PaletteCatalog.keyOf([setOf(light)]),
        )[lightTintSlot] ??
        const Color(0xFFFFFFFF);
    return SceneLook(
      floorPaletteKey: PaletteCatalog.keyOf([setOf(floor), setOf(wall)]),
      signSpriteId: sign?.spriteId ?? CafeRoomLayer.signFixtureSprite,
      lightTint: tint,
      lightIntensity: light?.intensity ?? 0,
      playerOutfit: slots.isEmpty
          ? PaletteCatalog.baseSet
          : outfit(slots.first),
      npcOutfits: [for (final slot in slots.skip(1)) outfit(slot)],
      machineLevel: cubit.visibleEquipmentLevel,
    );
  }

  static const String lightTintSlot = 'light_tint';

  void _syncLayout(GameState state) {
    final game = _game;
    if (game == null || state.cafeLayout == _layout) return;
    _layout = state.cafeLayout;
    playerOrder.value = null;
    game.applyLayout(cubit.cafeRoom, state.cafeLayout.items);
    editor.refresh();
  }

  void setEditing(bool editing) {
    final game = _game;
    if (editing) {
      editor.enter();
      playerOrder.value = null;
      cubit.resetBrew();
    } else {
      editor.exit();
    }
    game?.setEditing(editing ? editor : null);
  }

  void _syncStaff(GameState state) {
    final game = _game;
    if (game == null) return;
    final managers = state.managers.values.where((hired) => hired).length;
    final service = cubit.engine.serviceMath;
    final setup = (
      npc: service.visibleBaristas(managers),
      vip: state.store.isVip,
      drinks: cubit.availableDrinks(state),
      managers: managers,
      appeal: cubit.totalAppealOf(state),
    );
    if (setup == _staff) return;
    _staff = setup;
    game
      ..drinks = setup.drinks
      ..arrivalSeconds = service.arrivalSeconds(setup.appeal.toDouble())
      ..autoServeSeconds = service.autoServeSeconds(managers)
      ..configureStaff(npcBaristas: setup.npc, vip: setup.vip);
  }

  void onCustomerTapped(int customerId) {
    final game = _game;
    if (game == null) return;
    final order = playerOrder.value;
    if (order == null) {
      if (!game.flow.claimForPlayer(customerId)) return;
      final customer = game.flow.byId(customerId);
      if (customer == null) return;
      cubit
        ..takeOrder()
        ..resetBrew();
      playerOrder.value = PlayerOrder(
        customerId: customerId,
        drinkId: customer.drinkId,
      );
      return;
    }
    if (!order.ready || order.customerId != customerId) return;
    final customer = game.flow.byId(customerId);
    final ratio = game.flow.deliverPlayerOrder(customerId);
    if (customer == null || ratio == null) return;
    playerOrder.value = null;
    final result = cubit.serveOrder(
      drinkId: order.drinkId,
      patienceRatio: ratio,
      byBarista: false,
    );
    game.showServe(
      customer,
      gainText: formatGain(result.amount),
      perfectText: result.perfect ? perfectLabel : null,
      shake: result.rushStarted,
      reduceMotion: reduceMotion,
    );
  }

  void onBrewed() {
    final order = playerOrder.value;
    if (order == null || order.ready) return;
    _game?.flow.markPlayerOrderReady();
    playerOrder.value = order.readied();
  }

  void handleFlowEvent(FlowEvent event) {
    final game = _game;
    if (game == null) return;
    switch (event) {
      case CustomerLost(:final customer):
        cubit.customerLost();
        if (playerOrder.value?.customerId == customer.id) {
          playerOrder.value = null;
          cubit.resetBrew();
        }
        game.showLost(customer);
      case BaristaServed(:final customer, :final baristaIndex):
        final result = cubit.serveOrder(
          drinkId: customer.drinkId,
          patienceRatio: 0,
          byBarista: true,
          vipBarista: game.isVipWorker(baristaIndex),
        );
        game.showServe(
          customer,
          gainText: formatGain(result.amount),
          perfectText: null,
          shake: false,
          reduceMotion: reduceMotion,
        );
      case CustomerGone():
        break;
    }
  }

  void resetCafe() {
    _game?.resetCafe();
    playerOrder.value = null;
    cubit.resetBrew();
  }

  void dispose() {
    _subscription?.cancel();
    playerOrder.dispose();
    editor.dispose();
  }
}
