import '../config/economy_config.dart';
import '../core/bignumber/big_number.dart';
import 'shop_math.dart';

class FranchiseMath {
  const FranchiseMath(this.config);

  final FranchiseConfig config;

  int get totalSlots => config.cities.fold(0, (sum, city) => sum + city.slots);

  GeometricCost slotCost(CityConfig city) =>
      GeometricCost(city.baseCost, config.slotCostGrowth);

  BigNumber costOfSlot(CityConfig city, int slotIndex) =>
      slotCost(city).costOfNext(slotIndex);

  bool isCityUnlocked(CityConfig city, int brandHype) =>
      brandHype >= city.requiredHype;

  bool canOpen(CityConfig city, int owned, int brandHype) =>
      isCityUnlocked(city, brandHype) && owned < city.slots;

  bool isComplete(CityConfig city, int owned) => owned >= city.slots;

  double completionMultiplier(CityConfig city, int owned) =>
      isComplete(city, owned) ? config.completionMultiplier : 1;

  double royaltyShare(Map<String, int> franchises) {
    var share = 0.0;
    for (final city in config.cities) {
      final owned = (franchises[city.id] ?? 0).clamp(0, city.slots);
      share += owned * city.royaltyShare * completionMultiplier(city, owned);
    }
    return share;
  }

  BigNumber royaltyIncome(Map<String, int> franchises, BigNumber shopsSum) =>
      shopsSum * BigNumber.fromDouble(royaltyShare(franchises));
}
