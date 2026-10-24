import 'package:coffee_empire/config/economy_config.dart';
import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:coffee_empire/engine/lab_math.dart';
import 'package:flutter_test/flutter_test.dart';

const recipe = RecipeConfig(
  id: 'test',
  nameKey: 'recipe_test',
  unlockCost: BigNumber.zero,
  target: FlavorProfile(acidity: 50, body: 60, aroma: 70, caffeine: 80),
  tolerance: 10,
  testDurationSeconds: 60,
  testCostSeconds: 20,
  maxBonus: 0.4,
  isCapsule: false,
);

const capsuleRecipe = RecipeConfig(
  id: 'pod',
  nameKey: 'recipe_pod',
  unlockCost: BigNumber.one,
  target: FlavorProfile.neutral,
  tolerance: 5,
  testDurationSeconds: 60,
  testCostSeconds: 20,
  maxBonus: 1,
  isCapsule: true,
);

final math = LabMath(
  lab: LabConfig(
    testCostFloor: BigNumber.fromInt(10),
    scorePenaltyPerPoint: 3,
    recipes: [recipe, capsuleRecipe],
  ),
  capsule: CapsuleConfig(
    unlockScore: 80,
    unlockHype: 70,
    machineBaseCost: BigNumber.fromInt(100),
    machineCostGrowth: 1.12,
    machineIncome: BigNumber.fromInt(5),
  ),
);

void main() {
  group('score', () {
    test('within tolerance scores 100 and is on track', () {
      final result = math.evaluate(
        recipe,
        const FlavorProfile(acidity: 55, body: 52, aroma: 75, caffeine: 88),
      );
      expect(result.score, 100);
      expect(result.hint, BrewHint.onTrack);
    });

    test('far away scores low', () {
      final result = math.evaluate(
        recipe,
        const FlavorProfile(acidity: 0, body: 0, aroma: 0, caffeine: 0),
      );
      expect(result.score, 0);
    });

    test('penalty is three points per error point beyond tolerance', () {
      final result = math.evaluate(
        recipe,
        const FlavorProfile(acidity: 70, body: 80, aroma: 90, caffeine: 100),
      );
      expect(result.score, 70);
    });

    test('hint names only the worst slider and its direction', () {
      final low = math.evaluate(
        recipe,
        const FlavorProfile(acidity: 50, body: 60, aroma: 20, caffeine: 90),
      );
      expect(low.hint.attribute, FlavorAttribute.aroma);
      expect(low.hint.direction, HintDirection.tooLow);
      final high = math.evaluate(
        recipe,
        const FlavorProfile(acidity: 99, body: 60, aroma: 70, caffeine: 80),
      );
      expect(high.hint.attribute, FlavorAttribute.acidity);
      expect(high.hint.direction, HintDirection.tooHigh);
    });

    test('hint round-trips through json', () {
      const hint = BrewHint(
        attribute: FlavorAttribute.body,
        direction: HintDirection.tooHigh,
      );
      expect(BrewHint.fromJson(hint.toJson()), hint);
      expect(BrewHint.fromJson(BrewHint.onTrack.toJson()), BrewHint.onTrack);
    });
  });

  group('bonuses', () {
    test('recipe bonus scales with squared score', () {
      expect(math.recipeBonus(recipe, 100), closeTo(0.4, 1e-12));
      expect(math.recipeBonus(recipe, 50), closeTo(0.1, 1e-12));
      expect(math.recipeBonus(recipe, 0), 0);
    });

    test('lab multiplier ignores capsule recipes and vice versa', () {
      final scores = {'test': 100, 'pod': 100};
      expect(math.labBonusMultiplier(scores).toDouble(), closeTo(1.4, 1e-12));
      expect(math.capsuleBonus(scores), closeTo(1, 1e-12));
    });
  });

  group('costs and capsules', () {
    test('test cost is income-based with a floor', () {
      expect(math.testCost(recipe, BigNumber.zero), BigNumber.fromInt(10));
      expect(
        math.testCost(recipe, BigNumber.fromInt(5)),
        BigNumber.fromInt(100),
      );
    });

    test('capsule unlock needs both score and hype', () {
      expect(math.isCapsuleUnlocked({'test': 80}, 70), isTrue);
      expect(math.isCapsuleUnlocked({'test': 79}, 90), isFalse);
      expect(math.isCapsuleUnlocked({'test': 95}, 69), isFalse);
    });

    test('machine cost grows by 12 percent', () {
      expect(math.machineCost.costOfNext(0), BigNumber.fromInt(100));
      expect(math.machineCost.costOfNext(1).toDouble(), closeTo(112, 1e-9));
    });

    test('capsule income uses capsule bonus', () {
      final income = math.capsuleIncomePerSec(4, {'pod': 100});
      expect(income.toDouble(), closeTo(4 * 5 * 2, 1e-9));
      expect(math.capsuleIncomePerSec(0, {'pod': 100}), BigNumber.zero);
    });
  });
}
