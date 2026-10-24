import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:coffee_empire/features/game/game_settings.dart';
import 'package:coffee_empire/features/lab/lab_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/cubit_harness.dart';

void main() {
  late CubitHarness harness;

  setUp(() => harness = CubitHarness());

  test('prestige resets the run and keeps permanent progress', () async {
    final threshold = harness.config.prestige.threshold;
    final run = threshold * BigNumber.fromInt(4);
    final recipeId = harness.config.lab.recipes.first.id;
    final cubit = harness.build(
      harness
          .stateWithCash('1e20')
          .copyWith(
            runEarnings: run,
            lifetimeEarnings: BigNumber.parse('1e30'),
            goldenBeans: 3,
            prestigeCount: 1,
            shopLevels: {'street_cart': 100},
            managers: {'street_cart': true},
            equipment: {'street_cart': 2},
            franchises: {'vienna': 1},
            tutorialStep: 6,
            settings: const GameSettings(locale: 'tr'),
            lab: LabState(
              recipes: {
                recipeId: const RecipeProgress(bestScore: 90, unlocked: true),
              },
              capsuleMachines: 7,
              activeBrew: ActiveBrew(
                recipeId: recipeId,
                endsAt: harness.clock.now().add(const Duration(hours: 1)),
                sliders: harness.config.lab.recipes.first.target,
              ),
            ),
          ),
    );
    final hypeBefore = cubit.engine.brandHype(cubit.state.lifetimeEarnings);
    expect(await cubit.prestige(), isTrue);
    final state = cubit.state;

    expect(state.cash, harness.config.startingCash);
    expect(state.runEarnings, BigNumber.zero);
    expect(state.shopLevels, isEmpty);
    expect(state.managers, isEmpty);
    expect(state.equipment, isEmpty);
    expect(state.franchises, isEmpty);
    expect(state.lab.capsuleMachines, 0);
    expect(state.lab.activeBrew, isNull);

    expect(state.goldenBeans, 3 + 10);
    expect(state.prestigeCount, 2);
    expect(state.lifetimeEarnings, BigNumber.parse('1e30'));
    expect(state.lab.progressOf(recipeId).bestScore, 90);
    expect(state.lab.progressOf(recipeId).unlocked, isTrue);
    expect(state.tutorialStep, 6);
    expect(state.settings.locale, 'tr');
    expect(cubit.engine.brandHype(state.lifetimeEarnings), hypeBefore);
    verify(() => harness.repository.save(any())).called(1);
  });

  test('prestige is refused below the threshold', () async {
    final cubit = harness.build(harness.stateWithCash('1e5'));
    expect(await cubit.prestige(), isFalse);
  });

  test('golden beans raise the global multiplier after prestige', () async {
    final run = harness.config.prestige.threshold * BigNumber.fromInt(100);
    final cubit = harness.build(
      harness.stateWithCash('0').copyWith(runEarnings: run),
    );
    await cubit.prestige();
    final beans = cubit.state.goldenBeans;
    expect(beans, 50);
    final inputs = cubit.incomeInputsOf(
      cubit.state.copyWith(shopLevels: {'street_cart': 1}),
    );
    expect(
      cubit.engine.globalMultiplier(inputs).toDouble(),
      closeTo(1 + beans * harness.config.prestige.beanBonus, 1e-9),
    );
  });
}
