import 'package:coffee_empire/config/economy_config_loader.dart';
import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_economy.dart';

void main() {
  final config = loadTestEconomy();

  test('defines 10 shops starting with the street cart', () {
    expect(config.shops, hasLength(10));
    expect(config.shops.first.id, 'street_cart');
    expect(config.shops.last.id, 'global_mega_roastery');
    expect(config.startingCash, BigNumber.fromInt(5));
  });

  test('defines 8 recipes with decreasing tolerance', () {
    final recipes = config.lab.recipes;
    expect(recipes, hasLength(8));
    for (var i = 1; i < recipes.length; i++) {
      expect(recipes[i].tolerance, lessThan(recipes[i - 1].tolerance));
      expect(
        recipes[i].testDurationSeconds,
        greaterThan(recipes[i - 1].testDurationSeconds),
      );
    }
    expect(recipes.where((r) => r.isCapsule), isNotEmpty);
  });

  test('defines 30 cities with 87 slots in 4 regions', () {
    final cities = config.franchise.cities;
    expect(cities, hasLength(30));
    expect(cities.fold<int>(0, (sum, c) => sum + c.slots), 87);
    expect(cities.map((c) => c.region).toSet(), {
      'europe',
      'asia_pacific',
      'americas',
      'mea',
    });
    expect(cities.map((c) => c.id).toSet(), hasLength(30));
  });

  test('daily reward covers a 7 day cycle', () {
    expect(config.dailyReward.daySeconds, hasLength(7));
  });

  testWidgets('loader reads the bundled asset', (tester) async {
    final loaded = await EconomyConfigLoader(rootBundle).load();
    expect(loaded, config);
  });
}
