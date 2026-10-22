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

  @override
  String get shop_street_cart => 'Street Cart';

  @override
  String get shop_corner_booth => 'Corner Booth';

  @override
  String get shop_boutique_cafe => 'Boutique Café';

  @override
  String get shop_campus_coworking => 'Campus Co-working';

  @override
  String get shop_drive_thru => 'Drive-Thru';

  @override
  String get shop_city_roastery => 'City Roastery';

  @override
  String get shop_airport_lounge => 'Airport Lounge';

  @override
  String get shop_robotic_kiosk => 'Robotic Kiosk';

  @override
  String get shop_capsule_store => 'Capsule Store';

  @override
  String get shop_global_mega_roastery => 'Global Mega Roastery';

  @override
  String get buyAmountOne => 'x1';

  @override
  String get buyAmountTen => 'x10';

  @override
  String get buyAmountMax => 'MAX';

  @override
  String get managerHired => 'Manager hired';

  @override
  String get milestoneMaxed => 'All milestones reached';

  @override
  String get equipmentEspressoMachine => 'Espresso Machine';

  @override
  String get equipmentDiamondGrinder => 'Diamond Grinder';

  @override
  String get equipmentSmartSystem => 'Smart System';

  @override
  String shopLevel(int level) {
    return 'Lv. $level';
  }

  @override
  String buyLevels(int count, String cost) {
    return 'Buy x$count · $cost';
  }

  @override
  String hireManager(String cost) {
    return 'Hire manager · $cost';
  }

  @override
  String buyEquipment(String name, String cost) {
    return '$name · $cost';
  }

  @override
  String nextMilestone(int level) {
    return '×2 income at Lv. $level';
  }

  @override
  String shopLocked(String shop) {
    return 'Unlocks after buying $shop';
  }

  @override
  String equipmentAllOwned(String name) {
    return '$name · Owned';
  }
}
