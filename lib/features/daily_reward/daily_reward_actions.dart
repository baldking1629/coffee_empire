import '../../engine/daily_reward_math.dart';
import '../../engine/economy_engine.dart';
import '../game/game_state.dart';
import 'daily_reward_state.dart';

typedef DailyRewardClaim = ({GameState state, int dayIndex});

class DailyRewardActions {
  const DailyRewardActions(this.engine);

  final EconomyEngine engine;

  DailyRewardMath get math => engine.dailyRewardMath;

  DailyRewardStatus status(GameState state, DateTime now) => math.status(
    streak: state.dailyReward.streak,
    lastClaimedAt: state.dailyReward.lastClaimedAt,
    now: now,
  );

  DailyRewardClaim? claim(GameState state, DateTime now) {
    final current = status(state, now);
    if (!current.claimable) return null;
    final day = current.dayIndex;
    final rewarded = state
        .earn(math.cashReward(day, state.incomePerSec))
        .copyWith(
          goldenBeans: state.goldenBeans + math.goldenBeansReward(day),
          dailyReward: DailyRewardState(streak: day + 1, lastClaimedAt: now),
        );
    return (state: rewarded, dayIndex: day);
  }
}
