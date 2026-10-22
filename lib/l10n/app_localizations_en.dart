// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Coffee Empire';

  @override
  String durationDays(int value) {
    return '${value}d';
  }

  @override
  String durationHours(int value) {
    return '${value}h';
  }

  @override
  String durationMinutes(int value) {
    return '${value}m';
  }

  @override
  String durationSeconds(int value) {
    return '${value}s';
  }

  @override
  String get tabShops => 'Shops';

  @override
  String get tabLab => 'R&D';

  @override
  String get tabGrowth => 'Growth';

  @override
  String get tabStore => 'Store';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String incomePerSecond(String amount) {
    return '$amount/sec';
  }

  @override
  String comboLabel(int count) {
    return 'Combo x$count';
  }

  @override
  String get baristaRush => 'Barista Rush!';

  @override
  String get tapToBrew => 'Tap the cup to brew';

  @override
  String cupSemanticLabel(int percent) {
    return 'Coffee cup, $percent% full';
  }
}
