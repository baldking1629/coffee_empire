import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('ru'),
    Locale('tr'),
    Locale('vi'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Coffee Empire'**
  String get appTitle;

  /// No description provided for @durationDays.
  ///
  /// In en, this message translates to:
  /// **'{value}d'**
  String durationDays(int value);

  /// No description provided for @durationHours.
  ///
  /// In en, this message translates to:
  /// **'{value}h'**
  String durationHours(int value);

  /// No description provided for @durationMinutes.
  ///
  /// In en, this message translates to:
  /// **'{value}m'**
  String durationMinutes(int value);

  /// No description provided for @durationSeconds.
  ///
  /// In en, this message translates to:
  /// **'{value}s'**
  String durationSeconds(int value);

  /// No description provided for @tabShops.
  ///
  /// In en, this message translates to:
  /// **'Shops'**
  String get tabShops;

  /// No description provided for @tabLab.
  ///
  /// In en, this message translates to:
  /// **'R&D'**
  String get tabLab;

  /// No description provided for @tabGrowth.
  ///
  /// In en, this message translates to:
  /// **'Growth'**
  String get tabGrowth;

  /// No description provided for @tabStore.
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get tabStore;

  /// No description provided for @incomePerSecond.
  ///
  /// In en, this message translates to:
  /// **'{amount}/sec'**
  String incomePerSecond(String amount);

  /// No description provided for @comboLabel.
  ///
  /// In en, this message translates to:
  /// **'Combo x{count}'**
  String comboLabel(int count);

  /// No description provided for @baristaRush.
  ///
  /// In en, this message translates to:
  /// **'Barista Rush!'**
  String get baristaRush;

  /// No description provided for @tapToBrew.
  ///
  /// In en, this message translates to:
  /// **'Tap the cup to brew'**
  String get tapToBrew;

  /// No description provided for @cupSemanticLabel.
  ///
  /// In en, this message translates to:
  /// **'Coffee cup, {percent}% full'**
  String cupSemanticLabel(int percent);

  /// No description provided for @shop_street_cart.
  ///
  /// In en, this message translates to:
  /// **'Street Cart'**
  String get shop_street_cart;

  /// No description provided for @shop_corner_booth.
  ///
  /// In en, this message translates to:
  /// **'Corner Booth'**
  String get shop_corner_booth;

  /// No description provided for @shop_boutique_cafe.
  ///
  /// In en, this message translates to:
  /// **'Boutique Café'**
  String get shop_boutique_cafe;

  /// No description provided for @shop_campus_coworking.
  ///
  /// In en, this message translates to:
  /// **'Campus Co-working'**
  String get shop_campus_coworking;

  /// No description provided for @shop_drive_thru.
  ///
  /// In en, this message translates to:
  /// **'Drive-Thru'**
  String get shop_drive_thru;

  /// No description provided for @shop_city_roastery.
  ///
  /// In en, this message translates to:
  /// **'City Roastery'**
  String get shop_city_roastery;

  /// No description provided for @shop_airport_lounge.
  ///
  /// In en, this message translates to:
  /// **'Airport Lounge'**
  String get shop_airport_lounge;

  /// No description provided for @shop_robotic_kiosk.
  ///
  /// In en, this message translates to:
  /// **'Robotic Kiosk'**
  String get shop_robotic_kiosk;

  /// No description provided for @shop_capsule_store.
  ///
  /// In en, this message translates to:
  /// **'Capsule Store'**
  String get shop_capsule_store;

  /// No description provided for @shop_global_mega_roastery.
  ///
  /// In en, this message translates to:
  /// **'Global Mega Roastery'**
  String get shop_global_mega_roastery;

  /// No description provided for @buyAmountOne.
  ///
  /// In en, this message translates to:
  /// **'x1'**
  String get buyAmountOne;

  /// No description provided for @buyAmountTen.
  ///
  /// In en, this message translates to:
  /// **'x10'**
  String get buyAmountTen;

  /// No description provided for @buyAmountMax.
  ///
  /// In en, this message translates to:
  /// **'MAX'**
  String get buyAmountMax;

  /// No description provided for @managerHired.
  ///
  /// In en, this message translates to:
  /// **'Manager hired'**
  String get managerHired;

  /// No description provided for @milestoneMaxed.
  ///
  /// In en, this message translates to:
  /// **'All milestones reached'**
  String get milestoneMaxed;

  /// No description provided for @equipmentEspressoMachine.
  ///
  /// In en, this message translates to:
  /// **'Espresso Machine'**
  String get equipmentEspressoMachine;

  /// No description provided for @equipmentDiamondGrinder.
  ///
  /// In en, this message translates to:
  /// **'Diamond Grinder'**
  String get equipmentDiamondGrinder;

  /// No description provided for @equipmentSmartSystem.
  ///
  /// In en, this message translates to:
  /// **'Smart System'**
  String get equipmentSmartSystem;

  /// No description provided for @shopLevel.
  ///
  /// In en, this message translates to:
  /// **'Lv. {level}'**
  String shopLevel(int level);

  /// No description provided for @buyLevels.
  ///
  /// In en, this message translates to:
  /// **'Buy x{count} · {cost}'**
  String buyLevels(int count, String cost);

  /// No description provided for @hireManager.
  ///
  /// In en, this message translates to:
  /// **'Hire manager · {cost}'**
  String hireManager(String cost);

  /// No description provided for @buyEquipment.
  ///
  /// In en, this message translates to:
  /// **'{name} · {cost}'**
  String buyEquipment(String name, String cost);

  /// No description provided for @nextMilestone.
  ///
  /// In en, this message translates to:
  /// **'×2 income at Lv. {level}'**
  String nextMilestone(int level);

  /// No description provided for @shopLocked.
  ///
  /// In en, this message translates to:
  /// **'Unlocks after buying {shop}'**
  String shopLocked(String shop);

  /// No description provided for @equipmentAllOwned.
  ///
  /// In en, this message translates to:
  /// **'{name} · Owned'**
  String equipmentAllOwned(String name);

  /// No description provided for @recipe_espresso_classic.
  ///
  /// In en, this message translates to:
  /// **'Classic Espresso'**
  String get recipe_espresso_classic;

  /// No description provided for @recipe_cappuccino.
  ///
  /// In en, this message translates to:
  /// **'Cappuccino'**
  String get recipe_cappuccino;

  /// No description provided for @recipe_cold_brew.
  ///
  /// In en, this message translates to:
  /// **'Cold Brew'**
  String get recipe_cold_brew;

  /// No description provided for @recipe_flat_white.
  ///
  /// In en, this message translates to:
  /// **'Flat White'**
  String get recipe_flat_white;

  /// No description provided for @recipe_capsule_house_blend.
  ///
  /// In en, this message translates to:
  /// **'House Blend Capsule'**
  String get recipe_capsule_house_blend;

  /// No description provided for @recipe_ethiopian_pour_over.
  ///
  /// In en, this message translates to:
  /// **'Ethiopian Pour-Over'**
  String get recipe_ethiopian_pour_over;

  /// No description provided for @recipe_nitro_mocha.
  ///
  /// In en, this message translates to:
  /// **'Nitro Mocha'**
  String get recipe_nitro_mocha;

  /// No description provided for @recipe_capsule_signature_reserve.
  ///
  /// In en, this message translates to:
  /// **'Signature Reserve Capsule'**
  String get recipe_capsule_signature_reserve;

  /// No description provided for @flavorAcidity.
  ///
  /// In en, this message translates to:
  /// **'Acidity'**
  String get flavorAcidity;

  /// No description provided for @flavorBody.
  ///
  /// In en, this message translates to:
  /// **'Body'**
  String get flavorBody;

  /// No description provided for @flavorAroma.
  ///
  /// In en, this message translates to:
  /// **'Aroma'**
  String get flavorAroma;

  /// No description provided for @flavorCaffeine.
  ///
  /// In en, this message translates to:
  /// **'Caffeine'**
  String get flavorCaffeine;

  /// No description provided for @hintTooLow.
  ///
  /// In en, this message translates to:
  /// **'{attribute} is too low'**
  String hintTooLow(String attribute);

  /// No description provided for @hintTooHigh.
  ///
  /// In en, this message translates to:
  /// **'{attribute} is too high'**
  String hintTooHigh(String attribute);

  /// No description provided for @hintOnTrack.
  ///
  /// In en, this message translates to:
  /// **'You\'re on the right track!'**
  String get hintOnTrack;

  /// No description provided for @recipeBestScore.
  ///
  /// In en, this message translates to:
  /// **'Best: {score}'**
  String recipeBestScore(int score);

  /// No description provided for @recipeLastResult.
  ///
  /// In en, this message translates to:
  /// **'Last test: {score} · {hint}'**
  String recipeLastResult(int score, String hint);

  /// No description provided for @recipeCapsuleTag.
  ///
  /// In en, this message translates to:
  /// **'Capsule'**
  String get recipeCapsuleTag;

  /// No description provided for @unlockRecipe.
  ///
  /// In en, this message translates to:
  /// **'Unlock · {cost}'**
  String unlockRecipe(String cost);

  /// No description provided for @startTest.
  ///
  /// In en, this message translates to:
  /// **'Test · {cost}'**
  String startTest(String cost);

  /// No description provided for @brewingRemaining.
  ///
  /// In en, this message translates to:
  /// **'Brewing… {time}'**
  String brewingRemaining(String time);

  /// No description provided for @anotherBrewActive.
  ///
  /// In en, this message translates to:
  /// **'Another test is running'**
  String get anotherBrewActive;

  /// No description provided for @openRecipe.
  ///
  /// In en, this message translates to:
  /// **'Develop'**
  String get openRecipe;

  /// No description provided for @capsuleTitle.
  ///
  /// In en, this message translates to:
  /// **'Capsule Machines'**
  String get capsuleTitle;

  /// No description provided for @capsuleLocked.
  ///
  /// In en, this message translates to:
  /// **'Needs a recipe scoring {score}+ and {hype} Brand Hype'**
  String capsuleLocked(int score, int hype);

  /// No description provided for @capsuleOwned.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 machine} other{{count} machines}}'**
  String capsuleOwned(int count);

  /// No description provided for @brandHypeValue.
  ///
  /// In en, this message translates to:
  /// **'Brand Hype: {hype}'**
  String brandHypeValue(int hype);

  /// No description provided for @labBonusValue.
  ///
  /// In en, this message translates to:
  /// **'R&D bonus: +{percent}%'**
  String labBonusValue(int percent);

  /// No description provided for @flavorProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Flavor profile'**
  String get flavorProfileTitle;

  /// No description provided for @city_new_york.
  ///
  /// In en, this message translates to:
  /// **'New York'**
  String get city_new_york;

  /// No description provided for @city_tokyo.
  ///
  /// In en, this message translates to:
  /// **'Tokyo'**
  String get city_tokyo;

  /// No description provided for @city_london.
  ///
  /// In en, this message translates to:
  /// **'London'**
  String get city_london;

  /// No description provided for @city_istanbul.
  ///
  /// In en, this message translates to:
  /// **'Istanbul'**
  String get city_istanbul;

  /// No description provided for @city_sao_paulo.
  ///
  /// In en, this message translates to:
  /// **'São Paulo'**
  String get city_sao_paulo;

  /// No description provided for @city_paris.
  ///
  /// In en, this message translates to:
  /// **'Paris'**
  String get city_paris;

  /// No description provided for @city_dubai.
  ///
  /// In en, this message translates to:
  /// **'Dubai'**
  String get city_dubai;

  /// No description provided for @city_shanghai.
  ///
  /// In en, this message translates to:
  /// **'Shanghai'**
  String get city_shanghai;

  /// No description provided for @city_mexico_city.
  ///
  /// In en, this message translates to:
  /// **'Mexico City'**
  String get city_mexico_city;

  /// No description provided for @city_seoul.
  ///
  /// In en, this message translates to:
  /// **'Seoul'**
  String get city_seoul;

  /// No description provided for @city_berlin.
  ///
  /// In en, this message translates to:
  /// **'Berlin'**
  String get city_berlin;

  /// No description provided for @city_madrid.
  ///
  /// In en, this message translates to:
  /// **'Madrid'**
  String get city_madrid;

  /// No description provided for @city_rome.
  ///
  /// In en, this message translates to:
  /// **'Rome'**
  String get city_rome;

  /// No description provided for @city_toronto.
  ///
  /// In en, this message translates to:
  /// **'Toronto'**
  String get city_toronto;

  /// No description provided for @city_sydney.
  ///
  /// In en, this message translates to:
  /// **'Sydney'**
  String get city_sydney;

  /// No description provided for @city_mumbai.
  ///
  /// In en, this message translates to:
  /// **'Mumbai'**
  String get city_mumbai;

  /// No description provided for @city_cairo.
  ///
  /// In en, this message translates to:
  /// **'Cairo'**
  String get city_cairo;

  /// No description provided for @city_jakarta.
  ///
  /// In en, this message translates to:
  /// **'Jakarta'**
  String get city_jakarta;

  /// No description provided for @city_amsterdam.
  ///
  /// In en, this message translates to:
  /// **'Amsterdam'**
  String get city_amsterdam;

  /// No description provided for @city_singapore.
  ///
  /// In en, this message translates to:
  /// **'Singapore'**
  String get city_singapore;

  /// No description provided for @city_bangkok.
  ///
  /// In en, this message translates to:
  /// **'Bangkok'**
  String get city_bangkok;

  /// No description provided for @city_buenos_aires.
  ///
  /// In en, this message translates to:
  /// **'Buenos Aires'**
  String get city_buenos_aires;

  /// No description provided for @city_bogota.
  ///
  /// In en, this message translates to:
  /// **'Bogotá'**
  String get city_bogota;

  /// No description provided for @city_lagos.
  ///
  /// In en, this message translates to:
  /// **'Lagos'**
  String get city_lagos;

  /// No description provided for @city_vienna.
  ///
  /// In en, this message translates to:
  /// **'Vienna'**
  String get city_vienna;

  /// No description provided for @city_lisbon.
  ///
  /// In en, this message translates to:
  /// **'Lisbon'**
  String get city_lisbon;

  /// No description provided for @city_reykjavik.
  ///
  /// In en, this message translates to:
  /// **'Reykjavík'**
  String get city_reykjavik;

  /// No description provided for @city_addis_ababa.
  ///
  /// In en, this message translates to:
  /// **'Addis Ababa'**
  String get city_addis_ababa;

  /// No description provided for @city_nairobi.
  ///
  /// In en, this message translates to:
  /// **'Nairobi'**
  String get city_nairobi;

  /// No description provided for @city_hanoi.
  ///
  /// In en, this message translates to:
  /// **'Hanoi'**
  String get city_hanoi;

  /// No description provided for @country_US.
  ///
  /// In en, this message translates to:
  /// **'United States'**
  String get country_US;

  /// No description provided for @country_JP.
  ///
  /// In en, this message translates to:
  /// **'Japan'**
  String get country_JP;

  /// No description provided for @country_GB.
  ///
  /// In en, this message translates to:
  /// **'United Kingdom'**
  String get country_GB;

  /// No description provided for @country_TR.
  ///
  /// In en, this message translates to:
  /// **'Türkiye'**
  String get country_TR;

  /// No description provided for @country_BR.
  ///
  /// In en, this message translates to:
  /// **'Brazil'**
  String get country_BR;

  /// No description provided for @country_FR.
  ///
  /// In en, this message translates to:
  /// **'France'**
  String get country_FR;

  /// No description provided for @country_AE.
  ///
  /// In en, this message translates to:
  /// **'United Arab Emirates'**
  String get country_AE;

  /// No description provided for @country_CN.
  ///
  /// In en, this message translates to:
  /// **'China'**
  String get country_CN;

  /// No description provided for @country_MX.
  ///
  /// In en, this message translates to:
  /// **'Mexico'**
  String get country_MX;

  /// No description provided for @country_KR.
  ///
  /// In en, this message translates to:
  /// **'South Korea'**
  String get country_KR;

  /// No description provided for @country_DE.
  ///
  /// In en, this message translates to:
  /// **'Germany'**
  String get country_DE;

  /// No description provided for @country_ES.
  ///
  /// In en, this message translates to:
  /// **'Spain'**
  String get country_ES;

  /// No description provided for @country_IT.
  ///
  /// In en, this message translates to:
  /// **'Italy'**
  String get country_IT;

  /// No description provided for @country_CA.
  ///
  /// In en, this message translates to:
  /// **'Canada'**
  String get country_CA;

  /// No description provided for @country_AU.
  ///
  /// In en, this message translates to:
  /// **'Australia'**
  String get country_AU;

  /// No description provided for @country_IN.
  ///
  /// In en, this message translates to:
  /// **'India'**
  String get country_IN;

  /// No description provided for @country_EG.
  ///
  /// In en, this message translates to:
  /// **'Egypt'**
  String get country_EG;

  /// No description provided for @country_ID.
  ///
  /// In en, this message translates to:
  /// **'Indonesia'**
  String get country_ID;

  /// No description provided for @country_NL.
  ///
  /// In en, this message translates to:
  /// **'Netherlands'**
  String get country_NL;

  /// No description provided for @country_SG.
  ///
  /// In en, this message translates to:
  /// **'Singapore'**
  String get country_SG;

  /// No description provided for @country_TH.
  ///
  /// In en, this message translates to:
  /// **'Thailand'**
  String get country_TH;

  /// No description provided for @country_AR.
  ///
  /// In en, this message translates to:
  /// **'Argentina'**
  String get country_AR;

  /// No description provided for @country_CO.
  ///
  /// In en, this message translates to:
  /// **'Colombia'**
  String get country_CO;

  /// No description provided for @country_NG.
  ///
  /// In en, this message translates to:
  /// **'Nigeria'**
  String get country_NG;

  /// No description provided for @country_AT.
  ///
  /// In en, this message translates to:
  /// **'Austria'**
  String get country_AT;

  /// No description provided for @country_PT.
  ///
  /// In en, this message translates to:
  /// **'Portugal'**
  String get country_PT;

  /// No description provided for @country_IS.
  ///
  /// In en, this message translates to:
  /// **'Iceland'**
  String get country_IS;

  /// No description provided for @country_ET.
  ///
  /// In en, this message translates to:
  /// **'Ethiopia'**
  String get country_ET;

  /// No description provided for @country_KE.
  ///
  /// In en, this message translates to:
  /// **'Kenya'**
  String get country_KE;

  /// No description provided for @country_VN.
  ///
  /// In en, this message translates to:
  /// **'Vietnam'**
  String get country_VN;

  /// No description provided for @region_europe.
  ///
  /// In en, this message translates to:
  /// **'Europe'**
  String get region_europe;

  /// No description provided for @region_asia_pacific.
  ///
  /// In en, this message translates to:
  /// **'Asia-Pacific'**
  String get region_asia_pacific;

  /// No description provided for @region_americas.
  ///
  /// In en, this message translates to:
  /// **'Americas'**
  String get region_americas;

  /// No description provided for @region_mea.
  ///
  /// In en, this message translates to:
  /// **'Middle East & Africa'**
  String get region_mea;

  /// No description provided for @franchiseTitle.
  ///
  /// In en, this message translates to:
  /// **'Franchises'**
  String get franchiseTitle;

  /// No description provided for @franchiseRoyalty.
  ///
  /// In en, this message translates to:
  /// **'Royalties: {amount}/sec'**
  String franchiseRoyalty(String amount);

  /// No description provided for @franchisePerSlot.
  ///
  /// In en, this message translates to:
  /// **'+{amount}/sec per slot'**
  String franchisePerSlot(String amount);

  /// No description provided for @franchiseRequiresHype.
  ///
  /// In en, this message translates to:
  /// **'Requires {hype} Brand Hype'**
  String franchiseRequiresHype(int hype);

  /// No description provided for @franchiseOpen.
  ///
  /// In en, this message translates to:
  /// **'Open · {cost}'**
  String franchiseOpen(String cost);

  /// No description provided for @franchiseComplete.
  ///
  /// In en, this message translates to:
  /// **'City complete ×{multiplier}'**
  String franchiseComplete(String multiplier);

  /// No description provided for @prestigeTitle.
  ///
  /// In en, this message translates to:
  /// **'Golden Beans'**
  String get prestigeTitle;

  /// No description provided for @prestigeOwned.
  ///
  /// In en, this message translates to:
  /// **'{beans} Golden Beans · income ×{multiplier}'**
  String prestigeOwned(int beans, String multiplier);

  /// No description provided for @prestigeProgress.
  ///
  /// In en, this message translates to:
  /// **'Run earnings {earned} / {threshold}'**
  String prestigeProgress(String earned, String threshold);

  /// No description provided for @prestigeButton.
  ///
  /// In en, this message translates to:
  /// **'Sell the empire · +{beans}'**
  String prestigeButton(int beans);

  /// No description provided for @prestigeConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Start a new empire?'**
  String get prestigeConfirmTitle;

  /// No description provided for @prestigeConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'You will earn {beans} Golden Beans. Your income multiplier becomes ×{multiplier}. Shops, managers, equipment, capsule machines and franchises reset.'**
  String prestigeConfirmBody(int beans, String multiplier);

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @offlineTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back!'**
  String get offlineTitle;

  /// No description provided for @offlineBody.
  ///
  /// In en, this message translates to:
  /// **'While you were away for {duration}, your empire earned {amount}.'**
  String offlineBody(String duration, String amount);

  /// No description provided for @offlineCollect.
  ///
  /// In en, this message translates to:
  /// **'Collect'**
  String get offlineCollect;

  /// No description provided for @offlineCollectDouble.
  ///
  /// In en, this message translates to:
  /// **'Watch ad, collect 2x'**
  String get offlineCollectDouble;

  /// No description provided for @adPlaying.
  ///
  /// In en, this message translates to:
  /// **'Playing ad…'**
  String get adPlaying;

  /// No description provided for @notificationChannelName.
  ///
  /// In en, this message translates to:
  /// **'Coffee reminders'**
  String get notificationChannelName;

  /// No description provided for @notifOfflineTitle.
  ///
  /// In en, this message translates to:
  /// **'Your shops are overflowing!'**
  String get notifOfflineTitle;

  /// No description provided for @notifOfflineBody.
  ///
  /// In en, this message translates to:
  /// **'Offline earnings reached the limit. Come back to collect.'**
  String get notifOfflineBody;

  /// No description provided for @notifDailyTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily reward ready'**
  String get notifDailyTitle;

  /// No description provided for @notifDailyBody.
  ///
  /// In en, this message translates to:
  /// **'Your daily coffee bonus is waiting.'**
  String get notifDailyBody;

  /// No description provided for @notifRushTitle.
  ///
  /// In en, this message translates to:
  /// **'Caffeine Rush ended'**
  String get notifRushTitle;

  /// No description provided for @notifRushBody.
  ///
  /// In en, this message translates to:
  /// **'Watch another ad to keep income doubled.'**
  String get notifRushBody;

  /// No description provided for @rewardedTitle.
  ///
  /// In en, this message translates to:
  /// **'Free boosts'**
  String get rewardedTitle;

  /// No description provided for @rewardCaffeineRushTitle.
  ///
  /// In en, this message translates to:
  /// **'Caffeine Rush'**
  String get rewardCaffeineRushTitle;

  /// No description provided for @rewardCaffeineRushBody.
  ///
  /// In en, this message translates to:
  /// **'All income ×2 for 4 hours (up to 8 hours)'**
  String get rewardCaffeineRushBody;

  /// No description provided for @rewardEmergencyFundTitle.
  ///
  /// In en, this message translates to:
  /// **'Emergency Fund'**
  String get rewardEmergencyFundTitle;

  /// No description provided for @rewardEmergencyFundBody.
  ///
  /// In en, this message translates to:
  /// **'Get {amount} instantly'**
  String rewardEmergencyFundBody(String amount);

  /// No description provided for @rewardLabSpeedupTitle.
  ///
  /// In en, this message translates to:
  /// **'Lab Speed-up'**
  String get rewardLabSpeedupTitle;

  /// No description provided for @rewardLabSpeedupBody.
  ///
  /// In en, this message translates to:
  /// **'Finish the running R&D test now'**
  String get rewardLabSpeedupBody;

  /// No description provided for @watchAd.
  ///
  /// In en, this message translates to:
  /// **'Watch ad'**
  String get watchAd;

  /// No description provided for @readyIn.
  ///
  /// In en, this message translates to:
  /// **'Ready in {time}'**
  String readyIn(String time);

  /// No description provided for @unavailable.
  ///
  /// In en, this message translates to:
  /// **'Not available'**
  String get unavailable;

  /// No description provided for @boostActive.
  ///
  /// In en, this message translates to:
  /// **'×{multiplier} {time}'**
  String boostActive(String multiplier, String time);

  /// No description provided for @shopTitle.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get shopTitle;

  /// No description provided for @vipTitle.
  ///
  /// In en, this message translates to:
  /// **'Master Roaster VIP'**
  String get vipTitle;

  /// No description provided for @vipBody.
  ///
  /// In en, this message translates to:
  /// **'Permanent income ×2, 12-hour offline limit and an auto-tapping barista'**
  String get vipBody;

  /// No description provided for @starterPackTitle.
  ///
  /// In en, this message translates to:
  /// **'Espresso Starter Pack'**
  String get starterPackTitle;

  /// No description provided for @starterPackBody.
  ///
  /// In en, this message translates to:
  /// **'Permanent income ×1.25 plus 2 hours of income in cash'**
  String get starterPackBody;

  /// No description provided for @timeSkipTitle.
  ///
  /// In en, this message translates to:
  /// **'24h Time Skip'**
  String get timeSkipTitle;

  /// No description provided for @timeSkipBody.
  ///
  /// In en, this message translates to:
  /// **'Instantly receive {amount}'**
  String timeSkipBody(String amount);

  /// No description provided for @buyProduct.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get buyProduct;

  /// No description provided for @owned.
  ///
  /// In en, this message translates to:
  /// **'Owned'**
  String get owned;

  /// No description provided for @restorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get restorePurchases;

  /// No description provided for @noForcedAds.
  ///
  /// In en, this message translates to:
  /// **'No forced ads — rewarded ads are always optional.'**
  String get noForcedAds;

  /// No description provided for @dailyRewardTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily reward'**
  String get dailyRewardTitle;

  /// No description provided for @dailyRewardDay.
  ///
  /// In en, this message translates to:
  /// **'Day {day}'**
  String dailyRewardDay(int day);

  /// No description provided for @dailyRewardClaim.
  ///
  /// In en, this message translates to:
  /// **'Claim {amount}'**
  String dailyRewardClaim(String amount);

  /// No description provided for @dailyRewardNext.
  ///
  /// In en, this message translates to:
  /// **'Next reward in {time}'**
  String dailyRewardNext(String time);

  /// No description provided for @dailyRewardBean.
  ///
  /// In en, this message translates to:
  /// **'+{beans} Golden Bean'**
  String dailyRewardBean(int beans);

  /// No description provided for @tutorialTitle.
  ///
  /// In en, this message translates to:
  /// **'Barista training {step}/{total}'**
  String tutorialTitle(int step, int total);

  /// No description provided for @tutorialStepBuyFirstShop.
  ///
  /// In en, this message translates to:
  /// **'Buy a Street Cart in the Shops tab.'**
  String get tutorialStepBuyFirstShop;

  /// No description provided for @tutorialStepBuySecondShop.
  ///
  /// In en, this message translates to:
  /// **'Open your second shop: the Corner Booth.'**
  String get tutorialStepBuySecondShop;

  /// No description provided for @tutorialStepHireManager.
  ///
  /// In en, this message translates to:
  /// **'Hire a manager to triple a shop\'s income.'**
  String get tutorialStepHireManager;

  /// No description provided for @tutorialStepOpenLab.
  ///
  /// In en, this message translates to:
  /// **'Open the R&D tab to discover recipes.'**
  String get tutorialStepOpenLab;

  /// No description provided for @tutorialStepFinish.
  ///
  /// In en, this message translates to:
  /// **'You\'re ready to build your empire! Turn on reminders so you never miss a reward.'**
  String get tutorialStepFinish;

  /// No description provided for @tutorialSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get tutorialSkip;

  /// No description provided for @tutorialFinish.
  ///
  /// In en, this message translates to:
  /// **'Let\'s go!'**
  String get tutorialFinish;

  /// No description provided for @achievementsTitle.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievementsTitle;

  /// No description provided for @achievementsProgress.
  ///
  /// In en, this message translates to:
  /// **'{unlocked}/{total} unlocked · income +{percent}%'**
  String achievementsProgress(int unlocked, int total, int percent);

  /// No description provided for @achievementUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Achievement unlocked: {name}'**
  String achievementUnlocked(String name);

  /// No description provided for @achDescLifetime.
  ///
  /// In en, this message translates to:
  /// **'Earn {amount} in total'**
  String achDescLifetime(String amount);

  /// No description provided for @achDescShopLevel.
  ///
  /// In en, this message translates to:
  /// **'Reach level {level} in any shop'**
  String achDescShopLevel(int level);

  /// No description provided for @achDescRecipes.
  ///
  /// In en, this message translates to:
  /// **'Score {score}+ on {count} recipes'**
  String achDescRecipes(int score, int count);

  /// No description provided for @achDescFranchises.
  ///
  /// In en, this message translates to:
  /// **'Own {count} franchise slots'**
  String achDescFranchises(int count);

  /// No description provided for @achDescPrestige.
  ///
  /// In en, this message translates to:
  /// **'Start a new empire {count} times'**
  String achDescPrestige(int count);

  /// No description provided for @achDescTaps.
  ///
  /// In en, this message translates to:
  /// **'Tap the cup {count} times'**
  String achDescTaps(int count);

  /// No description provided for @achievement_first_dollars.
  ///
  /// In en, this message translates to:
  /// **'First Dollars'**
  String get achievement_first_dollars;

  /// No description provided for @achievement_small_business.
  ///
  /// In en, this message translates to:
  /// **'Small Business'**
  String get achievement_small_business;

  /// No description provided for @achievement_coffee_mogul.
  ///
  /// In en, this message translates to:
  /// **'Coffee Mogul'**
  String get achievement_coffee_mogul;

  /// No description provided for @achievement_bean_tycoon.
  ///
  /// In en, this message translates to:
  /// **'Bean Tycoon'**
  String get achievement_bean_tycoon;

  /// No description provided for @achievement_caffeine_empire.
  ///
  /// In en, this message translates to:
  /// **'Caffeine Empire'**
  String get achievement_caffeine_empire;

  /// No description provided for @achievement_growing_shop.
  ///
  /// In en, this message translates to:
  /// **'Growing Shop'**
  String get achievement_growing_shop;

  /// No description provided for @achievement_busy_counter.
  ///
  /// In en, this message translates to:
  /// **'Busy Counter'**
  String get achievement_busy_counter;

  /// No description provided for @achievement_centurion.
  ///
  /// In en, this message translates to:
  /// **'Centurion'**
  String get achievement_centurion;

  /// No description provided for @achievement_legendary_branch.
  ///
  /// In en, this message translates to:
  /// **'Legendary Branch'**
  String get achievement_legendary_branch;

  /// No description provided for @achievement_first_masterpiece.
  ///
  /// In en, this message translates to:
  /// **'First Masterpiece'**
  String get achievement_first_masterpiece;

  /// No description provided for @achievement_lab_regular.
  ///
  /// In en, this message translates to:
  /// **'Lab Regular'**
  String get achievement_lab_regular;

  /// No description provided for @achievement_master_brewer.
  ///
  /// In en, this message translates to:
  /// **'Master Brewer'**
  String get achievement_master_brewer;

  /// No description provided for @achievement_first_franchise.
  ///
  /// In en, this message translates to:
  /// **'First Franchise'**
  String get achievement_first_franchise;

  /// No description provided for @achievement_regional_brand.
  ///
  /// In en, this message translates to:
  /// **'Regional Brand'**
  String get achievement_regional_brand;

  /// No description provided for @achievement_global_chain.
  ///
  /// In en, this message translates to:
  /// **'Global Chain'**
  String get achievement_global_chain;

  /// No description provided for @achievement_world_domination.
  ///
  /// In en, this message translates to:
  /// **'World Domination'**
  String get achievement_world_domination;

  /// No description provided for @achievement_fresh_start.
  ///
  /// In en, this message translates to:
  /// **'Fresh Start'**
  String get achievement_fresh_start;

  /// No description provided for @achievement_serial_founder.
  ///
  /// In en, this message translates to:
  /// **'Serial Founder'**
  String get achievement_serial_founder;

  /// No description provided for @achievement_eager_barista.
  ///
  /// In en, this message translates to:
  /// **'Eager Barista'**
  String get achievement_eager_barista;

  /// No description provided for @achievement_tireless_barista.
  ///
  /// In en, this message translates to:
  /// **'Tireless Barista'**
  String get achievement_tireless_barista;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get languageSystem;

  /// No description provided for @settingsSound.
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get settingsSound;

  /// No description provided for @settingsHaptics.
  ///
  /// In en, this message translates to:
  /// **'Vibration'**
  String get settingsHaptics;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotifications;

  /// No description provided for @settingsScientific.
  ///
  /// In en, this message translates to:
  /// **'Scientific notation'**
  String get settingsScientific;

  /// No description provided for @settingsReset.
  ///
  /// In en, this message translates to:
  /// **'Reset progress'**
  String get settingsReset;

  /// No description provided for @resetConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset all progress?'**
  String get resetConfirmTitle;

  /// No description provided for @resetConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'This deletes your save, including Golden Beans and purchases. It cannot be undone.'**
  String get resetConfirmBody;

  /// No description provided for @resetConfirm.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get resetConfirm;

  /// No description provided for @languageNative_en.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageNative_en;

  /// No description provided for @languageNative_tr.
  ///
  /// In en, this message translates to:
  /// **'Türkçe'**
  String get languageNative_tr;

  /// No description provided for @languageNative_es.
  ///
  /// In en, this message translates to:
  /// **'Español'**
  String get languageNative_es;

  /// No description provided for @languageNative_pt.
  ///
  /// In en, this message translates to:
  /// **'Português (Brasil)'**
  String get languageNative_pt;

  /// No description provided for @languageNative_fr.
  ///
  /// In en, this message translates to:
  /// **'Français'**
  String get languageNative_fr;

  /// No description provided for @languageNative_de.
  ///
  /// In en, this message translates to:
  /// **'Deutsch'**
  String get languageNative_de;

  /// No description provided for @languageNative_it.
  ///
  /// In en, this message translates to:
  /// **'Italiano'**
  String get languageNative_it;

  /// No description provided for @languageNative_ru.
  ///
  /// In en, this message translates to:
  /// **'Русский'**
  String get languageNative_ru;

  /// No description provided for @languageNative_ar.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get languageNative_ar;

  /// No description provided for @languageNative_hi.
  ///
  /// In en, this message translates to:
  /// **'हिन्दी'**
  String get languageNative_hi;

  /// No description provided for @languageNative_id.
  ///
  /// In en, this message translates to:
  /// **'Bahasa Indonesia'**
  String get languageNative_id;

  /// No description provided for @languageNative_ja.
  ///
  /// In en, this message translates to:
  /// **'日本語'**
  String get languageNative_ja;

  /// No description provided for @languageNative_ko.
  ///
  /// In en, this message translates to:
  /// **'한국어'**
  String get languageNative_ko;

  /// No description provided for @languageNative_zh.
  ///
  /// In en, this message translates to:
  /// **'简体中文'**
  String get languageNative_zh;

  /// No description provided for @languageNative_vi.
  ///
  /// In en, this message translates to:
  /// **'Tiếng Việt'**
  String get languageNative_vi;

  /// No description provided for @floatingGain.
  ///
  /// In en, this message translates to:
  /// **'+{amount}'**
  String floatingGain(String amount);

  /// No description provided for @lockedStationName.
  ///
  /// In en, this message translates to:
  /// **'???'**
  String get lockedStationName;

  /// No description provided for @stationUpgradesHint.
  ///
  /// In en, this message translates to:
  /// **'Tap for manager & equipment'**
  String get stationUpgradesHint;

  /// No description provided for @spriteGalleryTitle.
  ///
  /// In en, this message translates to:
  /// **'Sprite Gallery'**
  String get spriteGalleryTitle;

  /// No description provided for @tabCafe.
  ///
  /// In en, this message translates to:
  /// **'Cafe'**
  String get tabCafe;

  /// No description provided for @tutorialStepServeCustomer.
  ///
  /// In en, this message translates to:
  /// **'Tap the customer at the counter, brew their drink, then tap them again to serve.'**
  String get tutorialStepServeCustomer;

  /// No description provided for @brewPanelTitle.
  ///
  /// In en, this message translates to:
  /// **'Brewing: {drink}'**
  String brewPanelTitle(String drink);

  /// No description provided for @serveHint.
  ///
  /// In en, this message translates to:
  /// **'Drink ready! Tap the customer to serve.'**
  String get serveHint;

  /// No description provided for @perfectServe.
  ///
  /// In en, this message translates to:
  /// **'Perfect!'**
  String get perfectServe;

  /// No description provided for @drink_espresso.
  ///
  /// In en, this message translates to:
  /// **'Espresso'**
  String get drink_espresso;

  /// No description provided for @drink_americano.
  ///
  /// In en, this message translates to:
  /// **'Americano'**
  String get drink_americano;

  /// No description provided for @drink_latte.
  ///
  /// In en, this message translates to:
  /// **'Latte'**
  String get drink_latte;

  /// No description provided for @drink_cappuccino.
  ///
  /// In en, this message translates to:
  /// **'Cappuccino'**
  String get drink_cappuccino;

  /// No description provided for @drink_mocha.
  ///
  /// In en, this message translates to:
  /// **'Mocha'**
  String get drink_mocha;

  /// No description provided for @drink_cold_brew.
  ///
  /// In en, this message translates to:
  /// **'Cold Brew'**
  String get drink_cold_brew;

  /// No description provided for @editLayout.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editLayout;

  /// No description provided for @editDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get editDone;

  /// No description provided for @editHint.
  ///
  /// In en, this message translates to:
  /// **'Tap a piece of furniture to move it.'**
  String get editHint;

  /// No description provided for @editRotate.
  ///
  /// In en, this message translates to:
  /// **'Rotate'**
  String get editRotate;

  /// No description provided for @editStore.
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get editStore;

  /// No description provided for @editPlace.
  ///
  /// In en, this message translates to:
  /// **'Place'**
  String get editPlace;

  /// No description provided for @editCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get editCancel;

  /// No description provided for @editInvalid.
  ///
  /// In en, this message translates to:
  /// **'Can\'t place here'**
  String get editInvalid;

  /// No description provided for @furnitureCatalog.
  ///
  /// In en, this message translates to:
  /// **'Furniture'**
  String get furnitureCatalog;

  /// No description provided for @furnitureOwned.
  ///
  /// In en, this message translates to:
  /// **'In storage: {count}'**
  String furnitureOwned(int count);

  /// No description provided for @furnitureAppeal.
  ///
  /// In en, this message translates to:
  /// **'+{appeal} appeal'**
  String furnitureAppeal(int appeal);

  /// No description provided for @furnitureLocked.
  ///
  /// In en, this message translates to:
  /// **'Unlocks with {shop}'**
  String furnitureLocked(String shop);

  /// No description provided for @cafeAppealSummary.
  ///
  /// In en, this message translates to:
  /// **'Appeal {appeal} · income ×{multiplier}'**
  String cafeAppealSummary(int appeal, String multiplier);

  /// No description provided for @furnitureCategorySeating.
  ///
  /// In en, this message translates to:
  /// **'Seating'**
  String get furnitureCategorySeating;

  /// No description provided for @furnitureCategoryTable.
  ///
  /// In en, this message translates to:
  /// **'Tables'**
  String get furnitureCategoryTable;

  /// No description provided for @furnitureCategoryDecor.
  ///
  /// In en, this message translates to:
  /// **'Decor'**
  String get furnitureCategoryDecor;

  /// No description provided for @furnitureCategoryLighting.
  ///
  /// In en, this message translates to:
  /// **'Lighting'**
  String get furnitureCategoryLighting;

  /// No description provided for @furnitureCategoryCounter.
  ///
  /// In en, this message translates to:
  /// **'Counter add-ons'**
  String get furnitureCategoryCounter;

  /// No description provided for @furniture_chair.
  ///
  /// In en, this message translates to:
  /// **'Wooden Chair'**
  String get furniture_chair;

  /// No description provided for @furniture_stool.
  ///
  /// In en, this message translates to:
  /// **'Stool'**
  String get furniture_stool;

  /// No description provided for @furniture_chair_white.
  ///
  /// In en, this message translates to:
  /// **'White Chair'**
  String get furniture_chair_white;

  /// No description provided for @furniture_bench.
  ///
  /// In en, this message translates to:
  /// **'Bench'**
  String get furniture_bench;

  /// No description provided for @furniture_armchair.
  ///
  /// In en, this message translates to:
  /// **'Armchair'**
  String get furniture_armchair;

  /// No description provided for @furniture_sofa.
  ///
  /// In en, this message translates to:
  /// **'Sofa'**
  String get furniture_sofa;

  /// No description provided for @furniture_table.
  ///
  /// In en, this message translates to:
  /// **'Table'**
  String get furniture_table;

  /// No description provided for @furniture_table_round.
  ///
  /// In en, this message translates to:
  /// **'Round Table'**
  String get furniture_table_round;

  /// No description provided for @furniture_table_long.
  ///
  /// In en, this message translates to:
  /// **'Long Table'**
  String get furniture_table_long;

  /// No description provided for @furniture_table_bar.
  ///
  /// In en, this message translates to:
  /// **'Bar Table'**
  String get furniture_table_bar;

  /// No description provided for @furniture_table_marble.
  ///
  /// In en, this message translates to:
  /// **'Marble Table'**
  String get furniture_table_marble;

  /// No description provided for @furniture_plant.
  ///
  /// In en, this message translates to:
  /// **'Potted Plant'**
  String get furniture_plant;

  /// No description provided for @furniture_painting.
  ///
  /// In en, this message translates to:
  /// **'Painting'**
  String get furniture_painting;

  /// No description provided for @furniture_shelf.
  ///
  /// In en, this message translates to:
  /// **'Shelf'**
  String get furniture_shelf;

  /// No description provided for @furniture_rug.
  ///
  /// In en, this message translates to:
  /// **'Rug'**
  String get furniture_rug;

  /// No description provided for @furniture_bookcase.
  ///
  /// In en, this message translates to:
  /// **'Bookcase'**
  String get furniture_bookcase;

  /// No description provided for @furniture_record_player.
  ///
  /// In en, this message translates to:
  /// **'Record Player'**
  String get furniture_record_player;

  /// No description provided for @furniture_neon_sign.
  ///
  /// In en, this message translates to:
  /// **'Neon Sign'**
  String get furniture_neon_sign;

  /// No description provided for @furniture_aquarium.
  ///
  /// In en, this message translates to:
  /// **'Aquarium'**
  String get furniture_aquarium;

  /// No description provided for @furniture_floor_lamp.
  ///
  /// In en, this message translates to:
  /// **'Floor Lamp'**
  String get furniture_floor_lamp;

  /// No description provided for @furniture_lantern.
  ///
  /// In en, this message translates to:
  /// **'Lantern'**
  String get furniture_lantern;

  /// No description provided for @furniture_light_pillar.
  ///
  /// In en, this message translates to:
  /// **'Light Pillar'**
  String get furniture_light_pillar;

  /// No description provided for @furniture_pastry_case.
  ///
  /// In en, this message translates to:
  /// **'Pastry Case'**
  String get furniture_pastry_case;

  /// No description provided for @furniture_drink_fridge.
  ///
  /// In en, this message translates to:
  /// **'Drink Fridge'**
  String get furniture_drink_fridge;

  /// No description provided for @appearanceButton.
  ///
  /// In en, this message translates to:
  /// **'Look'**
  String get appearanceButton;

  /// No description provided for @appearanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Cafe look'**
  String get appearanceTitle;

  /// No description provided for @cosmeticTypeFloor.
  ///
  /// In en, this message translates to:
  /// **'Floor'**
  String get cosmeticTypeFloor;

  /// No description provided for @cosmeticTypeWall.
  ///
  /// In en, this message translates to:
  /// **'Walls'**
  String get cosmeticTypeWall;

  /// No description provided for @cosmeticTypeSign.
  ///
  /// In en, this message translates to:
  /// **'Sign'**
  String get cosmeticTypeSign;

  /// No description provided for @cosmeticTypeLight.
  ///
  /// In en, this message translates to:
  /// **'Lighting'**
  String get cosmeticTypeLight;

  /// No description provided for @cosmeticTypeOutfit.
  ///
  /// In en, this message translates to:
  /// **'Outfits'**
  String get cosmeticTypeOutfit;

  /// No description provided for @outfitSlotPlayer.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get outfitSlotPlayer;

  /// No description provided for @outfitSlotBarista.
  ///
  /// In en, this message translates to:
  /// **'Barista {number}'**
  String outfitSlotBarista(int number);

  /// No description provided for @cosmeticLockShop.
  ///
  /// In en, this message translates to:
  /// **'Unlocks with {shop}'**
  String cosmeticLockShop(String shop);

  /// No description provided for @cosmeticLockAchievement.
  ///
  /// In en, this message translates to:
  /// **'Achievement: {name}'**
  String cosmeticLockAchievement(String name);

  /// No description provided for @cosmeticLockVip.
  ///
  /// In en, this message translates to:
  /// **'VIP only'**
  String get cosmeticLockVip;

  /// No description provided for @cosmeticUnlockBeans.
  ///
  /// In en, this message translates to:
  /// **'Unlock · {beans} beans'**
  String cosmeticUnlockBeans(int beans);

  /// No description provided for @cosmetic_floor_classic.
  ///
  /// In en, this message translates to:
  /// **'Classic Tiles'**
  String get cosmetic_floor_classic;

  /// No description provided for @cosmetic_floor_marble.
  ///
  /// In en, this message translates to:
  /// **'Marble'**
  String get cosmetic_floor_marble;

  /// No description provided for @cosmetic_floor_dark_wood.
  ///
  /// In en, this message translates to:
  /// **'Dark Wood'**
  String get cosmetic_floor_dark_wood;

  /// No description provided for @cosmetic_floor_checker.
  ///
  /// In en, this message translates to:
  /// **'Checkerboard'**
  String get cosmetic_floor_checker;

  /// No description provided for @cosmetic_floor_terracotta.
  ///
  /// In en, this message translates to:
  /// **'Terracotta'**
  String get cosmetic_floor_terracotta;

  /// No description provided for @cosmetic_floor_mint.
  ///
  /// In en, this message translates to:
  /// **'Mint Tiles'**
  String get cosmetic_floor_mint;

  /// No description provided for @cosmetic_wall_cream.
  ///
  /// In en, this message translates to:
  /// **'Cream'**
  String get cosmetic_wall_cream;

  /// No description provided for @cosmetic_wall_sage.
  ///
  /// In en, this message translates to:
  /// **'Sage'**
  String get cosmetic_wall_sage;

  /// No description provided for @cosmetic_wall_navy.
  ///
  /// In en, this message translates to:
  /// **'Navy'**
  String get cosmetic_wall_navy;

  /// No description provided for @cosmetic_wall_rose.
  ///
  /// In en, this message translates to:
  /// **'Rose'**
  String get cosmetic_wall_rose;

  /// No description provided for @cosmetic_wall_brick.
  ///
  /// In en, this message translates to:
  /// **'Brick'**
  String get cosmetic_wall_brick;

  /// No description provided for @cosmetic_wall_charcoal.
  ///
  /// In en, this message translates to:
  /// **'Charcoal'**
  String get cosmetic_wall_charcoal;

  /// No description provided for @cosmetic_sign_classic.
  ///
  /// In en, this message translates to:
  /// **'Classic Sign'**
  String get cosmetic_sign_classic;

  /// No description provided for @cosmetic_sign_round.
  ///
  /// In en, this message translates to:
  /// **'Round Sign'**
  String get cosmetic_sign_round;

  /// No description provided for @cosmetic_sign_chalk.
  ///
  /// In en, this message translates to:
  /// **'Chalkboard'**
  String get cosmetic_sign_chalk;

  /// No description provided for @cosmetic_sign_neon.
  ///
  /// In en, this message translates to:
  /// **'Neon Sign'**
  String get cosmetic_sign_neon;

  /// No description provided for @cosmetic_light_neutral.
  ///
  /// In en, this message translates to:
  /// **'Daylight'**
  String get cosmetic_light_neutral;

  /// No description provided for @cosmetic_light_warm.
  ///
  /// In en, this message translates to:
  /// **'Warm Glow'**
  String get cosmetic_light_warm;

  /// No description provided for @cosmetic_light_cool.
  ///
  /// In en, this message translates to:
  /// **'Cool Light'**
  String get cosmetic_light_cool;

  /// No description provided for @cosmetic_light_neon.
  ///
  /// In en, this message translates to:
  /// **'Neon Night'**
  String get cosmetic_light_neon;

  /// No description provided for @cosmetic_outfit_green.
  ///
  /// In en, this message translates to:
  /// **'Green Apron'**
  String get cosmetic_outfit_green;

  /// No description provided for @cosmetic_outfit_red.
  ///
  /// In en, this message translates to:
  /// **'Red Apron'**
  String get cosmetic_outfit_red;

  /// No description provided for @cosmetic_outfit_navy.
  ///
  /// In en, this message translates to:
  /// **'Navy Apron'**
  String get cosmetic_outfit_navy;

  /// No description provided for @cosmetic_outfit_pink.
  ///
  /// In en, this message translates to:
  /// **'Pink Apron'**
  String get cosmetic_outfit_pink;

  /// No description provided for @cosmetic_outfit_black.
  ///
  /// In en, this message translates to:
  /// **'Black Apron'**
  String get cosmetic_outfit_black;

  /// No description provided for @cosmetic_outfit_purple.
  ///
  /// In en, this message translates to:
  /// **'Purple Apron'**
  String get cosmetic_outfit_purple;

  /// No description provided for @cosmetic_outfit_teal.
  ///
  /// In en, this message translates to:
  /// **'Teal Apron'**
  String get cosmetic_outfit_teal;

  /// No description provided for @cosmetic_outfit_gold.
  ///
  /// In en, this message translates to:
  /// **'Golden Apron'**
  String get cosmetic_outfit_gold;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'id',
    'it',
    'ja',
    'ko',
    'pt',
    'ru',
    'tr',
    'vi',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
