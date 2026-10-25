part of 'game_cubit.dart';

class ServeResult {
  const ServeResult({
    required this.amount,
    required this.perfect,
    required this.rushStarted,
  });

  final BigNumber amount;
  final bool perfect;
  final bool rushStarted;
}

mixin _ServiceCommands on _GameCubitCore {
  ServiceMath get _service => engine.serviceMath;

  List<String> availableDrinks([GameState? source]) {
    final current = source ?? state;
    final shops = engine.config.shops;
    return [
      for (final drink in engine.config.service.drinks)
        if (drink.unlockShopIndex == 0 ||
            (drink.unlockShopIndex < shops.length &&
                (current.shopLevels[shops[drink.unlockShopIndex].id] ?? 0) > 0))
          drink.id,
    ];
  }

  int get hiredManagers => state.managers.values.where((hired) => hired).length;

  void takeOrder() => _play(FeedbackKind.orderTaken);

  bool brewTap() {
    final rushActive = state.barista.isRushActive(clock.now());
    final filled =
        state.barista.cupFill + _service.brewStep(rushActive: rushActive);
    // Epsilon absorbs floating-point drift from repeated 0.1 steps.
    final full = filled >= 1 - 1e-9;
    final stats = state.stats.copyWith(
      totalTaps: state.stats.totalTaps + 1,
      cupsFilled: state.stats.cupsFilled + (full ? 1 : 0),
    );
    _play(full ? FeedbackKind.cupFull : FeedbackKind.tap);
    emit(
      _evaluateProgress(
        state.copyWith(
          stats: stats,
          barista: state.barista.copyWith(cupFill: full ? 0 : filled),
        ),
      ),
    );
    return full;
  }

  void resetBrew() {
    if (state.barista.cupFill == 0) return;
    emit(state.copyWith(barista: state.barista.copyWith(cupFill: 0)));
  }

  ServeResult serveOrder({
    required String drinkId,
    required double patienceRatio,
    required bool byBarista,
    bool vipBarista = false,
  }) {
    final drink = engine.config.service.drinkById(drinkId);
    final drinkMult = drink?.drinkMult ?? 1;
    final now = clock.now();
    if (byBarista) {
      final amount = _service.autoServePayout(
        incomePerSec: state.incomePerSec,
        drinkMult: drinkMult,
        vip: vipBarista,
      );
      _finishServe(amount, drinkId, perfect: false, byBarista: true);
      return ServeResult(amount: amount, perfect: false, rushStarted: false);
    }
    final payout = _service.playerPayout(
      incomePerSec: state.incomePerSec,
      drinkMult: drinkMult,
      patienceRatio: patienceRatio,
      rushActive: state.barista.isRushActive(now),
    );
    final delivery = _service.registerDelivery(state.barista, now);
    emit(state.copyWith(barista: delivery.barista));
    _play(FeedbackKind.serve);
    _finishServe(
      payout.amount,
      drinkId,
      perfect: payout.perfect,
      byBarista: false,
    );
    return ServeResult(
      amount: payout.amount,
      perfect: payout.perfect,
      rushStarted: delivery.rushStarted,
    );
  }

  void customerLost() {
    _play(FeedbackKind.customerLost);
    _log(AnalyticsEvents.customerLost);
    emit(
      state.copyWith(
        barista: _service.breakCombo(state.barista),
        stats: state.stats.copyWith(
          customersLost: state.stats.customersLost + 1,
        ),
      ),
    );
  }

  void _finishServe(
    BigNumber amount,
    String drinkId, {
    required bool perfect,
    required bool byBarista,
  }) {
    _log(AnalyticsEvents.orderServed, {
      'drinkId': drinkId,
      'perfect': perfect,
      'byBarista': byBarista,
    });
    emit(
      _evaluateProgress(
        state
            .earn(amount)
            .copyWith(
              stats: state.stats.copyWith(
                ordersServed: state.stats.ordersServed + (byBarista ? 0 : 1),
                perfectServes: state.stats.perfectServes + (perfect ? 1 : 0),
              ),
            ),
      ),
    );
  }
}
