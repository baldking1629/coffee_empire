import 'package:coffee_empire/features/daily_reward/daily_reward_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/cubit_harness.dart';

void main() {
  late CubitHarness harness;

  setUp(() => harness = CubitHarness());

  test('claim, wait, continue streak, then reset after two days', () async {
    final cubit = harness.build(harness.stateWithCash('0'));
    expect(await cubit.claimDailyReward(), isTrue);
    expect(cubit.state.dailyReward.streak, 1);
    expect(await cubit.claimDailyReward(), isFalse);

    harness.clock.advance(const Duration(hours: 21));
    expect(await cubit.claimDailyReward(), isTrue);
    expect(cubit.state.dailyReward.streak, 2);

    harness.clock.advance(const Duration(hours: 50));
    expect(await cubit.claimDailyReward(), isTrue);
    expect(cubit.state.dailyReward.streak, 1);
  });

  test('seventh day grants a golden bean', () async {
    final cubit = harness.build(
      harness
          .stateWithCash('0')
          .copyWith(
            dailyReward: DailyRewardState(
              streak: 6,
              lastClaimedAt: harness.clock.now().subtract(
                const Duration(hours: 21),
              ),
            ),
          ),
    );
    expect(await cubit.claimDailyReward(), isTrue);
    expect(cubit.state.goldenBeans, 1);
  });

  test('clock moved back gives no reward', () async {
    final cubit = harness.build(
      harness
          .stateWithCash('0')
          .copyWith(
            dailyReward: DailyRewardState(
              streak: 2,
              lastClaimedAt: harness.clock.now().add(const Duration(days: 2)),
            ),
          ),
    );
    expect(await cubit.claimDailyReward(), isFalse);
  });
}
