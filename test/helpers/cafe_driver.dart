import 'package:coffee_empire/engine/cafe_customer.dart';
import 'package:coffee_empire/features/cafe_hud/brew_panel.dart';
import 'package:coffee_empire/features/home/widgets/cafe_view.dart';
import 'package:flutter_test/flutter_test.dart';

CafeViewState cafeViewState(WidgetTester tester) =>
    tester.state<CafeViewState>(find.byType(CafeView));

Future<CafeCustomer> waitForOrderingCustomer(WidgetTester tester) async {
  final game = cafeViewState(tester).game;
  for (var step = 0; step < 300; step++) {
    await tester.pump(const Duration(milliseconds: 100));
    for (final customer in game.flow.customers) {
      if (customer.isWaitingForOrder &&
          !customer.isMoving &&
          customer.laneIndex == 0 &&
          customer.claim == OrderClaim.none) {
        return customer;
      }
    }
  }
  fail('no customer reached the counter');
}

Future<void> serveNextCustomer(WidgetTester tester) async {
  final customer = await waitForOrderingCustomer(tester);
  final bridge = cafeViewState(tester).bridge;
  bridge.onCustomerTapped(customer.id);
  await tester.pump();
  for (var tap = 0; tap < 10; tap++) {
    await tester.tap(find.byKey(BrewPanel.tapKey));
  }
  await tester.pump();
  expect(bridge.playerOrder.value?.ready, isTrue);
  bridge.onCustomerTapped(customer.id);
  await tester.pump();
}
