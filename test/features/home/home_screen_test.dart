import 'package:coffee_empire/app/app.dart';
import 'package:coffee_empire/config/economy_config.dart';
import 'package:coffee_empire/features/game/game_cubit.dart';
import 'package:coffee_empire/features/game/save_repository.dart';
import 'package:coffee_empire/features/home/widgets/cash_header.dart';
import 'package:coffee_empire/features/home/widgets/counting_money_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/cafe_driver.dart';
import '../../helpers/cafe_files.dart';
import '../../helpers/fake_clock.dart';
import '../../helpers/test_economy.dart';

void main() {
  testWidgets('serving a customer at the counter pays into the cash', (
    tester,
  ) async {
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
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<EconomyConfig>.value(value: config),
          ...cafeProviders(),
        ],
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
    expect(find.byType(NavigationDestination), findsNWidgets(5));

    await serveNextCustomer(tester);
    await tester.pump(CountingMoneyText.duration);
    expect(cubit.state.stats.ordersServed, 1);
    expect(cashText(), anyOf(r'$6', r'$6.5'));
    expect(tester.takeException(), isNull);

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
