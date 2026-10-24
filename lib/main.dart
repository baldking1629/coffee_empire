import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'config/economy_config.dart';
import 'config/economy_config_loader.dart';
import 'core/services/analytics_service.dart';
import 'core/services/consent_service.dart';
import 'core/services/monetization_service.dart';
import 'core/services/notification_service.dart';
import 'core/time/clock.dart';
import 'features/game/game_cubit.dart';
import 'features/game/notification_coordinator.dart';
import 'features/game/notification_planner.dart';
import 'features/game/save_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  const clock = SystemClock();
  const AnalyticsService analytics = DebugAnalyticsService();
  const ConsentService consent = MockConsentService();
  final NotificationService notifications = LocalNotificationService();
  final config = await EconomyConfigLoader(rootBundle).load();
  final preferences = await SharedPreferences.getInstance();
  final repository = SaveRepository(preferences, clock: clock);
  final loaded = repository.load();
  if (loaded.corrupted) analytics.logEvent(AnalyticsEvents.saveCorrupt);
  analytics.logEvent(AnalyticsEvents.sessionStart);
  await consent.requestConsent();
  await notifications.initialize();
  final cubit = GameCubit(
    config: config,
    repository: repository,
    clock: clock,
    analytics: analytics,
    restored: loaded.state,
  );
  final MonetizationService monetization = MockMonetizationService(
    ownedProducts: cubit.state.store.purchases,
  );
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<EconomyConfig>.value(value: config),
        RepositoryProvider<SaveRepository>.value(value: repository),
        RepositoryProvider<AnalyticsService>.value(value: analytics),
        RepositoryProvider<ConsentService>.value(value: consent),
        RepositoryProvider<NotificationService>.value(value: notifications),
        RepositoryProvider<MonetizationService>.value(value: monetization),
      ],
      child: BlocProvider<GameCubit>.value(
        value: cubit,
        child: CoffeeEmpireApp(
          clock: clock,
          notifications: NotificationCoordinator(
            notifications,
            NotificationPlanner(cubit.engine),
          ),
        ),
      ),
    ),
  );
}
