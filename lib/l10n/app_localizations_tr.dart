// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Coffee Empire';

  @override
  String durationDays(int value) {
    return '${value}g';
  }

  @override
  String durationHours(int value) {
    return '${value}sa';
  }

  @override
  String durationMinutes(int value) {
    return '${value}dk';
  }

  @override
  String durationSeconds(int value) {
    return '${value}sn';
  }

  @override
  String get tabShops => 'Dükkanlar';

  @override
  String get tabLab => 'Ar-Ge';

  @override
  String get tabGrowth => 'Büyüme';

  @override
  String get tabStore => 'Mağaza';

  @override
  String get comingSoon => 'Yakında';

  @override
  String incomePerSecond(String amount) {
    return '$amount/sn';
  }

  @override
  String comboLabel(int count) {
    return 'Kombo x$count';
  }

  @override
  String get baristaRush => 'Barista Rush!';

  @override
  String get tapToBrew => 'Demlemek için fincana dokun';

  @override
  String cupSemanticLabel(int percent) {
    return 'Kahve fincanı, %$percent dolu';
  }
}
