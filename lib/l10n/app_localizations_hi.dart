// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'Coffee Empire';

  @override
  String durationDays(int value) {
    return '$value दि';
  }

  @override
  String durationHours(int value) {
    return '$value घं';
  }

  @override
  String durationMinutes(int value) {
    return '$value मि';
  }

  @override
  String durationSeconds(int value) {
    return '$value से';
  }

  @override
  String get tabShops => 'दुकानें';

  @override
  String get tabLab => 'अनुसंधान';

  @override
  String get tabGrowth => 'विकास';

  @override
  String get tabStore => 'स्टोर';

  @override
  String incomePerSecond(String amount) {
    return '$amount/से';
  }

  @override
  String comboLabel(int count) {
    return 'कॉम्बो x$count';
  }

  @override
  String get baristaRush => 'बरिस्ता रश!';

  @override
  String get tapToBrew => 'कॉफ़ी बनाने के लिए कप पर टैप करें';

  @override
  String cupSemanticLabel(int percent) {
    return 'कॉफ़ी कप, $percent% भरा';
  }

  @override
  String get shop_street_cart => 'स्ट्रीट कार्ट';

  @override
  String get shop_corner_booth => 'कॉर्नर बूथ';

  @override
  String get shop_boutique_cafe => 'बुटीक कैफ़े';

  @override
  String get shop_campus_coworking => 'कैंपस कोवर्किंग';

  @override
  String get shop_drive_thru => 'ड्राइव-थ्रू';

  @override
  String get shop_city_roastery => 'सिटी रोस्टरी';

  @override
  String get shop_airport_lounge => 'एयरपोर्ट लाउंज';

  @override
  String get shop_robotic_kiosk => 'रोबोटिक कियोस्क';

  @override
  String get shop_capsule_store => 'कैप्सूल स्टोर';

  @override
  String get shop_global_mega_roastery => 'ग्लोबल मेगा रोस्टरी';

  @override
  String get buyAmountOne => 'x1';

  @override
  String get buyAmountTen => 'x10';

  @override
  String get buyAmountMax => 'अधिकतम';

  @override
  String get managerHired => 'मैनेजर नियुक्त';

  @override
  String get milestoneMaxed => 'सभी पड़ाव पूरे';

  @override
  String get equipmentEspressoMachine => 'एस्प्रेसो मशीन';

  @override
  String get equipmentDiamondGrinder => 'हीरा ग्राइंडर';

  @override
  String get equipmentSmartSystem => 'स्मार्ट सिस्टम';

  @override
  String shopLevel(int level) {
    return 'स्तर $level';
  }

  @override
  String buyLevels(int count, String cost) {
    return 'खरीदें x$count · $cost';
  }

  @override
  String hireManager(String cost) {
    return 'मैनेजर रखें · $cost';
  }

  @override
  String buyEquipment(String name, String cost) {
    return '$name · $cost';
  }

  @override
  String nextMilestone(int level) {
    return 'स्तर $level पर आय ×2';
  }

  @override
  String shopLocked(String shop) {
    return '$shop खरीदने के बाद खुलेगा';
  }

  @override
  String equipmentAllOwned(String name) {
    return '$name · खरीदा गया';
  }

  @override
  String get recipe_espresso_classic => 'क्लासिक एस्प्रेसो';

  @override
  String get recipe_cappuccino => 'कैपुचीनो';

  @override
  String get recipe_cold_brew => 'कोल्ड ब्रू';

  @override
  String get recipe_flat_white => 'फ़्लैट व्हाइट';

  @override
  String get recipe_capsule_house_blend => 'हाउस ब्लेंड कैप्सूल';

  @override
  String get recipe_ethiopian_pour_over => 'इथियोपियन पोर-ओवर';

  @override
  String get recipe_nitro_mocha => 'नाइट्रो मोका';

  @override
  String get recipe_capsule_signature_reserve => 'सिग्नेचर रिज़र्व कैप्सूल';

  @override
  String get flavorAcidity => 'अम्लता';

  @override
  String get flavorBody => 'गाढ़ापन';

  @override
  String get flavorAroma => 'सुगंध';

  @override
  String get flavorCaffeine => 'कैफ़ीन';

  @override
  String hintTooLow(String attribute) {
    return '$attribute बहुत कम है';
  }

  @override
  String hintTooHigh(String attribute) {
    return '$attribute बहुत ज़्यादा है';
  }

  @override
  String get hintOnTrack => 'आप सही राह पर हैं!';

  @override
  String recipeBestScore(int score) {
    return 'सर्वश्रेष्ठ: $score';
  }

  @override
  String recipeLastResult(int score, String hint) {
    return 'पिछला परीक्षण: $score · $hint';
  }

  @override
  String get recipeCapsuleTag => 'कैप्सूल';

  @override
  String unlockRecipe(String cost) {
    return 'अनलॉक · $cost';
  }

  @override
  String startTest(String cost) {
    return 'परीक्षण · $cost';
  }

  @override
  String brewingRemaining(String time) {
    return 'बन रही है… $time';
  }

  @override
  String get anotherBrewActive => 'एक और परीक्षण चल रहा है';

  @override
  String get openRecipe => 'विकसित करें';

  @override
  String get capsuleTitle => 'कैप्सूल मशीनें';

  @override
  String capsuleLocked(int score, int hype) {
    return '$score+ स्कोर वाली रेसिपी और $hype ब्रांड हाइप चाहिए';
  }

  @override
  String capsuleOwned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count मशीनें',
      one: '$count मशीन',
    );
    return '$_temp0';
  }

  @override
  String brandHypeValue(int hype) {
    return 'ब्रांड हाइप: $hype';
  }

  @override
  String labBonusValue(int percent) {
    return 'अनुसंधान बोनस: +$percent%';
  }

  @override
  String get flavorProfileTitle => 'स्वाद प्रोफ़ाइल';

  @override
  String get city_new_york => 'न्यूयॉर्क';

  @override
  String get city_tokyo => 'टोक्यो';

  @override
  String get city_london => 'लंदन';

  @override
  String get city_istanbul => 'इस्तांबुल';

  @override
  String get city_sao_paulo => 'साओ पाउलो';

  @override
  String get city_paris => 'पेरिस';

  @override
  String get city_dubai => 'दुबई';

  @override
  String get city_shanghai => 'शंघाई';

  @override
  String get city_mexico_city => 'मेक्सिको सिटी';

  @override
  String get city_seoul => 'सियोल';

  @override
  String get city_berlin => 'बर्लिन';

  @override
  String get city_madrid => 'मैड्रिड';

  @override
  String get city_rome => 'रोम';

  @override
  String get city_toronto => 'टोरंटो';

  @override
  String get city_sydney => 'सिडनी';

  @override
  String get city_mumbai => 'मुंबई';

  @override
  String get city_cairo => 'काहिरा';

  @override
  String get city_jakarta => 'जकार्ता';

  @override
  String get city_amsterdam => 'एम्स्टर्डम';

  @override
  String get city_singapore => 'सिंगापुर';

  @override
  String get city_bangkok => 'बैंकॉक';

  @override
  String get city_buenos_aires => 'ब्यूनस आयर्स';

  @override
  String get city_bogota => 'बोगोटा';

  @override
  String get city_lagos => 'लागोस';

  @override
  String get city_vienna => 'वियना';

  @override
  String get city_lisbon => 'लिस्बन';

  @override
  String get city_reykjavik => 'रेक्याविक';

  @override
  String get city_addis_ababa => 'अदीस अबाबा';

  @override
  String get city_nairobi => 'नैरोबी';

  @override
  String get city_hanoi => 'हनोई';

  @override
  String get country_US => 'संयुक्त राज्य अमेरिका';

  @override
  String get country_JP => 'जापान';

  @override
  String get country_GB => 'यूनाइटेड किंगडम';

  @override
  String get country_TR => 'तुर्किये';

  @override
  String get country_BR => 'ब्राज़ील';

  @override
  String get country_FR => 'फ़्रांस';

  @override
  String get country_AE => 'संयुक्त अरब अमीरात';

  @override
  String get country_CN => 'चीन';

  @override
  String get country_MX => 'मेक्सिको';

  @override
  String get country_KR => 'दक्षिण कोरिया';

  @override
  String get country_DE => 'जर्मनी';

  @override
  String get country_ES => 'स्पेन';

  @override
  String get country_IT => 'इटली';

  @override
  String get country_CA => 'कनाडा';

  @override
  String get country_AU => 'ऑस्ट्रेलिया';

  @override
  String get country_IN => 'भारत';

  @override
  String get country_EG => 'मिस्र';

  @override
  String get country_ID => 'इंडोनेशिया';

  @override
  String get country_NL => 'नीदरलैंड्स';

  @override
  String get country_SG => 'सिंगापुर';

  @override
  String get country_TH => 'थाईलैंड';

  @override
  String get country_AR => 'अर्जेंटीना';

  @override
  String get country_CO => 'कोलंबिया';

  @override
  String get country_NG => 'नाइजीरिया';

  @override
  String get country_AT => 'ऑस्ट्रिया';

  @override
  String get country_PT => 'पुर्तगाल';

  @override
  String get country_IS => 'आइसलैंड';

  @override
  String get country_ET => 'इथियोपिया';

  @override
  String get country_KE => 'केन्या';

  @override
  String get country_VN => 'वियतनाम';

  @override
  String get region_europe => 'यूरोप';

  @override
  String get region_asia_pacific => 'एशिया-प्रशांत';

  @override
  String get region_americas => 'अमेरिका';

  @override
  String get region_mea => 'मध्य पूर्व और अफ़्रीका';

  @override
  String get franchiseTitle => 'फ्रैंचाइज़ी';

  @override
  String franchiseRoyalty(String amount) {
    return 'रॉयल्टी: $amount/से';
  }

  @override
  String franchisePerSlot(String amount) {
    return 'प्रति स्लॉट +$amount/से';
  }

  @override
  String franchiseRequiresHype(int hype) {
    return '$hype ब्रांड हाइप चाहिए';
  }

  @override
  String franchiseOpen(String cost) {
    return 'खोलें · $cost';
  }

  @override
  String franchiseComplete(String multiplier) {
    return 'शहर पूरा ×$multiplier';
  }

  @override
  String get prestigeTitle => 'सुनहरे बीन्स';

  @override
  String prestigeOwned(int beans, String multiplier) {
    return '$beans सुनहरे बीन्स · आय ×$multiplier';
  }

  @override
  String prestigeProgress(String earned, String threshold) {
    return 'इस दौर की कमाई $earned / $threshold';
  }

  @override
  String prestigeButton(int beans) {
    return 'साम्राज्य बेचें · +$beans';
  }

  @override
  String get prestigeConfirmTitle => 'नया साम्राज्य शुरू करें?';

  @override
  String prestigeConfirmBody(int beans, String multiplier) {
    return 'आपको $beans सुनहरे बीन्स मिलेंगे। आपका आय गुणक ×$multiplier हो जाएगा। दुकानें, मैनेजर, उपकरण, कैप्सूल मशीनें और फ्रैंचाइज़ी रीसेट हो जाएँगी।';
  }

  @override
  String get confirm => 'पुष्टि करें';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get offlineTitle => 'वापसी पर स्वागत है!';

  @override
  String offlineBody(String duration, String amount) {
    return 'आपकी $duration की अनुपस्थिति में आपके साम्राज्य ने $amount कमाए।';
  }

  @override
  String get offlineCollect => 'लें';

  @override
  String get offlineCollectDouble => 'विज्ञापन देखें, 2x लें';

  @override
  String get adPlaying => 'विज्ञापन चल रहा है…';

  @override
  String get notificationChannelName => 'कॉफ़ी रिमाइंडर';

  @override
  String get notifOfflineTitle => 'आपकी दुकानें भर गई हैं!';

  @override
  String get notifOfflineBody =>
      'ऑफ़लाइन कमाई सीमा तक पहुँच गई। लेने के लिए वापस आएँ।';

  @override
  String get notifDailyTitle => 'दैनिक इनाम तैयार है';

  @override
  String get notifDailyBody => 'आपका दैनिक कॉफ़ी बोनस इंतज़ार कर रहा है।';

  @override
  String get notifRushTitle => 'कैफ़ीन रश समाप्त';

  @override
  String get notifRushBody => 'आय दोगुनी रखने के लिए एक और विज्ञापन देखें।';

  @override
  String get rewardedTitle => 'मुफ़्त बूस्ट';

  @override
  String get rewardCaffeineRushTitle => 'कैफ़ीन रश';

  @override
  String get rewardCaffeineRushBody => '4 घंटे तक सारी आय ×2 (अधिकतम 8 घंटे)';

  @override
  String get rewardEmergencyFundTitle => 'आपातकालीन फंड';

  @override
  String rewardEmergencyFundBody(String amount) {
    return 'तुरंत $amount पाएँ';
  }

  @override
  String get rewardLabSpeedupTitle => 'लैब तेज़ करें';

  @override
  String get rewardLabSpeedupBody => 'चल रहा अनुसंधान परीक्षण अभी पूरा करें';

  @override
  String get watchAd => 'विज्ञापन देखें';

  @override
  String readyIn(String time) {
    return '$time में तैयार';
  }

  @override
  String get unavailable => 'उपलब्ध नहीं';

  @override
  String boostActive(String multiplier, String time) {
    return '×$multiplier $time';
  }

  @override
  String get shopTitle => 'प्रीमियम';

  @override
  String get vipTitle => 'मास्टर रोस्टर VIP';

  @override
  String get vipBody =>
      'स्थायी आय ×2, 12 घंटे की ऑफ़लाइन सीमा और अपने-आप टैप करने वाला बरिस्ता';

  @override
  String get starterPackTitle => 'एस्प्रेसो स्टार्टर पैक';

  @override
  String get starterPackBody => 'स्थायी आय ×1.25 और नकद में 2 घंटे की आय';

  @override
  String get timeSkipTitle => '24 घंटे आगे बढ़ें';

  @override
  String timeSkipBody(String amount) {
    return 'तुरंत $amount पाएँ';
  }

  @override
  String get buyProduct => 'खरीदें';

  @override
  String get owned => 'खरीदा गया';

  @override
  String get restorePurchases => 'खरीदारी बहाल करें';

  @override
  String get noForcedAds =>
      'कोई ज़बरदस्ती विज्ञापन नहीं — इनाम वाले विज्ञापन हमेशा वैकल्पिक हैं।';

  @override
  String get dailyRewardTitle => 'दैनिक इनाम';

  @override
  String dailyRewardDay(int day) {
    return 'दिन $day';
  }

  @override
  String dailyRewardClaim(String amount) {
    return '$amount लें';
  }

  @override
  String dailyRewardNext(String time) {
    return 'अगला इनाम $time में';
  }

  @override
  String dailyRewardBean(int beans) {
    return '+$beans सुनहरा बीन';
  }

  @override
  String tutorialTitle(int step, int total) {
    return 'बरिस्ता प्रशिक्षण $step/$total';
  }

  @override
  String get tutorialStepBuyFirstShop =>
      'दुकानें टैब से एक स्ट्रीट कार्ट खरीदें।';

  @override
  String get tutorialStepBuySecondShop => 'अपनी दूसरी दुकान खोलें: कॉर्नर बूथ।';

  @override
  String get tutorialStepHireManager =>
      'दुकान की आय तिगुनी करने के लिए मैनेजर रखें।';

  @override
  String get tutorialStepOpenLab => 'रेसिपी खोजने के लिए अनुसंधान टैब खोलें।';

  @override
  String get tutorialStepFinish =>
      'आप अपना साम्राज्य बनाने के लिए तैयार हैं! कोई इनाम न छूटे, इसलिए रिमाइंडर चालू करें।';

  @override
  String get tutorialSkip => 'छोड़ें';

  @override
  String get tutorialFinish => 'चलिए!';

  @override
  String get achievementsTitle => 'उपलब्धियाँ';

  @override
  String achievementsProgress(int unlocked, int total, int percent) {
    return '$unlocked/$total अनलॉक · आय +$percent%';
  }

  @override
  String achievementUnlocked(String name) {
    return 'उपलब्धि अनलॉक: $name';
  }

  @override
  String achDescLifetime(String amount) {
    return 'कुल $amount कमाएँ';
  }

  @override
  String achDescShopLevel(int level) {
    return 'किसी भी दुकान में स्तर $level तक पहुँचें';
  }

  @override
  String achDescRecipes(int score, int count) {
    return '$count रेसिपी में $score+ स्कोर करें';
  }

  @override
  String achDescFranchises(int count) {
    return '$count फ्रैंचाइज़ी स्लॉट के मालिक बनें';
  }

  @override
  String achDescPrestige(int count) {
    return '$count बार नया साम्राज्य शुरू करें';
  }

  @override
  String achDescTaps(int count) {
    return 'कप पर $count बार टैप करें';
  }

  @override
  String get achievement_first_dollars => 'पहले डॉलर';

  @override
  String get achievement_small_business => 'छोटा व्यवसाय';

  @override
  String get achievement_coffee_mogul => 'कॉफ़ी दिग्गज';

  @override
  String get achievement_bean_tycoon => 'बीन सम्राट';

  @override
  String get achievement_caffeine_empire => 'कैफ़ीन साम्राज्य';

  @override
  String get achievement_growing_shop => 'बढ़ती दुकान';

  @override
  String get achievement_busy_counter => 'व्यस्त काउंटर';

  @override
  String get achievement_centurion => 'शतकवीर';

  @override
  String get achievement_legendary_branch => 'पौराणिक शाखा';

  @override
  String get achievement_first_masterpiece => 'पहली उत्कृष्ट कृति';

  @override
  String get achievement_lab_regular => 'लैब का नियमित';

  @override
  String get achievement_master_brewer => 'मास्टर ब्रूअर';

  @override
  String get achievement_first_franchise => 'पहली फ्रैंचाइज़ी';

  @override
  String get achievement_regional_brand => 'क्षेत्रीय ब्रांड';

  @override
  String get achievement_global_chain => 'वैश्विक चेन';

  @override
  String get achievement_world_domination => 'विश्व प्रभुत्व';

  @override
  String get achievement_fresh_start => 'नई शुरुआत';

  @override
  String get achievement_serial_founder => 'सीरियल संस्थापक';

  @override
  String get achievement_eager_barista => 'उत्साही बरिस्ता';

  @override
  String get achievement_tireless_barista => 'अथक बरिस्ता';

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String get settingsLanguage => 'भाषा';

  @override
  String get languageSystem => 'सिस्टम';

  @override
  String get settingsSound => 'ध्वनि';

  @override
  String get settingsHaptics => 'कंपन';

  @override
  String get settingsNotifications => 'सूचनाएँ';

  @override
  String get settingsScientific => 'वैज्ञानिक संकेतन';

  @override
  String get settingsReset => 'प्रगति रीसेट करें';

  @override
  String get resetConfirmTitle => 'सारी प्रगति रीसेट करें?';

  @override
  String get resetConfirmBody =>
      'इससे सुनहरे बीन्स और खरीदारी सहित आपका सेव मिट जाएगा। इसे वापस नहीं किया जा सकता।';

  @override
  String get resetConfirm => 'रीसेट';

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
  String get stationUpgradesHint => 'मैनेजर और उपकरण के लिए टैप करें';

  @override
  String get spriteGalleryTitle => 'स्प्राइट गैलरी';

  @override
  String get tabCafe => 'कैफ़े';

  @override
  String get tutorialStepServeCustomer =>
      'काउंटर पर ग्राहक को टैप करें, ड्रिंक बनाएँ, फिर परोसने के लिए दोबारा टैप करें।';

  @override
  String brewPanelTitle(String drink) {
    return 'बन रही है: $drink';
  }

  @override
  String get serveHint => 'ड्रिंक तैयार! परोसने के लिए ग्राहक को टैप करें।';

  @override
  String get perfectServe => 'शानदार!';

  @override
  String get drink_espresso => 'एस्प्रेसो';

  @override
  String get drink_americano => 'अमेरिकानो';

  @override
  String get drink_latte => 'लाते';

  @override
  String get drink_cappuccino => 'कैपुचीनो';

  @override
  String get drink_mocha => 'मोका';

  @override
  String get drink_cold_brew => 'कोल्ड ब्रू';

  @override
  String get editLayout => 'संपादित करें';

  @override
  String get editDone => 'हो गया';

  @override
  String get editHint => 'फ़र्नीचर हटाने के लिए उस पर टैप करें।';

  @override
  String get editRotate => 'घुमाएँ';

  @override
  String get editStore => 'भंडार में रखें';

  @override
  String get editPlace => 'रखें';

  @override
  String get editCancel => 'रद्द करें';

  @override
  String get editInvalid => 'यहाँ नहीं रखा जा सकता';

  @override
  String get furnitureCatalog => 'फ़र्नीचर';

  @override
  String furnitureOwned(int count) {
    return 'भंडार में: $count';
  }

  @override
  String furnitureAppeal(int appeal) {
    return '+$appeal आकर्षण';
  }

  @override
  String furnitureLocked(String shop) {
    return '$shop से खुलता है';
  }

  @override
  String cafeAppealSummary(int appeal, String multiplier) {
    return 'आकर्षण $appeal · आय ×$multiplier';
  }

  @override
  String get furnitureCategorySeating => 'बैठने की जगह';

  @override
  String get furnitureCategoryTable => 'मेज़ें';

  @override
  String get furnitureCategoryDecor => 'सजावट';

  @override
  String get furnitureCategoryLighting => 'रोशनी';

  @override
  String get furnitureCategoryCounter => 'काउंटर एक्सटेंशन';

  @override
  String get furniture_chair => 'लकड़ी की कुर्सी';

  @override
  String get furniture_stool => 'स्टूल';

  @override
  String get furniture_chair_white => 'सफ़ेद कुर्सी';

  @override
  String get furniture_bench => 'बेंच';

  @override
  String get furniture_armchair => 'आरामकुर्सी';

  @override
  String get furniture_sofa => 'सोफ़ा';

  @override
  String get furniture_table => 'मेज़';

  @override
  String get furniture_table_round => 'गोल मेज़';

  @override
  String get furniture_table_long => 'लंबी मेज़';

  @override
  String get furniture_table_bar => 'बार मेज़';

  @override
  String get furniture_table_marble => 'संगमरमर की मेज़';

  @override
  String get furniture_plant => 'गमले का पौधा';

  @override
  String get furniture_painting => 'पेंटिंग';

  @override
  String get furniture_shelf => 'शेल्फ़';

  @override
  String get furniture_rug => 'कालीन';

  @override
  String get furniture_bookcase => 'किताबों की अलमारी';

  @override
  String get furniture_record_player => 'रिकॉर्ड प्लेयर';

  @override
  String get furniture_neon_sign => 'नियॉन साइन';

  @override
  String get furniture_aquarium => 'एक्वेरियम';

  @override
  String get furniture_floor_lamp => 'फ़्लोर लैंप';

  @override
  String get furniture_lantern => 'लालटेन';

  @override
  String get furniture_light_pillar => 'प्रकाश स्तंभ';

  @override
  String get furniture_pastry_case => 'पेस्ट्री शोकेस';

  @override
  String get furniture_drink_fridge => 'ड्रिंक फ़्रिज';
}
