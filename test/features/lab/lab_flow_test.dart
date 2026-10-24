import 'package:coffee_empire/config/economy_config.dart';
import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:coffee_empire/engine/lab_math.dart';
import 'package:coffee_empire/engine/shop_math.dart';
import 'package:coffee_empire/features/lab/lab_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/cubit_harness.dart';

void main() {
  late CubitHarness harness;
  late RecipeConfig starter;
  late RecipeConfig second;

  setUp(() {
    harness = CubitHarness();
    starter = harness.config.lab.recipes[0];
    second = harness.config.lab.recipes[1];
  });

  test('free recipe is unlocked, paid recipe needs cash', () async {
    final cubit = harness.build(harness.stateWithCash('1'));
    expect(cubit.state.lab.isUnlocked(starter), isTrue);
    expect(await cubit.unlockRecipe(second.id), isFalse);
    final rich = harness.build(harness.stateWithCash('1e9'));
    expect(await rich.unlockRecipe(second.id), isTrue);
    expect(rich.state.lab.isUnlocked(second), isTrue);
    expect(rich.state.cash, BigNumber.parse('1e9') - second.unlockCost);
  });

  test(
    'starting a test charges the floor cost and blocks a second test',
    () async {
      final cubit = harness.build(harness.stateWithCash('100'));
      expect(await cubit.startBrew(starter.id, starter.target), isTrue);
      expect(
        cubit.state.cash,
        BigNumber.parse('100') - harness.config.lab.testCostFloor,
      );
      expect(cubit.state.lab.activeBrew?.recipeId, starter.id);
      expect(await cubit.startBrew(starter.id, starter.target), isFalse);
    },
  );

  test('test completes after its duration via tick', () async {
    final cubit = harness.build(harness.stateWithCash('100'));
    await cubit.startBrew(starter.id, starter.target);
    harness.clock.advance(Duration(seconds: starter.testDurationSeconds - 1));
    await cubit.tick(1);
    expect(cubit.state.lab.activeBrew, isNotNull);
    harness.clock.advance(const Duration(seconds: 1));
    await cubit.tick(1);
    expect(cubit.state.lab.activeBrew, isNull);
    final progress = cubit.state.lab.progressOf(starter.id);
    expect(progress.bestScore, 100);
    expect(progress.lastHint, BrewHint.onTrack);
  });

  test('test finished while the app was closed shows its result on launch', () {
    final saved = harness
        .stateWithCash('100')
        .copyWith(
          lab: LabState(
            activeBrew: ActiveBrew(
              recipeId: starter.id,
              endsAt: harness.clock.now().subtract(const Duration(hours: 1)),
              sliders: FlavorProfile.neutral,
            ),
          ),
        );
    final cubit = harness.build(saved);
    expect(cubit.state.lab.activeBrew, isNull);
    expect(cubit.state.lab.progressOf(starter.id).lastScore, isNotNull);
  });

  test('best score is kept when a later test is worse', () async {
    final cubit = harness.build(harness.stateWithCash('1000'));
    await cubit.startBrew(starter.id, starter.target);
    await cubit.finishBrewNow();
    await cubit.startBrew(
      starter.id,
      const FlavorProfile(acidity: 0, body: 0, aroma: 0, caffeine: 0),
    );
    await cubit.finishBrewNow();
    final progress = cubit.state.lab.progressOf(starter.id);
    expect(progress.bestScore, 100);
    expect(progress.lastScore, 0);
  });

  test('lab bonus raises income after a perfect brew', () async {
    final cubit = harness.build(
      harness.stateWithCash('1000').copyWith(shopLevels: {'street_cart': 10}),
    );
    final before = cubit.state.incomePerSec.toDouble();
    await cubit.startBrew(starter.id, starter.target);
    await cubit.finishBrewNow();
    expect(
      cubit.state.incomePerSec.toDouble(),
      closeTo(before * (1 + starter.maxBonus), 1e-6),
    );
  });

  group('capsule machines', () {
    test('locked without score 80', () async {
      final cubit = harness.build(
        harness
            .stateWithCash('1e12')
            .copyWith(lifetimeEarnings: BigNumber.parse('1e12')),
      );
      expect(cubit.lab.isCapsuleUnlocked(cubit.state), isFalse);
      expect(await cubit.buyCapsuleMachines(BuyAmount.one), isFalse);
    });

    test('locked without enough hype', () async {
      final cubit = harness.build(
        harness
            .stateWithCash('1e12')
            .copyWith(
              lab: LabState(
                recipes: {starter.id: const RecipeProgress(bestScore: 95)},
              ),
            ),
      );
      expect(await cubit.buyCapsuleMachines(BuyAmount.one), isFalse);
    });

    test('purchasable once score and hype are met, adding income', () async {
      final cubit = harness.build(
        harness
            .stateWithCash('1e12')
            .copyWith(
              lifetimeEarnings: BigNumber.parse('1e12'),
              lab: LabState(
                recipes: {starter.id: const RecipeProgress(bestScore: 80)},
              ),
            ),
      );
      final before = cubit.state.incomePerSec;
      expect(await cubit.buyCapsuleMachines(BuyAmount.ten), isTrue);
      expect(cubit.state.lab.capsuleMachines, 10);
      expect(cubit.state.incomePerSec > before, isTrue);
    });
  });
}
