import 'package:coffee_empire/features/game/game_state.dart';
import 'package:coffee_empire/features/game/save_migrations.dart';
import 'package:flutter_test/flutter_test.dart';

const v1Sample = <String, dynamic>{
  'schemaVersion': 1,
  'savedAt': '2026-01-01T00:00:00.000Z',
  'cash': '1.25e3',
  'runEarnings': '2e3',
  'lifetimeEarnings': '2e3',
  'goldenBeans': 0,
  'prestigeCount': 0,
  'shopLevels': <String, dynamic>{},
  'managers': <String, dynamic>{},
  'equipment': <String, dynamic>{},
  'stats': <String, dynamic>{'totalTaps': 10, 'cupsFilled': 1},
  'tutorialStep': 0,
  'settings': <String, dynamic>{'locale': 'system'},
};

void main() {
  test('v1 sample migrates to the latest schema and parses', () {
    final migrated = const SaveMigrations().migrate(v1Sample);
    expect(migrated['schemaVersion'], SaveMigrations.latestSchemaVersion);
    final state = GameState.fromJson(migrated);
    expect(state.stats.totalTaps, 10);
    expect(state.lab.recipes, isEmpty);
    expect(state.lab.activeBrew, isNull);
    expect(state.lab.capsuleMachines, 0);
    expect(state.franchises, isEmpty);
  });

  test('migration steps are chained in order', () {
    final migrations = SaveMigrations(
      currentVersion: 3,
      steps: {
        1: (json) => {...json, 'trail': 'a'},
        2: (json) => {...json, 'trail': '${json['trail']}b'},
      },
    );
    final migrated = migrations.migrate(v1Sample);
    expect(migrated['trail'], 'ab');
    expect(migrated['schemaVersion'], 3);
  });

  test('missing or invalid version throws FormatException', () {
    expect(() => const SaveMigrations().migrate({}), throwsFormatException);
    expect(
      () => const SaveMigrations(
        currentVersion: SaveMigrations.latestSchemaVersion + 1,
      ).migrate(v1Sample),
      throwsFormatException,
    );
  });
}
