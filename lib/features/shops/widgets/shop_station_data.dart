import '../../../config/economy_config.dart';
import '../../../core/bignumber/big_number.dart';
import '../../../engine/shop_math.dart';
import '../../game/game_cubit.dart';
import '../../game/game_state.dart';

enum StationStatus { open, available, locked }

typedef ShopStationData = ({
  StationStatus status,
  int level,
  bool hasManager,
  int equipmentOwned,
  PurchasePlan plan,
  bool managerAffordable,
  bool equipmentAffordable,
  BigNumber income,
  bool scientific,
});

ShopStationData selectShopStation(
  GameCubit cubit,
  GameState state,
  ShopConfig shop,
  int index,
  BuyAmount amount,
) {
  final math = cubit.shopMath;
  final level = state.shopLevels[shop.id] ?? 0;
  final hasManager = state.managers[shop.id] ?? false;
  final equipmentOwned = state.equipment[shop.id] ?? 0;
  final canEquip = equipmentOwned < math.equipmentTierCount;
  final status = level > 0
      ? StationStatus.open
      : math.isShopAvailable(cubit.shopLevelList, index)
      ? StationStatus.available
      : StationStatus.locked;
  return (
    status: status,
    level: level,
    hasManager: hasManager,
    equipmentOwned: equipmentOwned,
    plan: math.purchasePlan(shop, level, state.cash, amount),
    managerAffordable: state.cash >= math.managerCost(shop),
    equipmentAffordable:
        canEquip && state.cash >= math.equipmentCost(shop, equipmentOwned),
    income: math.shopIncomePerSec(
      shop,
      level: level,
      hasManager: hasManager,
      equipmentOwned: equipmentOwned,
    ),
    scientific: state.settings.scientific,
  );
}

bool isStationReachable(GameState state, List<ShopConfig> shops, int index) =>
    index == 0 || (state.shopLevels[shops[index - 1].id] ?? 0) >= 1;
