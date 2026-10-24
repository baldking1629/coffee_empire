import 'dart:math' as math;

import 'package:equatable/equatable.dart';

import '../config/economy_config.dart';
import '../core/bignumber/big_number.dart';
import 'shop_math.dart';

enum FlavorAttribute { acidity, body, aroma, caffeine }

enum HintDirection { tooLow, tooHigh, onTrack }

class BrewHint extends Equatable {
  const BrewHint({required this.direction, this.attribute});

  factory BrewHint.fromJson(Map<String, dynamic> json) {
    final attribute = json['attribute'] as String?;
    return BrewHint(
      direction: HintDirection.values.byName(json['direction'] as String),
      attribute: attribute == null
          ? null
          : FlavorAttribute.values.byName(attribute),
    );
  }

  static const BrewHint onTrack = BrewHint(direction: HintDirection.onTrack);

  final HintDirection direction;
  final FlavorAttribute? attribute;

  Map<String, dynamic> toJson() => {
    'direction': direction.name,
    if (attribute != null) 'attribute': attribute?.name,
  };

  @override
  List<Object?> get props => [direction, attribute];
}

class BrewResult extends Equatable {
  const BrewResult({required this.score, required this.hint});

  final int score;
  final BrewHint hint;

  @override
  List<Object?> get props => [score, hint];
}

class LabMath {
  const LabMath({required this.lab, required this.capsule});

  final LabConfig lab;
  final CapsuleConfig capsule;

  BrewResult evaluate(RecipeConfig recipe, FlavorProfile sliders) {
    final targets = recipe.target.values;
    final deltas = [
      for (var i = 0; i < targets.length; i++) sliders.values[i] - targets[i],
    ];
    final averageError =
        deltas.fold<int>(0, (sum, d) => sum + d.abs()) / deltas.length;
    final penalty =
        math.max(0, averageError - recipe.tolerance) * lab.scorePenaltyPerPoint;
    final score = (100 - penalty).round().clamp(0, 100);
    return BrewResult(score: score, hint: _hint(deltas, recipe.tolerance));
  }

  BrewHint _hint(List<int> deltas, double tolerance) {
    var worst = 0;
    for (var i = 1; i < deltas.length; i++) {
      if (deltas[i].abs() > deltas[worst].abs()) worst = i;
    }
    final error = deltas[worst];
    if (error.abs() <= tolerance) return BrewHint.onTrack;
    return BrewHint(
      attribute: FlavorAttribute.values[worst],
      direction: error < 0 ? HintDirection.tooLow : HintDirection.tooHigh,
    );
  }

  double recipeBonus(RecipeConfig recipe, int bestScore) {
    final quality = bestScore.clamp(0, 100) / 100;
    return recipe.maxBonus * quality * quality;
  }

  double _bonusSum(Map<String, int> bestScores, {required bool capsules}) {
    var sum = 0.0;
    for (final recipe in lab.recipes) {
      if (recipe.isCapsule != capsules) continue;
      sum += recipeBonus(recipe, bestScores[recipe.id] ?? 0);
    }
    return sum;
  }

  BigNumber labBonusMultiplier(Map<String, int> bestScores) =>
      BigNumber.fromDouble(1 + _bonusSum(bestScores, capsules: false));

  double capsuleBonus(Map<String, int> bestScores) =>
      _bonusSum(bestScores, capsules: true);

  BigNumber testCost(RecipeConfig recipe, BigNumber incomePerSec) =>
      (incomePerSec * BigNumber.fromDouble(recipe.testCostSeconds)).clampMin(
        lab.testCostFloor,
      );

  bool isCapsuleUnlocked(Map<String, int> bestScores, int brandHype) =>
      brandHype >= capsule.unlockHype &&
      bestScores.values.any((score) => score >= capsule.unlockScore);

  GeometricCost get machineCost =>
      GeometricCost(capsule.machineBaseCost, capsule.machineCostGrowth);

  BigNumber capsuleIncomePerSec(int machines, Map<String, int> bestScores) {
    if (machines <= 0) return BigNumber.zero;
    return BigNumber.fromInt(machines) *
        capsule.machineIncome *
        BigNumber.fromDouble(1 + capsuleBonus(bestScores));
  }
}
