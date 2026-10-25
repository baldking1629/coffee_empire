import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../core/bignumber/big_number.dart';
import '../engine/cafe_customer.dart';
import '../features/game/game_cubit.dart';
import '../features/game/game_state.dart';
import 'cafe_game.dart';

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

typedef StaffSetup = ({int npc, bool vip, List<String> drinks, int managers});

class CafeBridge {
  CafeBridge({required this.cubit});

  final GameCubit cubit;
  final ValueNotifier<PlayerOrder?> playerOrder = ValueNotifier(null);
  String Function(BigNumber amount) formatGain = _plainGain;
  String perfectLabel = '';
  bool reduceMotion = false;
  CafeGame? _game;
  StreamSubscription<GameState>? _subscription;
  StaffSetup? _staff;

  static String _plainGain(BigNumber amount) => amount.toJson();

  bool get isBrewing {
    final order = playerOrder.value;
    return order != null && !order.ready;
  }

  void attach(CafeGame game) {
    _game = game;
    _syncStaff(cubit.state);
    _subscription = cubit.stream.listen(_syncStaff);
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
    );
    if (setup == _staff) return;
    _staff = setup;
    game
      ..drinks = setup.drinks
      ..arrivalSeconds = service.arrivalSeconds(0)
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
  }
}
