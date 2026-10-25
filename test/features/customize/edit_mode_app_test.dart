import 'package:coffee_empire/app/app.dart';
import 'package:coffee_empire/config/economy_config.dart';
import 'package:coffee_empire/features/customize/edit_toolbar.dart';
import 'package:coffee_empire/features/game/game_cubit.dart';
import 'package:coffee_empire/features/game/save_repository.dart';
import 'package:coffee_empire/features/home/widgets/cafe_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/cafe_driver.dart';
import '../../helpers/cafe_files.dart';
import '../../helpers/fake_clock.dart';
import '../../helpers/test_economy.dart';

void main() {
  testWidgets('edit mode stays on while the game keeps ticking', (
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
    await tester.tap(find.byKey(CafeView.editButtonKey));
    await tester.pump(const Duration(milliseconds: 100));
    final game = cafeViewState(tester).game;
    expect(game.isEditing, isTrue);
    for (var second = 0; second < 5; second++) {
      clock.advance(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 1));
    }
    expect(identical(cafeViewState(tester).game, game), isTrue);
    expect(game.isEditing, isTrue);
    expect(find.byType(EditToolbar), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
    await cubit.close();
  });
}
