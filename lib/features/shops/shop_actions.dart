import '../../engine/economy_engine.dart';
import '../../engine/shop_math.dart';
import '../game/game_state.dart';

class ShopActions {
  const ShopActions(this.engine);

  final EconomyEngine engine;

  ShopMath get math => engine.shopMath;

  List<int> levelList(GameState state) => [
    for (final shop in engine.config.shops) state.shopLevels[shop.id] ?? 0,
  ];

  int _indexOf(String shopId) =>
      engine.config.shops.indexWhere((shop) => shop.id == shopId);

  GameState? buyLevels(GameState state, String shopId, BuyAmount amount) {
    final index = _indexOf(shopId);
    if (index < 0 || !math.isShopAvailable(levelList(state), index)) {
      return null;
    }
    final level = state.shopLevels[shopId] ?? 0;
    final plan = math.purchasePlan(
      engine.config.shops[index],
      level,
      state.cash,
      amount,
    );
    if (!plan.affordable) return null;
    return state
        .spend(plan.cost)
        .copyWith(
          shopLevels: {...state.shopLevels, shopId: level + plan.count},
        );
  }

  GameState? hireManager(GameState state, String shopId) {
    final index = _indexOf(shopId);
    if (index < 0 ||
        (state.shopLevels[shopId] ?? 0) < 1 ||
        (state.managers[shopId] ?? false)) {
      return null;
    }
    final cost = math.managerCost(engine.config.shops[index]);
    if (state.cash < cost) return null;
    return state
        .spend(cost)
        .copyWith(managers: {...state.managers, shopId: true});
  }

  GameState? buyEquipment(GameState state, String shopId) {
    final index = _indexOf(shopId);
    final owned = state.equipment[shopId] ?? 0;
    if (index < 0 ||
        (state.shopLevels[shopId] ?? 0) < 1 ||
        owned >= math.equipmentTierCount) {
      return null;
    }
    final cost = math.equipmentCost(engine.config.shops[index], owned);
    if (state.cash < cost) return null;
    return state
        .spend(cost)
        .copyWith(equipment: {...state.equipment, shopId: owned + 1});
  }
}
