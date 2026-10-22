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

  @override
  String get shop_street_cart => 'Sokak Arabası';

  @override
  String get shop_corner_booth => 'Köşe Büfesi';

  @override
  String get shop_boutique_cafe => 'Butik Kafe';

  @override
  String get shop_campus_coworking => 'Kampüs Ortak Alanı';

  @override
  String get shop_drive_thru => 'Arabaya Servis';

  @override
  String get shop_city_roastery => 'Şehir Kavurmahanesi';

  @override
  String get shop_airport_lounge => 'Havalimanı Salonu';

  @override
  String get shop_robotic_kiosk => 'Robotik Kiosk';

  @override
  String get shop_capsule_store => 'Kapsül Mağazası';

  @override
  String get shop_global_mega_roastery => 'Küresel Mega Kavurmahane';

  @override
  String get buyAmountOne => 'x1';

  @override
  String get buyAmountTen => 'x10';

  @override
  String get buyAmountMax => 'MAKS';

  @override
  String get managerHired => 'Yönetici işte';

  @override
  String get milestoneMaxed => 'Tüm kilometre taşları tamam';

  @override
  String get equipmentEspressoMachine => 'Espresso Makinesi';

  @override
  String get equipmentDiamondGrinder => 'Elmas Değirmen';

  @override
  String get equipmentSmartSystem => 'Akıllı Sistem';

  @override
  String shopLevel(int level) {
    return 'Sv. $level';
  }

  @override
  String buyLevels(int count, String cost) {
    return 'x$count Al · $cost';
  }

  @override
  String hireManager(String cost) {
    return 'Yönetici kirala · $cost';
  }

  @override
  String buyEquipment(String name, String cost) {
    return '$name · $cost';
  }

  @override
  String nextMilestone(int level) {
    return 'Sv. $level\'de gelir ×2';
  }

  @override
  String shopLocked(String shop) {
    return '$shop alınınca açılır';
  }

  @override
  String equipmentAllOwned(String name) {
    return '$name · Alındı';
  }
}
