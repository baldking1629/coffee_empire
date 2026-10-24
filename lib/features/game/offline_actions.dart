import '../../core/bignumber/big_number.dart';
import '../../engine/economy_engine.dart';
import '../../engine/offline_math.dart';
import 'game_state.dart';

class OfflineActions {
  const OfflineActions(this.engine);

  final EconomyEngine engine;

  double secondsSinceSave(GameState state, DateTime now) {
    final savedAt = state.savedAt;
    if (savedAt == null) return 0;
    return now.difference(savedAt).inMilliseconds /
        Duration.millisecondsPerSecond;
  }

  GameState applyAway(
    GameState state, {
    required double awaySeconds,
    required BigNumber incomePerSec,
  }) {
    final earnings = engine.offlineMath.compute(
      awaySeconds: awaySeconds,
      incomePerSec: incomePerSec,
      vip: state.store.isVip,
    );
    if (earnings.amount.isZero) return state;
    if (!earnings.showModal) return state.earn(earnings.amount);
    final previous = state.pendingOffline;
    final merged = previous == null
        ? earnings
        : OfflineEarnings(
            awaySeconds: previous.awaySeconds + earnings.awaySeconds,
            creditedSeconds:
                previous.creditedSeconds + earnings.creditedSeconds,
            amount: previous.amount + earnings.amount,
            showModal: true,
          );
    return state.copyWith(pendingOffline: () => merged);
  }

  GameState? claim(GameState state, {required bool doubled}) {
    final pending = state.pendingOffline;
    if (pending == null) return null;
    final multiplier = doubled
        ? BigNumber.fromDouble(engine.config.rewarded.offlineDoubleMultiplier)
        : BigNumber.one;
    return state
        .earn(pending.amount * multiplier)
        .copyWith(pendingOffline: () => null);
  }
}
