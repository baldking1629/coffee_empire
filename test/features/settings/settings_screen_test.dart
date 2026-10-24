import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:coffee_empire/features/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/cubit_harness.dart';
import '../../helpers/pump_app.dart';

void main() {
  testWidgets('toggles settings and resets progress after confirmation', (
    tester,
  ) async {
    final harness = CubitHarness();
    when(harness.repository.clear).thenAnswer((_) async {});
    final cubit = harness.build(
      harness
          .stateWithCash('1e9')
          .copyWith(goldenBeans: 12, shopLevels: {'street_cart': 40}),
    );
    await pumpWithGame(
      tester,
      config: harness.config,
      cubit: cubit,
      child: const SettingsScreen(),
    );

    await tester.tap(find.byKey(const Key('settings_scientific')));
    await tester.pumpAndSettle();
    expect(cubit.state.settings.scientific, isTrue);

    await tester.tap(find.byKey(SettingsScreen.languageKey));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Türkçe').last);
    await tester.pumpAndSettle();
    expect(cubit.state.settings.locale, 'tr');

    await tester.tap(find.byKey(SettingsScreen.resetKey));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('settings_reset_confirm')));
    await tester.pumpAndSettle();
    expect(cubit.state.goldenBeans, 0);
    expect(cubit.state.shopLevels, isEmpty);
    expect(cubit.state.cash, BigNumber.fromInt(5));
    expect(cubit.state.settings.scientific, isTrue);
    verify(harness.repository.clear).called(1);
  });
}
