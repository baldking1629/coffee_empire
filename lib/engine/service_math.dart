import 'package:equatable/equatable.dart';

import '../config/economy_config.dart';
import '../core/bignumber/big_number.dart';
import 'barista_math.dart';

class ServePayout extends Equatable {
  const ServePayout({required this.amount, required this.perfect});

  final BigNumber amount;
  final bool perfect;

  @override
  List<Object?> get props => [amount, perfect];
}

class DeliveryOutcome extends Equatable {
  const DeliveryOutcome({required this.barista, required this.rushStarted});

  final BaristaState barista;
  final bool rushStarted;

  @override
  List<Object?> get props => [barista, rushStarted];
}

class ServiceMath {
  const ServiceMath({required this.service, required this.tap});

  final ServiceConfig service;
  final TapConfig tap;

  Duration get _comboWindow =>
      Duration(milliseconds: (tap.comboWindowSeconds * 1000).round());

  Duration get _rushDuration =>
      Duration(milliseconds: (tap.rushDurationSeconds * 1000).round());

  double brewStep({required bool rushActive}) =>
      rushActive ? tap.tapFillStep * tap.rushMultiplier : tap.tapFillStep;

  bool isPerfect(double patienceRatio) =>
      patienceRatio >= service.perfectPatienceRatio;

  ServePayout playerPayout({
    required BigNumber incomePerSec,
    required double drinkMult,
    required double patienceRatio,
    required bool rushActive,
  }) {
    final perfect = isPerfect(patienceRatio);
    var amount = _baseValue(incomePerSec, drinkMult);
    if (perfect) amount *= BigNumber.fromDouble(1 + service.perfectTipRatio);
    if (rushActive) amount *= BigNumber.fromDouble(tap.rushMultiplier);
    return ServePayout(amount: amount, perfect: perfect);
  }

  BigNumber autoServePayout({
    required BigNumber incomePerSec,
    required double drinkMult,
    required bool vip,
  }) =>
      _baseValue(incomePerSec, drinkMult) *
      BigNumber.fromDouble(
        vip ? service.vipAutoServeEfficiency : service.autoServeEfficiency,
      );

  double autoServeSeconds(int managerCount) =>
      service.autoServeSeconds /
      (1 + service.managerSpeedBonus * (managerCount - 1).clamp(0, 1 << 20));

  int visibleBaristas(int managerCount) =>
      managerCount.clamp(0, service.maxVisibleBaristas);

  double arrivalSeconds(double appeal) {
    final seconds =
        service.baseArrivalSeconds / (1 + appeal * service.arrivalAppealBonus);
    return seconds < service.minArrivalSeconds
        ? service.minArrivalSeconds
        : seconds;
  }

  DeliveryOutcome registerDelivery(BaristaState current, DateTime now) {
    final rushActive = current.isRushActive(now);
    final lastDelivery = current.lastCupFilledAt;
    final withinWindow =
        lastDelivery != null &&
        !now.difference(lastDelivery).isNegative &&
        now.difference(lastDelivery) <= _comboWindow;
    final combo = withinWindow ? current.combo + 1 : 0;
    final startsRush = !rushActive && combo >= tap.rushComboThreshold;
    return DeliveryOutcome(
      barista: BaristaState(
        cupFill: current.cupFill,
        combo: startsRush ? 0 : combo,
        lastCupFilledAt: now,
        rushEndsAt: startsRush ? now.add(_rushDuration) : current.rushEndsAt,
      ),
      rushStarted: startsRush,
    );
  }

  BaristaState breakCombo(BaristaState current) =>
      current.copyWith(combo: 0, lastCupFilledAt: () => null);

  BigNumber _baseValue(BigNumber incomePerSec, double drinkMult) =>
      (incomePerSec *
              BigNumber.fromDouble(service.orderValueSeconds * drinkMult))
          .clampMin(tap.minTapPayout);
}
