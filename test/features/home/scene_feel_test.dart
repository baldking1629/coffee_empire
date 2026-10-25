import 'package:coffee_empire/app/theme/app_theme.dart';
import 'package:coffee_empire/app/theme/pixel_border.dart';
import 'package:coffee_empire/app/widgets/bouncy_button.dart';
import 'package:coffee_empire/cafe/world/pixel_sprite_component.dart';
import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:coffee_empire/engine/cafe_customer.dart';
import 'package:coffee_empire/engine/service_math.dart';
import 'package:coffee_empire/features/home/widgets/cafe_view.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/cafe_driver.dart';
import '../../helpers/cubit_harness.dart';
import '../../helpers/pump_app.dart';

void main() {
  CafeCustomer customer() => CafeCustomer(
    id: 1,
    look: 0,
    drinkId: 'espresso',
    x: 3,
    y: 3,
    patience: 20,
  );

  Future<void> pumpScene(
    WidgetTester tester, {
    required bool reduceMotion,
  }) async {
    final harness = CubitHarness();
    await pumpWithGame(
      tester,
      config: harness.config,
      cubit: harness.build(),
      child: MediaQuery(
        data: const MediaQueryData(
          size: Size(400, 800),
        ).copyWith(disableAnimations: reduceMotion),
        child: const CafeView(active: true),
      ),
    );
    await tester.pump(const Duration(milliseconds: 50));
  }

  int coins(WidgetTester tester) => cafeViewState(tester).game.world
      .descendants()
      .whereType<PixelSpriteComponent>()
      .where((component) => component.spriteId == 'coin')
      .length;

  testWidgets('big serves shake the camera and fling coins', (tester) async {
    await pumpScene(tester, reduceMotion: false);
    final game = cafeViewState(tester).game;
    game.showServe(
      customer(),
      gainText: r'+$1',
      perfectText: 'Perfect!',
      shake: true,
      reduceMotion: false,
    );
    await tester.pump(const Duration(milliseconds: 16));
    expect(game.camera.viewfinder.children.whereType<Effect>(), isNotEmpty);
    expect(coins(tester), greaterThan(0));
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('reduced motion keeps the camera still and skips coins', (
    tester,
  ) async {
    await pumpScene(tester, reduceMotion: true);
    final game = cafeViewState(tester).game;
    game.showServe(
      customer(),
      gainText: r'+$1',
      perfectText: null,
      shake: true,
      reduceMotion: true,
    );
    await tester.pump(const Duration(milliseconds: 16));
    expect(game.camera.viewfinder.children.whereType<Effect>(), isEmpty);
    expect(coins(tester), 0);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  test('a payout worth many seconds of income counts as big', () {
    final harness = CubitHarness();
    final service = harness.config.service;
    final math = ServiceMath(service: service, tap: harness.config.tap);
    final income = BigNumber.fromInt(100);
    expect(
      math.isBigPayout(
        income * BigNumber.fromDouble(service.bigPayoutSeconds),
        income,
      ),
      isTrue,
    );
    expect(math.isBigPayout(income, income), isFalse);
    expect(math.isBigPayout(BigNumber.one, BigNumber.zero), isFalse);
  });

  testWidgets('buttons and sheets use stepped pixel corners', (tester) async {
    final harness = CubitHarness();
    await pumpWithGame(
      tester,
      config: harness.config,
      cubit: harness.build(),
      child: BouncyButton(onPressed: () {}, child: const Text('Go')),
    );
    final box = tester.widget<DecoratedBox>(
      find.descendant(
        of: find.byType(BouncyButton),
        matching: find.byType(DecoratedBox),
      ),
    );
    final decoration = box.decoration as ShapeDecoration;
    expect(decoration.shape, isA<PixelBorder>());
    expect(decoration.shadows?.first.blurRadius, 0);
    final theme = AppTheme.build();
    expect(theme.bottomSheetTheme.shape, isA<PixelBorder>());
    expect(theme.dialogTheme.shape, isA<PixelBorder>());
  });
}
