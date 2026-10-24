import '../../core/bignumber/big_number.dart';
import '../lab/lab_state.dart';
import 'game_settings.dart';
import 'game_state.dart';

typedef JsonMap = Map<String, dynamic>;

GameState gameStateFromJson(JsonMap json) {
  final savedAt = json['savedAt'] as String?;
  final activeBrew = json['activeBrew'] as JsonMap?;
  return GameState(
    cash: BigNumber.fromJson(json['cash']),
    runEarnings: BigNumber.fromJson(json['runEarnings']),
    lifetimeEarnings: BigNumber.fromJson(json['lifetimeEarnings']),
    incomePerSec: BigNumber.zero,
    goldenBeans: _int(json['goldenBeans']),
    prestigeCount: _int(json['prestigeCount']),
    shopLevels: _intMap(json['shopLevels']),
    managers: (json['managers'] as JsonMap).map(
      (id, owned) => MapEntry(id, owned as bool),
    ),
    equipment: _intMap(json['equipment']),
    lab: LabState(
      recipes: (json['recipes'] as JsonMap).map(
        (id, progress) =>
            MapEntry(id, RecipeProgress.fromJson(progress as JsonMap)),
      ),
      activeBrew: activeBrew == null ? null : ActiveBrew.fromJson(activeBrew),
      capsuleMachines: _int(json['capsuleMachines']),
    ),
    stats: GameStats.fromJson(json['stats'] as JsonMap),
    tutorialStep: _int(json['tutorialStep']),
    settings: GameSettings.fromJson(json['settings'] as JsonMap),
    savedAt: savedAt == null ? null : DateTime.parse(savedAt).toUtc(),
  );
}

JsonMap gameStateToJson(GameState state) => {
  'cash': state.cash.toJson(),
  'runEarnings': state.runEarnings.toJson(),
  'lifetimeEarnings': state.lifetimeEarnings.toJson(),
  'goldenBeans': state.goldenBeans,
  'prestigeCount': state.prestigeCount,
  'shopLevels': state.shopLevels,
  'managers': state.managers,
  'equipment': state.equipment,
  'recipes': state.lab.recipes.map((id, p) => MapEntry(id, p.toJson())),
  'activeBrew': state.lab.activeBrew?.toJson(),
  'capsuleMachines': state.lab.capsuleMachines,
  'stats': state.stats.toJson(),
  'tutorialStep': state.tutorialStep,
  'settings': state.settings.toJson(),
  if (state.savedAt != null)
    'savedAt': state.savedAt?.toUtc().toIso8601String(),
};

int _int(Object? value) => (value as num).toInt();

Map<String, int> _intMap(Object? json) =>
    (json as JsonMap).map((id, value) => MapEntry(id, _int(value)));
