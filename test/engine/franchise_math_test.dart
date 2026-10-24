import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:coffee_empire/engine/franchise_math.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_economy.dart';

void main() {
  final config = loadTestEconomy().franchise;
  final math = FranchiseMath(config);
  final istanbul = config.cities.firstWhere((c) => c.id == 'istanbul');
  final vienna = config.cities.firstWhere((c) => c.id == 'vienna');

  test('30 cities with 87 slots in total', () {
    expect(config.cities, hasLength(30));
    expect(math.totalSlots, 87);
  });

  test('nth slot costs baseCost * 1.8^n', () {
    expect(math.costOfSlot(istanbul, 0), istanbul.baseCost);
    expect(
      math.costOfSlot(istanbul, 3).toDouble(),
      closeTo(
        istanbul.baseCost.toDouble() * 1.8 * 1.8 * 1.8,
        istanbul.baseCost.toDouble() * 1e-9,
      ),
    );
  });

  test('city locked below required hype', () {
    expect(math.isCityUnlocked(istanbul, istanbul.requiredHype - 1), isFalse);
    expect(math.isCityUnlocked(istanbul, istanbul.requiredHype), isTrue);
  });

  test('slots cannot exceed the city limit', () {
    expect(math.canOpen(vienna, 0, 200), isTrue);
    expect(math.canOpen(vienna, vienna.slots, 200), isFalse);
    expect(math.canOpen(istanbul, 4, 200), isTrue);
    expect(math.canOpen(istanbul, 5, 200), isFalse);
  });

  test('completed city multiplies its royalty by 1.5', () {
    final partial = math.royaltyShare({'istanbul': 4});
    final complete = math.royaltyShare({'istanbul': 5});
    expect(partial, closeTo(4 * istanbul.royaltyShare, 1e-12));
    expect(complete, closeTo(5 * istanbul.royaltyShare * 1.5, 1e-12));
  });

  test('every slot filled yields about 90 percent of shop income', () {
    final all = {for (final city in config.cities) city.id: city.slots};
    expect(math.royaltyShare(all), closeTo(0.9, 0.01));
    final income = math.royaltyIncome(all, BigNumber.fromInt(1000));
    expect(income.toDouble(), closeTo(900, 10));
  });

  test('requiredHype increases evenly inside each slot tier', () {
    for (final slots in [1, 2, 3, 4, 5]) {
      final tier = config.cities.where((c) => c.slots == slots).toList();
      for (var i = 1; i < tier.length; i++) {
        expect(tier[i].requiredHype, greaterThan(tier[i - 1].requiredHype));
      }
    }
  });
}
