import 'package:flutter/material.dart';

import 'l10n/app_localizations.dart';

void main() {
  runApp(const CoffeeEmpireBootstrap());
}

class CoffeeEmpireBootstrap extends StatelessWidget {
  const CoffeeEmpireBootstrap({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Scaffold(),
    );
  }
}
