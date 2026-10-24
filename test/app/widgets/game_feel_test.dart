import 'dart:io';

import 'package:coffee_empire/app/widgets/bouncy_button.dart';
import 'package:coffee_empire/app/widgets/floating_text_layer.dart';
import 'package:coffee_empire/app/widgets/insufficient_funds_flash.dart';
import 'package:coffee_empire/core/services/haptic_service.dart';
import 'package:coffee_empire/features/game/game_cubit.dart';
import 'package:coffee_empire/features/game/game_feedback.dart';
import 'package:coffee_empire/features/game/game_settings.dart';
import 'package:coffee_empire/features/home/widgets/barista_tap_area.dart';
import 'package:coffee_empire/features/shops/shops_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/cubit_harness.dart';
import '../../helpers/pump_app.dart';

class MockHaptics extends Mock implements HapticService {}

Widget withAnimations(Widget child, {required bool disableAnimations}) =>
    Builder(
      builder: (context) => MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(disableAnimations: disableAnimations),
        child: child,
      ),
    );

Widget plainApp(Widget child, {bool disableAnimations = false}) => MaterialApp(
  home: withAnimations(
    Scaffold(body: Center(child: child)),
    disableAnimations: disableAnimations,
  ),
);

double scaleOf(WidgetTester tester) => tester
    .widget<ScaleTransition>(
      find.descendant(
        of: find.byType(BouncyButton),
        matching: find.byType(ScaleTransition),
      ),
    )
    .scale
    .value;

double shakeOffsetOf(WidgetTester tester) => tester
    .widget<Transform>(
      find
          .descendant(
            of: find.byType(BouncyButton),
            matching: find.byType(Transform),
          )
          .first,
    )
    .transform
    .getTranslation()
    .x;

