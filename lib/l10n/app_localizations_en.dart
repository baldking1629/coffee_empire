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
}
