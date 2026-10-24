// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Coffee Empire';

  @override
  String durationDays(int value) {
    return '$value g';
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
  String get tabShops => 'Negozi';

  @override
  String get tabLab => 'R&S';

  @override
  String get tabGrowth => 'Crescita';

  @override
  String get tabStore => 'Store';

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
  String get tapToBrew => 'Tocca la tazza per preparare';

  @override
  String cupSemanticLabel(int percent) {
    return 'Tazza di caffè, piena al $percent%';
  }

  @override
  String get shop_street_cart => 'Carretto di strada';

  @override
  String get shop_corner_booth => 'Chiosco d\'angolo';

  @override
  String get shop_boutique_cafe => 'Caffè boutique';

  @override
  String get shop_campus_coworking => 'Coworking del campus';

  @override
  String get shop_drive_thru => 'Drive-through';

  @override
  String get shop_city_roastery => 'Torrefazione cittadina';

  @override
  String get shop_airport_lounge => 'Lounge aeroportuale';

  @override
  String get shop_robotic_kiosk => 'Chiosco robotico';

  @override
  String get shop_capsule_store => 'Negozio di capsule';

  @override
  String get shop_global_mega_roastery => 'Mega torrefazione globale';

  @override
  String get buyAmountOne => 'x1';

  @override
  String get buyAmountTen => 'x10';

  @override
  String get buyAmountMax => 'MAX';

  @override
  String get managerHired => 'Manager assunto';

  @override
  String get milestoneMaxed => 'Tutti i traguardi raggiunti';

  @override
  String get equipmentEspressoMachine => 'Macchina espresso';

  @override
  String get equipmentDiamondGrinder => 'Macinino di diamante';

  @override
  String get equipmentSmartSystem => 'Sistema smart';

  @override
  String shopLevel(int level) {
    return 'Liv. $level';
  }

  @override
  String buyLevels(int count, String cost) {
    return 'Compra x$count · $cost';
  }

  @override
  String hireManager(String cost) {
    return 'Assumi manager · $cost';
  }

  @override
  String buyEquipment(String name, String cost) {
    return '$name · $cost';
  }

  @override
  String nextMilestone(int level) {
    return 'Entrate ×2 al liv. $level';
  }

  @override
  String shopLocked(String shop) {
    return 'Si sblocca dopo aver comprato $shop';
  }

  @override
  String equipmentAllOwned(String name) {
    return '$name · Acquistato';
  }

  @override
  String get recipe_espresso_classic => 'Espresso classico';

  @override
  String get recipe_cappuccino => 'Cappuccino';

  @override
  String get recipe_cold_brew => 'Cold brew';

  @override
  String get recipe_flat_white => 'Flat white';

  @override
  String get recipe_capsule_house_blend => 'Capsula miscela della casa';

  @override
  String get recipe_ethiopian_pour_over => 'Pour-over etiope';

  @override
  String get recipe_nitro_mocha => 'Nitro moka';

  @override
  String get recipe_capsule_signature_reserve => 'Capsula riserva d\'autore';

  @override
  String get flavorAcidity => 'Acidità';

  @override
  String get flavorBody => 'Corpo';

  @override
  String get flavorAroma => 'Aroma';

  @override
  String get flavorCaffeine => 'Caffeina';

  @override
  String hintTooLow(String attribute) {
    return '$attribute è troppo basso';
  }

  @override
  String hintTooHigh(String attribute) {
    return '$attribute è troppo alto';
  }

  @override
  String get hintOnTrack => 'Sei sulla strada giusta!';

  @override
  String recipeBestScore(int score) {
    return 'Migliore: $score';
  }

  @override
  String recipeLastResult(int score, String hint) {
    return 'Ultimo test: $score · $hint';
  }

  @override
  String get recipeCapsuleTag => 'Capsula';

  @override
  String unlockRecipe(String cost) {
    return 'Sblocca · $cost';
  }

  @override
  String startTest(String cost) {
    return 'Prova · $cost';
  }

  @override
  String brewingRemaining(String time) {
    return 'In preparazione… $time';
  }

  @override
  String get anotherBrewActive => 'È già in corso un altro test';

  @override
  String get openRecipe => 'Sviluppa';

  @override
  String get capsuleTitle => 'Macchine a capsule';

  @override
  String capsuleLocked(int score, int hype) {
    return 'Richiede una ricetta con $score+ e $hype di Fama del Marchio';
  }

  @override
  String capsuleOwned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count macchine',
      one: '1 macchina',
    );
    return '$_temp0';
  }

  @override
  String brandHypeValue(int hype) {
    return 'Fama del Marchio: $hype';
  }

  @override
  String labBonusValue(int percent) {
    return 'Bonus R&S: +$percent%';
  }

  @override
  String get flavorProfileTitle => 'Profilo aromatico';

  @override
  String get city_new_york => 'New York';

  @override
  String get city_tokyo => 'Tokyo';

  @override
  String get city_london => 'Londra';

  @override
  String get city_istanbul => 'Istanbul';

  @override
  String get city_sao_paulo => 'San Paolo';

  @override
  String get city_paris => 'Parigi';

  @override
  String get city_dubai => 'Dubai';

  @override
  String get city_shanghai => 'Shanghai';

  @override
  String get city_mexico_city => 'Città del Messico';

  @override
  String get city_seoul => 'Seul';

  @override
  String get city_berlin => 'Berlino';

  @override
  String get city_madrid => 'Madrid';

  @override
  String get city_rome => 'Roma';

  @override
  String get city_toronto => 'Toronto';

  @override
  String get city_sydney => 'Sydney';

  @override
  String get city_mumbai => 'Mumbai';

  @override
  String get city_cairo => 'Il Cairo';

  @override
  String get city_jakarta => 'Giacarta';

  @override
  String get city_amsterdam => 'Amsterdam';

  @override
  String get city_singapore => 'Singapore';

  @override
  String get city_bangkok => 'Bangkok';

  @override
  String get city_buenos_aires => 'Buenos Aires';

  @override
  String get city_bogota => 'Bogotà';

  @override
  String get city_lagos => 'Lagos';

  @override
  String get city_vienna => 'Vienna';

  @override
  String get city_lisbon => 'Lisbona';

  @override
  String get city_reykjavik => 'Reykjavík';

  @override
  String get city_addis_ababa => 'Addis Abeba';

  @override
  String get city_nairobi => 'Nairobi';

  @override
  String get city_hanoi => 'Hanoi';

  @override
  String get country_US => 'Stati Uniti';

  @override
  String get country_JP => 'Giappone';

  @override
  String get country_GB => 'Regno Unito';

  @override
  String get country_TR => 'Turchia';

  @override
  String get country_BR => 'Brasile';

  @override
  String get country_FR => 'Francia';

  @override
  String get country_AE => 'Emirati Arabi Uniti';

  @override
  String get country_CN => 'Cina';

  @override
  String get country_MX => 'Messico';

  @override
  String get country_KR => 'Corea del Sud';

  @override
  String get country_DE => 'Germania';

  @override
  String get country_ES => 'Spagna';

  @override
  String get country_IT => 'Italia';

  @override
  String get country_CA => 'Canada';

  @override
  String get country_AU => 'Australia';

  @override
  String get country_IN => 'India';

  @override
  String get country_EG => 'Egitto';

  @override
  String get country_ID => 'Indonesia';

  @override
  String get country_NL => 'Paesi Bassi';

  @override
  String get country_SG => 'Singapore';

  @override
  String get country_TH => 'Thailandia';

  @override
  String get country_AR => 'Argentina';

  @override
  String get country_CO => 'Colombia';

  @override
  String get country_NG => 'Nigeria';

  @override
  String get country_AT => 'Austria';

  @override
  String get country_PT => 'Portogallo';

  @override
  String get country_IS => 'Islanda';

  @override
  String get country_ET => 'Etiopia';

  @override
  String get country_KE => 'Kenya';

  @override
  String get country_VN => 'Vietnam';

  @override
  String get region_europe => 'Europa';

  @override
  String get region_asia_pacific => 'Asia-Pacifico';

  @override
  String get region_americas => 'Americhe';

  @override
  String get region_mea => 'Medio Oriente e Africa';

  @override
  String get franchiseTitle => 'Franchising';

  @override
  String franchiseRoyalty(String amount) {
    return 'Royalty: $amount/s';
  }

  @override
  String franchisePerSlot(String amount) {
    return '+$amount/s per sede';
  }

  @override
  String franchiseRequiresHype(int hype) {
    return 'Richiede $hype di Fama del Marchio';
  }

  @override
  String franchiseOpen(String cost) {
    return 'Apri · $cost';
  }

  @override
  String franchiseComplete(String multiplier) {
    return 'Città completata ×$multiplier';
  }

  @override
  String get prestigeTitle => 'Chicchi d\'oro';

  @override
  String prestigeOwned(int beans, String multiplier) {
    return '$beans Chicchi d\'oro · entrate ×$multiplier';
  }

  @override
  String prestigeProgress(String earned, String threshold) {
    return 'Guadagni della partita $earned / $threshold';
  }

  @override
  String prestigeButton(int beans) {
    return 'Vendi l\'impero · +$beans';
  }

  @override
  String get prestigeConfirmTitle => 'Fondare un nuovo impero?';

  @override
  String prestigeConfirmBody(int beans, String multiplier) {
    return 'Otterrai $beans Chicchi d\'oro. Il tuo moltiplicatore di entrate diventerà ×$multiplier. Negozi, manager, attrezzature, macchine a capsule e franchising verranno azzerati.';
  }

  @override
  String get confirm => 'Conferma';

  @override
  String get cancel => 'Annulla';

  @override
  String get offlineTitle => 'Bentornato!';

  @override
  String offlineBody(String duration, String amount) {
    return 'Mentre eri via per $duration, il tuo impero ha guadagnato $amount.';
  }

  @override
  String get offlineCollect => 'Riscuoti';

  @override
  String get offlineCollectDouble => 'Guarda un video, riscuoti x2';

  @override
  String get adPlaying => 'Pubblicità in corso…';

  @override
  String get notificationChannelName => 'Promemoria caffè';

  @override
  String get notifOfflineTitle => 'I tuoi negozi traboccano!';

  @override
  String get notifOfflineBody =>
      'I guadagni offline hanno raggiunto il limite. Torna a riscuoterli.';

  @override
  String get notifDailyTitle => 'Ricompensa giornaliera pronta';

  @override
  String get notifDailyBody => 'Il tuo bonus caffè giornaliero ti aspetta.';

  @override
  String get notifRushTitle => 'Caffeine Rush terminato';

  @override
  String get notifRushBody =>
      'Guarda un altro video per mantenere le entrate raddoppiate.';

  @override
  String get rewardedTitle => 'Potenziamenti gratuiti';

  @override
  String get rewardCaffeineRushTitle => 'Caffeine Rush';

  @override
  String get rewardCaffeineRushBody =>
      'Tutte le entrate ×2 per 4 ore (fino a 8 ore)';

  @override
  String get rewardEmergencyFundTitle => 'Fondo di emergenza';

  @override
  String rewardEmergencyFundBody(String amount) {
    return 'Ricevi subito $amount';
  }

  @override
  String get rewardLabSpeedupTitle => 'Accelera laboratorio';

  @override
  String get rewardLabSpeedupBody => 'Completa subito il test di R&S in corso';

  @override
  String get watchAd => 'Guarda video';

  @override
  String readyIn(String time) {
    return 'Pronto tra $time';
  }

  @override
  String get unavailable => 'Non disponibile';

  @override
  String boostActive(String multiplier, String time) {
    return '×$multiplier $time';
  }

  @override
  String get shopTitle => 'Premium';

  @override
  String get vipTitle => 'VIP Mastro Torrefattore';

  @override
  String get vipBody =>
      'Entrate ×2 permanenti, limite offline di 12 ore e un barista che tocca da solo';

  @override
  String get starterPackTitle => 'Pacchetto iniziale Espresso';

  @override
  String get starterPackBody =>
      'Entrate ×1,25 permanenti più 2 ore di entrate in contanti';

  @override
  String get timeSkipTitle => 'Salto di 24 ore';

  @override
  String timeSkipBody(String amount) {
    return 'Ricevi subito $amount';
  }

  @override
  String get buyProduct => 'Acquista';

  @override
  String get owned => 'Acquistato';

  @override
  String get restorePurchases => 'Ripristina acquisti';

  @override
  String get noForcedAds =>
      'Nessuna pubblicità forzata: i video premio sono sempre facoltativi.';

  @override
  String get dailyRewardTitle => 'Ricompensa giornaliera';

  @override
  String dailyRewardDay(int day) {
    return 'Giorno $day';
  }

  @override
  String dailyRewardClaim(String amount) {
    return 'Riscuoti $amount';
  }

  @override
  String dailyRewardNext(String time) {
    return 'Prossima ricompensa tra $time';
  }

  @override
  String dailyRewardBean(int beans) {
    return '+$beans Chicco d\'oro';
  }

  @override
  String tutorialTitle(int step, int total) {
    return 'Addestramento barista $step/$total';
  }

  @override
  String get tutorialStepTapCup =>
      'Tocca la tazza per preparare il tuo primo caffè.';

  @override
  String get tutorialStepBuyFirstShop =>
      'Compra un Carretto di strada nella scheda Negozi.';

  @override
  String get tutorialStepBuySecondShop =>
      'Apri il tuo secondo negozio: il Chiosco d\'angolo.';

  @override
  String get tutorialStepHireManager =>
      'Assumi un manager per triplicare le entrate di un negozio.';

  @override
  String get tutorialStepOpenLab =>
      'Apri la scheda R&S per scoprire le ricette.';

  @override
  String get tutorialStepFinish =>
      'Sei pronto a costruire il tuo impero! Attiva i promemoria per non perdere nessuna ricompensa.';

  @override
  String get tutorialSkip => 'Salta';

  @override
  String get tutorialFinish => 'Andiamo!';

  @override
  String get achievementsTitle => 'Obiettivi';

  @override
  String achievementsProgress(int unlocked, int total, int percent) {
    return '$unlocked/$total sbloccati · entrate +$percent%';
  }

  @override
  String achievementUnlocked(String name) {
    return 'Obiettivo sbloccato: $name';
  }

  @override
  String achDescLifetime(String amount) {
    return 'Guadagna $amount in totale';
  }

  @override
  String achDescShopLevel(int level) {
    return 'Raggiungi il livello $level in un negozio';
  }

  @override
  String achDescRecipes(int score, int count) {
    return 'Ottieni $score+ in $count ricette';
  }

  @override
  String achDescFranchises(int count) {
    return 'Possiedi $count sedi in franchising';
  }

  @override
  String achDescPrestige(int count) {
    return 'Fonda un nuovo impero $count volte';
  }

  @override
  String achDescTaps(int count) {
    return 'Tocca la tazza $count volte';
  }

  @override
  String get achievement_first_dollars => 'Primi dollari';

  @override
  String get achievement_small_business => 'Piccola impresa';

  @override
  String get achievement_coffee_mogul => 'Magnate del caffè';

  @override
  String get achievement_bean_tycoon => 'Re dei chicchi';

  @override
  String get achievement_caffeine_empire => 'Impero della caffeina';

  @override
  String get achievement_growing_shop => 'Negozio in crescita';

  @override
  String get achievement_busy_counter => 'Bancone affollato';

  @override
  String get achievement_centurion => 'Centurione';

  @override
  String get achievement_legendary_branch => 'Filiale leggendaria';

  @override
  String get achievement_first_masterpiece => 'Primo capolavoro';

  @override
  String get achievement_lab_regular => 'Habitué del laboratorio';

  @override
  String get achievement_master_brewer => 'Maestro del caffè';

  @override
  String get achievement_first_franchise => 'Primo franchising';

  @override
  String get achievement_regional_brand => 'Marchio regionale';

  @override
  String get achievement_global_chain => 'Catena globale';

  @override
  String get achievement_world_domination => 'Dominio mondiale';

  @override
  String get achievement_fresh_start => 'Nuovo inizio';

  @override
  String get achievement_serial_founder => 'Fondatore seriale';

  @override
  String get achievement_eager_barista => 'Barista entusiasta';

  @override
  String get achievement_tireless_barista => 'Barista instancabile';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get settingsLanguage => 'Lingua';

  @override
  String get languageSystem => 'Sistema';

  @override
  String get settingsSound => 'Audio';

  @override
  String get settingsHaptics => 'Vibrazione';

  @override
  String get settingsNotifications => 'Notifiche';

  @override
  String get settingsScientific => 'Notazione scientifica';

  @override
  String get settingsReset => 'Azzera progressi';

  @override
  String get resetConfirmTitle => 'Azzerare tutti i progressi?';

  @override
  String get resetConfirmBody =>
      'Verrà eliminato il salvataggio, inclusi Chicchi d\'oro e acquisti. L\'operazione è irreversibile.';

  @override
  String get resetConfirm => 'Azzera';

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
