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

  @override
  String get recipe_espresso_classic => 'Klasik Espresso';

  @override
  String get recipe_cappuccino => 'Kapuçino';

  @override
  String get recipe_cold_brew => 'Soğuk Demleme';

  @override
  String get recipe_flat_white => 'Flat White';

  @override
  String get recipe_capsule_house_blend => 'Ev Harmanı Kapsül';

  @override
  String get recipe_ethiopian_pour_over => 'Etiyopya Pour-Over';

  @override
  String get recipe_nitro_mocha => 'Nitro Mocha';

  @override
  String get recipe_capsule_signature_reserve => 'İmza Rezerv Kapsül';

  @override
  String get flavorAcidity => 'Asidite';

  @override
  String get flavorBody => 'Gövde';

  @override
  String get flavorAroma => 'Aroma';

  @override
  String get flavorCaffeine => 'Kafein';

  @override
  String hintTooLow(String attribute) {
    return '$attribute çok düşük';
  }

  @override
  String hintTooHigh(String attribute) {
    return '$attribute çok yüksek';
  }

  @override
  String get hintOnTrack => 'Doğru yoldasın!';

  @override
  String recipeBestScore(int score) {
    return 'En iyi: $score';
  }

  @override
  String recipeLastResult(int score, String hint) {
    return 'Son test: $score · $hint';
  }

  @override
  String get recipeCapsuleTag => 'Kapsül';

  @override
  String unlockRecipe(String cost) {
    return 'Aç · $cost';
  }

  @override
  String startTest(String cost) {
    return 'Test Et · $cost';
  }

  @override
  String brewingRemaining(String time) {
    return 'Demleniyor… $time';
  }

  @override
  String get anotherBrewActive => 'Başka bir test sürüyor';

  @override
  String get openRecipe => 'Geliştir';

  @override
  String get capsuleTitle => 'Kapsül Makineleri';

  @override
  String capsuleLocked(int score, int hype) {
    return '$score+ puanlı bir reçete ve $hype Marka Değeri gerekir';
  }

  @override
  String capsuleOwned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count makine',
    );
    return '$_temp0';
  }

  @override
  String brandHypeValue(int hype) {
    return 'Marka Değeri: $hype';
  }

  @override
  String labBonusValue(int percent) {
    return 'Ar-Ge bonusu: +%$percent';
  }

  @override
  String get flavorProfileTitle => 'Tat profili';

  @override
  String get city_new_york => 'New York';

  @override
  String get city_tokyo => 'Tokyo';

  @override
  String get city_london => 'Londra';

  @override
  String get city_istanbul => 'İstanbul';

  @override
  String get city_sao_paulo => 'São Paulo';

  @override
  String get city_paris => 'Paris';

  @override
  String get city_dubai => 'Dubai';

  @override
  String get city_shanghai => 'Şanghay';

  @override
  String get city_mexico_city => 'Meksiko';

  @override
  String get city_seoul => 'Seul';

  @override
  String get city_berlin => 'Berlin';

  @override
  String get city_madrid => 'Madrid';

  @override
  String get city_rome => 'Roma';

  @override
  String get city_toronto => 'Toronto';

  @override
  String get city_sydney => 'Sidney';

  @override
  String get city_mumbai => 'Mumbai';

  @override
  String get city_cairo => 'Kahire';

  @override
  String get city_jakarta => 'Cakarta';

  @override
  String get city_amsterdam => 'Amsterdam';

  @override
  String get city_singapore => 'Singapur';

  @override
  String get city_bangkok => 'Bangkok';

  @override
  String get city_buenos_aires => 'Buenos Aires';

  @override
  String get city_bogota => 'Bogota';

  @override
  String get city_lagos => 'Lagos';

  @override
  String get city_vienna => 'Viyana';

  @override
  String get city_lisbon => 'Lizbon';

  @override
  String get city_reykjavik => 'Reykjavik';

  @override
  String get city_addis_ababa => 'Addis Ababa';

  @override
  String get city_nairobi => 'Nairobi';

  @override
  String get city_hanoi => 'Hanoi';

  @override
  String get country_US => 'Amerika Birleşik Devletleri';

  @override
  String get country_JP => 'Japonya';

  @override
  String get country_GB => 'Birleşik Krallık';

  @override
  String get country_TR => 'Türkiye';

  @override
  String get country_BR => 'Brezilya';

  @override
  String get country_FR => 'Fransa';

  @override
  String get country_AE => 'Birleşik Arap Emirlikleri';

  @override
  String get country_CN => 'Çin';

  @override
  String get country_MX => 'Meksika';

  @override
  String get country_KR => 'Güney Kore';

  @override
  String get country_DE => 'Almanya';

  @override
  String get country_ES => 'İspanya';

  @override
  String get country_IT => 'İtalya';

  @override
  String get country_CA => 'Kanada';

  @override
  String get country_AU => 'Avustralya';

  @override
  String get country_IN => 'Hindistan';

  @override
  String get country_EG => 'Mısır';

  @override
  String get country_ID => 'Endonezya';

  @override
  String get country_NL => 'Hollanda';

  @override
  String get country_SG => 'Singapur';

  @override
  String get country_TH => 'Tayland';

  @override
  String get country_AR => 'Arjantin';

  @override
  String get country_CO => 'Kolombiya';

  @override
  String get country_NG => 'Nijerya';

  @override
  String get country_AT => 'Avusturya';

  @override
  String get country_PT => 'Portekiz';

  @override
  String get country_IS => 'İzlanda';

  @override
  String get country_ET => 'Etiyopya';

  @override
  String get country_KE => 'Kenya';

  @override
  String get country_VN => 'Vietnam';

  @override
  String get region_europe => 'Avrupa';

  @override
  String get region_asia_pacific => 'Asya-Pasifik';

  @override
  String get region_americas => 'Amerika';

  @override
  String get region_mea => 'Orta Doğu ve Afrika';

  @override
  String get franchiseTitle => 'Franchise\'lar';

  @override
  String franchiseRoyalty(String amount) {
    return 'Telif geliri: $amount/sn';
  }

  @override
  String franchisePerSlot(String amount) {
    return 'Yuva başı +$amount/sn';
  }

  @override
  String franchiseRequiresHype(int hype) {
    return '$hype Marka Değeri gerekir';
  }

  @override
  String franchiseOpen(String cost) {
    return 'Aç · $cost';
  }

  @override
  String franchiseComplete(String multiplier) {
    return 'Şehir tamamlandı ×$multiplier';
  }

  @override
  String get prestigeTitle => 'Altın Çekirdekler';

  @override
  String prestigeOwned(int beans, String multiplier) {
    return '$beans Altın Çekirdek · gelir ×$multiplier';
  }

  @override
  String prestigeProgress(String earned, String threshold) {
    return 'Bu turdaki kazanç $earned / $threshold';
  }

  @override
  String prestigeButton(int beans) {
    return 'İmparatorluğu sat · +$beans';
  }

  @override
  String get prestigeConfirmTitle => 'Yeni bir imparatorluk kurulsun mu?';

  @override
  String prestigeConfirmBody(int beans, String multiplier) {
    return '$beans Altın Çekirdek kazanacaksın. Gelir çarpanın ×$multiplier olacak. Dükkanlar, yöneticiler, ekipmanlar, kapsül makineleri ve franchise\'lar sıfırlanır.';
  }

  @override
  String get confirm => 'Onayla';

  @override
  String get cancel => 'Vazgeç';

  @override
  String get offlineTitle => 'Tekrar hoş geldin!';

  @override
  String offlineBody(String duration, String amount) {
    return 'Sen $duration yokken imparatorluğun $amount kazandı.';
  }

  @override
  String get offlineCollect => 'Al';

  @override
  String get offlineCollectDouble => 'Reklam İzle, 2x Al';

  @override
  String get adPlaying => 'Reklam oynatılıyor…';

  @override
  String get notificationChannelName => 'Kahve hatırlatmaları';

  @override
  String get notifOfflineTitle => 'Dükkanların taşıyor!';

  @override
  String get notifOfflineBody =>
      'Offline kazanç sınıra ulaştı. Toplamak için geri dön.';

  @override
  String get notifDailyTitle => 'Günlük ödül hazır';

  @override
  String get notifDailyBody => 'Günlük kahve bonusun seni bekliyor.';

  @override
  String get notifRushTitle => 'Caffeine Rush bitti';

  @override
  String get notifRushBody =>
      'Geliri ikiye katlamaya devam etmek için yeni bir reklam izle.';

  @override
  String get rewardedTitle => 'Ücretsiz destekler';

  @override
  String get rewardCaffeineRushTitle => 'Caffeine Rush';

  @override
  String get rewardCaffeineRushBody =>
      'Tüm gelir 4 saat boyunca ×2 (en fazla 8 saat)';

  @override
  String get rewardEmergencyFundTitle => 'Acil Durum Fonu';

  @override
  String rewardEmergencyFundBody(String amount) {
    return 'Anında $amount al';
  }

  @override
  String get rewardLabSpeedupTitle => 'Ar-Ge Hızlandırma';

  @override
  String get rewardLabSpeedupBody => 'Süren Ar-Ge testini hemen bitir';

  @override
  String get watchAd => 'Reklam izle';

  @override
  String readyIn(String time) {
    return '$time sonra hazır';
  }

  @override
  String get unavailable => 'Kullanılamaz';

  @override
  String boostActive(String multiplier, String time) {
    return '×$multiplier $time';
  }

  @override
  String get shopTitle => 'Premium';

  @override
  String get vipTitle => 'Usta Kavurucu VIP';

  @override
  String get vipBody =>
      'Kalıcı gelir ×2, 12 saatlik offline sınırı ve otomatik dokunan barista';

  @override
  String get starterPackTitle => 'Espresso Başlangıç Paketi';

  @override
  String get starterPackBody =>
      'Kalıcı gelir ×1,25 ve 2 saatlik gelir kadar nakit';

  @override
  String get timeSkipTitle => '24 Saat İleri Sar';

  @override
  String timeSkipBody(String amount) {
    return 'Anında $amount al';
  }

  @override
  String get buyProduct => 'Satın al';

  @override
  String get owned => 'Sahipsin';

  @override
  String get restorePurchases => 'Satın alımları geri yükle';

  @override
  String get noForcedAds =>
      'Zorunlu reklam yok — ödüllü reklamlar her zaman isteğe bağlı.';

  @override
  String get dailyRewardTitle => 'Günlük ödül';

  @override
  String dailyRewardDay(int day) {
    return 'Gün $day';
  }

  @override
  String dailyRewardClaim(String amount) {
    return '$amount al';
  }

  @override
  String dailyRewardNext(String time) {
    return 'Sonraki ödül $time sonra';
  }

  @override
  String dailyRewardBean(int beans) {
    return '+$beans Altın Çekirdek';
  }

  @override
  String tutorialTitle(int step, int total) {
    return 'Barista eğitimi $step/$total';
  }

  @override
  String get tutorialStepBuyFirstShop =>
      'Dükkanlar sekmesinden bir Sokak Arabası al.';

  @override
  String get tutorialStepBuySecondShop => 'İkinci dükkanını aç: Köşe Büfesi.';

  @override
  String get tutorialStepHireManager =>
      'Bir dükkanın gelirini üçe katlamak için yönetici kirala.';

  @override
  String get tutorialStepOpenLab =>
      'Reçeteleri keşfetmek için Ar-Ge sekmesini aç.';

  @override
  String get tutorialStepFinish =>
      'İmparatorluğunu kurmaya hazırsın! Hiçbir ödülü kaçırmamak için hatırlatmaları aç.';

  @override
  String get tutorialSkip => 'Atla';

  @override
  String get tutorialFinish => 'Başlayalım!';

  @override
  String get achievementsTitle => 'Başarımlar';

  @override
  String achievementsProgress(int unlocked, int total, int percent) {
    return '$unlocked/$total açıldı · gelir +%$percent';
  }

  @override
  String achievementUnlocked(String name) {
    return 'Başarım açıldı: $name';
  }

  @override
  String achDescLifetime(String amount) {
    return 'Toplam $amount kazan';
  }

  @override
  String achDescShopLevel(int level) {
    return 'Herhangi bir dükkanda $level. seviyeye ulaş';
  }

  @override
  String achDescRecipes(int score, int count) {
    return '$count reçetede $score+ puan al';
  }

  @override
  String achDescFranchises(int count) {
    return '$count franchise yuvasına sahip ol';
  }

  @override
  String achDescPrestige(int count) {
    return '$count kez yeni imparatorluk kur';
  }

  @override
  String achDescTaps(int count) {
    return 'Fincana $count kez dokun';
  }

  @override
  String get achievement_first_dollars => 'İlk Dolarlar';

  @override
  String get achievement_small_business => 'Küçük İşletme';

  @override
  String get achievement_coffee_mogul => 'Kahve Patronu';

  @override
  String get achievement_bean_tycoon => 'Çekirdek Kralı';

  @override
  String get achievement_caffeine_empire => 'Kafein İmparatorluğu';

  @override
  String get achievement_growing_shop => 'Büyüyen Dükkan';

  @override
  String get achievement_busy_counter => 'Yoğun Tezgah';

  @override
  String get achievement_centurion => 'Yüzbaşı';

  @override
  String get achievement_legendary_branch => 'Efsanevi Şube';

  @override
  String get achievement_first_masterpiece => 'İlk Başyapıt';

  @override
  String get achievement_lab_regular => 'Laboratuvar Müdavimi';

  @override
  String get achievement_master_brewer => 'Usta Demlemeci';

  @override
  String get achievement_first_franchise => 'İlk Franchise';

  @override
  String get achievement_regional_brand => 'Bölgesel Marka';

  @override
  String get achievement_global_chain => 'Küresel Zincir';

  @override
  String get achievement_world_domination => 'Dünya Hakimiyeti';

  @override
  String get achievement_fresh_start => 'Yeni Başlangıç';

  @override
  String get achievement_serial_founder => 'Seri Girişimci';

  @override
  String get achievement_eager_barista => 'Hevesli Barista';

  @override
  String get achievement_tireless_barista => 'Yorulmaz Barista';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get settingsLanguage => 'Dil';

  @override
  String get languageSystem => 'Sistem';

  @override
  String get settingsSound => 'Ses';

  @override
  String get settingsHaptics => 'Titreşim';

  @override
  String get settingsNotifications => 'Bildirimler';

  @override
  String get settingsScientific => 'Bilimsel gösterim';

  @override
  String get settingsReset => 'İlerlemeyi sıfırla';

  @override
  String get resetConfirmTitle => 'Tüm ilerleme sıfırlansın mı?';

  @override
  String get resetConfirmBody =>
      'Bu işlem Altın Çekirdekler ve satın alımlar dahil kaydını siler. Geri alınamaz.';

  @override
  String get resetConfirm => 'Sıfırla';

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
  String get stationUpgradesHint => 'Yönetici ve ekipman için dokun';

  @override
  String get spriteGalleryTitle => 'Sprite Galerisi';

  @override
  String get tabCafe => 'Kafe';

  @override
  String get tutorialStepServeCustomer =>
      'Tezgahtaki müşteriye dokun, içeceğini demle, sonra servis için tekrar dokun.';

  @override
  String brewPanelTitle(String drink) {
    return 'Hazırlanıyor: $drink';
  }

  @override
  String get serveHint => 'İçecek hazır! Servis için müşteriye dokun.';

  @override
  String get perfectServe => 'Mükemmel!';

  @override
  String get drink_espresso => 'Espresso';

  @override
  String get drink_americano => 'Americano';

  @override
  String get drink_latte => 'Latte';

  @override
  String get drink_cappuccino => 'Kapuçino';

  @override
  String get drink_mocha => 'Mocha';

  @override
  String get drink_cold_brew => 'Soğuk Demleme';
}
