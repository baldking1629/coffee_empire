import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/time/clock.dart';
import 'game_state.dart';
import 'save_migrations.dart';

enum SaveSource { current, backup, fresh }

class SaveLoadResult {
  const SaveLoadResult({
    required this.state,
    required this.source,
    required this.corrupted,
  });

  final GameState? state;
  final SaveSource source;
  final bool corrupted;
}

class SaveRepository {
  SaveRepository(
    this._preferences, {
    required Clock clock,
    SaveMigrations migrations = const SaveMigrations(),
  }) : _clock = clock,
       _migrations = migrations;

  static const String currentKey = 'save_current';
  static const String backupKey = 'save_backup';

  final SharedPreferences _preferences;
  final Clock _clock;
  final SaveMigrations _migrations;

  Future<GameState> save(GameState state) async {
    final saved = state.copyWith(savedAt: _clock.now().toUtc());
    final payload = jsonEncode({
      SaveMigrations.versionKey: _migrations.currentVersion,
      ...saved.toJson(),
    });
    final previous = _preferences.getString(currentKey);
    if (previous != null) {
      await _preferences.setString(backupKey, previous);
    }
    await _preferences.setString(currentKey, payload);
    return saved;
  }

  SaveLoadResult load() {
    final current = _preferences.getString(currentKey);
    if (current == null) {
      return const SaveLoadResult(
        state: null,
        source: SaveSource.fresh,
        corrupted: false,
      );
    }
    final fromCurrent = _decode(current);
    if (fromCurrent != null) {
      return SaveLoadResult(
        state: fromCurrent,
        source: SaveSource.current,
        corrupted: false,
      );
    }
    final backup = _preferences.getString(backupKey);
    final fromBackup = backup == null ? null : _decode(backup);
    if (fromBackup != null) {
      return SaveLoadResult(
        state: fromBackup,
        source: SaveSource.backup,
        corrupted: false,
      );
    }
    return const SaveLoadResult(
      state: null,
      source: SaveSource.fresh,
      corrupted: true,
    );
  }

  Future<void> clear() async {
    await _preferences.remove(currentKey);
    await _preferences.remove(backupKey);
  }

  GameState? _decode(String raw) {
    try {
      final json = jsonDecode(raw);
      if (json is! Map<String, dynamic>) return null;
      return GameState.fromJson(_migrations.migrate(json));
    } on FormatException {
      return null;
    } on TypeError {
      return null;
    }
  }
}
