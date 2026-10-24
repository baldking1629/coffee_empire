import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/cubit_harness.dart';

void main() {
  late CubitHarness harness;

  setUp(() => harness = CubitHarness());

  test(
    'launch after 5 hours offers 4 hours of earnings and waits for claim',
    () async {
      final saved = harness
          .stateWithCash('0')
          .copyWith(
            shopLevels: {'street_cart': 10},
            savedAt: harness.clock.now().subtract(const Duration(hours: 5)),
          );
      final cubit = harness.build(saved);
      final pending = cubit.state.pendingOffline;
      expect(pending, isNotNull);
      expect(pending?.creditedSeconds, 4 * 3600);
      expect(cubit.state.cash, BigNumber.zero);

      await cubit.claimOfflineEarnings(doubled: true);
      expect(cubit.state.pendingOffline, isNull);
      expect(
        cubit.state.cash.toDouble(),
        closeTo(0.5 * 10 * 4 * 3600 * 2, 1e-6),
      );
    },
  );

  test('launch after 30 seconds has no modal', () {
    final saved = harness
        .stateWithCash('0')
        .copyWith(
          shopLevels: {'street_cart': 10},
          savedAt: harness.clock.now().subtract(const Duration(seconds: 30)),
        );
    final cubit = harness.build(saved);
    expect(cubit.state.pendingOffline, isNull);
  });

  test('clock set back before the save earns nothing', () {
    final saved = harness
        .stateWithCash('7')
        .copyWith(
          shopLevels: {'street_cart': 10},
          savedAt: harness.clock.now().add(const Duration(hours: 3)),
        );
    final cubit = harness.build(saved);
    expect(cubit.state.pendingOffline, isNull);
    expect(cubit.state.cash, BigNumber.fromInt(7));
  });

  test('background gap over a minute opens the modal on resume', () async {
    final cubit = harness.build(
      harness.stateWithCash('0').copyWith(shopLevels: {'street_cart': 10}),
    );
    await cubit.handleBackgroundGap(600);
    expect(cubit.state.pendingOffline?.creditedSeconds, 600);
  });
}
