import 'package:coffee_empire/app/app.dart';
import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:coffee_empire/core/services/analytics_service.dart';
import 'package:coffee_empire/core/services/monetization_service.dart';
import 'package:coffee_empire/config/economy_config.dart';
import 'package:coffee_empire/engine/boost_math.dart';
import 'package:coffee_empire/engine/lab_math.dart';
import 'package:coffee_empire/features/game/game_settings.dart';
import 'package:coffee_empire/features/game/game_state.dart';
import 'package:coffee_empire/features/cafe_hud/service_hud.dart';
import 'package:coffee_empire/features/home/widgets/cash_header.dart';
import 'package:coffee_empire/features/lab/lab_state.dart';
import 'package:coffee_empire/features/store/store_state.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/cafe_driver.dart';
import '../helpers/cafe_files.dart';
import '../helpers/cubit_harness.dart';

GameState busyState(CubitHarness harness, String locale) {
  final config = harness.config;
  final now = harness.clock.now();
  final recipes = config.lab.recipes;
  return harness
      .stateWithCash('3.3e15')
      .copyWith(
        lifetimeEarnings: BigNumber.parse('1e17'),
        runEarnings: BigNumber.parse('5e16'),
        goldenBeans: 1234,
        shopLevels: {for (final shop in config.shops) shop.id: 137},
        managers: {config.shops.first.id: true},
        equipment: {config.shops.first.id: 3},
        franchises: {
          for (final city in config.franchise.cities) city.id: city.slots - 1,
        },
        tutorialStep: 3,
        settings: GameSettings(locale: locale),
        lab: LabState(
          capsuleMachines: 42,
          recipes: {
            recipes.first.id: const RecipeProgress(
              unlocked: true,
              bestScore: 97,
              lastScore: 64,
              lastHint: BrewHint(
                attribute: FlavorAttribute.caffeine,
                direction: HintDirection.tooHigh,
              ),
            ),
          },
          activeBrew: ActiveBrew(
            recipeId: recipes[1].id,
            endsAt: now.add(const Duration(hours: 2)),
            sliders: FlavorProfile.neutral,
          ),
        ),
        store: StoreState(
          purchases: const {ProductIds.vip},
          boosts: [
            ActiveBoost(
              type: ActiveBoost.caffeineRush,
              endsAt: now.add(const Duration(hours: 7, minutes: 59)),
            ),
          ],
          rewardedCooldowns: {
            'emergency_fund': now.add(const Duration(minutes: 9)),
          },
        ),
      );
}

void main() {
  for (final locale in ['de', 'ru', 'ar', 'ja', 'hi']) {
    testWidgets('$locale at 1.3 text scale has no overflow on any tab', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1179, 2556);
      tester.view.devicePixelRatio = 3;
      tester.platformDispatcher.textScaleFactorTestValue = 1.3;
      addTearDown(tester.view.reset);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

      final harness = CubitHarness();
      final cubit = harness.build(busyState(harness, locale));
      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            ...cafeProviders(),
            RepositoryProvider<EconomyConfig>.value(value: harness.config),
            RepositoryProvider<AnalyticsService>.value(
              value: const DebugAnalyticsService(),
            ),
            RepositoryProvider<MonetizationService>.value(
              value: MockMonetizationService(adDuration: Duration.zero),
            ),
          ],
          child: BlocProvider.value(
            value: cubit,
            child: CoffeeEmpireApp(clock: harness.clock),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 300));
      expect(tester.takeException(), isNull);

      final expectedDirection = locale == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr;
      expect(
        Directionality.of(tester.element(find.byType(CashHeader))),
        expectedDirection,
      );
      final cash = tester.widget<Text>(find.byKey(CashHeader.cashTextKey));
      expect(cash.textDirection, TextDirection.ltr);

      expect(
        Directionality.of(tester.element(find.byType(ServiceHud))),
        expectedDirection,
      );
      expect(
        Directionality.of(
          tester.element(
            find.byWidgetPredicate((widget) => widget is GameWidget),
          ),
        ),
        TextDirection.ltr,
      );

      final destinations = find.byType(NavigationDestination);
      expect(destinations, findsNWidgets(5));
      for (var tab = 0; tab < 5; tab++) {
        await tester.tap(destinations.at(tab));
        await tester.pump(const Duration(milliseconds: 300));
        expect(tester.takeException(), isNull, reason: 'tab $tab');
        expect(cafeViewState(tester).game.paused, tab != 0);
        final scrollable = find.byType(Scrollable).hitTestable();
        for (var page = 0; page < 12; page++) {
          if (scrollable.evaluate().isEmpty) break;
          await tester.drag(scrollable.first, const Offset(0, -400));
          await tester.pump(const Duration(milliseconds: 100));
          expect(tester.takeException(), isNull, reason: 'tab $tab page $page');
        }
      }
      await tester.pumpWidget(const SizedBox.shrink());
    });
  }
}
