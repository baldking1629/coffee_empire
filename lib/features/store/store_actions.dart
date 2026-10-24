import '../../core/bignumber/big_number.dart';
import '../../core/services/monetization_service.dart';
import '../../engine/boost_math.dart';
import '../../engine/economy_engine.dart';
import '../game/game_state.dart';
import 'store_state.dart';

class StoreActions {
  const StoreActions(this.engine);

  final EconomyEngine engine;

  BoostMath get math => engine.boostMath;

  DateTime? cooldownEnd(GameState state, RewardedAdType type) =>
      state.store.rewardedCooldowns[type.id];

  bool canWatch(GameState state, RewardedAdType type, DateTime now) {
    if (math.isOnCooldown(cooldownEnd(state, type), now)) return false;
    return switch (type) {
      RewardedAdType.labSpeedup => state.lab.activeBrew != null,
      RewardedAdType.offlineDouble => state.pendingOffline != null,
      RewardedAdType.caffeineRush || RewardedAdType.emergencyFund => true,
    };
  }

  GameState? applyRewarded(GameState state, RewardedAdType type, DateTime now) {
    if (!canWatch(state, type, now)) return null;
    final cooledDown = state.copyWith(
      store: state.store.copyWith(
        rewardedCooldowns: {
          ...state.store.rewardedCooldowns,
          type.id: math.cooldownEnd(now),
        },
      ),
    );
    switch (type) {
      case RewardedAdType.caffeineRush:
        final current = state.store.boostOf(ActiveBoost.caffeineRush);
        final endsAt = math.extendCaffeineRush(current?.endsAt, now);
        return cooledDown.copyWith(
          store: cooledDown.store.withBoost(
            ActiveBoost(type: ActiveBoost.caffeineRush, endsAt: endsAt),
          ),
        );
      case RewardedAdType.emergencyFund:
        return cooledDown.earn(math.emergencyFund(state.incomePerSec));
      case RewardedAdType.labSpeedup:
        final brew = state.lab.activeBrew;
        if (brew == null) return null;
        return cooledDown.copyWith(
          lab: state.lab.copyWith(activeBrew: () => brew.copyWith(endsAt: now)),
        );
      case RewardedAdType.offlineDouble:
        return cooledDown;
    }
  }

  bool canPurchase(GameState state, String productId) =>
      ProductIds.consumables.contains(productId) ||
      !state.store.purchases.contains(productId);

  GameState? applyPurchase(GameState state, String productId) {
    if (!canPurchase(state, productId)) return null;
    final iap = engine.config.iap;
    final owned = ProductIds.consumables.contains(productId)
        ? state
        : state.copyWith(
            store: state.store.copyWith(
              purchases: {...state.store.purchases, productId},
            ),
          );
    return switch (productId) {
      ProductIds.timeSkip => owned.earn(
        math.incomeFor(state.incomePerSec, iap.timeSkipSeconds),
      ),
      ProductIds.starterPack => owned.earn(
        math.incomeFor(state.incomePerSec, iap.starterPackCashSeconds),
      ),
      ProductIds.vip => owned,
      _ => null,
    };
  }

  GameState restore(GameState state, Iterable<String> ownedProducts) =>
      state.copyWith(
        store: state.store.copyWith(
          purchases: {...state.store.purchases, ...ownedProducts},
        ),
      );

  BigNumber timeSkipValue(GameState state) =>
      math.incomeFor(state.incomePerSec, engine.config.iap.timeSkipSeconds);
}
