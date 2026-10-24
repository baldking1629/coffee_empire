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

  @override
  String get recipe_espresso_classic => 'Classic Espresso';

  @override
  String get recipe_cappuccino => 'Cappuccino';

  @override
  String get recipe_cold_brew => 'Cold Brew';

  @override
  String get recipe_flat_white => 'Flat White';

  @override
  String get recipe_capsule_house_blend => 'House Blend Capsule';

  @override
  String get recipe_ethiopian_pour_over => 'Ethiopian Pour-Over';

  @override
  String get recipe_nitro_mocha => 'Nitro Mocha';

  @override
  String get recipe_capsule_signature_reserve => 'Signature Reserve Capsule';

  @override
  String get flavorAcidity => 'Acidity';

  @override
  String get flavorBody => 'Body';

  @override
  String get flavorAroma => 'Aroma';

  @override
  String get flavorCaffeine => 'Caffeine';

  @override
  String hintTooLow(String attribute) {
    return '$attribute is too low';
  }

  @override
  String hintTooHigh(String attribute) {
    return '$attribute is too high';
  }

  @override
  String get hintOnTrack => 'You\'re on the right track!';

  @override
  String recipeBestScore(int score) {
    return 'Best: $score';
  }

  @override
  String recipeLastResult(int score, String hint) {
    return 'Last test: $score · $hint';
  }

  @override
  String get recipeCapsuleTag => 'Capsule';

  @override
  String unlockRecipe(String cost) {
    return 'Unlock · $cost';
  }

  @override
  String startTest(String cost) {
    return 'Test · $cost';
  }

  @override
  String brewingRemaining(String time) {
    return 'Brewing… $time';
  }

  @override
  String get anotherBrewActive => 'Another test is running';

  @override
  String get openRecipe => 'Develop';

  @override
  String get capsuleTitle => 'Capsule Machines';

  @override
  String capsuleLocked(int score, int hype) {
    return 'Needs a recipe scoring $score+ and $hype Brand Hype';
  }

  @override
  String capsuleOwned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count machines',
      one: '1 machine',
    );
    return '$_temp0';
  }

  @override
  String brandHypeValue(int hype) {
    return 'Brand Hype: $hype';
  }

  @override
  String labBonusValue(int percent) {
    return 'R&D bonus: +$percent%';
  }

  @override
  String get flavorProfileTitle => 'Flavor profile';

  @override
  String get city_new_york => 'New York';

  @override
  String get city_tokyo => 'Tokyo';

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
  String get city_mexico_city => 'Mexico City';

  @override
  String get city_seoul => 'Seoul';

  @override
  String get city_berlin => 'Berlin';

  @override
  String get city_madrid => 'Madrid';

  @override
  String get city_rome => 'Rome';

  @override
  String get city_toronto => 'Toronto';

  @override
  String get city_sydney => 'Sydney';

  @override
  String get city_mumbai => 'Mumbai';

  @override
  String get city_cairo => 'Cairo';

  @override
  String get city_jakarta => 'Jakarta';

  @override
  String get city_amsterdam => 'Amsterdam';

  @override
  String get city_singapore => 'Singapore';

  @override
  String get city_bangkok => 'Bangkok';

  @override
  String get city_buenos_aires => 'Buenos Aires';

  @override
  String get city_bogota => 'Bogotá';

  @override
  String get city_lagos => 'Lagos';

  @override
  String get city_vienna => 'Vienna';

  @override
  String get city_lisbon => 'Lisbon';

  @override
  String get city_reykjavik => 'Reykjavík';

  @override
  String get city_addis_ababa => 'Addis Ababa';

  @override
  String get city_nairobi => 'Nairobi';

  @override
  String get city_hanoi => 'Hanoi';

  @override
  String get country_US => 'United States';

  @override
  String get country_JP => 'Japan';

  @override
  String get country_GB => 'United Kingdom';

  @override
  String get country_TR => 'Türkiye';

  @override
  String get country_BR => 'Brazil';

  @override
  String get country_FR => 'France';

  @override
  String get country_AE => 'United Arab Emirates';

  @override
  String get country_CN => 'China';

  @override
  String get country_MX => 'Mexico';

  @override
  String get country_KR => 'South Korea';

  @override
  String get country_DE => 'Germany';

  @override
  String get country_ES => 'Spain';

  @override
  String get country_IT => 'Italy';

  @override
  String get country_CA => 'Canada';

  @override
  String get country_AU => 'Australia';

  @override
  String get country_IN => 'India';

  @override
  String get country_EG => 'Egypt';

  @override
  String get country_ID => 'Indonesia';

  @override
  String get country_NL => 'Netherlands';

  @override
  String get country_SG => 'Singapore';

  @override
  String get country_TH => 'Thailand';

  @override
  String get country_AR => 'Argentina';

  @override
  String get country_CO => 'Colombia';

  @override
  String get country_NG => 'Nigeria';

  @override
  String get country_AT => 'Austria';

  @override
  String get country_PT => 'Portugal';

  @override
  String get country_IS => 'Iceland';

  @override
  String get country_ET => 'Ethiopia';

  @override
  String get country_KE => 'Kenya';

  @override
  String get country_VN => 'Vietnam';

  @override
  String get region_europe => 'Europe';

  @override
  String get region_asia_pacific => 'Asia-Pacific';

  @override
  String get region_americas => 'Americas';

  @override
  String get region_mea => 'Middle East & Africa';

  @override
  String get franchiseTitle => 'Franchises';

  @override
  String franchiseRoyalty(String amount) {
    return 'Royalties: $amount/sec';
  }

  @override
  String franchisePerSlot(String amount) {
    return '+$amount/sec per slot';
  }

  @override
  String franchiseRequiresHype(int hype) {
    return 'Requires $hype Brand Hype';
  }

  @override
  String franchiseOpen(String cost) {
    return 'Open · $cost';
  }

  @override
  String franchiseComplete(String multiplier) {
    return 'City complete ×$multiplier';
  }

  @override
  String get prestigeTitle => 'Golden Beans';

  @override
  String prestigeOwned(int beans, String multiplier) {
    return '$beans Golden Beans · income ×$multiplier';
  }

  @override
  String prestigeProgress(String earned, String threshold) {
    return 'Run earnings $earned / $threshold';
  }

  @override
  String prestigeButton(int beans) {
    return 'Sell the empire · +$beans';
  }

  @override
  String get prestigeConfirmTitle => 'Start a new empire?';

  @override
  String prestigeConfirmBody(int beans, String multiplier) {
    return 'You will earn $beans Golden Beans. Your income multiplier becomes ×$multiplier. Shops, managers, equipment, capsule machines and franchises reset.';
  }

  @override
  String get confirm => 'Confirm';

  @override
  String get cancel => 'Cancel';

  @override
  String get offlineTitle => 'Welcome back!';

  @override
  String offlineBody(String duration, String amount) {
    return 'While you were away for $duration, your empire earned $amount.';
  }

  @override
  String get offlineCollect => 'Collect';

  @override
  String get offlineCollectDouble => 'Watch ad, collect 2x';

  @override
  String get adPlaying => 'Playing ad…';

  @override
  String get notificationChannelName => 'Coffee reminders';

  @override
  String get notifOfflineTitle => 'Your shops are overflowing!';

  @override
  String get notifOfflineBody =>
      'Offline earnings reached the limit. Come back to collect.';

  @override
  String get notifDailyTitle => 'Daily reward ready';

  @override
  String get notifDailyBody => 'Your daily coffee bonus is waiting.';

  @override
  String get notifRushTitle => 'Caffeine Rush ended';

  @override
  String get notifRushBody => 'Watch another ad to keep income doubled.';

  @override
  String get rewardedTitle => 'Free boosts';

  @override
  String get rewardCaffeineRushTitle => 'Caffeine Rush';

  @override
  String get rewardCaffeineRushBody =>
      'All income ×2 for 4 hours (up to 8 hours)';

  @override
  String get rewardEmergencyFundTitle => 'Emergency Fund';

  @override
  String rewardEmergencyFundBody(String amount) {
    return 'Get $amount instantly';
  }

  @override
  String get rewardLabSpeedupTitle => 'Lab Speed-up';

  @override
  String get rewardLabSpeedupBody => 'Finish the running R&D test now';

  @override
  String get watchAd => 'Watch ad';

  @override
  String readyIn(String time) {
    return 'Ready in $time';
  }

  @override
  String get unavailable => 'Not available';

  @override
  String boostActive(String multiplier, String time) {
    return '×$multiplier $time';
  }

  @override
  String get shopTitle => 'Premium';

  @override
  String get vipTitle => 'Master Roaster VIP';

  @override
  String get vipBody =>
      'Permanent income ×2, 12-hour offline limit and an auto-tapping barista';

  @override
  String get starterPackTitle => 'Espresso Starter Pack';

  @override
  String get starterPackBody =>
      'Permanent income ×1.25 plus 2 hours of income in cash';

  @override
  String get timeSkipTitle => '24h Time Skip';

  @override
  String timeSkipBody(String amount) {
    return 'Instantly receive $amount';
  }

  @override
  String get buyProduct => 'Buy';

  @override
  String get owned => 'Owned';

  @override
  String get restorePurchases => 'Restore purchases';

  @override
  String get noForcedAds => 'No forced ads — rewarded ads are always optional.';

  @override
  String get dailyRewardTitle => 'Daily reward';

  @override
  String dailyRewardDay(int day) {
    return 'Day $day';
  }

  @override
  String dailyRewardClaim(String amount) {
    return 'Claim $amount';
  }

  @override
  String dailyRewardNext(String time) {
    return 'Next reward in $time';
  }

  @override
  String dailyRewardBean(int beans) {
    return '+$beans Golden Bean';
  }
}
