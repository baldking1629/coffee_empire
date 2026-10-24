import 'package:coffee_empire/engine/boost_math.dart';
import 'package:coffee_empire/features/daily_reward/daily_reward_card.dart';
import 'package:coffee_empire/features/store/store_state.dart';
import 'package:coffee_empire/features/store/store_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/cubit_harness.dart';
import '../../helpers/pump_app.dart';

void main() {
  testWidgets('rewarded ad, VIP purchase and daily reward from the store tab', (
    tester,
  ) async {
    final harness = CubitHarness();
    final cubit = harness.build(
      harness.stateWithCash('0').copyWith(shopLevels: {'street_cart': 3}),
    );
    await pumpWithGame(
      tester,
      config: harness.config,
      cubit: cubit,
      child: const StoreTab(),
    );

    await tester.tap(find.byKey(DailyRewardCard.claimKey));
    await tester.pumpAndSettle();
    expect(cubit.state.dailyReward.streak, 1);
    expect(find.textContaining('Next reward in'), findsOneWidget);

    await tester.tap(find.byKey(const Key('watch_ad_caffeine_rush')));
    await tester.pumpAndSettle();
    expect(cubit.state.store.boostOf(ActiveBoost.caffeineRush), isNotNull);
    expect(find.textContaining('Ready in'), findsOneWidget);

    final vip = find.byKey(const Key('buy_product_${ProductIds.vip}'));
    await tester.scrollUntilVisible(vip, 200);
    await tester.drag(find.byType(Scrollable).first, const Offset(0, -100));
    await tester.pumpAndSettle();
    await tester.tap(vip);
    await tester.pumpAndSettle();
    expect(cubit.state.store.isVip, isTrue);
    expect(find.text('Owned'), findsOneWidget);
  });
}
