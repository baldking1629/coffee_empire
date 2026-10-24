import 'package:equatable/equatable.dart';

import '../config/economy_config.dart';
import '../core/bignumber/big_number.dart';

class ActiveBoost extends Equatable {
  const ActiveBoost({required this.type, required this.endsAt});

  factory ActiveBoost.fromJson(Map<String, dynamic> json) => ActiveBoost(
    type: json['type'] as String,
    endsAt: DateTime.parse(json['endsAt'] as String).toUtc(),
  );

  static const String caffeineRush = 'caffeine_rush';

  final String type;
  final DateTime endsAt;

  bool isActive(DateTime now) => now.isBefore(endsAt);

  Map<String, dynamic> toJson() => {
    'type': type,
    'endsAt': endsAt.toUtc().toIso8601String(),
  };

  @override
  List<Object?> get props => [type, endsAt];
}

class BoostMath {
  const BoostMath({required this.rewarded, required this.iap});

  final RewardedConfig rewarded;
  final IapConfig iap;

  double boostMultiplier(List<ActiveBoost> boosts, DateTime now) {
    final rushActive = boosts.any(
      (boost) => boost.type == ActiveBoost.caffeineRush && boost.isActive(now),
    );
    return rushActive ? rewarded.caffeineRushMultiplier : 1;
  }

  DateTime extendCaffeineRush(DateTime? currentEndsAt, DateTime now) {
    final start = currentEndsAt != null && currentEndsAt.isAfter(now)
        ? currentEndsAt
        : now;
    final extended = start.add(Duration(seconds: rewarded.caffeineRushSeconds));
    final limit = now.add(Duration(seconds: rewarded.caffeineRushMaxSeconds));
    return extended.isAfter(limit) ? limit : extended;
  }

  bool isOnCooldown(DateTime? cooldownEndsAt, DateTime now) =>
      cooldownEndsAt != null && now.isBefore(cooldownEndsAt);

  DateTime cooldownEnd(DateTime now) =>
      now.add(Duration(seconds: rewarded.cooldownSeconds));

  BigNumber emergencyFund(BigNumber incomePerSec) =>
      (incomePerSec * BigNumber.fromDouble(rewarded.emergencyFundSeconds))
          .clampMin(rewarded.emergencyFundMin);

  double vipMultiplier({required bool vip}) =>
      vip ? iap.vipIncomeMultiplier : 1;

  double starterPackMultiplier({required bool owned}) =>
      owned ? iap.starterPackIncomeMultiplier : 1;

  BigNumber incomeFor(BigNumber incomePerSec, double seconds) =>
      incomePerSec * BigNumber.fromDouble(seconds);
}
