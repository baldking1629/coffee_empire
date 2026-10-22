typedef SaveJson = Map<String, dynamic>;
typedef SaveMigration = SaveJson Function(SaveJson);

class SaveMigrations {
  const SaveMigrations({
    this.currentVersion = latestSchemaVersion,
    this.steps = defaultSteps,
  });

  static const int latestSchemaVersion = 1;
  static const String versionKey = 'schemaVersion';
  static const Map<int, SaveMigration> defaultSteps = {};

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
}
