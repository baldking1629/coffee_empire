import 'package:flutter/widgets.dart';
import 'package:coffee_empire/features/home/widgets/cafe_view.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/cafe_driver.dart';
import '../../helpers/cubit_harness.dart';
import '../../helpers/pump_app.dart';

void main() {
  testWidgets('hiring a manager puts a barista in the scene who serves', (
    tester,
  ) async {
    final harness = CubitHarness();
    final cubit = harness.build(
      harness.stateWithCash('1e6').copyWith(shopLevels: {'street_cart': 5}),
    );
    await pumpWithGame(
      tester,
      config: harness.config,
      cubit: cubit,
      child: const CafeView(active: true),
    );
    await tester.pump(const Duration(milliseconds: 100));
    expect(cafeViewState(tester).game.visibleWorkers, 0);

    await cubit.hireManager('street_cart');
    await tester.pump(const Duration(milliseconds: 100));
    expect(cafeViewState(tester).game.visibleWorkers, 1);

    final cashBefore = cubit.state.cash;
    for (var step = 0; step < 600; step++) {
      await tester.pump(const Duration(milliseconds: 100));
      if (cubit.state.cash > cashBefore) break;
    }
    expect(cubit.state.cash > cashBefore, isTrue);
    expect(cubit.state.stats.ordersServed, 0);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('scene is paused while inactive', (tester) async {
    final harness = CubitHarness();
    final cubit = harness.build(harness.stateWithCash('5'));
    await pumpWithGame(
      tester,
      config: harness.config,
      cubit: cubit,
      child: const CafeView(active: false),
    );
    await tester.pump(const Duration(seconds: 10));
    expect(cafeViewState(tester).game.paused, isTrue);
    expect(cafeViewState(tester).game.flow.customers, isEmpty);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
