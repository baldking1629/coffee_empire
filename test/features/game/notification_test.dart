import 'dart:ui';

import 'package:coffee_empire/core/services/notification_service.dart';
import 'package:coffee_empire/engine/boost_math.dart';
import 'package:coffee_empire/engine/economy_engine.dart';
import 'package:coffee_empire/features/daily_reward/daily_reward_state.dart';
import 'package:coffee_empire/features/game/game_settings.dart';
import 'package:coffee_empire/features/game/game_state.dart';
import 'package:coffee_empire/features/game/notification_coordinator.dart';
import 'package:coffee_empire/features/game/notification_planner.dart';
import 'package:coffee_empire/features/store/store_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/cubit_harness.dart';

class RecordingNotificationService implements NotificationService {
  final List<String> calls = [];
  final List<ScheduledNotification> scheduled = [];

  @override
  Future<void> initialize() async => calls.add('initialize');

  @override
  Future<bool> requestPermission() async => true;

  @override
  Future<void> cancelAll() async {
    calls.add('cancelAll');
    scheduled.clear();
  }

  @override
  Future<void> schedule(ScheduledNotification notification) async {
    calls.add('schedule');
    scheduled.add(notification);
  }
}

void main() {
  final harness = CubitHarness();
  final engine = EconomyEngine(harness.config);
  final planner = NotificationPlanner(engine);
  final now = harness.clock.now();

  GameState richState() => harness
      .stateWithCash('0')
      .copyWith(
        shopLevels: {'street_cart': 5},
        dailyReward: DailyRewardState(
          streak: 1,
          lastClaimedAt: now.subtract(const Duration(hours: 2)),
        ),
        store: StoreState(
          boosts: [
            ActiveBoost(
              type: ActiveBoost.caffeineRush,
              endsAt: now.add(const Duration(hours: 1)),
            ),
          ],
        ),
      );

  GameState withIncome(GameState state) => harness.build(state).state;

  test('closing the app plans all three reminders', () {
    final plans = planner.plan(withIncome(richState()), now, appClosing: true);
    expect(plans, [
      ReminderPlan(
        ReminderKind.offlineCapReached,
        now.add(const Duration(hours: 4)),
      ),
      ReminderPlan(
        ReminderKind.dailyRewardReady,
        now.add(const Duration(hours: 18)),
      ),
      ReminderPlan(
        ReminderKind.caffeineRushEnded,
        now.add(const Duration(hours: 1)),
      ),
    ]);
  });

  test('open app skips the offline cap reminder', () {
    final plans = planner.plan(withIncome(richState()), now, appClosing: false);
    expect(
      plans.map((p) => p.kind),
      isNot(contains(ReminderKind.offlineCapReached)),
    );
  });

  test('coordinator cancels before rescheduling with localized text', () async {
    final service = RecordingNotificationService();
    final coordinator = NotificationCoordinator(service, planner);
    await coordinator.reschedule(
      withIncome(richState()),
      now,
      appClosing: true,
      locale: const Locale('tr'),
    );
    expect(service.calls.first, 'cancelAll');
    expect(service.scheduled, hasLength(3));
    expect(
      service.scheduled.map((n) => n.title),
      contains('Günlük ödül hazır'),
    );
  });

  test('disabled notifications only cancel', () async {
    final service = RecordingNotificationService();
    final coordinator = NotificationCoordinator(service, planner);
    await coordinator.reschedule(
      withIncome(
        richState(),
      ).copyWith(settings: const GameSettings(notifications: false)),
      now,
      appClosing: true,
      locale: const Locale('en'),
    );
    expect(service.calls, ['cancelAll']);
  });
}
