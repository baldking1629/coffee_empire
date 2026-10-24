import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/economy_config.dart';
import '../../core/bignumber/big_number.dart';
import '../../core/time/clock.dart';
import '../../engine/barista_math.dart';
import '../../engine/economy_engine.dart';
import '../../engine/lab_math.dart';
import '../../engine/offline_math.dart';
import '../../engine/shop_math.dart';
import '../growth/franchise_actions.dart';
import '../growth/prestige_actions.dart';
import '../lab/lab_actions.dart';
import 'game_state.dart';
import 'save_repository.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit({
    required EconomyConfig config,
    required SaveRepository repository,
    required Clock clock,
    GameState? restored,
  }) : this._(EconomyEngine(config), repository, clock, restored);

  GameCubit._(
    EconomyEngine engine,
    SaveRepository repository,
    Clock clock,
    GameState? restored,
  ) : _engine = engine,
      _barista = BaristaMath(engine.config.tap),
      _labActions = LabActions(engine),
      _franchiseActions = FranchiseActions(engine),
      _prestigeActions = PrestigeActions(engine),
      _repository = repository,
      _clock = clock,
      _autosaveIntervalSeconds = engine.config.autosaveIntervalSeconds
          .toDouble(),
      super(
        restored ?? GameState.initial(startingCash: engine.config.startingCash),
      ) {
    final restoredState = _withIncome(
      _labActions.completeDueBrew(state, _clock.now()).state,
    );
    emit(_withOfflineEarnings(restoredState, _awaySinceSave(restoredState)));
  }

  final EconomyEngine _engine;
  final BaristaMath _barista;
  final LabActions _labActions;
  final FranchiseActions _franchiseActions;
  final PrestigeActions _prestigeActions;
  final SaveRepository _repository;
  final Clock _clock;
  final double _autosaveIntervalSeconds;
  double _secondsSinceSave = 0;

  void tapCup() {
    final outcome = _barista.tap(
      state.barista,
      state.incomePerSec,
      _clock.now(),
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
    final earned = _engine.earningsFor(state.incomePerSec, safeDelta);
    final barista = _barista.settle(state.barista, _clock.now());
    emit(state.earn(earned).copyWith(barista: barista));
    _secondsSinceSave += safeDelta;
    if (await _completeDueBrew()) return;
    if (_secondsSinceSave >= _autosaveIntervalSeconds) {
      await save();
    }
  }

  LabActions get lab => _labActions;

  Clock get clock => _clock;

  Future<bool> unlockRecipe(String recipeId) =>
      _commit(_labActions.unlockRecipe(state, recipeId));

  Future<bool> startBrew(String recipeId, FlavorProfile sliders) =>
      _commit(_labActions.startBrew(state, recipeId, sliders, _clock.now()));

  Future<bool> finishBrewNow() async {
    final expired = _labActions.expireBrewNow(state, _clock.now());
    if (expired == null) return false;
    emit(expired);
    return _completeDueBrew();
  }

  Future<bool> buyCapsuleMachines(BuyAmount amount) =>
      _commit(_labActions.buyCapsuleMachines(state, amount));

  Future<bool> _completeDueBrew() async {
    final completion = _labActions.completeDueBrew(state, _clock.now());
    final BrewResult? result = completion.result;
    if (result == null) return false;
    return _commit(completion.state);
  }

  Future<bool> _commit(GameState? next) async {
    if (next == null) return false;
    emit(_withIncome(next));
    await save();
    return true;
  }

  Future<void> handleBackgroundGap(double gapSeconds) async {
    final settled = state.copyWith(
      barista: _barista.settle(state.barista, _clock.now()),
    );
    emit(_withOfflineEarnings(settled, gapSeconds));
    await _completeDueBrew();
    await save();
  }

  Future<void> claimOfflineEarnings({required bool doubled}) async {
    final pending = state.pendingOffline;
    if (pending == null) return;
    final multiplier = doubled
        ? BigNumber.fromDouble(_engine.config.rewarded.offlineDoubleMultiplier)
        : BigNumber.one;
    emit(
      state
          .earn(pending.amount * multiplier)
          .copyWith(pendingOffline: () => null),
    );
    await save();
  }

  double _awaySinceSave(GameState source) {
    final savedAt = source.savedAt;
    if (savedAt == null) return 0;
    return _clock.now().difference(savedAt).inMilliseconds /
        Duration.millisecondsPerSecond;
  }

  GameState _withOfflineEarnings(GameState source, double awaySeconds) {
    final earnings = _engine.offlineMath.compute(
      awaySeconds: awaySeconds,
      incomePerSec: source.incomePerSec,
      vip: false,
    );
    if (earnings.amount.isZero) return source;
    if (!earnings.showModal) return source.earn(earnings.amount);
    final previous = source.pendingOffline;
    final merged = previous == null
        ? earnings
        : OfflineEarnings(
            awaySeconds: previous.awaySeconds + earnings.awaySeconds,
            creditedSeconds:
                previous.creditedSeconds + earnings.creditedSeconds,
            amount: previous.amount + earnings.amount,
            showModal: true,
          );
    return source.copyWith(pendingOffline: () => merged);
  }

  EconomyEngine get engine => _engine;

  FranchiseActions get franchise => _franchiseActions;

  PrestigeActions get prestigeRules => _prestigeActions;

  Future<bool> openFranchise(String cityId) =>
      _commit(_franchiseActions.openFranchise(state, cityId));

  Future<bool> prestige() => _commit(_prestigeActions.prestige(state));

  ShopMath get shopMath => _engine.shopMath;

  List<int> get shopLevelList => [
    for (final shop in _engine.config.shops) state.shopLevels[shop.id] ?? 0,
  ];

  Future<bool> buyShopLevels(String shopId, BuyAmount amount) async {
    final index = _shopIndex(shopId);
    if (index < 0 || !shopMath.isShopAvailable(shopLevelList, index)) {
      return false;
    }
    final level = state.shopLevels[shopId] ?? 0;
    final plan = shopMath.purchasePlan(
      _engine.config.shops[index],
      level,
      state.cash,
      amount,
    );
    if (!plan.affordable) return false;
    return _completePurchase(
      plan.cost,
      state.copyWith(
        shopLevels: {...state.shopLevels, shopId: level + plan.count},
      ),
    );
  }

  Future<bool> hireManager(String shopId) async {
    final index = _shopIndex(shopId);
    if (index < 0 ||
        (state.shopLevels[shopId] ?? 0) < 1 ||
        (state.managers[shopId] ?? false)) {
      return false;
    }
    final cost = shopMath.managerCost(_engine.config.shops[index]);
    return _completePurchase(
      cost,
      state.copyWith(managers: {...state.managers, shopId: true}),
    );
  }

  Future<bool> buyEquipment(String shopId) async {
    final index = _shopIndex(shopId);
    final owned = state.equipment[shopId] ?? 0;
    if (index < 0 ||
        (state.shopLevels[shopId] ?? 0) < 1 ||
        owned >= shopMath.equipmentTierCount) {
      return false;
    }
    final cost = shopMath.equipmentCost(_engine.config.shops[index], owned);
    return _completePurchase(
      cost,
      state.copyWith(equipment: {...state.equipment, shopId: owned + 1}),
    );
  }

  int _shopIndex(String shopId) =>
      _engine.config.shops.indexWhere((shop) => shop.id == shopId);

  Future<bool> _completePurchase(BigNumber cost, GameState upgraded) async {
    if (state.cash < cost) return false;
    return _commit(upgraded.spend(cost));
  }

  Future<void> save() async {
    _secondsSinceSave = 0;
    final saved = await _repository.save(state);
    if (!isClosed) emit(state.copyWith(savedAt: saved.savedAt));
  }

  IncomeInputs incomeInputsOf(GameState source) => IncomeInputs(
    shopLevels: source.shopLevels,
    managers: source.managers,
    equipment: source.equipment,
    goldenBeans: source.goldenBeans,
    recipeBestScores: source.lab.bestScores,
    capsuleMachines: source.lab.capsuleMachines,
    franchises: source.franchises,
  );

  GameState _withIncome(GameState source) => source.copyWith(
    incomePerSec: _engine.totalIncomePerSec(incomeInputsOf(source)),
  );
}
