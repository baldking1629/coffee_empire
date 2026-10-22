import 'package:coffee_empire/config/economy_config.dart';
import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:coffee_empire/features/game/game_cubit.dart';
import 'package:coffee_empire/features/game/game_state.dart';
import 'package:coffee_empire/features/game/save_repository.dart';
import 'package:coffee_empire/features/shops/shops_tab.dart';
import 'package:coffee_empire/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/fake_clock.dart';
import '../../helpers/test_economy.dart';

class MockSaveRepository extends Mock implements SaveRepository {}

void main() {
  final config = loadTestEconomy();

  setUpAll(
    () =>
        registerFallbackValue(GameState.initial(startingCash: BigNumber.zero)),
  );

  Future<GameCubit> pumpShops(WidgetTester tester, String cash) async {
    final repository = MockSaveRepository();
    when(() => repository.save(any())).thenAnswer(
      (invocation) async => invocation.positionalArguments.first as GameState,
    );
    final cubit = GameCubit(
      config: config,
      repository: repository,
      clock: FakeClock(DateTime.utc(2026, 1, 1)),
      restored: GameState.initial(startingCash: BigNumber.parse(cash)),
    );
    await tester.pumpWidget(
      RepositoryProvider<EconomyConfig>.value(
        value: config,
        child: BlocProvider.value(
          value: cubit,
          child: const MaterialApp(
            locale: Locale('en'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(body: ShopsTab()),
          ),
        ),
      ),
    );
    return cubit;
  }

  FilledButton buyButton(WidgetTester tester, String shopId) =>
      tester.widget<FilledButton>(find.byKey(Key('buy_shop_$shopId')));

  testWidgets('buy button is disabled without enough cash', (tester) async {
    await pumpShops(tester, '3');
    expect(buyButton(tester, 'street_cart').onPressed, isNull);
    expect(find.text('Unlocks after buying Street Cart'), findsOneWidget);
  });

  testWidgets('buying the first shop unlocks upgrades and the next shop', (
    tester,
  ) async {
    final cubit = await pumpShops(tester, '5');
    expect(buyButton(tester, 'street_cart').onPressed, isNotNull);
    await tester.tap(find.byKey(const Key('buy_shop_street_cart')));
    await tester.pump();
    expect(cubit.state.shopLevels['street_cart'], 1);
    expect(find.text('Lv. 1'), findsOneWidget);
    expect(find.byKey(const Key('hire_manager_street_cart')), findsOneWidget);
    expect(find.byKey(const Key('buy_shop_corner_booth')), findsOneWidget);
  });

  testWidgets('x10 disables when ten are unaffordable while MAX stays active', (
    tester,
  ) async {
    await pumpShops(tester, '10');
    await tester.tap(find.text('x10'));
    await tester.pump();
    expect(buyButton(tester, 'street_cart').onPressed, isNull);
    await tester.tap(find.text('MAX'));
    await tester.pump();
    expect(buyButton(tester, 'street_cart').onPressed, isNotNull);
    expect(find.textContaining('Buy x2'), findsOneWidget);
  });
}
