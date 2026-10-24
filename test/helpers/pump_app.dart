import 'package:coffee_empire/config/economy_config.dart';
import 'package:coffee_empire/core/services/monetization_service.dart';
import 'package:coffee_empire/features/game/game_cubit.dart';
import 'package:coffee_empire/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> pumpWithGame(
  WidgetTester tester, {
  required EconomyConfig config,
  required GameCubit cubit,
  required Widget child,
  MonetizationService? monetization,
  Locale locale = const Locale('en'),
}) async {
  await tester.pumpWidget(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<EconomyConfig>.value(value: config),
        RepositoryProvider<MonetizationService>.value(
          value:
              monetization ??
              MockMonetizationService(adDuration: Duration.zero),
        ),
      ],
      child: BlocProvider.value(
        value: cubit,
        child: MaterialApp(
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: child),
        ),
      ),
    ),
  );
}
