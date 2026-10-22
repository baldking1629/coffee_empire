import 'package:coffee_empire/config/economy_config.dart';
import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:coffee_empire/engine/shop_math.dart';
import 'package:flutter_test/flutter_test.dart';

const rules = ShopRulesConfig(
  milestoneLevels: [25, 50, 100, 200, 300, 400],
  milestoneMultiplier: 2,
  managerCostMultiplier: 50,
  managerIncomeMultiplier: 3,
  equipmentCostMultipliers: [100, 1000, 10000],
  equipmentIncomeMultiplier: 2,
);

final booth = ShopConfig(
  id: 'corner_booth',
  baseCost: BigNumber.fromInt(60),
  baseIncome: BigNumber.fromInt(4),
  growth: 1.15,
);

void expectApprox(BigNumber actual, double expected) {
  expect(actual.toDouble(), closeTo(expected, expected.abs() * 1e-9));
}

double bruteForceCost(int level, int count) {
  var total = 0.0;
  for (var i = 0; i < count; i++) {
    total += 60 * _pow(1.15, level + i);
  }
  return total;
}

double _pow(double base, int exponent) {
  var result = 1.0;
  for (var i = 0; i < exponent; i++) {
    result *= base;
  }
  return result;
}

void main() {
  const math = ShopMath(rules);

  group('costs', () {
    test('costOfNext follows baseCost * r^L', () {
      expectApprox(math.costOfNext(booth, 0), 60);
      expectApprox(math.costOfNext(booth, 10), 60 * _pow(1.15, 10));
    });

    test('costOfN equals sum of individual costs', () {
      for (final (level, count) in [(0, 1), (0, 10), (7, 25), (40, 3)]) {
        expectApprox(
          math.costOfN(booth, level, count),
          bruteForceCost(level, count),
        );
      }
      expect(math.costOfN(booth, 5, 0), BigNumber.zero);
    });
  });

  group('maxAffordable', () {
    test('returns 0 when next level is unaffordable', () {
      expect(math.maxAffordable(booth, 0, BigNumber.fromInt(59)), 0);
    });

    test('exact cash for n levels buys exactly n', () {
      final cash = BigNumber.fromDouble(bruteForceCost(3, 10));
      expect(math.maxAffordable(booth, 3, cash), 10);
    });

    test('result is affordable and one more is not', () {
      for (final cashValue in [60.0, 500.0, 12345.0, 9.9e7, 3.3e15]) {
        final cash = BigNumber.fromDouble(cashValue);
        final count = math.maxAffordable(booth, 2, cash);
        expect(math.costOfN(booth, 2, count) <= cash, isTrue);
        expect(math.costOfN(booth, 2, count + 1) > cash, isTrue);
      }
    });

    test('handles astronomically large cash', () {
      final count = math.maxAffordable(booth, 0, BigNumber.parse('1e500'));
      expect(count, greaterThan(8000));
      expect(math.costOfN(booth, 0, count) <= BigNumber.parse('1e500'), isTrue);
    });
  });

  group('income', () {
    test('level 0 earns nothing', () {
      expect(
        math.shopIncomePerSec(
          booth,
          level: 0,
          hasManager: true,
          equipmentOwned: 3,
        ),
        BigNumber.zero,
      );
    });

    test('linear in level below first milestone', () {
      expectApprox(
        math.shopIncomePerSec(
          booth,
          level: 24,
          hasManager: false,
          equipmentOwned: 0,
        ),
        4 * 24,
      );
    });

    test('level 25 doubles income per level', () {
      final at24 = math.shopIncomePerSec(
        booth,
        level: 24,
        hasManager: false,
        equipmentOwned: 0,
      );
      final at25 = math.shopIncomePerSec(
        booth,
        level: 25,
        hasManager: false,
        equipmentOwned: 0,
      );
      expectApprox(at25, 4 * 25 * 2);
      expect(at25.toDouble() / at24.toDouble(), closeTo(2 * 25 / 24, 1e-9));
    });

    test('milestones stack cumulatively', () {
      expectApprox(math.milestoneMultiplier(24), 1);
      expectApprox(math.milestoneMultiplier(50), 4);
      expectApprox(math.milestoneMultiplier(400), 64);
      expect(math.nextMilestone(26), 50);
      expect(math.nextMilestone(400), isNull);
    });

    test('manager triples and each equipment doubles', () {
      expectApprox(
        math.shopIncomePerSec(
          booth,
          level: 10,
          hasManager: true,
          equipmentOwned: 2,
        ),
        4 * 10 * 3 * 4,
      );
    });
  });

  group('upgrades and unlocks', () {
    test('manager and equipment costs scale with base cost', () {
      expectApprox(math.managerCost(booth), 3000);
      expectApprox(math.equipmentCost(booth, 0), 6000);
      expectApprox(math.equipmentCost(booth, 2), 600000);
      expect(math.equipmentTierCount, 3);
    });

    test('a shop opens only after the previous one reaches level 1', () {
      expect(math.isShopAvailable([0, 0, 0], 0), isTrue);
      expect(math.isShopAvailable([0, 0, 0], 1), isFalse);
      expect(math.isShopAvailable([1, 0, 0], 1), isTrue);
      expect(math.isShopAvailable([1, 0, 0], 2), isFalse);
    });
  });

  group('purchase plan', () {
    test('x1 and x10 report exact cost and affordability', () {
      final one = math.purchasePlan(
        booth,
        0,
        BigNumber.fromInt(60),
        BuyAmount.one,
      );
      expect(one.count, 1);
      expect(one.affordable, isTrue);
      final ten = math.purchasePlan(
        booth,
        0,
        BigNumber.fromInt(60),
        BuyAmount.ten,
      );
      expect(ten.count, 10);
      expectApprox(ten.cost, bruteForceCost(0, 10));
      expect(ten.affordable, isFalse);
    });

    test('MAX buys as many as affordable', () {
      final cash = BigNumber.fromDouble(bruteForceCost(4, 7) + 1);
      final plan = math.purchasePlan(booth, 4, cash, BuyAmount.max);
      expect(plan.count, 7);
      expect(plan.affordable, isTrue);
    });

    test('MAX with nothing affordable shows next level as unaffordable', () {
      final plan = math.purchasePlan(
        booth,
        0,
        BigNumber.fromInt(10),
        BuyAmount.max,
      );
      expect(plan.count, 1);
      expect(plan.affordable, isFalse);
      expectApprox(plan.cost, 60);
    });

    test('previous milestone', () {
      expect(math.previousMilestone(10), isNull);
      expect(math.previousMilestone(60), 50);
    });
  });
}
