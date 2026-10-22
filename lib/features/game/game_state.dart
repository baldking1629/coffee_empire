import 'package:equatable/equatable.dart';

import '../../core/bignumber/big_number.dart';
import '../../engine/barista_math.dart';
import 'game_settings.dart';

class GameState extends Equatable {
  const GameState({
    required this.cash,
    required this.runEarnings,
    required this.lifetimeEarnings,
    required this.incomePerSec,
    this.goldenBeans = 0,
    this.prestigeCount = 0,
    this.shopLevels = const {},
    this.managers = const {},
    this.equipment = const {},
    this.stats = const GameStats(),
    this.tutorialStep = 0,
    this.settings = const GameSettings(),
    this.savedAt,
    this.barista = BaristaState.idle,
  });

  factory GameState.initial({required BigNumber startingCash}) => GameState(
    cash: startingCash,
    runEarnings: BigNumber.zero,
    lifetimeEarnings: BigNumber.zero,
    incomePerSec: BigNumber.zero,
  );

  factory GameState.fromJson(Map<String, dynamic> json) {
    final savedAt = json['savedAt'] as String?;
    return GameState(
      cash: BigNumber.fromJson(json['cash']),
      runEarnings: BigNumber.fromJson(json['runEarnings']),
      lifetimeEarnings: BigNumber.fromJson(json['lifetimeEarnings']),
      incomePerSec: BigNumber.zero,
      goldenBeans: (json['goldenBeans'] as num).toInt(),
      prestigeCount: (json['prestigeCount'] as num).toInt(),
      shopLevels: _intMap(json['shopLevels']),
      managers: (json['managers'] as Map<String, dynamic>).map(
        (id, owned) => MapEntry(id, owned as bool),
      ),
      equipment: _intMap(json['equipment']),
      stats: GameStats.fromJson(json['stats'] as Map<String, dynamic>),
      tutorialStep: (json['tutorialStep'] as num).toInt(),
      settings: GameSettings.fromJson(json['settings'] as Map<String, dynamic>),
      savedAt: savedAt == null ? null : DateTime.parse(savedAt).toUtc(),
    );
  }

  final BigNumber cash;
  final BigNumber runEarnings;
  final BigNumber lifetimeEarnings;
  final BigNumber incomePerSec;
  final int goldenBeans;
  final int prestigeCount;
  final Map<String, int> shopLevels;
  final Map<String, bool> managers;
  final Map<String, int> equipment;
  final GameStats stats;
  final int tutorialStep;
  final GameSettings settings;
  final DateTime? savedAt;
  final BaristaState barista;

  GameState earn(BigNumber amount) => amount.isZero
      ? this
      : copyWith(
          cash: cash + amount,
          runEarnings: runEarnings + amount,
          lifetimeEarnings: lifetimeEarnings + amount,
        );

  GameState copyWith({
    BigNumber? cash,
    BigNumber? runEarnings,
    BigNumber? lifetimeEarnings,
    BigNumber? incomePerSec,
    int? goldenBeans,
    int? prestigeCount,
    Map<String, int>? shopLevels,
    Map<String, bool>? managers,
    Map<String, int>? equipment,
    GameStats? stats,
    int? tutorialStep,
    GameSettings? settings,
    DateTime? savedAt,
    BaristaState? barista,
  }) => GameState(
    cash: cash ?? this.cash,
    runEarnings: runEarnings ?? this.runEarnings,
    lifetimeEarnings: lifetimeEarnings ?? this.lifetimeEarnings,
    incomePerSec: incomePerSec ?? this.incomePerSec,
    goldenBeans: goldenBeans ?? this.goldenBeans,
    prestigeCount: prestigeCount ?? this.prestigeCount,
    shopLevels: shopLevels ?? this.shopLevels,
    managers: managers ?? this.managers,
    equipment: equipment ?? this.equipment,
    stats: stats ?? this.stats,
    tutorialStep: tutorialStep ?? this.tutorialStep,
    settings: settings ?? this.settings,
    savedAt: savedAt ?? this.savedAt,
    barista: barista ?? this.barista,
  );

  Map<String, dynamic> toJson() => {
    'cash': cash.toJson(),
    'runEarnings': runEarnings.toJson(),
    'lifetimeEarnings': lifetimeEarnings.toJson(),
    'goldenBeans': goldenBeans,
    'prestigeCount': prestigeCount,
    'shopLevels': shopLevels,
    'managers': managers,
    'equipment': equipment,
    'stats': stats.toJson(),
    'tutorialStep': tutorialStep,
    'settings': settings.toJson(),
    if (savedAt != null) 'savedAt': savedAt?.toUtc().toIso8601String(),
  };

  static Map<String, int> _intMap(Object? json) =>
      (json as Map<String, dynamic>).map(
        (id, value) => MapEntry(id, (value as num).toInt()),
      );

  @override
  List<Object?> get props => [
    cash,
    runEarnings,
    lifetimeEarnings,
    incomePerSec,
    goldenBeans,
    prestigeCount,
    shopLevels,
    managers,
    equipment,
    stats,
    tutorialStep,
    settings,
    savedAt,
    barista,
  ];
}
