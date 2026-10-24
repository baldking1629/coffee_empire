import 'dart:math' as math;

import 'package:equatable/equatable.dart';

import '../config/economy_config.dart';
import '../core/bignumber/big_number.dart';

enum BuyAmount { one, ten, max }

class PurchasePlan extends Equatable {
  const PurchasePlan({
    required this.count,
    required this.cost,
    required this.affordable,
  });

  final int count;
  final BigNumber cost;
  final bool affordable;

  @override
  List<Object?> get props => [count, cost, affordable];
}

class GeometricCost {
  const GeometricCost(this.baseCost, this.growth);

  final BigNumber baseCost;
  final double growth;

  BigNumber costOfNext(int owned) =>
      baseCost * BigNumber.fromDouble(growth).pow(owned.toDouble());

  BigNumber costOfN(int owned, int count) {
    if (count <= 0) return BigNumber.zero;
    final growthBig = BigNumber.fromDouble(growth);
    final seriesFactor =
        (growthBig.pow(count.toDouble()) - BigNumber.one) /
        BigNumber.fromDouble(growth - 1);
    return costOfNext(owned) * seriesFactor;
  }

  int maxAffordable(int owned, BigNumber cash) {
    final nextCost = costOfNext(owned);
    if (cash < nextCost) return 0;
    final ratio =
        cash * BigNumber.fromDouble(growth - 1) / nextCost + BigNumber.one;
    var count = (ratio.log10() / (math.log(growth) / math.ln10)).floor();
    // Floating-point log can be off by one at exact boundaries.
    while (count > 0 && costOfN(owned, count) > cash) {
      count--;
    }
    while (costOfN(owned, count + 1) <= cash) {
      count++;
    }
    return count;
  }

  PurchasePlan plan(int owned, BigNumber cash, BuyAmount amount) {
    final count = switch (amount) {
      BuyAmount.one => 1,
      BuyAmount.ten => 10,
      BuyAmount.max => maxAffordable(owned, cash),
    };
    if (count == 0) {
      return PurchasePlan(count: 1, cost: costOfNext(owned), affordable: false);
    }
    final cost = costOfN(owned, count);
    return PurchasePlan(count: count, cost: cost, affordable: cost <= cash);
  }
}

class ShopMath {
  const ShopMath(this.rules);

  final ShopRulesConfig rules;

  GeometricCost _levelCost(ShopConfig shop) =>
      GeometricCost(shop.baseCost, shop.growth);

  BigNumber costOfNext(ShopConfig shop, int level) =>
      _levelCost(shop).costOfNext(level);

  BigNumber costOfN(ShopConfig shop, int level, int count) =>
      _levelCost(shop).costOfN(level, count);

  int maxAffordable(ShopConfig shop, int level, BigNumber cash) =>
      _levelCost(shop).maxAffordable(level, cash);

  PurchasePlan purchasePlan(
    ShopConfig shop,
    int level,
    BigNumber cash,
    BuyAmount amount,
  ) => _levelCost(shop).plan(level, cash, amount);

  int? previousMilestone(int level) {
    int? reached;
    for (final milestone in rules.milestoneLevels) {
      if (level >= milestone) reached = milestone;
    }
    return reached;
  }

  BigNumber milestoneMultiplier(int level) {
    final reached = rules.milestoneLevels.where((m) => level >= m).length;
    return BigNumber.fromDouble(
      rules.milestoneMultiplier,
    ).pow(reached.toDouble());
  }

  int? nextMilestone(int level) {
    for (final milestone in rules.milestoneLevels) {
      if (level < milestone) return milestone;
    }
    return null;
  }

  BigNumber equipmentMultiplier(int equipmentOwned) => BigNumber.fromDouble(
    rules.equipmentIncomeMultiplier,
  ).pow(equipmentOwned.toDouble());

  BigNumber shopIncomePerSec(
    ShopConfig shop, {
    required int level,
    required bool hasManager,
    required int equipmentOwned,
  }) {
    if (level <= 0) return BigNumber.zero;
    final managerMult = hasManager
        ? BigNumber.fromDouble(rules.managerIncomeMultiplier)
        : BigNumber.one;
    return shop.baseIncome *
        BigNumber.fromInt(level) *
        milestoneMultiplier(level) *
        managerMult *
        equipmentMultiplier(equipmentOwned);
  }

  BigNumber managerCost(ShopConfig shop) =>
      shop.baseCost * BigNumber.fromDouble(rules.managerCostMultiplier);

  int get equipmentTierCount => rules.equipmentCostMultipliers.length;

  BigNumber equipmentCost(ShopConfig shop, int tierIndex) =>
      shop.baseCost *
      BigNumber.fromDouble(rules.equipmentCostMultipliers[tierIndex]);

  bool isShopAvailable(List<int> shopLevels, int shopIndex) =>
      shopIndex == 0 || shopLevels[shopIndex - 1] >= 1;
}
