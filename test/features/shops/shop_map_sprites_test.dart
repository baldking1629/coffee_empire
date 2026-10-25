import 'package:coffee_empire/features/shops/shops_tab.dart';
import 'package:coffee_empire/features/shops/widgets/shop_station_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/cubit_harness.dart';
import '../../helpers/pump_app.dart';

void main() {
  testWidgets(
    'stations show pixel buildings, locked ones as dark silhouettes',
    (tester) async {
      tester.view.physicalSize = const Size(1179, 4000);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      final harness = CubitHarness();
      final cubit = harness.build(
        harness
            .stateWithCash('5')
            .copyWith(shopLevels: const {'street_cart': 1}),
      );
      await pumpWithGame(
        tester,
        config: harness.config,
        cubit: cubit,
        child: const ShopsTab(),
      );
      final open = find.byKey(ShopBuildingSprite.keyOf('street_cart'));
      expect(open, findsOneWidget);
      expect(
        find.ancestor(of: open, matching: find.byType(ColorFiltered)),
        findsNothing,
      );
      final locked = find.byKey(ShopBuildingSprite.keyOf('boutique_cafe'));
      expect(locked, findsOneWidget);
      expect(
        find.ancestor(of: locked, matching: find.byType(ColorFiltered)),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    },
  );
}
