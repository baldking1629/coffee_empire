import '../../core/bignumber/big_number.dart';
import '../../engine/boost_math.dart';
import '../daily_reward/daily_reward_state.dart';
import '../lab/lab_state.dart';
import '../store/store_state.dart';
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
    franchises: _intMap(json['franchises']),
    store: StoreState(
      boosts: (json['boosts'] as List<dynamic>)
          .cast<JsonMap>()
          .map(ActiveBoost.fromJson)
          .toList(),
      purchases: (json['purchases'] as List<dynamic>).cast<String>().toSet(),
      rewardedCooldowns: (json['rewardedCooldowns'] as JsonMap).map(
        (type, endsAt) =>
            MapEntry(type, DateTime.parse(endsAt as String).toUtc()),
      ),
    ),
    dailyReward: DailyRewardState.fromJson(json['dailyReward'] as JsonMap),
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
  'franchises': state.franchises,
  'boosts': [for (final boost in state.store.boosts) boost.toJson()],
  'purchases': state.store.purchases.toList(),
  'rewardedCooldowns': state.store.rewardedCooldowns.map(
    (type, endsAt) => MapEntry(type, endsAt.toUtc().toIso8601String()),
  ),
  'dailyReward': state.dailyReward.toJson(),
  'stats': state.stats.toJson(),
  'tutorialStep': state.tutorialStep,
  'settings': state.settings.toJson(),
  if (state.savedAt != null)
    'savedAt': state.savedAt?.toUtc().toIso8601String(),
};

int _int(Object? value) => (value as num).toInt();

Map<String, int> _intMap(Object? json) =>
    (json as JsonMap).map((id, value) => MapEntry(id, _int(value)));
