// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Coffee Empire';

  @override
  String durationDays(int value) {
    return '$value ي';
  }

  @override
  String durationHours(int value) {
    return '$value س';
  }

  @override
  String durationMinutes(int value) {
    return '$value د';
  }

  @override
  String durationSeconds(int value) {
    return '$value ث';
  }

  @override
  String get tabShops => 'المتاجر';

  @override
  String get tabLab => 'البحث والتطوير';

  @override
  String get tabGrowth => 'النمو';

  @override
  String get tabStore => 'المتجر';

  @override
  String incomePerSecond(String amount) {
    return '$amount/ث';
  }

  @override
  String comboLabel(int count) {
    return 'كومبو x$count';
  }

  @override
  String get baristaRush => 'اندفاعة الباريستا!';

  @override
  String get tapToBrew => 'المس الكوب للتحضير';

  @override
  String cupSemanticLabel(int percent) {
    return 'كوب قهوة ممتلئ بنسبة $percent%';
  }

  @override
  String get shop_street_cart => 'عربة الشارع';

  @override
  String get shop_corner_booth => 'كشك الزاوية';

  @override
  String get shop_boutique_cafe => 'مقهى بوتيك';

  @override
  String get shop_campus_coworking => 'مساحة عمل الحرم الجامعي';

  @override
  String get shop_drive_thru => 'خدمة السيارات';

  @override
  String get shop_city_roastery => 'محمصة المدينة';

  @override
  String get shop_airport_lounge => 'صالة المطار';

  @override
  String get shop_robotic_kiosk => 'كشك آلي';

  @override
  String get shop_capsule_store => 'متجر الكبسولات';

  @override
  String get shop_global_mega_roastery => 'المحمصة العالمية الكبرى';

  @override
  String get buyAmountOne => 'x1';

  @override
  String get buyAmountTen => 'x10';

  @override
  String get buyAmountMax => 'الأقصى';

  @override
  String get managerHired => 'تم تعيين المدير';

  @override
  String get milestoneMaxed => 'تم بلوغ كل المراحل';

  @override
  String get equipmentEspressoMachine => 'آلة إسبريسو';

  @override
  String get equipmentDiamondGrinder => 'مطحنة ماسية';

  @override
  String get equipmentSmartSystem => 'نظام ذكي';

  @override
  String shopLevel(int level) {
    return 'مستوى $level';
  }

  @override
  String buyLevels(int count, String cost) {
    return 'شراء x$count · $cost';
  }

  @override
  String hireManager(String cost) {
    return 'تعيين مدير · $cost';
  }

  @override
  String buyEquipment(String name, String cost) {
    return '$name · $cost';
  }

  @override
  String nextMilestone(int level) {
    return 'الدخل ×2 عند المستوى $level';
  }

  @override
  String shopLocked(String shop) {
    return 'يُفتح بعد شراء $shop';
  }

  @override
  String equipmentAllOwned(String name) {
    return '$name · مملوك';
  }

  @override
  String get recipe_espresso_classic => 'إسبريسو كلاسيكي';

  @override
  String get recipe_cappuccino => 'كابتشينو';

  @override
  String get recipe_cold_brew => 'قهوة باردة';

  @override
  String get recipe_flat_white => 'فلات وايت';

  @override
  String get recipe_capsule_house_blend => 'كبسولة خلطة البيت';

  @override
  String get recipe_ethiopian_pour_over => 'قهوة إثيوبية مقطّرة';

  @override
  String get recipe_nitro_mocha => 'نيترو موكا';

  @override
  String get recipe_capsule_signature_reserve => 'كبسولة الاحتياطي المميز';

  @override
  String get flavorAcidity => 'الحموضة';

  @override
  String get flavorBody => 'القوام';

  @override
  String get flavorAroma => 'الرائحة';

  @override
  String get flavorCaffeine => 'الكافيين';

  @override
  String hintTooLow(String attribute) {
    return '$attribute منخفض جدًا';
  }

  @override
  String hintTooHigh(String attribute) {
    return '$attribute مرتفع جدًا';
  }

  @override
  String get hintOnTrack => 'أنت على الطريق الصحيح!';

  @override
  String recipeBestScore(int score) {
    return 'الأفضل: $score';
  }

  @override
  String recipeLastResult(int score, String hint) {
    return 'آخر اختبار: $score · $hint';
  }

  @override
  String get recipeCapsuleTag => 'كبسولة';

  @override
  String unlockRecipe(String cost) {
    return 'فتح · $cost';
  }

  @override
  String startTest(String cost) {
    return 'اختبار · $cost';
  }

  @override
  String brewingRemaining(String time) {
    return 'جارٍ التحضير… $time';
  }

  @override
  String get anotherBrewActive => 'يوجد اختبار آخر قيد التشغيل';

  @override
  String get openRecipe => 'تطوير';

  @override
  String get capsuleTitle => 'آلات الكبسولات';

  @override
  String capsuleLocked(int score, int hype) {
    return 'تحتاج وصفة بنتيجة $score+ و$hype من شهرة العلامة';
  }

  @override
  String capsuleOwned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count آلة',
      many: '$count آلة',
      few: '$count آلات',
      two: 'آلتان',
      one: 'آلة واحدة',
      zero: 'لا آلات',
    );
    return '$_temp0';
  }

  @override
  String brandHypeValue(int hype) {
    return 'شهرة العلامة: $hype';
  }

  @override
  String labBonusValue(int percent) {
    return 'مكافأة البحث: +$percent%';
  }

  @override
  String get flavorProfileTitle => 'ملف النكهة';

  @override
  String get city_new_york => 'نيويورك';

  @override
  String get city_tokyo => 'طوكيو';

  @override
  String get city_london => 'لندن';

  @override
  String get city_istanbul => 'إسطنبول';

  @override
  String get city_sao_paulo => 'ساو باولو';

  @override
  String get city_paris => 'باريس';

  @override
  String get city_dubai => 'دبي';

  @override
  String get city_shanghai => 'شنغهاي';

  @override
  String get city_mexico_city => 'مكسيكو سيتي';

  @override
  String get city_seoul => 'سول';

  @override
  String get city_berlin => 'برلين';

  @override
  String get city_madrid => 'مدريد';

  @override
  String get city_rome => 'روما';

  @override
  String get city_toronto => 'تورونتو';

  @override
  String get city_sydney => 'سيدني';

  @override
  String get city_mumbai => 'مومباي';

  @override
  String get city_cairo => 'القاهرة';

  @override
  String get city_jakarta => 'جاكرتا';

  @override
  String get city_amsterdam => 'أمستردام';

  @override
  String get city_singapore => 'سنغافورة';

  @override
  String get city_bangkok => 'بانكوك';

  @override
  String get city_buenos_aires => 'بوينس آيرس';

  @override
  String get city_bogota => 'بوغوتا';

  @override
  String get city_lagos => 'لاغوس';

  @override
  String get city_vienna => 'فيينا';

  @override
  String get city_lisbon => 'لشبونة';

  @override
  String get city_reykjavik => 'ريكيافيك';

  @override
  String get city_addis_ababa => 'أديس أبابا';

  @override
  String get city_nairobi => 'نيروبي';

  @override
  String get city_hanoi => 'هانوي';

  @override
  String get country_US => 'الولايات المتحدة';

  @override
  String get country_JP => 'اليابان';

  @override
  String get country_GB => 'المملكة المتحدة';

  @override
  String get country_TR => 'تركيا';

  @override
  String get country_BR => 'البرازيل';

  @override
  String get country_FR => 'فرنسا';

  @override
  String get country_AE => 'الإمارات العربية المتحدة';

  @override
  String get country_CN => 'الصين';

  @override
  String get country_MX => 'المكسيك';

  @override
  String get country_KR => 'كوريا الجنوبية';

  @override
  String get country_DE => 'ألمانيا';

  @override
  String get country_ES => 'إسبانيا';

  @override
  String get country_IT => 'إيطاليا';

  @override
  String get country_CA => 'كندا';

  @override
  String get country_AU => 'أستراليا';

  @override
  String get country_IN => 'الهند';

  @override
  String get country_EG => 'مصر';

  @override
  String get country_ID => 'إندونيسيا';

  @override
  String get country_NL => 'هولندا';

  @override
  String get country_SG => 'سنغافورة';

  @override
  String get country_TH => 'تايلاند';

  @override
  String get country_AR => 'الأرجنتين';

  @override
  String get country_CO => 'كولومبيا';

  @override
  String get country_NG => 'نيجيريا';

  @override
  String get country_AT => 'النمسا';

  @override
  String get country_PT => 'البرتغال';

  @override
  String get country_IS => 'آيسلندا';

  @override
  String get country_ET => 'إثيوبيا';

  @override
  String get country_KE => 'كينيا';

  @override
  String get country_VN => 'فيتنام';

  @override
  String get region_europe => 'أوروبا';

  @override
  String get region_asia_pacific => 'آسيا والمحيط الهادئ';

  @override
  String get region_americas => 'الأمريكتان';

  @override
  String get region_mea => 'الشرق الأوسط وأفريقيا';

  @override
  String get franchiseTitle => 'الامتيازات';

  @override
  String franchiseRoyalty(String amount) {
    return 'العائدات: $amount/ث';
  }

  @override
  String franchisePerSlot(String amount) {
    return '+$amount/ث لكل فرع';
  }

  @override
  String franchiseRequiresHype(int hype) {
    return 'يتطلب $hype من شهرة العلامة';
  }

  @override
  String franchiseOpen(String cost) {
    return 'افتتاح · $cost';
  }

  @override
  String franchiseComplete(String multiplier) {
    return 'اكتملت المدينة ×$multiplier';
  }

  @override
  String get prestigeTitle => 'الحبوب الذهبية';

  @override
  String prestigeOwned(int beans, String multiplier) {
    return '$beans حبة ذهبية · الدخل ×$multiplier';
  }

  @override
  String prestigeProgress(String earned, String threshold) {
    return 'أرباح الجولة $earned / $threshold';
  }

  @override
  String prestigeButton(int beans) {
    return 'بيع الإمبراطورية · +$beans';
  }

  @override
  String get prestigeConfirmTitle => 'هل تبدأ إمبراطورية جديدة؟';

  @override
  String prestigeConfirmBody(int beans, String multiplier) {
    return 'ستحصل على $beans حبة ذهبية. سيصبح مضاعف دخلك ×$multiplier. سيتم تصفير المتاجر والمديرين والمعدات وآلات الكبسولات والامتيازات.';
  }

  @override
  String get confirm => 'تأكيد';

  @override
  String get cancel => 'إلغاء';

  @override
  String get offlineTitle => 'مرحبًا بعودتك!';

  @override
  String offlineBody(String duration, String amount) {
    return 'أثناء غيابك لمدة $duration، ربحت إمبراطوريتك $amount.';
  }

  @override
  String get offlineCollect => 'استلام';

  @override
  String get offlineCollectDouble => 'شاهد إعلانًا واستلم الضعف';

  @override
  String get adPlaying => 'جارٍ عرض الإعلان…';

  @override
  String get notificationChannelName => 'تذكيرات القهوة';

  @override
  String get notifOfflineTitle => 'متاجرك ممتلئة!';

  @override
  String get notifOfflineBody =>
      'بلغت أرباحك أثناء الغياب الحد الأقصى. عُد لاستلامها.';

  @override
  String get notifDailyTitle => 'المكافأة اليومية جاهزة';

  @override
  String get notifDailyBody => 'مكافأة القهوة اليومية في انتظارك.';

  @override
  String get notifRushTitle => 'انتهت اندفاعة الكافيين';

  @override
  String get notifRushBody => 'شاهد إعلانًا آخر لتبقى أرباحك مضاعفة.';

  @override
  String get rewardedTitle => 'معززات مجانية';

  @override
  String get rewardCaffeineRushTitle => 'اندفاعة الكافيين';

  @override
  String get rewardCaffeineRushBody => 'كل الدخل ×2 لمدة 4 ساعات (حتى 8 ساعات)';

  @override
  String get rewardEmergencyFundTitle => 'صندوق الطوارئ';

  @override
  String rewardEmergencyFundBody(String amount) {
    return 'احصل على $amount فورًا';
  }

  @override
  String get rewardLabSpeedupTitle => 'تسريع المختبر';

  @override
  String get rewardLabSpeedupBody => 'أنهِ اختبار البحث الجاري الآن';

  @override
  String get watchAd => 'شاهد إعلانًا';

  @override
  String readyIn(String time) {
    return 'جاهز خلال $time';
  }

  @override
  String get unavailable => 'غير متاح';

  @override
  String boostActive(String multiplier, String time) {
    return '×$multiplier $time';
  }

  @override
  String get shopTitle => 'بريميوم';

  @override
  String get vipTitle => 'كبار المحمّصين VIP';

  @override
  String get vipBody => 'دخل ×2 دائم، وحد غياب 12 ساعة، وباريستا يلمس تلقائيًا';

  @override
  String get starterPackTitle => 'حزمة إسبريسو المبدئية';

  @override
  String get starterPackBody => 'دخل ×1.25 دائم بالإضافة إلى دخل ساعتين نقدًا';

  @override
  String get timeSkipTitle => 'تخطي 24 ساعة';

  @override
  String timeSkipBody(String amount) {
    return 'احصل على $amount فورًا';
  }

  @override
  String get buyProduct => 'شراء';

  @override
  String get owned => 'مملوك';

  @override
  String get restorePurchases => 'استعادة المشتريات';

  @override
  String get noForcedAds =>
      'لا إعلانات إجبارية — إعلانات المكافآت اختيارية دائمًا.';

  @override
  String get dailyRewardTitle => 'المكافأة اليومية';

  @override
  String dailyRewardDay(int day) {
    return 'اليوم $day';
  }

  @override
  String dailyRewardClaim(String amount) {
    return 'استلم $amount';
  }

  @override
  String dailyRewardNext(String time) {
    return 'المكافأة التالية خلال $time';
  }

  @override
  String dailyRewardBean(int beans) {
    return '+$beans حبة ذهبية';
  }

  @override
  String tutorialTitle(int step, int total) {
    return 'تدريب الباريستا $step/$total';
  }

  @override
  String get tutorialStepTapCup => 'المس كوب القهوة لتحضير أول كوب.';

  @override
  String get tutorialStepBuyFirstShop => 'اشترِ عربة شارع من تبويب المتاجر.';

  @override
  String get tutorialStepBuySecondShop => 'افتتح متجرك الثاني: كشك الزاوية.';

  @override
  String get tutorialStepHireManager =>
      'عيّن مديرًا لمضاعفة دخل المتجر ثلاث مرات.';

  @override
  String get tutorialStepOpenLab =>
      'افتح تبويب البحث والتطوير لاكتشاف الوصفات.';

  @override
  String get tutorialStepFinish =>
      'أنت جاهز لبناء إمبراطوريتك! فعّل التذكيرات حتى لا تفوتك أي مكافأة.';

  @override
  String get tutorialSkip => 'تخطٍّ';

  @override
  String get tutorialFinish => 'هيا بنا!';

  @override
  String get achievementsTitle => 'الإنجازات';

  @override
  String achievementsProgress(int unlocked, int total, int percent) {
    return '$unlocked/$total مفتوحة · الدخل +$percent%';
  }

  @override
  String achievementUnlocked(String name) {
    return 'تم فتح إنجاز: $name';
  }

  @override
  String achDescLifetime(String amount) {
    return 'اربح $amount إجمالًا';
  }

  @override
  String achDescShopLevel(int level) {
    return 'بلّغ أي متجر المستوى $level';
  }

  @override
  String achDescRecipes(int score, int count) {
    return 'احصل على $score+ في $count وصفات';
  }

  @override
  String achDescFranchises(int count) {
    return 'امتلك $count فروع امتياز';
  }

  @override
  String achDescPrestige(int count) {
    return 'ابدأ إمبراطورية جديدة $count مرات';
  }

  @override
  String achDescTaps(int count) {
    return 'المس الكوب $count مرة';
  }

  @override
  String get achievement_first_dollars => 'أول الدولارات';

  @override
  String get achievement_small_business => 'مشروع صغير';

  @override
  String get achievement_coffee_mogul => 'قطب القهوة';

  @override
  String get achievement_bean_tycoon => 'ملك الحبوب';

  @override
  String get achievement_caffeine_empire => 'إمبراطورية الكافيين';

  @override
  String get achievement_growing_shop => 'متجر ينمو';

  @override
  String get achievement_busy_counter => 'منضدة مزدحمة';

  @override
  String get achievement_centurion => 'القائد المئوي';

  @override
  String get achievement_legendary_branch => 'فرع أسطوري';

  @override
  String get achievement_first_masterpiece => 'أول تحفة';

  @override
  String get achievement_lab_regular => 'زائر المختبر الدائم';

  @override
  String get achievement_master_brewer => 'خبير التحضير';

  @override
  String get achievement_first_franchise => 'أول امتياز';

  @override
  String get achievement_regional_brand => 'علامة إقليمية';

  @override
  String get achievement_global_chain => 'سلسلة عالمية';

  @override
  String get achievement_world_domination => 'الهيمنة العالمية';

  @override
  String get achievement_fresh_start => 'بداية جديدة';

  @override
  String get achievement_serial_founder => 'مؤسس متسلسل';

  @override
  String get achievement_eager_barista => 'باريستا متحمس';

  @override
  String get achievement_tireless_barista => 'باريستا لا يتعب';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get languageSystem => 'النظام';

  @override
  String get settingsSound => 'الصوت';

  @override
  String get settingsHaptics => 'الاهتزاز';

  @override
  String get settingsNotifications => 'الإشعارات';

  @override
  String get settingsScientific => 'الترميز العلمي';

  @override
  String get settingsReset => 'إعادة ضبط التقدم';

  @override
  String get resetConfirmTitle => 'إعادة ضبط كل التقدم؟';

  @override
  String get resetConfirmBody =>
      'سيؤدي هذا إلى حذف حفظك بما في ذلك الحبوب الذهبية والمشتريات. لا يمكن التراجع عن ذلك.';

  @override
  String get resetConfirm => 'إعادة الضبط';

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
}
