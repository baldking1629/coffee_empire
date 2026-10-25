import 'package:coffee_empire/config/economy_config.dart';
import 'package:coffee_empire/engine/economy_engine.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_economy.dart';

void main() {
  final economy = loadTestEconomy();
  final math = EconomyEngine(economy).appealMath;

  test('appeal sums placed furniture and ignores unknown ids', () {
    expect(
      math.appealOf(const [
        LayoutItem(uid: 'a', itemId: 'armchair', x: 0, y: 0),
        LayoutItem(uid: 'b', itemId: 'aquarium', x: 0, y: 0),
        LayoutItem(uid: 'c', itemId: 'counter', x: 0, y: 0),
      ]),
      9,
    );
  });

  test('starter furniture is appeal neutral', () {
    expect(math.appealOf(economy.cafe.defaultLayout.items), 0);
    expect(math.multiplier(0), 1);
  });

  test('multiplier grows linearly and never passes the cap', () {
    final rules = economy.cafeRules;
    expect(math.multiplier(10), closeTo(1 + 10 * rules.appealBonus, 1e-12));
    expect(math.multiplier(100000), 1 + rules.appealCap);
    expect(math.multiplier(-5), 1);
  });

  test('engine applies the appeal multiplier to income', () {
    final engine = EconomyEngine(economy);
    const base = IncomeInputs(shopLevels: {'street_cart': 10});
    const decorated = IncomeInputs(shopLevels: {'street_cart': 10}, appeal: 20);
    expect(
      engine.totalIncomePerSec(decorated).toDouble(),
      closeTo(
        engine.totalIncomePerSec(base).toDouble() * math.multiplier(20),
        1e-9,
      ),
    );
  });
}
