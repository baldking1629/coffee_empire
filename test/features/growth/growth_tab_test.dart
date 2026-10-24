import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:coffee_empire/features/growth/growth_tab.dart';
import 'package:coffee_empire/features/growth/widgets/prestige_card.dart';
import 'package:coffee_empire/features/home/widgets/offline_earnings_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/cubit_harness.dart';
import '../../helpers/pump_app.dart';

void main() {
  testWidgets('region chip filters cities and prestige asks for confirmation', (
    tester,
  ) async {
    final harness = CubitHarness();
    final cubit = harness.build(
      harness
          .stateWithCash('1')
          .copyWith(
            runEarnings:
                harness.config.prestige.threshold * BigNumber.fromInt(4),
          ),
    );
    await pumpWithGame(
      tester,
      config: harness.config,
      cubit: cubit,
      child: const GrowthTab(),
    );

    expect(find.text('Vienna', skipOffstage: false), findsOneWidget);
    await tester.tap(find.text('Americas'));
    await tester.pump();
    expect(find.text('Vienna', skipOffstage: false), findsNothing);
    expect(find.text('Toronto', skipOffstage: false), findsOneWidget);

    await tester.tap(find.byKey(PrestigeCard.buttonKey));
    await tester.pumpAndSettle();
    expect(find.text('Start a new empire?'), findsOneWidget);
    await tester.tap(find.byKey(const Key('prestige_confirm')));
    await tester.pumpAndSettle();
    expect(cubit.state.goldenBeans, 10);
    expect(cubit.state.prestigeCount, 1);
  });

  testWidgets('offline modal pays double after the mock ad', (tester) async {
    final harness = CubitHarness();
    final cubit = harness.build(
      harness
          .stateWithCash('0')
          .copyWith(
            shopLevels: {'street_cart': 10},
            savedAt: harness.clock.now().subtract(const Duration(hours: 1)),
          ),
    );
    await pumpWithGame(
      tester,
      config: harness.config,
      cubit: cubit,
      child: const OfflineEarningsListener(child: SizedBox()),
    );
    await tester.pumpAndSettle();
    expect(find.text('Welcome back!'), findsOneWidget);
    expect(cubit.state.cash, BigNumber.zero);
    await tester.tap(find.byKey(const Key('offline_collect_double')));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back!'), findsNothing);
    expect(cubit.state.cash.toDouble(), closeTo(5 * 3600 * 2, 1e-6));
  });
}
