import '../config/economy_config.dart';
import '../core/bignumber/big_number.dart';
import 'shop_math.dart';

class EconomyEngine {
  EconomyEngine(this.config) : shopMath = ShopMath(config.shopRules);

  final EconomyConfig config;
  final ShopMath shopMath;

  BigNumber shopsIncomePerSec({
    required Map<String, int> shopLevels,
    required Map<String, bool> managers,
    required Map<String, int> equipment,
  }) {
    var total = BigNumber.zero;
    for (final shop in config.shops) {
      total += shopMath.shopIncomePerSec(
        shop,
        level: shopLevels[shop.id] ?? 0,
        hasManager: managers[shop.id] ?? false,
        equipmentOwned: equipment[shop.id] ?? 0,
      );
    }
    return total;
  }

  BigNumber globalMultiplier({required int goldenBeans}) =>
      BigNumber.one +
      BigNumber.fromDouble(goldenBeans * config.prestige.beanBonus);

  BigNumber totalIncomePerSec({
    required Map<String, int> shopLevels,
    required Map<String, bool> managers,
    required Map<String, int> equipment,
    required int goldenBeans,
  }) =>
      shopsIncomePerSec(
        shopLevels: shopLevels,
        managers: managers,
        equipment: equipment,
      ) *
      globalMultiplier(goldenBeans: goldenBeans);

  BigNumber earningsFor(BigNumber incomePerSec, double deltaSeconds) {
    if (deltaSeconds <= 0 || incomePerSec.isZero) return BigNumber.zero;
    return incomePerSec * BigNumber.fromDouble(deltaSeconds);
  }
}
