import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:coffee_empire/engine/daily_reward_math.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_economy.dart';

void main() {
  final math = DailyRewardMath(loadTestEconomy().dailyReward);
  final last = DateTime.utc(2026, 3, 1, 9);

  DailyRewardStatus after(Duration elapsed, {int streak = 3}) =>
      math.status(streak: streak, lastClaimedAt: last, now: last.add(elapsed));

  test('first ever claim is day one', () {
    final status = math.status(streak: 0, lastClaimedAt: null, now: last);
    expect(status.claimable, isTrue);
    expect(status.dayIndex, 0);
  });

  test('not claimable before 20 hours', () {
    final status = after(const Duration(hours: 19, minutes: 59));
    expect(status.claimable, isFalse);
    expect(status.availableAt, last.add(const Duration(hours: 20)));
  });

  test('between 20 and 48 hours continues the streak', () {
    final status = after(const Duration(hours: 30));
    expect(status.claimable, isTrue);
    expect(status.dayIndex, 3);
  });

  test('after 48 hours the streak resets to day one', () {
    final status = after(const Duration(hours: 49));
    expect(status.claimable, isTrue);
    expect(status.dayIndex, 0);
  });

  test('cycle wraps after day seven', () {
    expect(after(const Duration(hours: 21), streak: 7).dayIndex, 0);
  });

  test('clock set before the last claim gives nothing', () {
    final status = after(const Duration(hours: -5));
    expect(status.claimable, isFalse);
  });

  test('reward grows by day and day seven adds a golden bean', () {
    final income = BigNumber.fromInt(10);
    expect(math.cashReward(0, income) < math.cashReward(6, income), isTrue);
    expect(
      math.cashReward(0, BigNumber.zero),
      loadTestEconomy().dailyReward.minCash,
    );
    expect(math.goldenBeansReward(6), 1);
    expect(math.goldenBeansReward(5), 0);
  });
}
