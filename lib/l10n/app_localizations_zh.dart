// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Coffee Empire';

  @override
  String durationDays(int value) {
    return '$value天';
  }

  @override
  String durationHours(int value) {
    return '$value小时';
  }

  @override
  String durationMinutes(int value) {
    return '$value分';
  }

  @override
  String durationSeconds(int value) {
    return '$value秒';
  }

  @override
  String get tabShops => '店铺';

  @override
  String get tabLab => '研发';

  @override
  String get tabGrowth => '发展';

  @override
  String get tabStore => '商店';

  @override
  String incomePerSecond(String amount) {
    return '$amount/秒';
  }

  @override
  String comboLabel(int count) {
    return '连击 x$count';
  }

  @override
  String get baristaRush => '咖啡师冲刺！';

  @override
  String get tapToBrew => '点击杯子冲煮';

  @override
  String cupSemanticLabel(int percent) {
    return '咖啡杯，已满$percent%';
  }

  @override
  String get shop_street_cart => '街头推车';

  @override
  String get shop_corner_booth => '街角小亭';

  @override
  String get shop_boutique_cafe => '精品咖啡馆';

  @override
  String get shop_campus_coworking => '校园共享办公';

  @override
  String get shop_drive_thru => '得来速';

  @override
  String get shop_city_roastery => '城市烘焙坊';

  @override
  String get shop_airport_lounge => '机场贵宾室';

  @override
  String get shop_robotic_kiosk => '机器人售货亭';

  @override
  String get shop_capsule_store => '胶囊专卖店';

  @override
  String get shop_global_mega_roastery => '全球超级烘焙厂';

  @override
  String get buyAmountOne => 'x1';

  @override
  String get buyAmountTen => 'x10';

  @override
  String get buyAmountMax => '最大';

  @override
  String get managerHired => '已雇用店长';

  @override
  String get milestoneMaxed => '已达成所有里程碑';

  @override
  String get equipmentEspressoMachine => '意式咖啡机';

  @override
  String get equipmentDiamondGrinder => '钻石磨豆机';

  @override
  String get equipmentSmartSystem => '智能系统';

  @override
  String shopLevel(int level) {
    return '等级 $level';
  }

  @override
  String buyLevels(int count, String cost) {
    return '购买 x$count · $cost';
  }

  @override
  String hireManager(String cost) {
    return '雇用店长 · $cost';
  }

  @override
  String buyEquipment(String name, String cost) {
    return '$name · $cost';
  }

  @override
  String nextMilestone(int level) {
    return '等级 $level 时收入×2';
  }

  @override
  String shopLocked(String shop) {
    return '购买$shop后解锁';
  }

  @override
  String equipmentAllOwned(String name) {
    return '$name · 已拥有';
  }

  @override
  String get recipe_espresso_classic => '经典意式浓缩';

  @override
  String get recipe_cappuccino => '卡布奇诺';

  @override
  String get recipe_cold_brew => '冷萃咖啡';

  @override
  String get recipe_flat_white => '澳白';

  @override
  String get recipe_capsule_house_blend => '招牌拼配胶囊';

  @override
  String get recipe_ethiopian_pour_over => '埃塞俄比亚手冲';

  @override
  String get recipe_nitro_mocha => '氮气摩卡';

  @override
  String get recipe_capsule_signature_reserve => '臻选珍藏胶囊';

  @override
  String get flavorAcidity => '酸度';

  @override
  String get flavorBody => '醇厚度';

  @override
  String get flavorAroma => '香气';

  @override
  String get flavorCaffeine => '咖啡因';

  @override
  String hintTooLow(String attribute) {
    return '$attribute太低了';
  }

  @override
  String hintTooHigh(String attribute) {
    return '$attribute太高了';
  }

  @override
  String get hintOnTrack => '方向对了！';

  @override
  String recipeBestScore(int score) {
    return '最佳：$score';
  }

  @override
  String recipeLastResult(int score, String hint) {
    return '上次测试：$score · $hint';
  }

  @override
  String get recipeCapsuleTag => '胶囊';

  @override
  String unlockRecipe(String cost) {
    return '解锁 · $cost';
  }

  @override
  String startTest(String cost) {
    return '测试 · $cost';
  }

  @override
  String brewingRemaining(String time) {
    return '冲煮中… $time';
  }

  @override
  String get anotherBrewActive => '另一项测试正在进行';

  @override
  String get openRecipe => '研发';

  @override
  String get capsuleTitle => '胶囊咖啡机';

  @override
  String capsuleLocked(int score, int hype) {
    return '需要一款$score分以上的配方和$hype品牌热度';
  }

  @override
  String capsuleOwned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count台',
    );
    return '$_temp0';
  }

  @override
  String brandHypeValue(int hype) {
    return '品牌热度：$hype';
  }

  @override
  String labBonusValue(int percent) {
    return '研发加成：+$percent%';
  }

  @override
  String get flavorProfileTitle => '风味档案';

  @override
  String get city_new_york => '纽约';

  @override
  String get city_tokyo => '东京';

  @override
  String get city_london => '伦敦';

  @override
  String get city_istanbul => '伊斯坦布尔';

  @override
  String get city_sao_paulo => '圣保罗';

  @override
  String get city_paris => '巴黎';

  @override
  String get city_dubai => '迪拜';

  @override
  String get city_shanghai => '上海';

  @override
  String get city_mexico_city => '墨西哥城';

  @override
  String get city_seoul => '首尔';

  @override
  String get city_berlin => '柏林';

  @override
  String get city_madrid => '马德里';

  @override
  String get city_rome => '罗马';

  @override
  String get city_toronto => '多伦多';

  @override
  String get city_sydney => '悉尼';

  @override
  String get city_mumbai => '孟买';

  @override
  String get city_cairo => '开罗';

  @override
  String get city_jakarta => '雅加达';

  @override
  String get city_amsterdam => '阿姆斯特丹';

  @override
  String get city_singapore => '新加坡';

  @override
  String get city_bangkok => '曼谷';

  @override
  String get city_buenos_aires => '布宜诺斯艾利斯';

  @override
  String get city_bogota => '波哥大';

  @override
  String get city_lagos => '拉各斯';

  @override
  String get city_vienna => '维也纳';

  @override
  String get city_lisbon => '里斯本';

  @override
  String get city_reykjavik => '雷克雅未克';

  @override
  String get city_addis_ababa => '亚的斯亚贝巴';

  @override
  String get city_nairobi => '内罗毕';

  @override
  String get city_hanoi => '河内';

  @override
  String get country_US => '美国';

  @override
  String get country_JP => '日本';

  @override
  String get country_GB => '英国';

  @override
  String get country_TR => '土耳其';

  @override
  String get country_BR => '巴西';

  @override
  String get country_FR => '法国';

  @override
  String get country_AE => '阿联酋';

  @override
  String get country_CN => '中国';

  @override
  String get country_MX => '墨西哥';

  @override
  String get country_KR => '韩国';

  @override
  String get country_DE => '德国';

  @override
  String get country_ES => '西班牙';

  @override
  String get country_IT => '意大利';

  @override
  String get country_CA => '加拿大';

  @override
  String get country_AU => '澳大利亚';

  @override
  String get country_IN => '印度';

  @override
  String get country_EG => '埃及';

  @override
  String get country_ID => '印度尼西亚';

  @override
  String get country_NL => '荷兰';

  @override
  String get country_SG => '新加坡';

  @override
  String get country_TH => '泰国';

  @override
  String get country_AR => '阿根廷';

  @override
  String get country_CO => '哥伦比亚';

  @override
  String get country_NG => '尼日利亚';

  @override
  String get country_AT => '奥地利';

  @override
  String get country_PT => '葡萄牙';

  @override
  String get country_IS => '冰岛';

  @override
  String get country_ET => '埃塞俄比亚';

  @override
  String get country_KE => '肯尼亚';

  @override
  String get country_VN => '越南';

  @override
  String get region_europe => '欧洲';

  @override
  String get region_asia_pacific => '亚太';

  @override
  String get region_americas => '美洲';

  @override
  String get region_mea => '中东和非洲';

  @override
  String get franchiseTitle => '特许经营';

  @override
  String franchiseRoyalty(String amount) {
    return '特许费：$amount/秒';
  }

  @override
  String franchisePerSlot(String amount) {
    return '每个店位 +$amount/秒';
  }

  @override
  String franchiseRequiresHype(int hype) {
    return '需要$hype品牌热度';
  }

  @override
  String franchiseOpen(String cost) {
    return '开店 · $cost';
  }

  @override
  String franchiseComplete(String multiplier) {
    return '城市已完成 ×$multiplier';
  }

  @override
  String get prestigeTitle => '金咖啡豆';

  @override
  String prestigeOwned(int beans, String multiplier) {
    return '$beans颗金咖啡豆 · 收入×$multiplier';
  }

  @override
  String prestigeProgress(String earned, String threshold) {
    return '本轮收益 $earned / $threshold';
  }

  @override
  String prestigeButton(int beans) {
    return '出售帝国 · +$beans';
  }

  @override
  String get prestigeConfirmTitle => '开始一个新帝国？';

  @override
  String prestigeConfirmBody(int beans, String multiplier) {
    return '你将获得$beans颗金咖啡豆。收入倍数将变为×$multiplier。店铺、店长、设备、胶囊咖啡机和特许店将被重置。';
  }

  @override
  String get confirm => '确认';

  @override
  String get cancel => '取消';

  @override
  String get offlineTitle => '欢迎回来！';

  @override
  String offlineBody(String duration, String amount) {
    return '你离开的$duration里，你的帝国赚了$amount。';
  }

  @override
  String get offlineCollect => '领取';

  @override
  String get offlineCollectDouble => '看广告，领取2倍';

  @override
  String get adPlaying => '广告播放中…';

  @override
  String get notificationChannelName => '咖啡提醒';

  @override
  String get notifOfflineTitle => '你的店铺爆满了！';

  @override
  String get notifOfflineBody => '离线收益已达上限，快回来领取吧。';

  @override
  String get notifDailyTitle => '每日奖励已就绪';

  @override
  String get notifDailyBody => '你的每日咖啡奖励正在等你。';

  @override
  String get notifRushTitle => '咖啡因冲刺结束';

  @override
  String get notifRushBody => '再看一个广告，让收入继续翻倍。';

  @override
  String get rewardedTitle => '免费加成';

  @override
  String get rewardCaffeineRushTitle => '咖啡因冲刺';

  @override
  String get rewardCaffeineRushBody => '4小时内所有收入×2（最多8小时）';

  @override
  String get rewardEmergencyFundTitle => '应急资金';

  @override
  String rewardEmergencyFundBody(String amount) {
    return '立即获得$amount';
  }

  @override
  String get rewardLabSpeedupTitle => '实验室加速';

  @override
  String get rewardLabSpeedupBody => '立即完成正在进行的研发测试';

  @override
  String get watchAd => '看广告';

  @override
  String readyIn(String time) {
    return '$time后可用';
  }

  @override
  String get unavailable => '不可用';

  @override
  String boostActive(String multiplier, String time) {
    return '×$multiplier $time';
  }

  @override
  String get shopTitle => '高级';

  @override
  String get vipTitle => '烘焙大师VIP';

  @override
  String get vipBody => '永久收入×2、12小时离线上限，以及自动点击的咖啡师';

  @override
  String get starterPackTitle => '意式浓缩新手礼包';

  @override
  String get starterPackBody => '永久收入×1.25，外加2小时收入的现金';

  @override
  String get timeSkipTitle => '跳过24小时';

  @override
  String timeSkipBody(String amount) {
    return '立即获得$amount';
  }

  @override
  String get buyProduct => '购买';

  @override
  String get owned => '已拥有';

  @override
  String get restorePurchases => '恢复购买';

  @override
  String get noForcedAds => '没有强制广告——奖励广告始终自愿观看。';

  @override
  String get dailyRewardTitle => '每日奖励';

  @override
  String dailyRewardDay(int day) {
    return '第$day天';
  }

  @override
  String dailyRewardClaim(String amount) {
    return '领取$amount';
  }

  @override
  String dailyRewardNext(String time) {
    return '$time后可领下一个奖励';
  }

  @override
  String dailyRewardBean(int beans) {
    return '+$beans颗金咖啡豆';
  }

  @override
  String tutorialTitle(int step, int total) {
    return '咖啡师培训 $step/$total';
  }

  @override
  String get tutorialStepTapCup => '点击咖啡杯，冲煮你的第一杯咖啡。';

  @override
  String get tutorialStepBuyFirstShop => '在店铺标签中购买一辆街头推车。';

  @override
  String get tutorialStepBuySecondShop => '开设你的第二家店：街角小亭。';

  @override
  String get tutorialStepHireManager => '雇用店长，让店铺收入翻三倍。';

  @override
  String get tutorialStepOpenLab => '打开研发标签，发现新配方。';

  @override
  String get tutorialStepFinish => '你已准备好建立帝国！开启提醒，不错过任何奖励。';

  @override
  String get tutorialSkip => '跳过';

  @override
  String get tutorialFinish => '出发！';

  @override
  String get achievementsTitle => '成就';

  @override
  String achievementsProgress(int unlocked, int total, int percent) {
    return '已解锁$unlocked/$total · 收入+$percent%';
  }

  @override
  String achievementUnlocked(String name) {
    return '成就解锁：$name';
  }

  @override
  String achDescLifetime(String amount) {
    return '累计赚取$amount';
  }

  @override
  String achDescShopLevel(int level) {
    return '任意店铺达到等级$level';
  }

  @override
  String achDescRecipes(int score, int count) {
    return '在$count个配方中获得$score分以上';
  }

  @override
  String achDescFranchises(int count) {
    return '拥有$count个特许店位';
  }

  @override
  String achDescPrestige(int count) {
    return '开始新帝国$count次';
  }

  @override
  String achDescTaps(int count) {
    return '点击杯子$count次';
  }

  @override
  String get achievement_first_dollars => '第一桶金';

  @override
  String get achievement_small_business => '小本生意';

  @override
  String get achievement_coffee_mogul => '咖啡大亨';

  @override
  String get achievement_bean_tycoon => '咖啡豆巨头';

  @override
  String get achievement_caffeine_empire => '咖啡因帝国';

  @override
  String get achievement_growing_shop => '成长的店铺';

  @override
  String get achievement_busy_counter => '繁忙的柜台';

  @override
  String get achievement_centurion => '百夫长';

  @override
  String get achievement_legendary_branch => '传奇分店';

  @override
  String get achievement_first_masterpiece => '首部杰作';

  @override
  String get achievement_lab_regular => '实验室常客';

  @override
  String get achievement_master_brewer => '冲煮大师';

  @override
  String get achievement_first_franchise => '首家特许店';

  @override
  String get achievement_regional_brand => '区域品牌';

  @override
  String get achievement_global_chain => '全球连锁';

  @override
  String get achievement_world_domination => '称霸世界';

  @override
  String get achievement_fresh_start => '重新开始';

  @override
  String get achievement_serial_founder => '连续创业者';

  @override
  String get achievement_eager_barista => '热情的咖啡师';

  @override
  String get achievement_tireless_barista => '不知疲倦的咖啡师';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsLanguage => '语言';

  @override
  String get languageSystem => '跟随系统';

  @override
  String get settingsSound => '声音';

  @override
  String get settingsHaptics => '振动';

  @override
  String get settingsNotifications => '通知';

  @override
  String get settingsScientific => '科学计数法';

  @override
  String get settingsReset => '重置进度';

  @override
  String get resetConfirmTitle => '重置全部进度？';

  @override
  String get resetConfirmBody => '这将删除你的存档，包括金咖啡豆和购买记录，且无法撤销。';

  @override
  String get resetConfirm => '重置';

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
