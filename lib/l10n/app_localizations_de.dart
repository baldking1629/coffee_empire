// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Coffee Empire';

  @override
  String durationDays(int value) {
    return '$value T';
  }

  @override
  String durationHours(int value) {
    return '$value Std';
  }

  @override
  String durationMinutes(int value) {
    return '$value Min';
  }

  @override
  String durationSeconds(int value) {
    return '$value s';
  }

  @override
  String get tabShops => 'Läden';

  @override
  String get tabLab => 'F&E';

  @override
  String get tabGrowth => 'Wachstum';

  @override
  String get tabStore => 'Shop';

  @override
  String incomePerSecond(String amount) {
    return '$amount/s';
  }

  @override
  String comboLabel(int count) {
    return 'Combo x$count';
  }

  @override
  String get baristaRush => 'Barista Rush!';

  @override
  String get tapToBrew => 'Tippe auf die Tasse zum Brühen';

  @override
  String cupSemanticLabel(int percent) {
    return 'Kaffeetasse, zu $percent % voll';
  }

  @override
  String get shop_street_cart => 'Straßenwagen';

  @override
  String get shop_corner_booth => 'Eckkiosk';

  @override
  String get shop_boutique_cafe => 'Boutique-Café';

  @override
  String get shop_campus_coworking => 'Campus-Coworking';

  @override
  String get shop_drive_thru => 'Drive-in';

  @override
  String get shop_city_roastery => 'Stadtrösterei';

  @override
  String get shop_airport_lounge => 'Flughafen-Lounge';

  @override
  String get shop_robotic_kiosk => 'Roboterkiosk';

  @override
  String get shop_capsule_store => 'Kapselladen';

  @override
  String get shop_global_mega_roastery => 'Globale Megarösterei';

  @override
  String get buyAmountOne => 'x1';

  @override
  String get buyAmountTen => 'x10';

  @override
  String get buyAmountMax => 'MAX';

  @override
  String get managerHired => 'Manager eingestellt';

  @override
  String get milestoneMaxed => 'Alle Meilensteine erreicht';

  @override
  String get equipmentEspressoMachine => 'Espressomaschine';

  @override
  String get equipmentDiamondGrinder => 'Diamantmühle';

  @override
  String get equipmentSmartSystem => 'Smart-System';

  @override
  String shopLevel(int level) {
    return 'St. $level';
  }

  @override
  String buyLevels(int count, String cost) {
    return 'Kaufen x$count · $cost';
  }

  @override
  String hireManager(String cost) {
    return 'Manager einstellen · $cost';
  }

  @override
  String buyEquipment(String name, String cost) {
    return '$name · $cost';
  }

  @override
  String nextMilestone(int level) {
    return 'Einnahmen ×2 ab St. $level';
  }

  @override
  String shopLocked(String shop) {
    return 'Freigeschaltet nach Kauf von $shop';
  }

  @override
  String equipmentAllOwned(String name) {
    return '$name · Gekauft';
  }

  @override
  String get recipe_espresso_classic => 'Klassischer Espresso';

  @override
  String get recipe_cappuccino => 'Cappuccino';

  @override
  String get recipe_cold_brew => 'Cold Brew';

  @override
  String get recipe_flat_white => 'Flat White';

  @override
  String get recipe_capsule_house_blend => 'Hausmischung-Kapsel';

  @override
  String get recipe_ethiopian_pour_over => 'Äthiopischer Pour-Over';

  @override
  String get recipe_nitro_mocha => 'Nitro-Mokka';

  @override
  String get recipe_capsule_signature_reserve => 'Signature-Reserve-Kapsel';

  @override
  String get flavorAcidity => 'Säure';

  @override
  String get flavorBody => 'Körper';

  @override
  String get flavorAroma => 'Aroma';

  @override
  String get flavorCaffeine => 'Koffein';

  @override
  String hintTooLow(String attribute) {
    return '$attribute ist zu niedrig';
  }

  @override
  String hintTooHigh(String attribute) {
    return '$attribute ist zu hoch';
  }

  @override
  String get hintOnTrack => 'Du bist auf dem richtigen Weg!';

  @override
  String recipeBestScore(int score) {
    return 'Bestwert: $score';
  }

  @override
  String recipeLastResult(int score, String hint) {
    return 'Letzter Test: $score · $hint';
  }

  @override
  String get recipeCapsuleTag => 'Kapsel';

  @override
  String unlockRecipe(String cost) {
    return 'Freischalten · $cost';
  }

  @override
  String startTest(String cost) {
    return 'Testen · $cost';
  }

  @override
  String brewingRemaining(String time) {
    return 'Brüht… $time';
  }

  @override
  String get anotherBrewActive => 'Ein anderer Test läuft bereits';

  @override
  String get openRecipe => 'Entwickeln';

  @override
  String get capsuleTitle => 'Kapselmaschinen';

  @override
  String capsuleLocked(int score, int hype) {
    return 'Benötigt ein Rezept mit $score+ und $hype Markenhype';
  }

  @override
  String capsuleOwned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Maschinen',
      one: '1 Maschine',
    );
    return '$_temp0';
  }

  @override
  String brandHypeValue(int hype) {
    return 'Markenhype: $hype';
  }

  @override
  String labBonusValue(int percent) {
    return 'F&E-Bonus: +$percent %';
  }

  @override
  String get flavorProfileTitle => 'Geschmacksprofil';

  @override
  String get city_new_york => 'New York';

  @override
  String get city_tokyo => 'Tokio';

  @override
  String get city_london => 'London';

  @override
  String get city_istanbul => 'Istanbul';

  @override
  String get city_sao_paulo => 'São Paulo';

  @override
  String get city_paris => 'Paris';

  @override
  String get city_dubai => 'Dubai';

  @override
  String get city_shanghai => 'Shanghai';

  @override
  String get city_mexico_city => 'Mexiko-Stadt';

  @override
  String get city_seoul => 'Seoul';

  @override
  String get city_berlin => 'Berlin';

  @override
  String get city_madrid => 'Madrid';

  @override
  String get city_rome => 'Rom';

  @override
  String get city_toronto => 'Toronto';

  @override
  String get city_sydney => 'Sydney';

  @override
  String get city_mumbai => 'Mumbai';

  @override
  String get city_cairo => 'Kairo';

  @override
  String get city_jakarta => 'Jakarta';

  @override
  String get city_amsterdam => 'Amsterdam';

  @override
  String get city_singapore => 'Singapur';

  @override
  String get city_bangkok => 'Bangkok';

  @override
  String get city_buenos_aires => 'Buenos Aires';

  @override
  String get city_bogota => 'Bogotá';

  @override
  String get city_lagos => 'Lagos';

  @override
  String get city_vienna => 'Wien';

  @override
  String get city_lisbon => 'Lissabon';

  @override
  String get city_reykjavik => 'Reykjavík';

  @override
  String get city_addis_ababa => 'Addis Abeba';

  @override
  String get city_nairobi => 'Nairobi';

  @override
  String get city_hanoi => 'Hanoi';

  @override
  String get country_US => 'Vereinigte Staaten';

  @override
  String get country_JP => 'Japan';

  @override
  String get country_GB => 'Vereinigtes Königreich';

  @override
  String get country_TR => 'Türkei';

  @override
  String get country_BR => 'Brasilien';

  @override
  String get country_FR => 'Frankreich';

  @override
  String get country_AE => 'Vereinigte Arabische Emirate';

  @override
  String get country_CN => 'China';

  @override
  String get country_MX => 'Mexiko';

  @override
  String get country_KR => 'Südkorea';

  @override
  String get country_DE => 'Deutschland';

  @override
  String get country_ES => 'Spanien';

  @override
  String get country_IT => 'Italien';

  @override
  String get country_CA => 'Kanada';

  @override
  String get country_AU => 'Australien';

  @override
  String get country_IN => 'Indien';

  @override
  String get country_EG => 'Ägypten';

  @override
  String get country_ID => 'Indonesien';

  @override
  String get country_NL => 'Niederlande';

  @override
  String get country_SG => 'Singapur';

  @override
  String get country_TH => 'Thailand';

  @override
  String get country_AR => 'Argentinien';

  @override
  String get country_CO => 'Kolumbien';

  @override
  String get country_NG => 'Nigeria';

  @override
  String get country_AT => 'Österreich';

  @override
  String get country_PT => 'Portugal';

  @override
  String get country_IS => 'Island';

  @override
  String get country_ET => 'Äthiopien';

  @override
  String get country_KE => 'Kenia';

  @override
  String get country_VN => 'Vietnam';

  @override
  String get region_europe => 'Europa';

  @override
  String get region_asia_pacific => 'Asien-Pazifik';

  @override
  String get region_americas => 'Amerika';

  @override
  String get region_mea => 'Naher Osten & Afrika';

  @override
  String get franchiseTitle => 'Franchises';

  @override
  String franchiseRoyalty(String amount) {
    return 'Lizenzgebühren: $amount/s';
  }

  @override
  String franchisePerSlot(String amount) {
    return '+$amount/s pro Standort';
  }

  @override
  String franchiseRequiresHype(int hype) {
    return 'Benötigt $hype Markenhype';
  }

  @override
  String franchiseOpen(String cost) {
    return 'Eröffnen · $cost';
  }

  @override
  String franchiseComplete(String multiplier) {
    return 'Stadt komplett ×$multiplier';
  }

  @override
  String get prestigeTitle => 'Goldene Bohnen';

  @override
  String prestigeOwned(int beans, String multiplier) {
    return '$beans Goldene Bohnen · Einnahmen ×$multiplier';
  }

  @override
  String prestigeProgress(String earned, String threshold) {
    return 'Einnahmen dieser Runde $earned / $threshold';
  }

  @override
  String prestigeButton(int beans) {
    return 'Imperium verkaufen · +$beans';
  }

  @override
  String get prestigeConfirmTitle => 'Ein neues Imperium gründen?';

  @override
  String prestigeConfirmBody(int beans, String multiplier) {
    return 'Du erhältst $beans Goldene Bohnen. Dein Einnahmen-Multiplikator wird ×$multiplier. Läden, Manager, Ausrüstung, Kapselmaschinen und Franchises werden zurückgesetzt.';
  }

  @override
  String get confirm => 'Bestätigen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get offlineTitle => 'Willkommen zurück!';

  @override
  String offlineBody(String duration, String amount) {
    return 'Während du $duration weg warst, hat dein Imperium $amount verdient.';
  }

  @override
  String get offlineCollect => 'Einsammeln';

  @override
  String get offlineCollectDouble => 'Werbung ansehen, 2x einsammeln';

  @override
  String get adPlaying => 'Werbung läuft…';

  @override
  String get notificationChannelName => 'Kaffee-Erinnerungen';

  @override
  String get notifOfflineTitle => 'Deine Läden laufen über!';

  @override
  String get notifOfflineBody =>
      'Die Offline-Einnahmen haben das Limit erreicht. Komm zurück und sammle sie ein.';

  @override
  String get notifDailyTitle => 'Tagesbelohnung bereit';

  @override
  String get notifDailyBody => 'Dein täglicher Kaffeebonus wartet.';

  @override
  String get notifRushTitle => 'Caffeine Rush beendet';

  @override
  String get notifRushBody =>
      'Sieh dir eine weitere Werbung an, um doppelte Einnahmen zu behalten.';

  @override
  String get rewardedTitle => 'Gratis-Boosts';

  @override
  String get rewardCaffeineRushTitle => 'Caffeine Rush';

  @override
  String get rewardCaffeineRushBody =>
      'Alle Einnahmen ×2 für 4 Stunden (bis zu 8 Stunden)';

  @override
  String get rewardEmergencyFundTitle => 'Notfallfonds';

  @override
  String rewardEmergencyFundBody(String amount) {
    return 'Erhalte sofort $amount';
  }

  @override
  String get rewardLabSpeedupTitle => 'Labor-Beschleuniger';

  @override
  String get rewardLabSpeedupBody => 'Laufenden F&E-Test sofort beenden';

  @override
  String get watchAd => 'Werbung ansehen';

  @override
  String readyIn(String time) {
    return 'Bereit in $time';
  }

  @override
  String get unavailable => 'Nicht verfügbar';

  @override
  String boostActive(String multiplier, String time) {
    return '×$multiplier $time';
  }

  @override
  String get shopTitle => 'Premium';

  @override
  String get vipTitle => 'Meisterröster-VIP';

  @override
  String get vipBody =>
      'Dauerhaft Einnahmen ×2, 12 Stunden Offline-Limit und ein Barista, der automatisch tippt';

  @override
  String get starterPackTitle => 'Espresso-Starterpaket';

  @override
  String get starterPackBody =>
      'Dauerhaft Einnahmen ×1,25 und 2 Stunden Einnahmen in bar';

  @override
  String get timeSkipTitle => '24-Std.-Zeitsprung';

  @override
  String timeSkipBody(String amount) {
    return 'Erhalte sofort $amount';
  }

  @override
  String get buyProduct => 'Kaufen';

  @override
  String get owned => 'Gekauft';

  @override
  String get restorePurchases => 'Käufe wiederherstellen';

  @override
  String get noForcedAds =>
      'Keine Zwangswerbung – Belohnungswerbung ist immer freiwillig.';

  @override
  String get dailyRewardTitle => 'Tagesbelohnung';

  @override
  String dailyRewardDay(int day) {
    return 'Tag $day';
  }

  @override
  String dailyRewardClaim(String amount) {
    return '$amount abholen';
  }

  @override
  String dailyRewardNext(String time) {
    return 'Nächste Belohnung in $time';
  }

  @override
  String dailyRewardBean(int beans) {
    return '+$beans Goldene Bohne';
  }

  @override
  String tutorialTitle(int step, int total) {
    return 'Barista-Training $step/$total';
  }

  @override
  String get tutorialStepTapCup =>
      'Tippe auf die Kaffeetasse, um deinen ersten Kaffee zu brühen.';

  @override
  String get tutorialStepBuyFirstShop =>
      'Kaufe im Tab Läden einen Straßenwagen.';

  @override
  String get tutorialStepBuySecondShop =>
      'Eröffne deinen zweiten Laden: den Eckkiosk.';

  @override
  String get tutorialStepHireManager =>
      'Stelle einen Manager ein, um die Einnahmen eines Ladens zu verdreifachen.';

  @override
  String get tutorialStepOpenLab =>
      'Öffne den Tab F&E, um Rezepte zu entdecken.';

  @override
  String get tutorialStepFinish =>
      'Du bist bereit, dein Imperium aufzubauen! Aktiviere Erinnerungen, damit du keine Belohnung verpasst.';

  @override
  String get tutorialSkip => 'Überspringen';

  @override
  String get tutorialFinish => 'Los geht\'s!';

  @override
  String get achievementsTitle => 'Erfolge';

  @override
  String achievementsProgress(int unlocked, int total, int percent) {
    return '$unlocked/$total freigeschaltet · Einnahmen +$percent %';
  }

  @override
  String achievementUnlocked(String name) {
    return 'Erfolg freigeschaltet: $name';
  }

  @override
  String achDescLifetime(String amount) {
    return 'Verdiene insgesamt $amount';
  }

  @override
  String achDescShopLevel(int level) {
    return 'Erreiche Stufe $level in einem Laden';
  }

  @override
  String achDescRecipes(int score, int count) {
    return 'Erreiche $score+ bei $count Rezepten';
  }

  @override
  String achDescFranchises(int count) {
    return 'Besitze $count Franchise-Standorte';
  }

  @override
  String achDescPrestige(int count) {
    return 'Gründe $count-mal ein neues Imperium';
  }

  @override
  String achDescTaps(int count) {
    return 'Tippe $count-mal auf die Tasse';
  }

  @override
  String get achievement_first_dollars => 'Erste Dollars';

  @override
  String get achievement_small_business => 'Kleines Geschäft';

  @override
  String get achievement_coffee_mogul => 'Kaffeemogul';

  @override
  String get achievement_bean_tycoon => 'Bohnenmagnat';

  @override
  String get achievement_caffeine_empire => 'Koffein-Imperium';

  @override
  String get achievement_growing_shop => 'Wachsender Laden';

  @override
  String get achievement_busy_counter => 'Volle Theke';

  @override
  String get achievement_centurion => 'Zenturio';

  @override
  String get achievement_legendary_branch => 'Legendäre Filiale';

  @override
  String get achievement_first_masterpiece => 'Erstes Meisterwerk';

  @override
  String get achievement_lab_regular => 'Laborstammgast';

  @override
  String get achievement_master_brewer => 'Meisterbrüher';

  @override
  String get achievement_first_franchise => 'Erstes Franchise';

  @override
  String get achievement_regional_brand => 'Regionale Marke';

  @override
  String get achievement_global_chain => 'Globale Kette';

  @override
  String get achievement_world_domination => 'Weltherrschaft';

  @override
  String get achievement_fresh_start => 'Neuanfang';

  @override
  String get achievement_serial_founder => 'Serienunternehmer';

  @override
  String get achievement_eager_barista => 'Eifriger Barista';

  @override
  String get achievement_tireless_barista => 'Unermüdlicher Barista';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get languageSystem => 'System';

  @override
  String get settingsSound => 'Ton';

  @override
  String get settingsHaptics => 'Vibration';

  @override
  String get settingsNotifications => 'Benachrichtigungen';

  @override
  String get settingsScientific => 'Wissenschaftliche Notation';

  @override
  String get settingsReset => 'Fortschritt zurücksetzen';

  @override
  String get resetConfirmTitle => 'Gesamten Fortschritt zurücksetzen?';

  @override
  String get resetConfirmBody =>
      'Dadurch wird dein Spielstand gelöscht, einschließlich Goldener Bohnen und Käufe. Dies kann nicht rückgängig gemacht werden.';

  @override
  String get resetConfirm => 'Zurücksetzen';

  @override
  String get languageNative_en => 'English';

  @override
  String get languageNative_tr => 'Türkçe';

  @override
  String get languageNative_es => 'Español';

  @override
  String get languageNative_pt => 'Português (Brasil)';

  @override
  String get languageNative_fr => 'Français';

  @override
  String get languageNative_de => 'Deutsch';

  @override
  String get languageNative_it => 'Italiano';

  @override
  String get languageNative_ru => 'Русский';

  @override
  String get languageNative_ar => 'العربية';

  @override
  String get languageNative_hi => 'हिन्दी';

  @override
  String get languageNative_id => 'Bahasa Indonesia';

  @override
  String get languageNative_ja => '日本語';

  @override
  String get languageNative_ko => '한국어';

  @override
  String get languageNative_zh => '简体中文';

  @override
  String get languageNative_vi => 'Tiếng Việt';

  @override
  String floatingGain(String amount) {
    return '+$amount';
  }

  @override
  String get lockedStationName => '???';

  @override
  String get stationUpgradesHint => 'Tippen für Manager & Ausrüstung';

  @override
  String get spriteGalleryTitle => 'Sprite-Galerie';
}
