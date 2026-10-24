import 'dart:ui';

import '../../core/services/notification_service.dart';
import '../../l10n/app_localizations.dart';
import 'game_state.dart';
import 'notification_planner.dart';

class NotificationCoordinator {
  const NotificationCoordinator(this.service, this.planner);

  final NotificationService service;
  final NotificationPlanner planner;

  Future<void> reschedule(
    GameState state,
    DateTime now, {
    required bool appClosing,
    required Locale locale,
  }) async {
    await service.cancelAll();
    if (!state.settings.notifications) return;
    final l10n = lookupAppLocalizations(locale);
    for (final plan in planner.plan(state, now, appClosing: appClosing)) {
      final (title, body) = switch (plan.kind) {
        ReminderKind.offlineCapReached => (
          l10n.notifOfflineTitle,
          l10n.notifOfflineBody,
        ),
        ReminderKind.dailyRewardReady => (
          l10n.notifDailyTitle,
          l10n.notifDailyBody,
        ),
        ReminderKind.caffeineRushEnded => (
          l10n.notifRushTitle,
          l10n.notifRushBody,
        ),
      };
      await service.schedule(
        ScheduledNotification(
          id: plan.kind.index + 1,
          at: plan.at,
          title: title,
          body: body,
          channelName: l10n.notificationChannelName,
        ),
      );
    }
  }
}
