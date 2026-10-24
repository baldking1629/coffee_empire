// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Coffee Empire';

  @override
  String durationDays(int value) {
    return '$value j';
  }

  @override
  String durationHours(int value) {
    return '$value h';
  }

  @override
  String durationMinutes(int value) {
    return '$value min';
  }

  @override
  String durationSeconds(int value) {
    return '$value s';
  }

  @override
  String get tabShops => 'Boutiques';

  @override
  String get tabLab => 'R&D';

  @override
  String get tabGrowth => 'Croissance';

  @override
  String get tabStore => 'Magasin';

  @override
  String incomePerSecond(String amount) {
    return '$amount/s';
  }

  @override
  String comboLabel(int count) {
    return 'Combo x$count';
  }

  @override
  String get baristaRush => 'Barista Rush !';

  @override
  String get tapToBrew => 'Touchez la tasse pour préparer';

  @override
  String cupSemanticLabel(int percent) {
    return 'Tasse de café, remplie à $percent %';
  }

  @override
  String get shop_street_cart => 'Charrette de rue';

  @override
  String get shop_corner_booth => 'Kiosque du coin';

  @override
  String get shop_boutique_cafe => 'Café boutique';

  @override
  String get shop_campus_coworking => 'Coworking du campus';

  @override
  String get shop_drive_thru => 'Drive';

  @override
  String get shop_city_roastery => 'Torréfaction urbaine';

  @override
  String get shop_airport_lounge => 'Salon d\'aéroport';

  @override
  String get shop_robotic_kiosk => 'Kiosque robotisé';

  @override
  String get shop_capsule_store => 'Boutique de capsules';

  @override
  String get shop_global_mega_roastery => 'Méga-torréfaction mondiale';

  @override
  String get buyAmountOne => 'x1';

  @override
  String get buyAmountTen => 'x10';

  @override
  String get buyAmountMax => 'MAX';

  @override
  String get managerHired => 'Gérant embauché';

  @override
  String get milestoneMaxed => 'Tous les paliers atteints';

  @override
  String get equipmentEspressoMachine => 'Machine à espresso';

  @override
  String get equipmentDiamondGrinder => 'Moulin diamant';

  @override
  String get equipmentSmartSystem => 'Système intelligent';

  @override
  String shopLevel(int level) {
    return 'Niv. $level';
  }

  @override
  String buyLevels(int count, String cost) {
    return 'Acheter x$count · $cost';
  }

  @override
  String hireManager(String cost) {
    return 'Embaucher un gérant · $cost';
  }

  @override
  String buyEquipment(String name, String cost) {
    return '$name · $cost';
  }

  @override
  String nextMilestone(int level) {
    return 'Revenus ×2 au niv. $level';
  }

  @override
  String shopLocked(String shop) {
    return 'Se débloque après l\'achat de $shop';
  }

  @override
  String equipmentAllOwned(String name) {
    return '$name · Acquis';
  }

  @override
  String get recipe_espresso_classic => 'Espresso classique';

  @override
  String get recipe_cappuccino => 'Cappuccino';

  @override
  String get recipe_cold_brew => 'Cold Brew';

  @override
  String get recipe_flat_white => 'Flat White';

  @override
  String get recipe_capsule_house_blend => 'Capsule mélange maison';

  @override
  String get recipe_ethiopian_pour_over => 'Pour-over éthiopien';

  @override
  String get recipe_nitro_mocha => 'Nitro moka';

  @override
  String get recipe_capsule_signature_reserve => 'Capsule réserve signature';

  @override
  String get flavorAcidity => 'Acidité';

  @override
  String get flavorBody => 'Corps';

  @override
  String get flavorAroma => 'Arôme';

  @override
  String get flavorCaffeine => 'Caféine';

  @override
  String hintTooLow(String attribute) {
    return '$attribute est trop bas';
  }

  @override
  String hintTooHigh(String attribute) {
    return '$attribute est trop haut';
  }

  @override
  String get hintOnTrack => 'Vous êtes sur la bonne voie !';

  @override
  String recipeBestScore(int score) {
    return 'Meilleur : $score';
  }

  @override
  String recipeLastResult(int score, String hint) {
    return 'Dernier test : $score · $hint';
  }

  @override
  String get recipeCapsuleTag => 'Capsule';

  @override
  String unlockRecipe(String cost) {
    return 'Débloquer · $cost';
  }

  @override
  String startTest(String cost) {
    return 'Tester · $cost';
  }

  @override
  String brewingRemaining(String time) {
    return 'Infusion… $time';
  }

  @override
  String get anotherBrewActive => 'Un autre test est en cours';

  @override
  String get openRecipe => 'Développer';

  @override
  String get capsuleTitle => 'Machines à capsules';

  @override
  String capsuleLocked(int score, int hype) {
    return 'Nécessite une recette notée $score+ et $hype de Notoriété';
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
    return 'Notoriété : $hype';
  }

  @override
  String labBonusValue(int percent) {
    return 'Bonus R&D : +$percent %';
  }

  @override
  String get flavorProfileTitle => 'Profil aromatique';

  @override
  String get city_new_york => 'New York';

  @override
  String get city_tokyo => 'Tokyo';

  @override
  String get city_london => 'Londres';

  @override
  String get city_istanbul => 'Istanbul';

  @override
  String get city_sao_paulo => 'São Paulo';

  @override
  String get city_paris => 'Paris';

  @override
  String get city_dubai => 'Dubaï';

  @override
  String get city_shanghai => 'Shanghai';

  @override
  String get city_mexico_city => 'Mexico';

  @override
  String get city_seoul => 'Séoul';

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
  String get city_mumbai => 'Bombay';

  @override
  String get city_cairo => 'Le Caire';

  @override
  String get city_jakarta => 'Jakarta';

  @override
  String get city_amsterdam => 'Amsterdam';

  @override
  String get city_singapore => 'Singapour';

  @override
  String get city_bangkok => 'Bangkok';

  @override
  String get city_buenos_aires => 'Buenos Aires';

  @override
  String get city_bogota => 'Bogota';

  @override
  String get city_lagos => 'Lagos';

  @override
  String get city_vienna => 'Vienne';

  @override
  String get city_lisbon => 'Lisbonne';

  @override
  String get city_reykjavik => 'Reykjavik';

  @override
  String get city_addis_ababa => 'Addis-Abeba';

  @override
  String get city_nairobi => 'Nairobi';

  @override
  String get city_hanoi => 'Hanoï';

  @override
  String get country_US => 'États-Unis';

  @override
  String get country_JP => 'Japon';

  @override
  String get country_GB => 'Royaume-Uni';

  @override
  String get country_TR => 'Turquie';

  @override
  String get country_BR => 'Brésil';

  @override
  String get country_FR => 'France';

  @override
  String get country_AE => 'Émirats arabes unis';

  @override
  String get country_CN => 'Chine';

  @override
  String get country_MX => 'Mexique';

  @override
  String get country_KR => 'Corée du Sud';

  @override
  String get country_DE => 'Allemagne';

  @override
  String get country_ES => 'Espagne';

  @override
  String get country_IT => 'Italie';

  @override
  String get country_CA => 'Canada';

  @override
  String get country_AU => 'Australie';

  @override
  String get country_IN => 'Inde';

  @override
  String get country_EG => 'Égypte';

  @override
  String get country_ID => 'Indonésie';

  @override
  String get country_NL => 'Pays-Bas';

  @override
  String get country_SG => 'Singapour';

  @override
  String get country_TH => 'Thaïlande';

  @override
  String get country_AR => 'Argentine';

  @override
  String get country_CO => 'Colombie';

  @override
  String get country_NG => 'Nigeria';

  @override
  String get country_AT => 'Autriche';

  @override
  String get country_PT => 'Portugal';

  @override
  String get country_IS => 'Islande';

  @override
  String get country_ET => 'Éthiopie';

  @override
  String get country_KE => 'Kenya';

  @override
  String get country_VN => 'Viêt Nam';

  @override
  String get region_europe => 'Europe';

  @override
  String get region_asia_pacific => 'Asie-Pacifique';

  @override
  String get region_americas => 'Amériques';

  @override
  String get region_mea => 'Moyen-Orient et Afrique';

  @override
  String get franchiseTitle => 'Franchises';

  @override
  String franchiseRoyalty(String amount) {
    return 'Redevances : $amount/s';
  }

  @override
  String franchisePerSlot(String amount) {
    return '+$amount/s par emplacement';
  }

  @override
  String franchiseRequiresHype(int hype) {
    return 'Nécessite $hype de Notoriété';
  }

  @override
  String franchiseOpen(String cost) {
    return 'Ouvrir · $cost';
  }

  @override
  String franchiseComplete(String multiplier) {
    return 'Ville complète ×$multiplier';
  }

  @override
  String get prestigeTitle => 'Grains d\'or';

  @override
  String prestigeOwned(int beans, String multiplier) {
    return '$beans Grains d\'or · revenus ×$multiplier';
  }

  @override
  String prestigeProgress(String earned, String threshold) {
    return 'Gains de la partie $earned / $threshold';
  }

  @override
  String prestigeButton(int beans) {
    return 'Vendre l\'empire · +$beans';
  }

  @override
  String get prestigeConfirmTitle => 'Fonder un nouvel empire ?';

  @override
  String prestigeConfirmBody(int beans, String multiplier) {
    return 'Vous gagnerez $beans Grains d\'or. Votre multiplicateur de revenus passera à ×$multiplier. Boutiques, gérants, équipements, machines à capsules et franchises sont réinitialisés.';
  }

  @override
  String get confirm => 'Confirmer';

  @override
  String get cancel => 'Annuler';

  @override
  String get offlineTitle => 'Bon retour !';

  @override
  String offlineBody(String duration, String amount) {
    return 'Pendant votre absence de $duration, votre empire a gagné $amount.';
  }

  @override
  String get offlineCollect => 'Récupérer';

  @override
  String get offlineCollectDouble => 'Voir une pub, récupérer x2';

  @override
  String get adPlaying => 'Publicité en cours…';

  @override
  String get notificationChannelName => 'Rappels café';

  @override
  String get notifOfflineTitle => 'Vos boutiques débordent !';

  @override
  String get notifOfflineBody =>
      'Les gains hors ligne ont atteint la limite. Revenez les récupérer.';

  @override
  String get notifDailyTitle => 'Récompense quotidienne prête';

  @override
  String get notifDailyBody => 'Votre bonus café du jour vous attend.';

  @override
  String get notifRushTitle => 'Caffeine Rush terminé';

  @override
  String get notifRushBody =>
      'Regardez une autre pub pour garder des revenus doublés.';

  @override
  String get rewardedTitle => 'Boosts gratuits';

  @override
  String get rewardCaffeineRushTitle => 'Caffeine Rush';

  @override
  String get rewardCaffeineRushBody =>
      'Tous les revenus ×2 pendant 4 heures (jusqu\'à 8 heures)';

  @override
  String get rewardEmergencyFundTitle => 'Fonds d\'urgence';

  @override
  String rewardEmergencyFundBody(String amount) {
    return 'Recevez $amount immédiatement';
  }

  @override
  String get rewardLabSpeedupTitle => 'Accélérer le labo';

  @override
  String get rewardLabSpeedupBody =>
      'Terminer tout de suite le test de R&D en cours';

  @override
  String get watchAd => 'Voir la pub';

  @override
  String readyIn(String time) {
    return 'Prêt dans $time';
  }

  @override
  String get unavailable => 'Indisponible';

  @override
  String boostActive(String multiplier, String time) {
    return '×$multiplier $time';
  }

  @override
  String get shopTitle => 'Premium';

  @override
  String get vipTitle => 'VIP Maître Torréfacteur';

  @override
  String get vipBody =>
      'Revenus ×2 permanents, limite hors ligne de 12 heures et un barista qui touche tout seul';

  @override
  String get starterPackTitle => 'Pack de départ Espresso';

  @override
  String get starterPackBody =>
      'Revenus ×1,25 permanents et 2 heures de revenus en espèces';

  @override
  String get timeSkipTitle => 'Saut de 24 h';

  @override
  String timeSkipBody(String amount) {
    return 'Recevez $amount immédiatement';
  }

  @override
  String get buyProduct => 'Acheter';

  @override
  String get owned => 'Acquis';

  @override
  String get restorePurchases => 'Restaurer les achats';

  @override
  String get noForcedAds =>
      'Aucune pub imposée : les pubs récompensées restent toujours facultatives.';

  @override
  String get dailyRewardTitle => 'Récompense quotidienne';

  @override
  String dailyRewardDay(int day) {
    return 'Jour $day';
  }

  @override
  String dailyRewardClaim(String amount) {
    return 'Récupérer $amount';
  }

  @override
  String dailyRewardNext(String time) {
    return 'Prochaine récompense dans $time';
  }

  @override
  String dailyRewardBean(int beans) {
    return '+$beans Grain d\'or';
  }

  @override
  String tutorialTitle(int step, int total) {
    return 'Formation barista $step/$total';
  }

  @override
  String get tutorialStepTapCup =>
      'Touchez la tasse pour préparer votre premier café.';

  @override
  String get tutorialStepBuyFirstShop =>
      'Achetez une Charrette de rue dans l\'onglet Boutiques.';

  @override
  String get tutorialStepBuySecondShop =>
      'Ouvrez votre deuxième boutique : le Kiosque du coin.';

  @override
  String get tutorialStepHireManager =>
      'Embauchez un gérant pour tripler les revenus d\'une boutique.';

  @override
  String get tutorialStepOpenLab =>
      'Ouvrez l\'onglet R&D pour découvrir des recettes.';

  @override
  String get tutorialStepFinish =>
      'Vous êtes prêt à bâtir votre empire ! Activez les rappels pour ne manquer aucune récompense.';

  @override
  String get tutorialSkip => 'Passer';

  @override
  String get tutorialFinish => 'C\'est parti !';

  @override
  String get achievementsTitle => 'Succès';

  @override
  String achievementsProgress(int unlocked, int total, int percent) {
    return '$unlocked/$total débloqués · revenus +$percent %';
  }

  @override
  String achievementUnlocked(String name) {
    return 'Succès débloqué : $name';
  }

  @override
  String achDescLifetime(String amount) {
    return 'Gagnez $amount au total';
  }

  @override
  String achDescShopLevel(int level) {
    return 'Atteignez le niveau $level dans une boutique';
  }

  @override
  String achDescRecipes(int score, int count) {
    return 'Obtenez $score+ sur $count recettes';
  }

  @override
  String achDescFranchises(int count) {
    return 'Possédez $count emplacements de franchise';
  }

  @override
  String achDescPrestige(int count) {
    return 'Fondez un nouvel empire $count fois';
  }

  @override
  String achDescTaps(int count) {
    return 'Touchez la tasse $count fois';
  }

  @override
  String get achievement_first_dollars => 'Premiers dollars';

  @override
  String get achievement_small_business => 'Petite entreprise';

  @override
  String get achievement_coffee_mogul => 'Magnat du café';

  @override
  String get achievement_bean_tycoon => 'Baron du grain';

  @override
  String get achievement_caffeine_empire => 'Empire de la caféine';

  @override
  String get achievement_growing_shop => 'Boutique en croissance';

  @override
  String get achievement_busy_counter => 'Comptoir animé';

  @override
  String get achievement_centurion => 'Centurion';

  @override
  String get achievement_legendary_branch => 'Succursale légendaire';

  @override
  String get achievement_first_masterpiece => 'Premier chef-d\'œuvre';

  @override
  String get achievement_lab_regular => 'Habitué du labo';

  @override
  String get achievement_master_brewer => 'Maître infuseur';

  @override
  String get achievement_first_franchise => 'Première franchise';

  @override
  String get achievement_regional_brand => 'Marque régionale';

  @override
  String get achievement_global_chain => 'Chaîne mondiale';

  @override
  String get achievement_world_domination => 'Domination mondiale';

  @override
  String get achievement_fresh_start => 'Nouveau départ';

  @override
  String get achievement_serial_founder => 'Fondateur en série';

  @override
  String get achievement_eager_barista => 'Barista motivé';

  @override
  String get achievement_tireless_barista => 'Barista infatigable';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get languageSystem => 'Système';

  @override
  String get settingsSound => 'Son';

  @override
  String get settingsHaptics => 'Vibrations';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsScientific => 'Notation scientifique';

  @override
  String get settingsReset => 'Réinitialiser la progression';

  @override
  String get resetConfirmTitle => 'Réinitialiser toute la progression ?';

  @override
  String get resetConfirmBody =>
      'Cela supprime votre sauvegarde, y compris les Grains d\'or et les achats. Action irréversible.';

  @override
  String get resetConfirm => 'Réinitialiser';

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
}
