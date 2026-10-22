import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:coffee_empire/engine/economy_engine.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_economy.dart';

void main() {
  final engine = EconomyEngine(loadTestEconomy());

  test('no shops means zero income', () {
    final income = engine.totalIncomePerSec(
      shopLevels: const {},
      managers: const {},
      equipment: const {},
      goldenBeans: 0,
    );
    expect(income, BigNumber.zero);
  });

  test('sums shop income and applies golden bean multiplier', () {
    final income = engine.totalIncomePerSec(
      shopLevels: const {'street_cart': 2},
      managers: const {'street_cart': true},
      equipment: const {},
      goldenBeans: 50,
    );
    expect(income.toDouble(), closeTo(0.5 * 2 * 3 * 2, 1e-9));
  });

  test('earnings ignore non-positive delta', () {
    final income = BigNumber.fromInt(10);
    expect(engine.earningsFor(income, -5), BigNumber.zero);
    expect(engine.earningsFor(income, 0), BigNumber.zero);
    expect(engine.earningsFor(income, 2.5), BigNumber.fromInt(25));
  });
}
