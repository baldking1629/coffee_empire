import 'package:equatable/equatable.dart';

import '../../engine/boost_math.dart';
import '../../engine/economy_engine.dart';
import 'game_state.dart';

enum ReminderKind { offlineCapReached, dailyRewardReady, caffeineRushEnded }

class ReminderPlan extends Equatable {
  const ReminderPlan(this.kind, this.at);

  final ReminderKind kind;
  final DateTime at;

  @override
  List<Object?> get props => [kind, at];
}

class NotificationPlanner {
  const NotificationPlanner(this.engine);

  final EconomyEngine engine;

  List<ReminderPlan> plan(
    GameState state,
    DateTime now, {
    required bool appClosing,
  }) {
    final plans = <ReminderPlan>[];
    if (appClosing && !state.incomePerSec.isZero) {
      final cap = engine.offlineMath.capSeconds(vip: state.store.isVip);
      plans.add(
        ReminderPlan(
          ReminderKind.offlineCapReached,
          now.add(Duration(seconds: cap)),
        ),
      );
    }
    final daily = engine.dailyRewardMath.status(
      streak: state.dailyReward.streak,
      lastClaimedAt: state.dailyReward.lastClaimedAt,
      now: now,
    );
    final availableAt = daily.availableAt;
    if (!daily.claimable && availableAt != null && availableAt.isAfter(now)) {
      plans.add(ReminderPlan(ReminderKind.dailyRewardReady, availableAt));
    }
    final rush = state.store.boostOf(ActiveBoost.caffeineRush);
    if (rush != null && rush.isActive(now)) {
      plans.add(ReminderPlan(ReminderKind.caffeineRushEnded, rush.endsAt));
    }
    return plans;
  }
}
