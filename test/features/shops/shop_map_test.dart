import 'package:coffee_empire/features/game/game_cubit.dart';
import 'package:coffee_empire/features/game/game_state.dart';
import 'package:coffee_empire/engine/shop_math.dart';
import 'package:coffee_empire/features/shops/shops_tab.dart';
import 'package:coffee_empire/features/shops/widgets/progress_road_painter.dart';
import 'package:coffee_empire/features/shops/widgets/shop_station.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/cubit_harness.dart';
import '../../helpers/pump_app.dart';

void main() {
  late CubitHarness harness;

  setUp(() => harness = CubitHarness());

  Future<GameCubit> pumpMap(
    WidgetTester tester,
    GameState state, {
    Locale locale = const Locale('en'),
  }) async {
    tester.view.physicalSize = const Size(1179, 4000);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    final cubit = harness.build(state);
    await pumpWithGame(
      tester,
      config: harness.config,
      cubit: cubit,
      child: const ShopsTab(),
      locale: locale,
    );
    return cubit;
  }

  ProgressRoadPainter roadOf(WidgetTester tester, String shopId) => tester
      .widgetList<CustomPaint>(
        find.descendant(
          of: find.byKey(ValueKey(shopId)),
          matching: find.byType(CustomPaint),
        ),
      )
      .map((paint) => paint.painter)
      .whereType<ProgressRoadPainter>()
      .single;

  testWidgets(
    'locked stations hide name and cost; only the next one shows it',
    (tester) async {
      await pumpMap(
        tester,
        harness.stateWithCash('1e9').copyWith(shopLevels: {'street_cart': 1}),
      );
      expect(find.byKey(const Key('buy_shop_corner_booth')), findsOneWidget);
      expect(find.text('Corner Booth'), findsOneWidget);
      for (final shop in harness.config.shops.skip(2)) {
        expect(find.byKey(Key('locked_station_${shop.id}')), findsOneWidget);
        expect(find.byKey(Key('buy_shop_${shop.id}')), findsNothing);
      }
      expect(find.text('???'), findsNWidgets(harness.config.shops.length - 2));
      expect(find.text('Boutique Café'), findsNothing);
    },
  );

  testWidgets('next shop cannot be opened while the previous is level 0', (
    tester,
  ) async {
    final cubit = await pumpMap(tester, harness.stateWithCash('1e9'));
    expect(find.byKey(const Key('buy_shop_corner_booth')), findsNothing);
    expect(await cubit.buyShopLevels('corner_booth', BuyAmount.one), isFalse);
  });

  testWidgets('opening a shop glows once and never again', (tester) async {
    await pumpMap(tester, harness.stateWithCash('100'));
    final glow = find.byKey(ShopStation.glowKey('street_cart'));
    expect(glow, findsNothing);

    await tester.tap(find.byKey(const Key('buy_shop_street_cart')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(glow, findsOneWidget);
    await tester.pumpAndSettle();
    expect(glow, findsNothing);

    await tester.tap(find.byKey(const Key('buy_shop_street_cart')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(glow, findsNothing);
  });

  testWidgets('road mirrors in Arabic and lights up only reached stations', (
    tester,
  ) async {
    await pumpMap(
      tester,
      harness.stateWithCash('0').copyWith(shopLevels: {'street_cart': 1}),
      locale: const Locale('ar'),
    );
    final first = roadOf(tester, 'street_cart');
    expect(first.rtl, isTrue);
    expect(first.hasIncoming, isFalse);
    expect(first.outgoingUnlocked, isTrue);
    final second = roadOf(tester, 'corner_booth');
    expect(second.incomingUnlocked, isTrue);
    expect(second.outgoingUnlocked, isFalse);
    expect(roadOf(tester, 'boutique_cafe').incomingUnlocked, isFalse);
  });

  testWidgets('road is left-to-right in English', (tester) async {
    await pumpMap(tester, harness.stateWithCash('0'));
    expect(roadOf(tester, 'street_cart').rtl, isFalse);
  });

  testWidgets('a tick does not rebuild or repaint the road', (tester) async {
    final cubit = await pumpMap(
      tester,
      harness.stateWithCash('0').copyWith(shopLevels: {'street_cart': 5}),
    );
    final before = roadOf(tester, 'street_cart');
    final paints = find.descendant(
      of: find.byKey(const ValueKey('street_cart')),
      matching: find.byType(RepaintBoundary),
    );
    expect(paints, findsWidgets);
    harness.clock.advance(const Duration(seconds: 1));
    await cubit.tick(1);
    await tester.pump();
    expect(identical(roadOf(tester, 'street_cart'), before), isTrue);
    expect(before.shouldRepaint(before), isFalse);
  });

  testWidgets('partially unlocked map fits in German at 1.3 text scale', (
    tester,
  ) async {
    tester.platformDispatcher.textScaleFactorTestValue = 1.3;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await pumpMap(
      tester,
      harness
          .stateWithCash('1e6')
          .copyWith(shopLevels: {'street_cart': 30, 'corner_booth': 2}),
      locale: const Locale('de'),
    );
    expect(tester.takeException(), isNull);
  });
}
