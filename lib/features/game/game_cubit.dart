import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/economy_config.dart';
import '../../core/bignumber/big_number.dart';
import '../../core/time/clock.dart';
import '../../engine/barista_math.dart';
import '../../engine/economy_engine.dart';
import '../../engine/lab_math.dart';
import '../../engine/shop_math.dart';
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
      _repository = repository,
      _clock = clock,
      _autosaveIntervalSeconds = engine.config.autosaveIntervalSeconds
          .toDouble(),
      super(
        restored ?? GameState.initial(startingCash: engine.config.startingCash),
      ) {
    emit(_withIncome(_labActions.completeDueBrew(state, _clock.now()).state));
  }

  final EconomyEngine _engine;
  final BaristaMath _barista;
  final LabActions _labActions;
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
    emit(state.copyWith(barista: _barista.settle(state.barista, _clock.now())));
    await save();
  }

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
  );

  GameState _withIncome(GameState source) => source.copyWith(
    incomePerSec: _engine.totalIncomePerSec(incomeInputsOf(source)),
  );
}
