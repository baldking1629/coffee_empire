import 'package:coffee_empire/config/economy_config.dart';
import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:coffee_empire/features/game/game_cubit.dart';
import 'package:coffee_empire/features/game/game_state.dart';
import 'package:coffee_empire/features/game/save_repository.dart';
import 'package:mocktail/mocktail.dart';

import 'fake_clock.dart';
import 'test_economy.dart';

class MockSaveRepository extends Mock implements SaveRepository {}

class CubitHarness {
  CubitHarness({EconomyConfig? config, DateTime? start})
    : config = config ?? loadTestEconomy(),
      clock = FakeClock(start ?? DateTime.utc(2026, 1, 1)),
      repository = MockSaveRepository() {
    registerFallbackValue(GameState.initial(startingCash: BigNumber.zero));
    when(() => repository.save(any())).thenAnswer(
      (invocation) async => (invocation.positionalArguments.first as GameState)
          .copyWith(savedAt: clock.now()),
    );
  }

  final EconomyConfig config;
  final FakeClock clock;
  final MockSaveRepository repository;

  GameState stateWithCash(String cash) =>
      GameState.initial(startingCash: BigNumber.parse(cash));

  GameCubit build([GameState? restored]) => GameCubit(
    config: config,
    repository: repository,
    clock: clock,
    restored: restored,
  );
}
