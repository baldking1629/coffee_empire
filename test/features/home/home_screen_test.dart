import 'package:coffee_empire/app/app.dart';
import 'package:coffee_empire/config/economy_config.dart';
import 'package:coffee_empire/features/game/game_cubit.dart';
import 'package:coffee_empire/features/game/save_repository.dart';
import 'package:coffee_empire/features/home/widgets/barista_tap_area.dart';
import 'package:coffee_empire/features/home/widgets/cash_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/fake_clock.dart';
import '../../helpers/test_economy.dart';

void main() {
  testWidgets('tapping the cup ten times adds a dollar', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final clock = FakeClock(DateTime.utc(2026, 1, 1));
    final config = loadTestEconomy();
    final cubit = GameCubit(
      config: config,
      repository: SaveRepository(preferences, clock: clock),
      clock: clock,
    );
    await tester.pumpWidget(
      RepositoryProvider<EconomyConfig>.value(
        value: config,
        child: BlocProvider.value(
          value: cubit,
          child: CoffeeEmpireApp(clock: clock),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));

    String cashText() =>
        tester.widget<Text>(find.byKey(CashHeader.cashTextKey)).data ?? '';
    expect(cashText(), r'$5');
    expect(find.byType(NavigationDestination), findsNWidgets(4));

    for (var i = 0; i < 10; i++) {
      await tester.tap(find.byKey(BaristaTapArea.cupKey));
      await tester.pump(const Duration(milliseconds: 50));
    }
    expect(cashText(), r'$6');

    for (var cup = 1; cup < 6; cup++) {
      clock.advance(const Duration(seconds: 1));
      for (var i = 0; i < 10; i++) {
        await tester.tap(find.byKey(BaristaTapArea.cupKey));
      }
      await tester.pump(const Duration(milliseconds: 300));
      if (cup < 5) expect(find.text('Combo x$cup'), findsOneWidget);
    }
    expect(find.text('Barista Rush!'), findsNWidgets(2));
    expect(cashText(), r'$11');

    await tester.pumpWidget(const SizedBox.shrink());
    await cubit.close();
  });

  test('device locale falls back to English when unsupported', () {
    const supported = [Locale('en'), Locale('tr')];
    expect(
      resolveSupportedLocale(const Locale('tr', 'TR'), supported),
      const Locale('tr'),
    );
    expect(
      resolveSupportedLocale(const Locale('xx'), supported),
      const Locale('en'),
    );
    expect(resolveSupportedLocale(null, supported), const Locale('en'));
  });
}
