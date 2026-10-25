typedef SaveJson = Map<String, dynamic>;
typedef SaveMigration = SaveJson Function(SaveJson);

class SaveMigrations {
  const SaveMigrations({
    this.currentVersion = latestSchemaVersion,
    this.steps = defaultSteps,
  });

  static const int latestSchemaVersion = 7;
  static const String versionKey = 'schemaVersion';
  static const Map<int, SaveMigration> defaultSteps = {
    1: _addLab,
    2: _addFranchises,
    3: _addStore,
    4: _addAchievements,
    5: _addServiceStats,
    6: _addCafeLayout,
  };

  final int currentVersion;
  final Map<int, SaveMigration> steps;

  SaveJson migrate(SaveJson json) {
    final version = json[versionKey];
    if (version is! int || version < 1 || version > currentVersion) {
      throw FormatException('Unsupported save schema: $version');
    }
    var migrated = Map<String, dynamic>.of(json);
    for (var from = version; from < currentVersion; from++) {
      final step = steps[from];
      if (step == null) {
        throw FormatException('Missing migration from schema $from');
      }
      migrated = step(migrated)..[versionKey] = from + 1;
    }
    return migrated;
  }

  static SaveJson _addLab(SaveJson json) => {
    ...json,
    'recipes': json['recipes'] ?? <String, dynamic>{},
    'activeBrew': json['activeBrew'],
    'capsuleMachines': json['capsuleMachines'] ?? 0,
  };

  static SaveJson _addFranchises(SaveJson json) => {
    ...json,
    'franchises': json['franchises'] ?? <String, dynamic>{},
  };

  static SaveJson _addStore(SaveJson json) => {
    ...json,
    'boosts': json['boosts'] ?? <dynamic>[],
    'purchases': json['purchases'] ?? <dynamic>[],
    'rewardedCooldowns': json['rewardedCooldowns'] ?? <String, dynamic>{},
    'dailyReward': json['dailyReward'] ?? <String, dynamic>{'streak': 0},
  };

  static SaveJson _addAchievements(SaveJson json) => {
    ...json,
    'achievements': json['achievements'] ?? <dynamic>[],
  };

  static SaveJson _addServiceStats(SaveJson json) {
    final stats = Map<String, dynamic>.of(
      json['stats'] as Map<String, dynamic>? ?? const {},
    );
    for (final key in ['ordersServed', 'perfectServes', 'customersLost']) {
      stats[key] ??= 0;
    }
    return {...json, 'stats': stats};
  }

  static SaveJson _addCafeLayout(SaveJson json) => {
    ...json,
    'cafeLayout':
        json['cafeLayout'] ??
        <String, dynamic>{'roomTier': 1, 'items': <dynamic>[]},
    'inventory': json['inventory'] ?? <String, dynamic>{},
  };
}
