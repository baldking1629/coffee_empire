import 'package:equatable/equatable.dart';

import '../../core/bignumber/big_number.dart';
import '../../engine/barista_math.dart';
import '../lab/lab_state.dart';
import 'game_settings.dart';
import 'game_state_json.dart';

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
    this.lab = const LabState(),
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

  factory GameState.fromJson(Map<String, dynamic> json) =>
      gameStateFromJson(json);

  final BigNumber cash;
  final BigNumber runEarnings;
  final BigNumber lifetimeEarnings;
  final BigNumber incomePerSec;
  final int goldenBeans;
  final int prestigeCount;
  final Map<String, int> shopLevels;
  final Map<String, bool> managers;
  final Map<String, int> equipment;
  final LabState lab;
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

  GameState spend(BigNumber amount) => copyWith(cash: cash - amount);

  Map<String, dynamic> toJson() => gameStateToJson(this);

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
    LabState? lab,
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
    lab: lab ?? this.lab,
    stats: stats ?? this.stats,
    tutorialStep: tutorialStep ?? this.tutorialStep,
    settings: settings ?? this.settings,
    savedAt: savedAt ?? this.savedAt,
    barista: barista ?? this.barista,
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
    lab,
    stats,
    tutorialStep,
    settings,
    savedAt,
    barista,
  ];
}
