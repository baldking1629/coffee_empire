import 'package:equatable/equatable.dart';

import '../core/bignumber/big_number.dart';
import 'json_readers.dart';

class ShopConfig extends Equatable {
  const ShopConfig({
    required this.id,
    required this.baseCost,
    required this.baseIncome,
    required this.growth,
  });

  factory ShopConfig.fromJson(JsonMap json) => ShopConfig(
    id: readString(json, 'id'),
    baseCost: readBig(json, 'baseCost'),
    baseIncome: readBig(json, 'baseIncome'),
    growth: readDouble(json, 'growth'),
  );

  final String id;
  final BigNumber baseCost;
  final BigNumber baseIncome;
  final double growth;

  @override
  List<Object?> get props => [id, baseCost, baseIncome, growth];
}

class ShopRulesConfig extends Equatable {
  const ShopRulesConfig({
    required this.milestoneLevels,
    required this.milestoneMultiplier,
    required this.managerCostMultiplier,
    required this.managerIncomeMultiplier,
    required this.equipmentCostMultipliers,
    required this.equipmentIncomeMultiplier,
  });

  factory ShopRulesConfig.fromJson(JsonMap json) => ShopRulesConfig(
    milestoneLevels: readIntList(json, 'milestoneLevels'),
    milestoneMultiplier: readDouble(json, 'milestoneMultiplier'),
    managerCostMultiplier: readDouble(json, 'managerCostMultiplier'),
    managerIncomeMultiplier: readDouble(json, 'managerIncomeMultiplier'),
    equipmentCostMultipliers: readDoubleList(json, 'equipmentCostMultipliers'),
    equipmentIncomeMultiplier: readDouble(json, 'equipmentIncomeMultiplier'),
  );

  final List<int> milestoneLevels;
  final double milestoneMultiplier;
  final double managerCostMultiplier;
  final double managerIncomeMultiplier;
  final List<double> equipmentCostMultipliers;
  final double equipmentIncomeMultiplier;

  @override
  List<Object?> get props => [
    milestoneLevels,
    milestoneMultiplier,
    managerCostMultiplier,
    managerIncomeMultiplier,
    equipmentCostMultipliers,
    equipmentIncomeMultiplier,
  ];
}

class TapConfig extends Equatable {
  const TapConfig({
    required this.tapFillStep,
    required this.tapPayoutSeconds,
    required this.minTapPayout,
    required this.comboWindowSeconds,
    required this.rushComboThreshold,
    required this.rushDurationSeconds,
    required this.rushMultiplier,
    required this.autoTapPerSecond,
  });

  factory TapConfig.fromJson(JsonMap json) => TapConfig(
    tapFillStep: readDouble(json, 'tapFillStep'),
    tapPayoutSeconds: readDouble(json, 'tapPayoutSeconds'),
    minTapPayout: readBig(json, 'minTapPayout'),
    comboWindowSeconds: readDouble(json, 'comboWindowSeconds'),
    rushComboThreshold: readInt(json, 'rushComboThreshold'),
    rushDurationSeconds: readDouble(json, 'rushDurationSeconds'),
    rushMultiplier: readDouble(json, 'rushMultiplier'),
    autoTapPerSecond: readDouble(json, 'autoTapPerSecond'),
  );

  final double tapFillStep;
  final double tapPayoutSeconds;
  final BigNumber minTapPayout;
  final double comboWindowSeconds;
  final int rushComboThreshold;
  final double rushDurationSeconds;
  final double rushMultiplier;
  final double autoTapPerSecond;

  @override
  List<Object?> get props => [
    tapFillStep,
    tapPayoutSeconds,
    minTapPayout,
    comboWindowSeconds,
    rushComboThreshold,
    rushDurationSeconds,
    rushMultiplier,
    autoTapPerSecond,
  ];
}
