import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/economy_config.dart';
import '../../core/time/clock.dart';
import '../../engine/barista_math.dart';
import '../../engine/economy_engine.dart';
import 'game_state.dart';
import 'save_repository.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit({
    required EconomyConfig config,
    required SaveRepository repository,
    required Clock clock,
    GameState? restored,
  }) : _engine = EconomyEngine(config),
       _barista = BaristaMath(config.tap),
       _repository = repository,
       _clock = clock,
       _autosaveIntervalSeconds = config.autosaveIntervalSeconds.toDouble(),
       super(restored ?? GameState.initial(startingCash: config.startingCash)) {
    emit(_withIncome(state));
  }

  final EconomyEngine _engine;
  final BaristaMath _barista;
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
    if (_secondsSinceSave >= _autosaveIntervalSeconds) {
      await save();
    }
  }

  Future<void> handleBackgroundGap(double gapSeconds) async {
    emit(state.copyWith(barista: _barista.settle(state.barista, _clock.now())));
    await save();
  }

  Future<void> save() async {
    _secondsSinceSave = 0;
    final saved = await _repository.save(state);
    if (!isClosed) emit(state.copyWith(savedAt: saved.savedAt));
  }

  GameState _withIncome(GameState source) => source.copyWith(
    incomePerSec: _engine.totalIncomePerSec(
      shopLevels: source.shopLevels,
      managers: source.managers,
      equipment: source.equipment,
      goldenBeans: source.goldenBeans,
    ),
  );
}
