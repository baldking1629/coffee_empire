import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/economy_config.dart';
import '../../core/bignumber/big_number.dart';
import '../../core/services/analytics_service.dart';
import '../../core/services/monetization_service.dart';
import '../../core/time/clock.dart';
import '../../engine/barista_math.dart';
import '../../engine/economy_engine.dart';
import '../../engine/shop_math.dart';
import '../daily_reward/daily_reward_actions.dart';
import '../growth/franchise_actions.dart';
import '../growth/prestige_actions.dart';
import '../lab/lab_actions.dart';
import '../shops/shop_actions.dart';
import '../store/store_actions.dart';
import 'game_state.dart';
import 'offline_actions.dart';
import 'save_repository.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit({
    required EconomyConfig config,
    required SaveRepository repository,
    required Clock clock,
    AnalyticsService analytics = const DebugAnalyticsService(),
    GameState? restored,
  }) : this._(EconomyEngine(config), repository, clock, analytics, restored);

  GameCubit._(
    this.engine,
    this._repository,
    this.clock,
    this._analytics,
    GameState? restored,
  ) : _barista = BaristaMath(engine.config.tap),
      shops = ShopActions(engine),
      lab = LabActions(engine),
      franchise = FranchiseActions(engine),
      prestigeRules = PrestigeActions(engine),
      store = StoreActions(engine),
      dailyRewards = DailyRewardActions(engine),
      _offline = OfflineActions(engine),
      super(
        restored ?? GameState.initial(startingCash: engine.config.startingCash),
      ) {
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

  final EconomyEngine engine;
  final Clock clock;
  final ShopActions shops;
  final LabActions lab;
  final FranchiseActions franchise;
  final PrestigeActions prestigeRules;
  final StoreActions store;
  final DailyRewardActions dailyRewards;
  final BaristaMath _barista;
  final OfflineActions _offline;
  final SaveRepository _repository;
  final AnalyticsService _analytics;
  double _secondsSinceSave = 0;

  ShopMath get shopMath => engine.shopMath;

  List<int> get shopLevelList => shops.levelList(state);

  void tapCup() {
    final outcome = _barista.tap(
      state.barista,
      state.incomePerSec,
      clock.now(),
    );
    final stats = state.stats.copyWith(
      totalTaps: state.stats.totalTaps + 1,
      cupsFilled: state.stats.cupsFilled + (outcome.cupFilled ? 1 : 0),
    );
    emit(
      state
          .earn(outcome.payout)
          .copyWith(barista: outcome.barista, stats: stats),
    );
  }

  Future<void> tick(double deltaSeconds) async {
    final safeDelta = deltaSeconds > 0 ? deltaSeconds : 0.0;
    final now = clock.now();
    final earned = engine.earningsFor(state.incomePerSec, safeDelta);
    var next = state
        .earn(earned)
        .copyWith(
          barista: _barista.settle(state.barista, now),
          store: state.store.withoutExpiredBoosts(now),
        );
    if (next.store.isVip) {
      final autoTaps = engine.config.tap.autoTapPerSecond * safeDelta;
      final auto = _barista.autoFill(next.barista, next.incomePerSec, autoTaps);
      next = next.earn(auto.payout).copyWith(barista: auto.barista);
    }
    emit(_withIncome(next));
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

  Future<void> claimOfflineEarnings({required bool doubled}) async {
    final pending = state.pendingOffline;
    if (pending == null) return;
    _log(AnalyticsEvents.offlineModal, {
      'minutes': (pending.awaySeconds / Duration.secondsPerMinute).round(),
    });
    await _commit(_offline.claim(state, doubled: doubled));
  }

  Future<bool> buyShopLevels(String shopId, BuyAmount amount) {
    final firstPurchase = (state.shopLevels[shopId] ?? 0) == 0;
    return _commit(
      shops.buyLevels(state, shopId, amount),
      onSuccess: () {
        if (firstPurchase) _log(AnalyticsEvents.shopUnlocked, {'id': shopId});
      },
    );
  }

  Future<bool> hireManager(String shopId) => _commit(
    shops.hireManager(state, shopId),
    onSuccess: () => _log(AnalyticsEvents.managerHired, {'id': shopId}),
  );

  Future<bool> buyEquipment(String shopId) =>
      _commit(shops.buyEquipment(state, shopId));

  Future<bool> unlockRecipe(String recipeId) =>
      _commit(lab.unlockRecipe(state, recipeId));

  Future<bool> startBrew(String recipeId, FlavorProfile sliders) =>
      _commit(lab.startBrew(state, recipeId, sliders, clock.now()));

  Future<bool> finishBrewNow() async {
    final expired = lab.expireBrewNow(state, clock.now());
    if (expired == null) return false;
    emit(expired);
    return _completeDueBrew();
  }

  Future<bool> buyCapsuleMachines(BuyAmount amount) {
    final firstMachine = state.lab.capsuleMachines == 0;
    return _commit(
      lab.buyCapsuleMachines(state, amount),
      onSuccess: () {
        if (firstMachine) _log(AnalyticsEvents.capsuleUnlocked);
      },
    );
  }

  Future<bool> openFranchise(String cityId) {
    final slotIndex = franchise.ownedIn(state, cityId);
    return _commit(
      franchise.openFranchise(state, cityId),
      onSuccess: () => _log(AnalyticsEvents.franchiseOpened, {
        'cityId': cityId,
        'slotIndex': slotIndex,
      }),
    );
  }

  Future<bool> prestige() {
    final gain = prestigeRules.previewGain(state);
    return _commit(
      prestigeRules.prestige(state),
      onSuccess: () => _log(AnalyticsEvents.prestige, {
        'count': state.prestigeCount,
        'gain': gain,
      }),
    );
  }

  Future<bool> applyRewardedAd(RewardedAdType type) async {
    final applied = await _commit(
      store.applyRewarded(state, type, clock.now()),
      onSuccess: () =>
          _log(AnalyticsEvents.rewardedCompleted, {'type': type.id}),
    );
    if (applied && type == RewardedAdType.labSpeedup) await _completeDueBrew();
    return applied;
  }

  Future<bool> applyPurchase(String productId) => _commit(
    store.applyPurchase(state, productId),
    onSuccess: () => _log(AnalyticsEvents.iapPurchase, {'id': productId}),
  );

  Future<void> restorePurchases(Iterable<String> ownedProducts) async {
    await _commit(store.restore(state, ownedProducts));
  }

  Future<bool> claimDailyReward() async {
    final claim = dailyRewards.claim(state, clock.now());
    if (claim == null) return false;
    return _commit(
      claim.state,
      onSuccess: () =>
          _log(AnalyticsEvents.dailyRewardClaimed, {'day': claim.dayIndex + 1}),
    );
  }

  Future<void> save() async {
    _secondsSinceSave = 0;
    final saved = await _repository.save(state);
    if (!isClosed) emit(state.copyWith(savedAt: saved.savedAt));
  }

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
      );

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

  Future<bool> _commit(GameState? next, {void Function()? onSuccess}) async {
    if (next == null) return false;
    emit(_withIncome(next));
    onSuccess?.call();
    await save();
    return true;
  }

  void _log(String event, [Map<String, Object> parameters = const {}]) =>
      _analytics.logEvent(event, parameters);

  BigNumber _offlineIncome(GameState source) =>
      engine.totalIncomePerSec(incomeInputsOf(source, includeBoosts: false));

  GameState _withIncome(GameState source) => source.copyWith(
    incomePerSec: engine.totalIncomePerSec(incomeInputsOf(source)),
  );
}
