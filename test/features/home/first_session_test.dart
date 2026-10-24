import 'package:coffee_empire/app/app.dart';
import 'package:coffee_empire/config/economy_config.dart';
import 'package:coffee_empire/core/services/analytics_service.dart';
import 'package:coffee_empire/core/services/monetization_service.dart';
import 'package:coffee_empire/features/game/game_cubit.dart';
import 'package:coffee_empire/features/game/save_repository.dart';
import 'package:coffee_empire/features/home/widgets/barista_tap_area.dart';
import 'package:coffee_empire/features/tutorial/tutorial_overlay.dart';
import 'package:coffee_empire/features/tutorial/tutorial_rules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/fake_clock.dart';
import '../../helpers/test_economy.dart';

void main() {
  testWidgets('fresh install walks through the whole tutorial', (tester) async {
    tester.view.physicalSize = const Size(1179, 2556);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final clock = FakeClock(DateTime.utc(2026, 1, 1));
    final config = loadTestEconomy();
    final repository = SaveRepository(preferences, clock: clock);
    final cubit = GameCubit(
      config: config,
      repository: repository,
      clock: clock,
    );
    await tester.pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<EconomyConfig>.value(value: config),
          RepositoryProvider<AnalyticsService>.value(
            value: const DebugAnalyticsService(),
          ),
          RepositoryProvider<MonetizationService>.value(
            value: MockMonetizationService(adDuration: Duration.zero),
          ),
        ],
        child: BlocProvider.value(
          value: cubit,
          child: CoffeeEmpireApp(clock: clock),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));

    Future<void> earnWhileAway(Duration duration) async {
      clock.advance(duration);
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Welcome back!'), findsOneWidget);
      await tester.tap(find.byKey(const Key('offline_collect')));
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pump(const Duration(milliseconds: 300));
    }

    Future<void> tapKey(Key key) async {
      final list = find.byType(Scrollable).first;
      tester.state<ScrollableState>(list).position.jumpTo(0);
      await tester.pump(const Duration(milliseconds: 300));
      await tester.dragUntilVisible(
        find.byKey(key),
        list,
        const Offset(0, -100),
      );
      await Scrollable.ensureVisible(
        tester.element(find.byKey(key)),
        alignment: 0.5,
      );
      await tester.pump(const Duration(milliseconds: 300));
      await tester.tap(find.byKey(key));
      await tester.pump(const Duration(milliseconds: 300));
    }

    expect(find.textContaining('1/6'), findsOneWidget);
    for (var i = 0; i < 10; i++) {
      await tester.tap(find.byKey(BaristaTapArea.cupKey));
    }
    await tester.pump(const Duration(milliseconds: 300));
    expect(cubit.state.tutorialStep, TutorialSteps.buyFirstShop);

    await tapKey(const Key('buy_shop_street_cart'));
    expect(cubit.state.tutorialStep, TutorialSteps.buySecondShop);

    await earnWhileAway(const Duration(minutes: 3));
    await tapKey(const Key('buy_shop_corner_booth'));
    expect(cubit.state.tutorialStep, TutorialSteps.hireManager);

    await earnWhileAway(const Duration(minutes: 5));
    final upgradesHint = find.descendant(
      of: find.byKey(const Key('station_card_street_cart')),
      matching: find.text('Tap for manager & equipment'),
    );
    tester
        .state<ScrollableState>(find.byType(Scrollable).first)
        .position
        .jumpTo(0);
    await tester.pump(const Duration(milliseconds: 300));
    await Scrollable.ensureVisible(
      tester.element(upgradesHint),
      alignment: 0.5,
    );
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(upgradesHint);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.tap(find.byKey(const Key('hire_manager_street_cart')));
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tapAt(const Offset(20, 60));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(cubit.state.tutorialStep, TutorialSteps.openLab);

    await tester.tap(find.text('R&D'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(cubit.state.tutorialStep, TutorialSteps.finish);

    await tester.tap(find.byKey(TutorialBanner.finishKey));
    await tester.pump(const Duration(milliseconds: 300));
    expect(cubit.state.tutorialStep, TutorialSteps.done);
    expect(find.byType(TutorialBanner), findsOneWidget);
    expect(find.textContaining('Barista training'), findsNothing);

    final reloaded = repository.load().state;
    expect(reloaded?.tutorialStep, TutorialSteps.done);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
