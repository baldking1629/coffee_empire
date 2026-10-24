import '../../core/bignumber/big_number.dart';
import '../../engine/economy_engine.dart';
import '../../engine/prestige_math.dart';
import '../../engine/barista_math.dart';
import '../game/game_state.dart';

class PrestigeActions {
  const PrestigeActions(this.engine);

  final EconomyEngine engine;

  PrestigeMath get math => engine.prestigeMath;

  int previewGain(GameState state) => math.goldenBeansFor(state.runEarnings);

  BigNumber multiplierAfter(GameState state) =>
      math.beanMultiplier(state.goldenBeans + previewGain(state));

  GameState? prestige(GameState state) {
    if (!math.canPrestige(state.runEarnings)) return null;
    final gain = previewGain(state);
    return state.copyWith(
      cash: engine.config.startingCash,
      runEarnings: BigNumber.zero,
      goldenBeans: state.goldenBeans + gain,
      prestigeCount: state.prestigeCount + 1,
      shopLevels: const {},
      managers: const {},
      equipment: const {},
      franchises: const {},
      lab: state.lab.copyWith(capsuleMachines: 0, activeBrew: () => null),
      barista: BaristaState.idle,
    );
  }
}
