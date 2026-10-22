import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:coffee_empire/features/game/game_cubit.dart';
import 'package:coffee_empire/features/game/game_state.dart';
import 'package:coffee_empire/features/game/save_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/fake_clock.dart';
import '../../helpers/test_economy.dart';

class MockSaveRepository extends Mock implements SaveRepository {}

void main() {
  final config = loadTestEconomy();
  late FakeClock clock;
  late MockSaveRepository repository;

  setUpAll(
    () =>
        registerFallbackValue(GameState.initial(startingCash: BigNumber.zero)),
  );

  setUp(() {
    clock = FakeClock(DateTime.utc(2026, 1, 1));
    repository = MockSaveRepository();
    when(() => repository.save(any())).thenAnswer(
      (invocation) async => (invocation.positionalArguments.first as GameState)
          .copyWith(savedAt: clock.now()),
    );
  });

  GameCubit build({GameState? restored}) => GameCubit(
    config: config,
    repository: repository,
    clock: clock,
    restored: restored,
  );

  test('new game starts with starting cash and zero income', () {
    final cubit = build();
    expect(cubit.state.cash, config.startingCash);
    expect(cubit.state.incomePerSec, BigNumber.zero);
  });

  blocTest<GameCubit, GameState>(
    'filling a cup adds the minimum payout to cash and earnings',
    build: build,
    act: (cubit) {
      for (var i = 0; i < 10; i++) {
        cubit.tapCup();
      }
    },
    verify: (cubit) {
      expect(cubit.state.cash, config.startingCash + BigNumber.one);
      expect(cubit.state.lifetimeEarnings, BigNumber.one);
      expect(cubit.state.stats.totalTaps, 10);
      expect(cubit.state.stats.cupsFilled, 1);
    },
  );

  blocTest<GameCubit, GameState>(
    'tick credits income times delta',
    build: () => build(
      restored: GameState.initial(
        startingCash: BigNumber.zero,
      ).copyWith(shopLevels: const {'street_cart': 2}),
    ),
    act: (cubit) => cubit.tick(3),
    verify: (cubit) {
      expect(cubit.state.cash.toDouble(), closeTo(0.5 * 2 * 3, 1e-9));
    },
  );

  blocTest<GameCubit, GameState>(
    'negative delta never lowers cash',
    build: build,
    act: (cubit) => cubit.tick(-100),
    verify: (cubit) => expect(cubit.state.cash, config.startingCash),
  );

  blocTest<GameCubit, GameState>(
    'autosaves once the interval has elapsed',
    build: build,
    act: (cubit) async {
      for (var i = 0; i < config.autosaveIntervalSeconds; i++) {
        await cubit.tick(1);
      }
    },
    verify: (_) => verify(() => repository.save(any())).called(1),
  );
}