void main() {
  group('BouncyButton', () {
    testWidgets('shrinks while pressed and springs back', (tester) async {
      var presses = 0;
      await tester.pumpWidget(
        plainApp(
          BouncyButton(onPressed: () => presses++, child: const Text('Go')),
        ),
      );
      final gesture = await tester.startGesture(
        tester.getCenter(find.text('Go')),
      );
      await tester.pump(const Duration(milliseconds: 150));
      await tester.pump(const Duration(milliseconds: 100));
      expect(scaleOf(tester), closeTo(BouncyButton.pressedScale, 0.01));
      await gesture.up();
      await tester.pumpAndSettle();
      expect(scaleOf(tester), closeTo(1, 0.001));
      expect(presses, 1);
    });

    testWidgets('unaffordable press shakes and reports denial', (tester) async {
      var presses = 0;
      var denials = 0;
      await tester.pumpWidget(
        plainApp(
          BouncyButton(
            canAfford: false,
            onPressed: () => presses++,
            onDenied: () => denials++,
            child: const Text('Buy'),
          ),
        ),
      );
      await tester.tap(find.text('Buy'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 40));
      expect(shakeOffsetOf(tester), isNot(0));
      await tester.pumpAndSettle();
      expect(presses, 0);
      expect(denials, 1);
    });

    testWidgets('no shake when animations are disabled', (tester) async {
      var denials = 0;
      await tester.pumpWidget(
        plainApp(
          BouncyButton(
            canAfford: false,
            onPressed: () {},
            onDenied: () => denials++,
            child: const Text('Buy'),
          ),
          disableAnimations: true,
        ),
      );
      await tester.tap(find.text('Buy'));
      await tester.pump(const Duration(milliseconds: 40));
      expect(shakeOffsetOf(tester), 0);
      expect(denials, 1);
    });
  });

  group('insufficient funds', () {
    Future<GameCubit> pumpShopsWithFlash(
      WidgetTester tester,
      String cash,
    ) async {
      final harness = CubitHarness();
      final cubit = harness.build(harness.stateWithCash(cash));
      await pumpWithGame(
        tester,
        config: harness.config,
        cubit: cubit,
        child: InsufficientFundsFlash(
          signals: cubit.deniedSignals,
          child: const ShopsTab(),
        ),
      );
      return cubit;
    }

    testWidgets('unaffordable purchase is refused and flashes red', (
      tester,
    ) async {
      final cubit = await pumpShopsWithFlash(tester, '1');
      await tester.tap(find.byKey(const Key('buy_shop_street_cart')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.byKey(InsufficientFundsFlash.flashKey), findsOneWidget);
      expect(cubit.state.shopLevels['street_cart'], isNull);
      await tester.pumpAndSettle();
      expect(find.byKey(InsufficientFundsFlash.flashKey), findsNothing);
    });

    testWidgets('successful purchase never flashes', (tester) async {
      final cubit = await pumpShopsWithFlash(tester, '100');
      await tester.tap(find.byKey(const Key('buy_shop_street_cart')));
      await tester.pump(const Duration(milliseconds: 100));
      expect(cubit.state.shopLevels['street_cart'], 1);
      expect(find.byKey(InsufficientFundsFlash.flashKey), findsNothing);
    });
  });

  group('floating text', () {
    test('controller keeps at most eight entries, dropping the oldest', () {
      final controller = FloatingTextController();
      for (var i = 0; i < 12; i++) {
        controller.spawn('+$i', Offset.zero);
      }
      expect(controller.entries, hasLength(FloatingTextController.maxEntries));
      expect(controller.entries.first.text, '+4');
      expect(controller.entries.last.text, '+11');
    });

    testWidgets('entries fade out after their lifetime', (tester) async {
      final controller = FloatingTextController();
      await tester.pumpWidget(
        plainApp(
          FloatingTextLayer(
            controller: controller,
            child: const SizedBox(width: 300, height: 300),
          ),
        ),
      );
      controller.spawn(r'+$5', const Offset(400, 300));
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text(r'+$5'), findsOneWidget);
      await tester.pump(FloatingTextLayer.lifetime);
      await tester.pump();
      expect(find.text(r'+$5'), findsNothing);
      expect(controller.entries, isEmpty);
    });

    Future<void> fillCup(
      WidgetTester tester, {
      required bool disableAnimations,
    }) async {
      final harness = CubitHarness();
      final cubit = harness.build(harness.stateWithCash('0'));
      await pumpWithGame(
        tester,
        config: harness.config,
        cubit: cubit,
        child: withAnimations(
          const BaristaTapArea(),
          disableAnimations: disableAnimations,
        ),
      );
      for (var i = 0; i < 10; i++) {
        await tester.tap(find.byKey(BaristaTapArea.cupKey));
      }
      await tester.pump(const Duration(milliseconds: 100));
      expect(cubit.state.cash.isZero, isFalse);
    }

    testWidgets('a full cup spawns a floating gain', (tester) async {
      await fillCup(tester, disableAnimations: false);
      expect(find.text(r'+$1'), findsOneWidget);
      await tester.pump(FloatingTextLayer.lifetime);
      await tester.pump();
    });

    testWidgets('no floating gain when animations are disabled', (
      tester,
    ) async {
      await fillCup(tester, disableAnimations: true);
      expect(find.text(r'+$1'), findsNothing);
    });
  });

  group('haptics', () {
    test(
      'vibration off means no haptic call at all, including denial',
      () async {
        final harness = CubitHarness();
        final haptics = MockHaptics();
        final cubit = GameCubit(
          config: harness.config,
          repository: harness.repository,
          clock: harness.clock,
          feedback: GameFeedback(haptics: haptics),
          restored: harness
              .stateWithCash('1')
              .copyWith(settings: const GameSettings(haptics: false)),
        );
        for (var i = 0; i < 10; i++) {
          cubit.tapCup();
        }
        cubit.reportInsufficientFunds();
        verifyZeroInteractions(haptics);
        await cubit.close();
      },
    );

    test('denial plays a light impact when vibration is on', () async {
      final harness = CubitHarness();
      final haptics = MockHaptics();
      when(haptics.light).thenAnswer((_) async {});
      final cubit = GameCubit(
        config: harness.config,
        repository: harness.repository,
        clock: harness.clock,
        feedback: GameFeedback(haptics: haptics),
      );
      cubit.reportInsufficientFunds();
      verify(haptics.light).called(1);
      await cubit.close();
    });

    test('HapticFeedback is only called inside haptic_service.dart', () {
      final offenders = Directory('lib')
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) => file.path.endsWith('.dart'))
          .where((file) => !file.path.endsWith('haptic_service.dart'))
          .where((file) => file.readAsStringSync().contains('HapticFeedback.'))
          .map((file) => file.path)
          .toList();
      expect(offenders, isEmpty);
    });
  });
}
