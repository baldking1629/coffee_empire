import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:coffee_empire/engine/economy_engine.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_economy.dart';

void main() {
  final config = loadTestEconomy();
  final engine = EconomyEngine(config);
  final espresso = config.lab.recipes.firstWhere((r) => !r.isCapsule);
  final capsuleRecipe = config.lab.recipes.firstWhere((r) => r.isCapsule);

  test('no shops means zero income', () {
    expect(engine.totalIncomePerSec(const IncomeInputs()), BigNumber.zero);
  });

  test('sums shop income and applies golden bean multiplier', () {
    final income = engine.totalIncomePerSec(
      const IncomeInputs(
        shopLevels: {'street_cart': 2},
        managers: {'street_cart': true},
        goldenBeans: 50,
      ),
    );
    expect(income.toDouble(), closeTo(0.5 * 2 * 3 * 2, 1e-9));
  });

  test('lab bonus multiplies all income', () {
    final base = const IncomeInputs(shopLevels: {'street_cart': 10});
    final withLab = IncomeInputs(
      shopLevels: const {'street_cart': 10},
      recipeBestScores: {espresso.id: 100},
    );
    final ratio =
        engine.totalIncomePerSec(withLab).toDouble() /
        engine.totalIncomePerSec(base).toDouble();
    expect(ratio, closeTo(1 + espresso.maxBonus, 1e-9));
  });

  test('capsule machines add income boosted by capsule recipes', () {
    final machines = IncomeInputs(
      capsuleMachines: 3,
      recipeBestScores: {capsuleRecipe.id: 50},
    );
    final expected =
        3 *
        config.capsule.machineIncome.toDouble() *
        (1 + capsuleRecipe.maxBonus * 0.25);
    expect(
      engine.totalIncomePerSec(machines).toDouble(),
      closeTo(expected, 1e-6),
    );
  });

  test('earnings ignore non-positive delta', () {
    final income = BigNumber.fromInt(10);
    expect(engine.earningsFor(income, -5), BigNumber.zero);
    expect(engine.earningsFor(income, 0), BigNumber.zero);
    expect(engine.earningsFor(income, 2.5), BigNumber.fromInt(25));
  });

  test('brand hype is ten times log10 of lifetime earnings', () {
    expect(engine.brandHype(BigNumber.zero), 0);
    expect(engine.brandHype(BigNumber.parse('999')), 30);
    expect(engine.brandHype(BigNumber.parse('1e7')), 70);
    expect(engine.brandHype(BigNumber.parse('1e15')), 150);
  });
}
