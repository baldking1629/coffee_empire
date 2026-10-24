import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

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
    Locale('en'),
    Locale('tr'),
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
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
