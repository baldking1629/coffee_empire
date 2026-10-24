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

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

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
