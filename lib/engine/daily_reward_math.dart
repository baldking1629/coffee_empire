import 'package:equatable/equatable.dart';

import '../config/economy_config.dart';
import '../core/bignumber/big_number.dart';

class DailyRewardStatus extends Equatable {
  const DailyRewardStatus({
    required this.claimable,
    required this.dayIndex,
    this.availableAt,
  });

  final bool claimable;
  final int dayIndex;
  final DateTime? availableAt;

  @override
  List<Object?> get props => [claimable, dayIndex, availableAt];
}

class DailyRewardMath {
  const DailyRewardMath(this.config);

  final DailyRewardConfig config;

  int get cycleLength => config.daySeconds.length;

  DailyRewardStatus status({
    required int streak,
    required DateTime? lastClaimedAt,
    required DateTime now,
  }) {
    if (lastClaimedAt == null) {
      return const DailyRewardStatus(claimable: true, dayIndex: 0);
    }
    final elapsed = now.difference(lastClaimedAt);
    final nextDay = streak % cycleLength;
    final availableAt = lastClaimedAt.add(
      Duration(seconds: config.claimableAfterSeconds),
    );
    if (elapsed.isNegative) {
      return DailyRewardStatus(
        claimable: false,
        dayIndex: nextDay,
        availableAt: availableAt,
      );
    }
    if (elapsed.inSeconds > config.streakResetSeconds) {
      return const DailyRewardStatus(claimable: true, dayIndex: 0);
    }
    return DailyRewardStatus(
      claimable: elapsed.inSeconds >= config.claimableAfterSeconds,
      dayIndex: nextDay,
      availableAt: availableAt,
    );
  }

  BigNumber cashReward(int dayIndex, BigNumber incomePerSec) =>
      (incomePerSec * BigNumber.fromDouble(config.daySeconds[dayIndex]))
          .clampMin(config.minCash);

  int goldenBeansReward(int dayIndex) =>
      dayIndex == cycleLength - 1 ? config.finalDayGoldenBeans : 0;
}
