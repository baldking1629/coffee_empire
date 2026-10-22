import 'dart:convert';

import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:coffee_empire/features/game/game_settings.dart';
import 'package:coffee_empire/features/game/game_state.dart';
import 'package:coffee_empire/features/game/save_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/fake_clock.dart';

GameState sampleState() => GameState(
  cash: BigNumber.parse('1.5e12'),
  runEarnings: BigNumber.parse('2e12'),
  lifetimeEarnings: BigNumber.parse('9.9e450'),
  incomePerSec: BigNumber.zero,
  goldenBeans: 7,
  prestigeCount: 2,
  shopLevels: const {'street_cart': 12, 'corner_booth': 3},
  managers: const {'street_cart': true},
  equipment: const {'street_cart': 1},
  stats: const GameStats(totalTaps: 420, cupsFilled: 42),
  tutorialStep: 3,
  settings: const GameSettings(locale: 'tr', scientific: true),
);

void main() {
  final clock = FakeClock(DateTime.utc(2026, 5, 1, 12));

  Future<(SaveRepository, SharedPreferences)> repositoryWith(
    Map<String, Object> values,
  ) async {
    SharedPreferences.setMockInitialValues(values);
    final preferences = await SharedPreferences.getInstance();
    return (SaveRepository(preferences, clock: clock), preferences);
  }

  test('round-trips state with schema version and savedAt', () async {
    final (repository, preferences) = await repositoryWith({});
    final saved = await repository.save(sampleState());
    final raw = jsonDecode(
      preferences.getString(SaveRepository.currentKey) ?? '',
    );
    expect(raw['schemaVersion'], 1);
    expect(raw['savedAt'], '2026-05-01T12:00:00.000Z');
    expect(raw['cash'], '1.5e12');

    final loaded = repository.load();
    expect(loaded.source, SaveSource.current);
    expect(loaded.state, saved);
    expect(loaded.state, sampleState().copyWith(savedAt: clock.now()));
  });

  test('copies previous save into backup before writing', () async {
    final (repository, preferences) = await repositoryWith({});
    await repository.save(sampleState());
    final first = preferences.getString(SaveRepository.currentKey);
    await repository.save(sampleState().copyWith(goldenBeans: 99));
    expect(preferences.getString(SaveRepository.backupKey), first);
  });

  test('corrupt current save falls back to backup', () async {
    final (seed, preferences) = await repositoryWith({});
    await seed.save(sampleState());
    final valid = preferences.getString(SaveRepository.currentKey) ?? '';
    final (repository, _) = await repositoryWith({
      SaveRepository.currentKey: '{"schemaVersion": 1, "cash": ',
      SaveRepository.backupKey: valid,
    });
    final loaded = repository.load();
    expect(loaded.source, SaveSource.backup);
    expect(loaded.state?.goldenBeans, 7);
    expect(loaded.corrupted, isFalse);
  });

  test('both saves corrupt starts a new game and flags corruption', () async {
    final (repository, _) = await repositoryWith({
      SaveRepository.currentKey: 'not json',
      SaveRepository.backupKey: '{"schemaVersion": 1, "cash": 5}',
    });
    final loaded = repository.load();
    expect(loaded.state, isNull);
    expect(loaded.source, SaveSource.fresh);
    expect(loaded.corrupted, isTrue);
  });

  test('unknown future schema is treated as corrupt', () async {
    final (repository, _) = await repositoryWith({
      SaveRepository.currentKey: '{"schemaVersion": 999}',
    });
    expect(repository.load().corrupted, isTrue);
  });

  test('no save means fresh game without corruption', () async {
    final (repository, _) = await repositoryWith({});
    final loaded = repository.load();
    expect(loaded.state, isNull);
    expect(loaded.corrupted, isFalse);
  });
}
