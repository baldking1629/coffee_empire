import 'dart:math' as math;

import '../config/economy_config.dart';
import '../core/bignumber/big_number.dart';

class ShopMath {
  const ShopMath(this.rules);

  final ShopRulesConfig rules;

  BigNumber costOfNext(ShopConfig shop, int level) =>
      shop.baseCost * BigNumber.fromDouble(shop.growth).pow(level.toDouble());

  BigNumber costOfN(ShopConfig shop, int level, int count) {
    if (count <= 0) return BigNumber.zero;
    final growth = BigNumber.fromDouble(shop.growth);
    final seriesFactor =
        (growth.pow(count.toDouble()) - BigNumber.one) /
        BigNumber.fromDouble(shop.growth - 1);
    return costOfNext(shop, level) * seriesFactor;
  }

  int maxAffordable(ShopConfig shop, int level, BigNumber cash) {
    final nextCost = costOfNext(shop, level);
    if (cash < nextCost) return 0;
    final ratio =
        cash * BigNumber.fromDouble(shop.growth - 1) / nextCost + BigNumber.one;
    var count = (ratio.log10() / (math.log(shop.growth) / math.ln10)).floor();
    // Floating-point log can be off by one at exact boundaries.
    while (count > 0 && costOfN(shop, level, count) > cash) {
      count--;
    }
    while (costOfN(shop, level, count + 1) <= cash) {
      count++;
    }
    return count;
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
