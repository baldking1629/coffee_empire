import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/achievement_config.dart';
import '../../config/economy_config.dart';
import '../../core/bignumber/big_number.dart';
import '../../core/services/analytics_service.dart';
import '../../core/services/monetization_service.dart';
import '../../core/time/clock.dart';
import '../../engine/achievement_math.dart';
import '../../engine/barista_math.dart';
import '../../engine/economy_engine.dart';
import '../../engine/service_math.dart';
import '../../engine/shop_math.dart';
import '../daily_reward/daily_reward_actions.dart';
import '../growth/franchise_actions.dart';
import '../growth/prestige_actions.dart';
import '../lab/lab_actions.dart';
import '../shops/shop_actions.dart';
import '../store/store_actions.dart';
import '../tutorial/tutorial_rules.dart';
import 'game_feedback.dart';
import 'game_settings.dart';
import 'game_state.dart';
import 'offline_actions.dart';
import 'save_repository.dart';

part 'game_cubit_commands.dart';
part 'game_cubit_service.dart';

abstract class _GameCubitCore extends Cubit<GameState> {
  _GameCubitCore(
    this.engine,
    this._repository,
    this.clock,
    this._analytics,
    this._feedback,
    GameState? restored,
  ) : _barista = BaristaMath(engine.config.tap),
      shops = ShopActions(engine),
      lab = LabActions(engine),
      franchise = FranchiseActions(engine),
      prestigeRules = PrestigeActions(engine),
      store = StoreActions(engine),
      dailyRewards = DailyRewardActions(engine),
      tutorial = TutorialRules(engine.config.shops),
      _offline = OfflineActions(engine),
      super(
        restored ?? GameState.initial(startingCash: engine.config.startingCash),
      );

  final EconomyEngine engine;
  final Clock clock;
  final ShopActions shops;
  final LabActions lab;
  final FranchiseActions franchise;
  final PrestigeActions prestigeRules;
  final StoreActions store;
  final DailyRewardActions dailyRewards;
  final TutorialRules tutorial;
  final BaristaMath _barista;
  final OfflineActions _offline;
  final SaveRepository _repository;
  final AnalyticsService _analytics;
  final GameFeedback _feedback;
  double _secondsSinceSave = 0;
  final StreamController<void> _deniedSignals = StreamController.broadcast();

  Stream<void> get deniedSignals => _deniedSignals.stream;

  void reportInsufficientFunds() {
    _play(FeedbackKind.denied);
    _deniedSignals.add(null);
  }

  @override
  Future<void> close() async {
    await _deniedSignals.close();
    return super.close();
  }

  void _restore() {
    final now = clock.now();
    final restoredState = _withIncome(lab.completeDueBrew(state, now).state);
    emit(
      _offline.applyAway(
        restoredState,
        awaySeconds: _offline.secondsSinceSave(restoredState, now),
        incomePerSec: _offlineIncome(restoredState),
      ),
    );
  }

  Future<void> tick(double deltaSeconds) async {
    final safeDelta = deltaSeconds > 0 ? deltaSeconds : 0.0;
    final now = clock.now();
    final earned = engine.earningsFor(state.incomePerSec, safeDelta);
    final next = state
        .earn(earned)
        .copyWith(
          barista: _barista.settle(state.barista, now),
          store: state.store.withoutExpiredBoosts(now),
        );
    emit(_withIncome(_evaluateProgress(next)));
    _secondsSinceSave += safeDelta;
    if (await _completeDueBrew()) return;
    if (_secondsSinceSave >= engine.config.autosaveIntervalSeconds) {
      await save();
    }
  }

  Future<void> handleBackgroundGap(double gapSeconds) async {
    final settled = state.copyWith(
      barista: _barista.settle(state.barista, clock.now()),
    );
    emit(
      _offline.applyAway(
        settled,
        awaySeconds: gapSeconds,
        incomePerSec: _offlineIncome(settled),
      ),
    );
    await _completeDueBrew();
    await save();
  }

