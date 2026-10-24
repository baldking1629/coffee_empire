import 'package:equatable/equatable.dart';

import '../core/bignumber/big_number.dart';
import 'json_readers.dart';

class OfflineConfig extends Equatable {
  const OfflineConfig({
    required this.minAwaySeconds,
    required this.capSeconds,
    required this.vipCapSeconds,
    required this.efficiency,
  });

  factory OfflineConfig.fromJson(JsonMap json) => OfflineConfig(
    minAwaySeconds: readInt(json, 'minAwaySeconds'),
    capSeconds: readInt(json, 'capSeconds'),
    vipCapSeconds: readInt(json, 'vipCapSeconds'),
    efficiency: readDouble(json, 'efficiency'),
  );

  final int minAwaySeconds;
  final int capSeconds;
  final int vipCapSeconds;
  final double efficiency;

  @override
  List<Object?> get props => [
    minAwaySeconds,
    capSeconds,
    vipCapSeconds,
    efficiency,
  ];
}

class RewardedConfig extends Equatable {
  const RewardedConfig({
    required this.cooldownSeconds,
    required this.caffeineRushMultiplier,
    required this.caffeineRushSeconds,
    required this.caffeineRushMaxSeconds,
    required this.emergencyFundSeconds,
    required this.emergencyFundMin,
    required this.offlineDoubleMultiplier,
  });

  factory RewardedConfig.fromJson(JsonMap json) => RewardedConfig(
    cooldownSeconds: readInt(json, 'cooldownSeconds'),
    caffeineRushMultiplier: readDouble(json, 'caffeineRushMultiplier'),
    caffeineRushSeconds: readInt(json, 'caffeineRushSeconds'),
    caffeineRushMaxSeconds: readInt(json, 'caffeineRushMaxSeconds'),
    emergencyFundSeconds: readDouble(json, 'emergencyFundSeconds'),
    emergencyFundMin: readBig(json, 'emergencyFundMin'),
    offlineDoubleMultiplier: readDouble(json, 'offlineDoubleMultiplier'),
  );

  final int cooldownSeconds;
  final double caffeineRushMultiplier;
  final int caffeineRushSeconds;
  final int caffeineRushMaxSeconds;
  final double emergencyFundSeconds;
  final BigNumber emergencyFundMin;
  final double offlineDoubleMultiplier;

  @override
  List<Object?> get props => [
    cooldownSeconds,
    caffeineRushMultiplier,
    caffeineRushSeconds,
    caffeineRushMaxSeconds,
    emergencyFundSeconds,
    emergencyFundMin,
    offlineDoubleMultiplier,
  ];
}

class IapConfig extends Equatable {
  const IapConfig({
    required this.vipIncomeMultiplier,
    required this.timeSkipSeconds,
    required this.starterPackIncomeMultiplier,
    required this.starterPackCashSeconds,
  });

  factory IapConfig.fromJson(JsonMap json) => IapConfig(
    vipIncomeMultiplier: readDouble(json, 'vipIncomeMultiplier'),
    timeSkipSeconds: readDouble(json, 'timeSkipSeconds'),
    starterPackIncomeMultiplier: readDouble(
      json,
      'starterPackIncomeMultiplier',
    ),
    starterPackCashSeconds: readDouble(json, 'starterPackCashSeconds'),
  );

  final double vipIncomeMultiplier;
  final double timeSkipSeconds;
  final double starterPackIncomeMultiplier;
  final double starterPackCashSeconds;

  @override
  List<Object?> get props => [
    vipIncomeMultiplier,
    timeSkipSeconds,
    starterPackIncomeMultiplier,
    starterPackCashSeconds,
  ];
}

class DailyRewardConfig extends Equatable {
  const DailyRewardConfig({
    required this.claimableAfterSeconds,
    required this.streakResetSeconds,
    required this.daySeconds,
    required this.finalDayGoldenBeans,
    required this.minCash,
  });

  factory DailyRewardConfig.fromJson(JsonMap json) => DailyRewardConfig(
    claimableAfterSeconds: readInt(json, 'claimableAfterSeconds'),
    streakResetSeconds: readInt(json, 'streakResetSeconds'),
    daySeconds: readDoubleList(json, 'daySeconds'),
    finalDayGoldenBeans: readInt(json, 'finalDayGoldenBeans'),
    minCash: readBig(json, 'minCash'),
  );

  final int claimableAfterSeconds;
  final int streakResetSeconds;
  final List<double> daySeconds;
  final int finalDayGoldenBeans;
  final BigNumber minCash;

  @override
  List<Object?> get props => [
    claimableAfterSeconds,
    streakResetSeconds,
    daySeconds,
    finalDayGoldenBeans,
    minCash,
  ];
}
