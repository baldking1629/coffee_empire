import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/economy_config.dart';
import '../core/time/clock.dart';
import '../features/game/game_cubit.dart';
import '../features/game/game_settings.dart';
import '../features/game/game_state.dart';
import '../features/game/game_tick_service.dart';
import '../features/home/home_screen.dart';
import '../l10n/app_localizations.dart';
import 'theme/app_theme.dart';

class CoffeeEmpireApp extends StatefulWidget {
  const CoffeeEmpireApp({super.key, required this.clock});

  final Clock clock;

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
        _tickService.start();
      case AppLifecycleState.inactive ||
          AppLifecycleState.paused ||
          AppLifecycleState.detached:
        if (_tickService.isRunning) {
          _tickService.stop();
          _cubit.save();
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