  Future<void> save() async {
    _secondsSinceSave = 0;
    final saved = await _repository.save(state);
    if (!isClosed) emit(state.copyWith(savedAt: saved.savedAt));
  }

  ShopMath get shopMath => engine.shopMath;

  List<int> get shopLevelList => shops.levelList(state);

  IncomeInputs incomeInputsOf(GameState source, {bool includeBoosts = true}) =>
      IncomeInputs(
        shopLevels: source.shopLevels,
        managers: source.managers,
        equipment: source.equipment,
        goldenBeans: source.goldenBeans,
        recipeBestScores: source.lab.bestScores,
        capsuleMachines: source.lab.capsuleMachines,
        franchises: source.franchises,
        boostMultiplier: includeBoosts
            ? engine.boostMath.boostMultiplier(source.store.boosts, clock.now())
            : 1,
        vip: source.store.isVip,
        starterPack: source.store.hasStarterPack,
        achievementCount: source.achievements.length,
      );

  AchievementProgress achievementProgressOf(GameState source) =>
      AchievementProgress(
        lifetimeEarnings: source.lifetimeEarnings,
        maxShopLevel: source.shopLevels.values.fold(
          0,
          (best, level) => level > best ? level : best,
        ),
        recipeBestScores: source.lab.bestScores.values,
        franchiseSlots: source.franchises.values.fold(0, (a, b) => a + b),
        prestigeCount: source.prestigeCount,
        totalTaps: source.stats.totalTaps,
      );

  GameState _evaluateProgress(GameState source, {int? openedTab}) {
    var next = source;
    final unlocked = engine.achievementMath.newlyUnlocked(
      source.achievements,
      achievementProgressOf(source),
    );
    if (unlocked.isNotEmpty) {
      next = next.copyWith(achievements: {...next.achievements, ...unlocked});
    }
    if (tutorial.isActive(next)) {
      final step = tutorial.advance(next, openedTab: openedTab);
      for (var reached = next.tutorialStep + 1; reached <= step; reached++) {
        _log(AnalyticsEvents.tutorialStep, {'step': reached});
      }
      next = next.copyWith(tutorialStep: step);
    }
    return next;
  }

  Future<bool> _completeDueBrew() async {
    final completion = lab.completeDueBrew(state, clock.now());
    final result = completion.result;
    if (result == null) return false;
    final recipeId = state.lab.activeBrew?.recipeId ?? '';
    return _commit(
      completion.state,
      onSuccess: () => _log(AnalyticsEvents.recipeBrewed, {
        'id': recipeId,
        'score': result.score,
      }),
    );
  }

  Future<bool> _commit(
    GameState? next, {
    void Function()? onSuccess,
    FeedbackKind? feedback,
  }) async {
    if (next == null) return false;
    emit(_withIncome(_evaluateProgress(next)));
    if (feedback != null) _play(feedback);
    onSuccess?.call();
    await save();
    return true;
  }

  void _play(FeedbackKind kind) => _feedback.play(kind, state.settings);

  void _log(String event, [Map<String, Object> parameters = const {}]) =>
      _analytics.logEvent(event, parameters);

  BigNumber _offlineIncome(GameState source) =>
      engine.totalIncomePerSec(incomeInputsOf(source, includeBoosts: false));

  GameState _withIncome(GameState source) => source.copyWith(
    incomePerSec: engine.totalIncomePerSec(incomeInputsOf(source)),
  );
}

class GameCubit extends _GameCubitCore
    with _ProgressCommands, _StoreCommands, _MetaCommands, _ServiceCommands {
  GameCubit({
    required EconomyConfig config,
    required SaveRepository repository,
    required Clock clock,
    AchievementCatalog achievements = AchievementCatalog.empty,
    AnalyticsService analytics = const DebugAnalyticsService(),
    GameFeedback feedback = const GameFeedback(),
    GameState? restored,
  }) : super(
         EconomyEngine(config, achievements: achievements),
         repository,
         clock,
         analytics,
         feedback,
         restored,
       ) {
    _restore();
  }
}
