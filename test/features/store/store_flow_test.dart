import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:coffee_empire/core/services/monetization_service.dart';
import 'package:coffee_empire/engine/boost_math.dart';
import 'package:coffee_empire/features/game/game_state.dart';
import 'package:coffee_empire/features/lab/lab_state.dart';
import 'package:coffee_empire/features/store/store_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/cubit_harness.dart';

void main() {
  late CubitHarness harness;

  setUp(() => harness = CubitHarness());

  GameState earning() =>
      harness.stateWithCash('0').copyWith(shopLevels: {'street_cart': 10});

  test('caffeine rush doubles income and expires', () async {
    final cubit = harness.build(earning());
    final base = cubit.state.incomePerSec.toDouble();
    expect(await cubit.applyRewardedAd(RewardedAdType.caffeineRush), isTrue);
    expect(cubit.state.incomePerSec.toDouble(), closeTo(base * 2, 1e-9));
    harness.clock.advance(const Duration(hours: 4, seconds: 1));
    await cubit.tick(1);
    expect(cubit.state.incomePerSec.toDouble(), closeTo(base, 1e-9));
    expect(cubit.state.store.boosts, isEmpty);
  });

  test('every rewarded type starts a cooldown that is saved', () async {
    final cubit = harness.build(earning());
    expect(await cubit.applyRewardedAd(RewardedAdType.emergencyFund), isTrue);
    expect(await cubit.applyRewardedAd(RewardedAdType.emergencyFund), isFalse);
    expect(cubit.state.cash, BigNumber.fromInt(5 * 600));
    final json = cubit.state.toJson();
    final restored = GameState.fromJson(json);
    expect(
      restored.store.rewardedCooldowns[RewardedAdType.emergencyFund.id],
      cubit.state.store.rewardedCooldowns[RewardedAdType.emergencyFund.id],
    );
    harness.clock.advance(
      Duration(seconds: harness.config.rewarded.cooldownSeconds),
    );
    expect(await cubit.applyRewardedAd(RewardedAdType.emergencyFund), isTrue);
  });

  test('lab speed-up finishes the running test', () async {
    final cubit = harness.build(harness.stateWithCash('100'));
    expect(await cubit.applyRewardedAd(RewardedAdType.labSpeedup), isFalse);
    final recipe = harness.config.lab.recipes.first;
    await cubit.startBrew(recipe.id, recipe.target);
    expect(await cubit.applyRewardedAd(RewardedAdType.labSpeedup), isTrue);
    expect(cubit.state.lab.activeBrew, isNull);
    expect(cubit.state.lab.progressOf(recipe.id).bestScore, 100);
  });

  test('offline double needs a pending modal', () async {
    final cubit = harness.build(earning());
    expect(await cubit.applyRewardedAd(RewardedAdType.offlineDouble), isFalse);
    await cubit.handleBackgroundGap(3600);
    expect(await cubit.applyRewardedAd(RewardedAdType.offlineDouble), isTrue);
  });

  test('VIP doubles income, extends offline cap and auto-taps', () async {
    final cubit = harness.build(earning());
    final base = cubit.state.incomePerSec.toDouble();
    expect(await cubit.applyPurchase(ProductIds.vip), isTrue);
    expect(cubit.state.store.isVip, isTrue);
    expect(cubit.state.incomePerSec.toDouble(), closeTo(base * 2, 1e-9));
    expect(await cubit.applyPurchase(ProductIds.vip), isFalse);

    final cashBefore = cubit.state.cash;
    await cubit.tick(10);
    final passive = cubit.state.incomePerSec * BigNumber.fromInt(10);
    expect(cubit.state.cash > cashBefore + passive, isTrue);

    await cubit.handleBackgroundGap(20 * 3600);
    expect(cubit.state.pendingOffline?.creditedSeconds, 12 * 3600);
  });

  test('starter pack is one-time and grants multiplier plus cash', () async {
    final cubit = harness.build(earning());
    final base = cubit.state.incomePerSec;
    expect(await cubit.applyPurchase(ProductIds.starterPack), isTrue);
    expect(cubit.state.cash, base * BigNumber.fromInt(7200));
    expect(
      cubit.state.incomePerSec.toDouble(),
      closeTo(base.toDouble() * 1.25, 1e-9),
    );
    expect(await cubit.applyPurchase(ProductIds.starterPack), isFalse);
  });

  test('time skip is consumable and adds 24 hours of income', () async {
    final cubit = harness.build(earning());
    final income = cubit.state.incomePerSec;
    expect(await cubit.applyPurchase(ProductIds.timeSkip), isTrue);
    expect(await cubit.applyPurchase(ProductIds.timeSkip), isTrue);
    expect(cubit.state.cash, income * BigNumber.fromInt(2 * 86400));
    expect(cubit.state.store.purchases, isEmpty);
  });

  test('restore keeps purchases as they are', () async {
    final cubit = harness.build(
      earning().copyWith(store: const StoreState(purchases: {ProductIds.vip})),
    );
    await cubit.restorePurchases(const []);
    expect(cubit.state.store.purchases, {ProductIds.vip});
  });

  test('rush boost is not applied to offline earnings', () async {
    final cubit = harness.build(
      earning().copyWith(
        store: StoreState(
          boosts: [
            ActiveBoost(
              type: ActiveBoost.caffeineRush,
              endsAt: harness.clock.now().add(const Duration(hours: 4)),
            ),
          ],
        ),
        lab: const LabState(),
      ),
    );
    await cubit.handleBackgroundGap(100);
    expect(
      cubit.state.pendingOffline?.amount.toDouble(),
      closeTo(0.5 * 10 * 100, 1e-6),
    );
  });
}
