import 'package:coffee_empire/config/economy_config.dart';
import 'package:coffee_empire/features/game/game_cubit.dart';
import 'package:coffee_empire/features/lab/lab_tab.dart';
import 'package:coffee_empire/features/lab/recipe_screen.dart';
import 'package:coffee_empire/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/cubit_harness.dart';

void main() {
  testWidgets('opening a recipe and starting a test shows a countdown', (
    tester,
  ) async {
    final harness = CubitHarness();
    final GameCubit cubit = harness.build(harness.stateWithCash('100'));
    await tester.pumpWidget(
      RepositoryProvider<EconomyConfig>.value(
        value: harness.config,
        child: BlocProvider.value(
          value: cubit,
          child: const MaterialApp(
            locale: Locale('en'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(body: LabTab()),
          ),
        ),
      ),
    );
    expect(find.text('Classic Espresso'), findsOneWidget);
    expect(find.textContaining('Needs a recipe scoring'), findsOneWidget);

    await tester.tap(find.byKey(const Key('open_recipe_espresso_classic')));
    await tester.pumpAndSettle();
    expect(find.byType(Slider), findsNWidgets(4));

    await tester.ensureVisible(find.byKey(RecipeScreen.testButtonKey));
    await tester.tap(find.byKey(RecipeScreen.testButtonKey));
    await tester.pump();
    expect(cubit.state.lab.activeBrew, isNotNull);
    expect(find.textContaining('Brewing'), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
