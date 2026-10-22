import 'package:equatable/equatable.dart';

import '../core/bignumber/big_number.dart';
import 'json_readers.dart';

class FlavorProfile extends Equatable {
  const FlavorProfile({
    required this.acidity,
    required this.body,
    required this.aroma,
    required this.caffeine,
  });

  factory FlavorProfile.fromJson(JsonMap json) => FlavorProfile(
    acidity: readInt(json, 'acidity'),
    body: readInt(json, 'body'),
    aroma: readInt(json, 'aroma'),
    caffeine: readInt(json, 'caffeine'),
  );

  final int acidity;
  final int body;
  final int aroma;
  final int caffeine;

  JsonMap toJson() => {
    'acidity': acidity,
    'body': body,
    'aroma': aroma,
    'caffeine': caffeine,
  };

  @override
  List<Object?> get props => [acidity, body, aroma, caffeine];
}

class RecipeConfig extends Equatable {
  const RecipeConfig({
    required this.id,
    required this.nameKey,
    required this.unlockCost,
    required this.target,
    required this.tolerance,
    required this.testDurationSeconds,
    required this.testCostSeconds,
    required this.maxBonus,
    required this.isCapsule,
  });

  factory RecipeConfig.fromJson(JsonMap json) => RecipeConfig(
    id: readString(json, 'id'),
    nameKey: readString(json, 'nameKey'),
    unlockCost: readBig(json, 'unlockCost'),
    target: FlavorProfile.fromJson(readMap(json, 'target')),
    tolerance: readDouble(json, 'tolerance'),
    testDurationSeconds: readInt(json, 'testDurationSeconds'),
    testCostSeconds: readDouble(json, 'testCostSeconds'),
    maxBonus: readDouble(json, 'maxBonus'),
    isCapsule: json['isCapsule'] as bool,
  );

  final String id;
  final String nameKey;
  final BigNumber unlockCost;
  final FlavorProfile target;
  final double tolerance;
  final int testDurationSeconds;
  final double testCostSeconds;
  final double maxBonus;
  final bool isCapsule;

  @override
  List<Object?> get props => [
    id,
    nameKey,
    unlockCost,
    target,
    tolerance,
    testDurationSeconds,
    testCostSeconds,
    maxBonus,
    isCapsule,
  ];
}

class LabConfig extends Equatable {
  const LabConfig({
    required this.testCostFloor,
    required this.scorePenaltyPerPoint,
    required this.recipes,
  });

  factory LabConfig.fromJson(JsonMap json) => LabConfig(
    testCostFloor: readBig(json, 'testCostFloor'),
    scorePenaltyPerPoint: readDouble(json, 'scorePenaltyPerPoint'),
    recipes: readList(json, 'recipes', RecipeConfig.fromJson),
  );

  final BigNumber testCostFloor;
  final double scorePenaltyPerPoint;
  final List<RecipeConfig> recipes;

  @override
  List<Object?> get props => [testCostFloor, scorePenaltyPerPoint, recipes];
}

class CapsuleConfig extends Equatable {
  const CapsuleConfig({
    required this.unlockScore,
    required this.unlockHype,
    required this.machineBaseCost,
    required this.machineCostGrowth,
    required this.machineIncome,
  });

  factory CapsuleConfig.fromJson(JsonMap json) => CapsuleConfig(
    unlockScore: readInt(json, 'unlockScore'),
    unlockHype: readInt(json, 'unlockHype'),
    machineBaseCost: readBig(json, 'machineBaseCost'),
    machineCostGrowth: readDouble(json, 'machineCostGrowth'),
    machineIncome: readBig(json, 'machineIncome'),
  );

  final int unlockScore;
  final int unlockHype;
  final BigNumber machineBaseCost;
  final double machineCostGrowth;
  final BigNumber machineIncome;

  @override
  List<Object?> get props => [
    unlockScore,
    unlockHype,
    machineBaseCost,
    machineCostGrowth,
    machineIncome,
  ];
}
