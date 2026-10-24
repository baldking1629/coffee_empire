import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/economy_config.dart';
import '../core/time/clock.dart';
import '../features/game/game_cubit.dart';
import '../features/game/notification_coordinator.dart';
import '../features/game/game_settings.dart';
import '../features/game/game_state.dart';
import '../features/game/game_tick_service.dart';
import '../features/home/home_screen.dart';
import '../l10n/app_localizations.dart';
import 'theme/app_theme.dart';
import 'widgets/insufficient_funds_flash.dart';

class CoffeeEmpireApp extends StatefulWidget {
  const CoffeeEmpireApp({super.key, required this.clock, this.notifications});

  final Clock clock;
  final NotificationCoordinator? notifications;

  @override
  State<CoffeeEmpireApp> createState() => _CoffeeEmpireAppState();
}

class _CoffeeEmpireAppState extends State<CoffeeEmpireApp> {
  late final GameCubit _cubit = context.read<GameCubit>();
  late final GameTickService _tickService = GameTickService(
    clock: widget.clock,
    backgroundGapSeconds: context.read<EconomyConfig>().backgroundGapSeconds,
    onTick: _cubit.tick,
    onBackgroundGap: _cubit.handleBackgroundGap,
  );
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(onStateChange: _handleLifecycle);
    _tickService.start();
    _rescheduleNotifications(appClosing: false);
  }

  Future<void> _rescheduleNotifications({required bool appClosing}) async {
    final coordinator = widget.notifications;
    if (coordinator == null) return;
    await coordinator.reschedule(
      _cubit.state,
      widget.clock.now(),
      appClosing: appClosing,
      locale: appLocaleFor(_cubit.state.settings),
    );
  }

  @override
  void dispose() {
    _tickService.stop();
    _lifecycle.dispose();
    super.dispose();
  }

  void _handleLifecycle(AppLifecycleState lifecycle) {
    switch (lifecycle) {
      case AppLifecycleState.resumed:
        if (!_tickService.isRunning) {
          _tickService.start();
          _rescheduleNotifications(appClosing: false);
        }
      case AppLifecycleState.inactive ||
          AppLifecycleState.paused ||
          AppLifecycleState.detached:
        if (_tickService.isRunning) {
          _tickService.stop();
          _cubit.save();
          _rescheduleNotifications(appClosing: true);
        }
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<GameCubit, GameState, String>(
      selector: (state) => state.settings.locale,
      builder: (context, localeCode) => MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
        theme: AppTheme.build(),
        locale: localeCode == GameSettings.systemLocale
            ? null
            : Locale(localeCode),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        localeResolutionCallback: resolveSupportedLocale,
        builder: (context, child) => InsufficientFundsFlash(
          signals: _cubit.deniedSignals,
          child: child ?? const SizedBox.shrink(),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

Locale resolveSupportedLocale(
  Locale? deviceLocale,
  Iterable<Locale> supported,
) {
  for (final locale in supported) {
    if (locale.languageCode == deviceLocale?.languageCode) return locale;
  }
  return const Locale('en');
}

Locale appLocaleFor(GameSettings settings) =>
    settings.locale == GameSettings.systemLocale
    ? resolveSupportedLocale(
        PlatformDispatcher.instance.locale,
        AppLocalizations.supportedLocales,
      )
    : Locale(settings.locale);
