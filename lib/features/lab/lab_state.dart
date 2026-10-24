import 'package:equatable/equatable.dart';

import '../../config/economy_config.dart';
import '../../engine/lab_math.dart';

class RecipeProgress extends Equatable {
  const RecipeProgress({
    this.unlocked = false,
    this.bestScore = 0,
    this.lastScore,
    this.lastHint,
  });

  factory RecipeProgress.fromJson(Map<String, dynamic> json) {
    final hint = json['lastHint'] as Map<String, dynamic>?;
    return RecipeProgress(
      unlocked: json['unlocked'] as bool? ?? false,
      bestScore: (json['bestScore'] as num?)?.toInt() ?? 0,
      lastScore: (json['lastScore'] as num?)?.toInt(),
      lastHint: hint == null ? null : BrewHint.fromJson(hint),
    );
  }

  final bool unlocked;
  final int bestScore;
  final int? lastScore;
  final BrewHint? lastHint;

  RecipeProgress copyWith({
    bool? unlocked,
    int? bestScore,
    int? lastScore,
    BrewHint? lastHint,
  }) => RecipeProgress(
    unlocked: unlocked ?? this.unlocked,
    bestScore: bestScore ?? this.bestScore,
    lastScore: lastScore ?? this.lastScore,
    lastHint: lastHint ?? this.lastHint,
  );

  Map<String, dynamic> toJson() => {
    'unlocked': unlocked,
    'bestScore': bestScore,
    if (lastScore != null) 'lastScore': lastScore,
    if (lastHint != null) 'lastHint': lastHint?.toJson(),
  };

  @override
  List<Object?> get props => [unlocked, bestScore, lastScore, lastHint];
}

class ActiveBrew extends Equatable {
  const ActiveBrew({
    required this.recipeId,
    required this.endsAt,
    required this.sliders,
  });

  factory ActiveBrew.fromJson(Map<String, dynamic> json) => ActiveBrew(
    recipeId: json['recipeId'] as String,
    endsAt: DateTime.parse(json['endsAt'] as String).toUtc(),
    sliders: FlavorProfile.fromJson(json['sliders'] as Map<String, dynamic>),
  );

  final String recipeId;
  final DateTime endsAt;
  final FlavorProfile sliders;

  bool isDone(DateTime now) => !now.isBefore(endsAt);

  ActiveBrew copyWith({DateTime? endsAt}) => ActiveBrew(
    recipeId: recipeId,
    endsAt: endsAt ?? this.endsAt,
    sliders: sliders,
  );

  Map<String, dynamic> toJson() => {
    'recipeId': recipeId,
    'endsAt': endsAt.toUtc().toIso8601String(),
    'sliders': sliders.toJson(),
  };

  @override
  List<Object?> get props => [recipeId, endsAt, sliders];
}

class LabState extends Equatable {
  const LabState({
    this.recipes = const {},
    this.activeBrew,
    this.capsuleMachines = 0,
  });

  final Map<String, RecipeProgress> recipes;
  final ActiveBrew? activeBrew;
  final int capsuleMachines;

  RecipeProgress progressOf(String recipeId) =>
      recipes[recipeId] ?? const RecipeProgress();

  bool isUnlocked(RecipeConfig recipe) =>
      recipe.unlockCost.isZero || progressOf(recipe.id).unlocked;

  Map<String, int> get bestScores => {
    for (final entry in recipes.entries) entry.key: entry.value.bestScore,
  };

  LabState copyWith({
    Map<String, RecipeProgress>? recipes,
    ActiveBrew? Function()? activeBrew,
    int? capsuleMachines,
  }) => LabState(
    recipes: recipes ?? this.recipes,
    activeBrew: activeBrew == null ? this.activeBrew : activeBrew(),
    capsuleMachines: capsuleMachines ?? this.capsuleMachines,
  );

  LabState withRecipe(String recipeId, RecipeProgress progress) =>
      copyWith(recipes: {...recipes, recipeId: progress});

  @override
  List<Object?> get props => [recipes, activeBrew, capsuleMachines];
}
