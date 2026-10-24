// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Coffee Empire';

  @override
  String durationDays(int value) {
    return '$value h';
  }

  @override
  String durationHours(int value) {
    return '$value j';
  }

  @override
  String durationMinutes(int value) {
    return '$value m';
  }

  @override
  String durationSeconds(int value) {
    return '$value d';
  }

  @override
  String get tabShops => 'Toko';

  @override
  String get tabLab => 'Litbang';

  @override
  String get tabGrowth => 'Pertumbuhan';

  @override
  String get tabStore => 'Toko Premium';

  @override
  String incomePerSecond(String amount) {
    return '$amount/dtk';
  }

  @override
  String comboLabel(int count) {
    return 'Kombo x$count';
  }

  @override
  String get baristaRush => 'Barista Rush!';

  @override
  String get tapToBrew => 'Ketuk cangkir untuk menyeduh';

  @override
  String cupSemanticLabel(int percent) {
    return 'Cangkir kopi, terisi $percent%';
  }

  @override
  String get shop_street_cart => 'Gerobak Jalanan';

  @override
  String get shop_corner_booth => 'Kios Pojok';

  @override
  String get shop_boutique_cafe => 'Kafe Butik';

  @override
  String get shop_campus_coworking => 'Coworking Kampus';

  @override
  String get shop_drive_thru => 'Drive-Thru';

  @override
  String get shop_city_roastery => 'Roastery Kota';

  @override
  String get shop_airport_lounge => 'Lounge Bandara';

  @override
  String get shop_robotic_kiosk => 'Kios Robotik';

  @override
  String get shop_capsule_store => 'Toko Kapsul';

  @override
  String get shop_global_mega_roastery => 'Roastery Mega Global';

  @override
  String get buyAmountOne => 'x1';

  @override
  String get buyAmountTen => 'x10';

  @override
  String get buyAmountMax => 'MAKS';

  @override
  String get managerHired => 'Manajer direkrut';

  @override
  String get milestoneMaxed => 'Semua pencapaian tercapai';

  @override
  String get equipmentEspressoMachine => 'Mesin espreso';

  @override
  String get equipmentDiamondGrinder => 'Penggiling berlian';

  @override
  String get equipmentSmartSystem => 'Sistem pintar';

  @override
  String shopLevel(int level) {
    return 'Lv. $level';
  }

  @override
  String buyLevels(int count, String cost) {
    return 'Beli x$count · $cost';
  }

  @override
  String hireManager(String cost) {
    return 'Rekrut manajer · $cost';
  }

  @override
  String buyEquipment(String name, String cost) {
    return '$name · $cost';
  }

  @override
  String nextMilestone(int level) {
    return 'Pendapatan ×2 di Lv. $level';
  }

  @override
  String shopLocked(String shop) {
    return 'Terbuka setelah membeli $shop';
  }

  @override
  String equipmentAllOwned(String name) {
    return '$name · Dimiliki';
  }

  @override
  String get recipe_espresso_classic => 'Espreso Klasik';

  @override
  String get recipe_cappuccino => 'Cappuccino';

  @override
  String get recipe_cold_brew => 'Cold Brew';

  @override
  String get recipe_flat_white => 'Flat White';

  @override
  String get recipe_capsule_house_blend => 'Kapsul Racikan Rumah';

  @override
  String get recipe_ethiopian_pour_over => 'Pour-Over Etiopia';

  @override
  String get recipe_nitro_mocha => 'Nitro Moka';

  @override
  String get recipe_capsule_signature_reserve => 'Kapsul Signature Reserve';

  @override
  String get flavorAcidity => 'Keasaman';

  @override
  String get flavorBody => 'Kekentalan';

  @override
  String get flavorAroma => 'Aroma';

  @override
  String get flavorCaffeine => 'Kafein';

  @override
  String hintTooLow(String attribute) {
    return '$attribute terlalu rendah';
  }

  @override
  String hintTooHigh(String attribute) {
    return '$attribute terlalu tinggi';
  }

  @override
  String get hintOnTrack => 'Kamu sudah di jalur yang benar!';

  @override
  String recipeBestScore(int score) {
    return 'Terbaik: $score';
  }

  @override
  String recipeLastResult(int score, String hint) {
    return 'Tes terakhir: $score · $hint';
  }

  @override
  String get recipeCapsuleTag => 'Kapsul';

  @override
  String unlockRecipe(String cost) {
    return 'Buka · $cost';
  }

  @override
  String startTest(String cost) {
    return 'Uji · $cost';
  }

  @override
  String brewingRemaining(String time) {
    return 'Menyeduh… $time';
  }

  @override
  String get anotherBrewActive => 'Tes lain sedang berjalan';

  @override
  String get openRecipe => 'Kembangkan';

  @override
  String get capsuleTitle => 'Mesin Kapsul';

  @override
  String capsuleLocked(int score, int hype) {
    return 'Butuh resep dengan skor $score+ dan $hype Popularitas Merek';
  }

  @override
  String capsuleOwned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mesin',
    );
    return '$_temp0';
  }

  @override
  String brandHypeValue(int hype) {
    return 'Popularitas Merek: $hype';
  }

  @override
  String labBonusValue(int percent) {
    return 'Bonus litbang: +$percent%';
  }

  @override
  String get flavorProfileTitle => 'Profil rasa';

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
  String get city_mexico_city => 'Kota Meksiko';

  @override
  String get city_seoul => 'Seoul';

  @override
  String get city_berlin => 'Berlin';

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
  String get city_cairo => 'Kairo';

  @override
  String get city_jakarta => 'Jakarta';

  @override
  String get city_amsterdam => 'Amsterdam';

  @override
  String get city_singapore => 'Singapura';

  @override
  String get city_bangkok => 'Bangkok';

  @override
  String get city_buenos_aires => 'Buenos Aires';

  @override
  String get city_bogota => 'Bogotá';

  @override
  String get city_lagos => 'Lagos';

  @override
  String get city_vienna => 'Wina';

  @override
  String get city_lisbon => 'Lisboa';

  @override
  String get city_reykjavik => 'Reykjavík';

  @override
  String get city_addis_ababa => 'Addis Ababa';

  @override
  String get city_nairobi => 'Nairobi';

  @override
  String get city_hanoi => 'Hanoi';

  @override
  String get country_US => 'Amerika Serikat';

  @override
  String get country_JP => 'Jepang';

  @override
  String get country_GB => 'Britania Raya';

  @override
  String get country_TR => 'Turki';

  @override
  String get country_BR => 'Brasil';

  @override
  String get country_FR => 'Prancis';

  @override
  String get country_AE => 'Uni Emirat Arab';

  @override
  String get country_CN => 'Tiongkok';

  @override
  String get country_MX => 'Meksiko';

  @override
  String get country_KR => 'Korea Selatan';

  @override
  String get country_DE => 'Jerman';

  @override
  String get country_ES => 'Spanyol';

  @override
  String get country_IT => 'Italia';

  @override
  String get country_CA => 'Kanada';

  @override
  String get country_AU => 'Australia';

  @override
  String get country_IN => 'India';

  @override
  String get country_EG => 'Mesir';

  @override
  String get country_ID => 'Indonesia';

  @override
  String get country_NL => 'Belanda';

  @override
  String get country_SG => 'Singapura';

  @override
  String get country_TH => 'Thailand';

  @override
  String get country_AR => 'Argentina';

  @override
  String get country_CO => 'Kolombia';

  @override
  String get country_NG => 'Nigeria';

  @override
  String get country_AT => 'Austria';

  @override
  String get country_PT => 'Portugal';

  @override
  String get country_IS => 'Islandia';

  @override
  String get country_ET => 'Etiopia';

  @override
  String get country_KE => 'Kenya';

  @override
  String get country_VN => 'Vietnam';

  @override
  String get region_europe => 'Eropa';

  @override
  String get region_asia_pacific => 'Asia-Pasifik';

  @override
  String get region_americas => 'Amerika';

  @override
  String get region_mea => 'Timur Tengah & Afrika';

  @override
  String get franchiseTitle => 'Waralaba';

  @override
  String franchiseRoyalty(String amount) {
    return 'Royalti: $amount/dtk';
  }

  @override
  String franchisePerSlot(String amount) {
    return '+$amount/dtk per gerai';
  }

  @override
  String franchiseRequiresHype(int hype) {
    return 'Butuh $hype Popularitas Merek';
  }

  @override
  String franchiseOpen(String cost) {
    return 'Buka · $cost';
  }

  @override
  String franchiseComplete(String multiplier) {
    return 'Kota lengkap ×$multiplier';
  }

  @override
  String get prestigeTitle => 'Biji Emas';

  @override
  String prestigeOwned(int beans, String multiplier) {
    return '$beans Biji Emas · pendapatan ×$multiplier';
  }

  @override
  String prestigeProgress(String earned, String threshold) {
    return 'Pendapatan putaran $earned / $threshold';
  }

  @override
  String prestigeButton(int beans) {
    return 'Jual kerajaan · +$beans';
  }

  @override
  String get prestigeConfirmTitle => 'Mulai kerajaan baru?';

  @override
  String prestigeConfirmBody(int beans, String multiplier) {
    return 'Kamu akan mendapat $beans Biji Emas. Pengali pendapatanmu menjadi ×$multiplier. Toko, manajer, peralatan, mesin kapsul, dan waralaba akan direset.';
  }

  @override
  String get confirm => 'Konfirmasi';

  @override
  String get cancel => 'Batal';

  @override
  String get offlineTitle => 'Selamat datang kembali!';

  @override
  String offlineBody(String duration, String amount) {
    return 'Selama kamu pergi $duration, kerajaanmu menghasilkan $amount.';
  }

  @override
  String get offlineCollect => 'Ambil';

  @override
  String get offlineCollectDouble => 'Tonton iklan, ambil 2x';

  @override
  String get adPlaying => 'Memutar iklan…';

  @override
  String get notificationChannelName => 'Pengingat kopi';

  @override
  String get notifOfflineTitle => 'Tokomu meluap!';

  @override
  String get notifOfflineBody =>
      'Pendapatan offline mencapai batas. Kembali untuk mengambilnya.';

  @override
  String get notifDailyTitle => 'Hadiah harian siap';

  @override
  String get notifDailyBody => 'Bonus kopi harianmu sudah menunggu.';

  @override
  String get notifRushTitle => 'Caffeine Rush berakhir';

  @override
  String get notifRushBody =>
      'Tonton iklan lagi agar pendapatan tetap berlipat ganda.';

  @override
  String get rewardedTitle => 'Boost gratis';

  @override
  String get rewardCaffeineRushTitle => 'Caffeine Rush';

  @override
  String get rewardCaffeineRushBody =>
      'Semua pendapatan ×2 selama 4 jam (hingga 8 jam)';

  @override
  String get rewardEmergencyFundTitle => 'Dana Darurat';

  @override
  String rewardEmergencyFundBody(String amount) {
    return 'Dapatkan $amount langsung';
  }

  @override
  String get rewardLabSpeedupTitle => 'Percepat Lab';

  @override
  String get rewardLabSpeedupBody =>
      'Selesaikan tes litbang yang berjalan sekarang';

  @override
  String get watchAd => 'Tonton iklan';

  @override
  String readyIn(String time) {
    return 'Siap dalam $time';
  }

  @override
  String get unavailable => 'Tidak tersedia';

  @override
  String boostActive(String multiplier, String time) {
    return '×$multiplier $time';
  }

  @override
  String get shopTitle => 'Premium';

  @override
  String get vipTitle => 'VIP Master Roaster';

  @override
  String get vipBody =>
      'Pendapatan ×2 permanen, batas offline 12 jam, dan barista yang mengetuk otomatis';

  @override
  String get starterPackTitle => 'Paket Awal Espreso';

  @override
  String get starterPackBody =>
      'Pendapatan ×1,25 permanen plus pendapatan 2 jam dalam bentuk tunai';

  @override
  String get timeSkipTitle => 'Lompat 24 Jam';

  @override
  String timeSkipBody(String amount) {
    return 'Dapatkan $amount langsung';
  }

  @override
  String get buyProduct => 'Beli';

  @override
  String get owned => 'Dimiliki';

  @override
  String get restorePurchases => 'Pulihkan pembelian';

  @override
  String get noForcedAds =>
      'Tanpa iklan paksa — iklan berhadiah selalu opsional.';

  @override
  String get dailyRewardTitle => 'Hadiah harian';

  @override
  String dailyRewardDay(int day) {
    return 'Hari $day';
  }

  @override
  String dailyRewardClaim(String amount) {
    return 'Ambil $amount';
  }

  @override
  String dailyRewardNext(String time) {
    return 'Hadiah berikutnya dalam $time';
  }

  @override
  String dailyRewardBean(int beans) {
    return '+$beans Biji Emas';
  }

  @override
  String tutorialTitle(int step, int total) {
    return 'Pelatihan barista $step/$total';
  }

  @override
  String get tutorialStepTapCup =>
      'Ketuk cangkir kopi untuk menyeduh cangkir pertamamu.';

  @override
  String get tutorialStepBuyFirstShop => 'Beli Gerobak Jalanan di tab Toko.';

  @override
  String get tutorialStepBuySecondShop => 'Buka toko keduamu: Kios Pojok.';

  @override
  String get tutorialStepHireManager =>
      'Rekrut manajer untuk melipatgandakan pendapatan toko tiga kali.';

  @override
  String get tutorialStepOpenLab => 'Buka tab Litbang untuk menemukan resep.';

  @override
  String get tutorialStepFinish =>
      'Kamu siap membangun kerajaanmu! Aktifkan pengingat agar tidak melewatkan hadiah.';

  @override
  String get tutorialSkip => 'Lewati';

  @override
  String get tutorialFinish => 'Ayo!';

  @override
  String get achievementsTitle => 'Pencapaian';

  @override
  String achievementsProgress(int unlocked, int total, int percent) {
    return '$unlocked/$total terbuka · pendapatan +$percent%';
  }

  @override
  String achievementUnlocked(String name) {
    return 'Pencapaian terbuka: $name';
  }

  @override
  String achDescLifetime(String amount) {
    return 'Hasilkan total $amount';
  }

  @override
  String achDescShopLevel(int level) {
    return 'Capai level $level di toko mana pun';
  }

  @override
  String achDescRecipes(int score, int count) {
    return 'Raih skor $score+ di $count resep';
  }

  @override
  String achDescFranchises(int count) {
    return 'Miliki $count gerai waralaba';
  }

  @override
  String achDescPrestige(int count) {
    return 'Mulai kerajaan baru $count kali';
  }

  @override
  String achDescTaps(int count) {
    return 'Ketuk cangkir $count kali';
  }

  @override
  String get achievement_first_dollars => 'Dolar Pertama';

  @override
  String get achievement_small_business => 'Usaha Kecil';

  @override
  String get achievement_coffee_mogul => 'Raja Kopi';

  @override
  String get achievement_bean_tycoon => 'Taipan Biji Kopi';

  @override
  String get achievement_caffeine_empire => 'Kerajaan Kafein';

  @override
  String get achievement_growing_shop => 'Toko Berkembang';

  @override
  String get achievement_busy_counter => 'Konter Sibuk';

  @override
  String get achievement_centurion => 'Centurion';

  @override
  String get achievement_legendary_branch => 'Cabang Legendaris';

  @override
  String get achievement_first_masterpiece => 'Mahakarya Pertama';

  @override
  String get achievement_lab_regular => 'Pelanggan Lab';

  @override
  String get achievement_master_brewer => 'Master Penyeduh';

  @override
  String get achievement_first_franchise => 'Waralaba Pertama';

  @override
  String get achievement_regional_brand => 'Merek Regional';

  @override
  String get achievement_global_chain => 'Jaringan Global';

  @override
  String get achievement_world_domination => 'Dominasi Dunia';

  @override
  String get achievement_fresh_start => 'Awal Baru';

  @override
  String get achievement_serial_founder => 'Pendiri Berantai';

  @override
  String get achievement_eager_barista => 'Barista Bersemangat';

  @override
  String get achievement_tireless_barista => 'Barista Tak Kenal Lelah';

  @override
  String get settingsTitle => 'Pengaturan';

  @override
  String get settingsLanguage => 'Bahasa';

  @override
  String get languageSystem => 'Sistem';

  @override
  String get settingsSound => 'Suara';

  @override
  String get settingsHaptics => 'Getaran';

  @override
  String get settingsNotifications => 'Notifikasi';

  @override
  String get settingsScientific => 'Notasi ilmiah';

  @override
  String get settingsReset => 'Reset kemajuan';

  @override
  String get resetConfirmTitle => 'Reset semua kemajuan?';

  @override
  String get resetConfirmBody =>
      'Ini menghapus simpananmu, termasuk Biji Emas dan pembelian. Tidak bisa dibatalkan.';

  @override
  String get resetConfirm => 'Reset';

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
