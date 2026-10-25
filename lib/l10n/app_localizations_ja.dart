// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Coffee Empire';

  @override
  String durationDays(int value) {
    return '$value日';
  }

  @override
  String durationHours(int value) {
    return '$value時間';
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
  String get tabShops => '店舗';

  @override
  String get tabLab => '研究開発';

  @override
  String get tabGrowth => '成長';

  @override
  String get tabStore => 'ストア';

  @override
  String incomePerSecond(String amount) {
    return '$amount/秒';
  }

  @override
  String comboLabel(int count) {
    return 'コンボ x$count';
  }

  @override
  String get baristaRush => 'バリスタラッシュ！';

  @override
  String get tapToBrew => 'カップをタップして抽出';

  @override
  String cupSemanticLabel(int percent) {
    return 'コーヒーカップ、$percent%';
  }

  @override
  String get shop_street_cart => '屋台';

  @override
  String get shop_corner_booth => '街角スタンド';

  @override
  String get shop_boutique_cafe => 'ブティックカフェ';

  @override
  String get shop_campus_coworking => 'キャンパス・コワーキング';

  @override
  String get shop_drive_thru => 'ドライブスルー';

  @override
  String get shop_city_roastery => 'シティロースタリー';

  @override
  String get shop_airport_lounge => '空港ラウンジ';

  @override
  String get shop_robotic_kiosk => 'ロボットキオスク';

  @override
  String get shop_capsule_store => 'カプセルストア';

  @override
  String get shop_global_mega_roastery => 'グローバル・メガロースタリー';

  @override
  String get buyAmountOne => 'x1';

  @override
  String get buyAmountTen => 'x10';

  @override
  String get buyAmountMax => '最大';

  @override
  String get managerHired => '店長を雇用済み';

  @override
  String get milestoneMaxed => 'すべてのマイルストーン達成';

  @override
  String get equipmentEspressoMachine => 'エスプレッソマシン';

  @override
  String get equipmentDiamondGrinder => 'ダイヤモンドグラインダー';

  @override
  String get equipmentSmartSystem => 'スマートシステム';

  @override
  String shopLevel(int level) {
    return 'Lv.$level';
  }

  @override
  String buyLevels(int count, String cost) {
    return 'x$count購入 · $cost';
  }

  @override
  String hireManager(String cost) {
    return '店長を雇う · $cost';
  }

  @override
  String buyEquipment(String name, String cost) {
    return '$name · $cost';
  }

  @override
  String nextMilestone(int level) {
    return 'Lv.$levelで収入×2';
  }

  @override
  String shopLocked(String shop) {
    return '$shopを購入すると解放';
  }

  @override
  String equipmentAllOwned(String name) {
    return '$name · 購入済み';
  }

  @override
  String get recipe_espresso_classic => 'クラシックエスプレッソ';

  @override
  String get recipe_cappuccino => 'カプチーノ';

  @override
  String get recipe_cold_brew => 'コールドブリュー';

  @override
  String get recipe_flat_white => 'フラットホワイト';

  @override
  String get recipe_capsule_house_blend => 'ハウスブレンドカプセル';

  @override
  String get recipe_ethiopian_pour_over => 'エチオピア ハンドドリップ';

  @override
  String get recipe_nitro_mocha => 'ニトロモカ';

  @override
  String get recipe_capsule_signature_reserve => 'シグネチャーリザーブカプセル';

  @override
  String get flavorAcidity => '酸味';

  @override
  String get flavorBody => 'コク';

  @override
  String get flavorAroma => '香り';

  @override
  String get flavorCaffeine => 'カフェイン';

  @override
  String hintTooLow(String attribute) {
    return '$attributeが低すぎます';
  }

  @override
  String hintTooHigh(String attribute) {
    return '$attributeが高すぎます';
  }

  @override
  String get hintOnTrack => 'いい感じです！';

  @override
  String recipeBestScore(int score) {
    return '最高: $score';
  }

  @override
  String recipeLastResult(int score, String hint) {
    return '前回のテスト: $score · $hint';
  }

  @override
  String get recipeCapsuleTag => 'カプセル';

  @override
  String unlockRecipe(String cost) {
    return '解放 · $cost';
  }

  @override
  String startTest(String cost) {
    return 'テスト · $cost';
  }

  @override
  String brewingRemaining(String time) {
    return '抽出中… $time';
  }

  @override
  String get anotherBrewActive => '別のテストを実行中です';

  @override
  String get openRecipe => '開発する';

  @override
  String get capsuleTitle => 'カプセルマシン';

  @override
  String capsuleLocked(int score, int hype) {
    return '$score点以上のレシピとブランド人気$hypeが必要';
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
    return 'ブランド人気: $hype';
  }

  @override
  String labBonusValue(int percent) {
    return '研究ボーナス: +$percent%';
  }

  @override
  String get flavorProfileTitle => 'フレーバープロフィール';

  @override
  String get city_new_york => 'ニューヨーク';

  @override
  String get city_tokyo => '東京';

  @override
  String get city_london => 'ロンドン';

  @override
  String get city_istanbul => 'イスタンブール';

  @override
  String get city_sao_paulo => 'サンパウロ';

  @override
  String get city_paris => 'パリ';

  @override
  String get city_dubai => 'ドバイ';

  @override
  String get city_shanghai => '上海';

  @override
  String get city_mexico_city => 'メキシコシティ';

  @override
  String get city_seoul => 'ソウル';

  @override
  String get city_berlin => 'ベルリン';

  @override
  String get city_madrid => 'マドリード';

  @override
  String get city_rome => 'ローマ';

  @override
  String get city_toronto => 'トロント';

  @override
  String get city_sydney => 'シドニー';

  @override
  String get city_mumbai => 'ムンバイ';

  @override
  String get city_cairo => 'カイロ';

  @override
  String get city_jakarta => 'ジャカルタ';

  @override
  String get city_amsterdam => 'アムステルダム';

  @override
  String get city_singapore => 'シンガポール';

  @override
  String get city_bangkok => 'バンコク';

  @override
  String get city_buenos_aires => 'ブエノスアイレス';

  @override
  String get city_bogota => 'ボゴタ';

  @override
  String get city_lagos => 'ラゴス';

  @override
  String get city_vienna => 'ウィーン';

  @override
  String get city_lisbon => 'リスボン';

  @override
  String get city_reykjavik => 'レイキャビク';

  @override
  String get city_addis_ababa => 'アディスアベバ';

  @override
  String get city_nairobi => 'ナイロビ';

  @override
  String get city_hanoi => 'ハノイ';

  @override
  String get country_US => 'アメリカ合衆国';

  @override
  String get country_JP => '日本';

  @override
  String get country_GB => 'イギリス';

  @override
  String get country_TR => 'トルコ';

  @override
  String get country_BR => 'ブラジル';

  @override
  String get country_FR => 'フランス';

  @override
  String get country_AE => 'アラブ首長国連邦';

  @override
  String get country_CN => '中国';

  @override
  String get country_MX => 'メキシコ';

  @override
  String get country_KR => '韓国';

  @override
  String get country_DE => 'ドイツ';

  @override
  String get country_ES => 'スペイン';

  @override
  String get country_IT => 'イタリア';

  @override
  String get country_CA => 'カナダ';

  @override
  String get country_AU => 'オーストラリア';

  @override
  String get country_IN => 'インド';

  @override
  String get country_EG => 'エジプト';

  @override
  String get country_ID => 'インドネシア';

  @override
  String get country_NL => 'オランダ';

  @override
  String get country_SG => 'シンガポール';

  @override
  String get country_TH => 'タイ';

  @override
  String get country_AR => 'アルゼンチン';

  @override
  String get country_CO => 'コロンビア';

  @override
  String get country_NG => 'ナイジェリア';

  @override
  String get country_AT => 'オーストリア';

  @override
  String get country_PT => 'ポルトガル';

  @override
  String get country_IS => 'アイスランド';

  @override
  String get country_ET => 'エチオピア';

  @override
  String get country_KE => 'ケニア';

  @override
  String get country_VN => 'ベトナム';

  @override
  String get region_europe => 'ヨーロッパ';

  @override
  String get region_asia_pacific => 'アジア太平洋';

  @override
  String get region_americas => '南北アメリカ';

  @override
  String get region_mea => '中東・アフリカ';

  @override
  String get franchiseTitle => 'フランチャイズ';

  @override
  String franchiseRoyalty(String amount) {
    return 'ロイヤリティ: $amount/秒';
  }

  @override
  String franchisePerSlot(String amount) {
    return '1枠あたり +$amount/秒';
  }

  @override
  String franchiseRequiresHype(int hype) {
    return 'ブランド人気$hypeが必要';
  }

  @override
  String franchiseOpen(String cost) {
    return '出店 · $cost';
  }

  @override
  String franchiseComplete(String multiplier) {
    return '都市コンプリート ×$multiplier';
  }

  @override
  String get prestigeTitle => 'ゴールデンビーン';

  @override
  String prestigeOwned(int beans, String multiplier) {
    return 'ゴールデンビーン$beans個 · 収入×$multiplier';
  }

  @override
  String prestigeProgress(String earned, String threshold) {
    return '今回の収益 $earned / $threshold';
  }

  @override
  String prestigeButton(int beans) {
    return '帝国を売却 · +$beans';
  }

  @override
  String get prestigeConfirmTitle => '新しい帝国を始めますか？';

  @override
  String prestigeConfirmBody(int beans, String multiplier) {
    return 'ゴールデンビーンを$beans個獲得します。収入倍率は×$multiplierになります。店舗、店長、設備、カプセルマシン、フランチャイズはリセットされます。';
  }

  @override
  String get confirm => '確認';

  @override
  String get cancel => 'キャンセル';

  @override
  String get offlineTitle => 'おかえりなさい！';

  @override
  String offlineBody(String duration, String amount) {
    return '$durationの不在中に、帝国は$amountを稼ぎました。';
  }

  @override
  String get offlineCollect => '受け取る';

  @override
  String get offlineCollectDouble => '広告を見て2倍受け取る';

  @override
  String get adPlaying => '広告を再生中…';

  @override
  String get notificationChannelName => 'コーヒーのお知らせ';

  @override
  String get notifOfflineTitle => '店舗が満杯です！';

  @override
  String get notifOfflineBody => 'オフライン収益が上限に達しました。戻って受け取りましょう。';

  @override
  String get notifDailyTitle => 'デイリー報酬の準備完了';

  @override
  String get notifDailyBody => '毎日のコーヒーボーナスが待っています。';

  @override
  String get notifRushTitle => 'カフェインラッシュ終了';

  @override
  String get notifRushBody => 'もう一度広告を見て収入2倍を続けましょう。';

  @override
  String get rewardedTitle => '無料ブースト';

  @override
  String get rewardCaffeineRushTitle => 'カフェインラッシュ';

  @override
  String get rewardCaffeineRushBody => '4時間すべての収入×2（最大8時間）';

  @override
  String get rewardEmergencyFundTitle => '緊急資金';

  @override
  String rewardEmergencyFundBody(String amount) {
    return '$amountを今すぐ獲得';
  }

  @override
  String get rewardLabSpeedupTitle => 'ラボ加速';

  @override
  String get rewardLabSpeedupBody => '実行中の研究テストを今すぐ完了';

  @override
  String get watchAd => '広告を見る';

  @override
  String readyIn(String time) {
    return 'あと$time';
  }

  @override
  String get unavailable => '利用不可';

  @override
  String boostActive(String multiplier, String time) {
    return '×$multiplier $time';
  }

  @override
  String get shopTitle => 'プレミアム';

  @override
  String get vipTitle => 'マスターロースターVIP';

  @override
  String get vipBody => '永久に収入×2、オフライン上限12時間、自動タップするバリスタ';

  @override
  String get starterPackTitle => 'エスプレッソ スターターパック';

  @override
  String get starterPackBody => '永久に収入×1.25、さらに2時間分の収入を現金で';

  @override
  String get timeSkipTitle => '24時間スキップ';

  @override
  String timeSkipBody(String amount) {
    return '$amountを今すぐ獲得';
  }

  @override
  String get buyProduct => '購入';

  @override
  String get owned => '購入済み';

  @override
  String get restorePurchases => '購入を復元';

  @override
  String get noForcedAds => '強制広告なし — リワード広告はいつでも任意です。';

  @override
  String get dailyRewardTitle => 'デイリー報酬';

  @override
  String dailyRewardDay(int day) {
    return '$day日目';
  }

  @override
  String dailyRewardClaim(String amount) {
    return '$amountを受け取る';
  }

  @override
  String dailyRewardNext(String time) {
    return '次の報酬まで$time';
  }

  @override
  String dailyRewardBean(int beans) {
    return 'ゴールデンビーン+$beans';
  }

  @override
  String tutorialTitle(int step, int total) {
    return 'バリスタ研修 $step/$total';
  }

  @override
  String get tutorialStepBuyFirstShop => '店舗タブで屋台を購入しましょう。';

  @override
  String get tutorialStepBuySecondShop => '2店舗目の街角スタンドを開きましょう。';

  @override
  String get tutorialStepHireManager => '店長を雇って店舗の収入を3倍にしましょう。';

  @override
  String get tutorialStepOpenLab => '研究開発タブを開いてレシピを見つけましょう。';

  @override
  String get tutorialStepFinish => '帝国を築く準備ができました！報酬を逃さないようリマインダーをオンにしましょう。';

  @override
  String get tutorialSkip => 'スキップ';

  @override
  String get tutorialFinish => '始めよう！';

  @override
  String get achievementsTitle => '実績';

  @override
  String achievementsProgress(int unlocked, int total, int percent) {
    return '$unlocked/$total解除 · 収入+$percent%';
  }

  @override
  String achievementUnlocked(String name) {
    return '実績解除: $name';
  }

  @override
  String achDescLifetime(String amount) {
    return '累計$amountを稼ぐ';
  }

  @override
  String achDescShopLevel(int level) {
    return 'いずれかの店舗をLv.$levelにする';
  }

  @override
  String achDescRecipes(int score, int count) {
    return '$count個のレシピで$score点以上を取る';
  }

  @override
  String achDescFranchises(int count) {
    return 'フランチャイズ枠を$count個所有する';
  }

  @override
  String achDescPrestige(int count) {
    return '新しい帝国を$count回始める';
  }

  @override
  String achDescTaps(int count) {
    return 'カップを$count回タップする';
  }

  @override
  String get achievement_first_dollars => '最初の1ドル';

  @override
  String get achievement_small_business => '小さな商売';

  @override
  String get achievement_coffee_mogul => 'コーヒー王';

  @override
  String get achievement_bean_tycoon => '豆の大富豪';

  @override
  String get achievement_caffeine_empire => 'カフェイン帝国';

  @override
  String get achievement_growing_shop => '成長する店';

  @override
  String get achievement_busy_counter => 'にぎわうカウンター';

  @override
  String get achievement_centurion => '百人隊長';

  @override
  String get achievement_legendary_branch => '伝説の支店';

  @override
  String get achievement_first_masterpiece => '最初の傑作';

  @override
  String get achievement_lab_regular => 'ラボの常連';

  @override
  String get achievement_master_brewer => 'マスターブリュワー';

  @override
  String get achievement_first_franchise => '初のフランチャイズ';

  @override
  String get achievement_regional_brand => '地域ブランド';

  @override
  String get achievement_global_chain => 'グローバルチェーン';

  @override
  String get achievement_world_domination => '世界制覇';

  @override
  String get achievement_fresh_start => '新たな出発';

  @override
  String get achievement_serial_founder => '連続創業者';

  @override
  String get achievement_eager_barista => 'やる気のバリスタ';

  @override
  String get achievement_tireless_barista => '不屈のバリスタ';

  @override
  String get settingsTitle => '設定';

  @override
  String get settingsLanguage => '言語';

  @override
  String get languageSystem => 'システム';

  @override
  String get settingsSound => 'サウンド';

  @override
  String get settingsHaptics => '振動';

  @override
  String get settingsNotifications => '通知';

  @override
  String get settingsScientific => '指数表記';

  @override
  String get settingsReset => '進行状況をリセット';

  @override
  String get resetConfirmTitle => 'すべての進行状況をリセットしますか？';

  @override
  String get resetConfirmBody => 'ゴールデンビーンや購入を含むセーブデータが削除されます。元に戻せません。';

  @override
  String get resetConfirm => 'リセット';

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
  String get stationUpgradesHint => 'タップで店長と設備';

  @override
  String get spriteGalleryTitle => 'スプライトギャラリー';

  @override
  String get tabCafe => 'カフェ';

  @override
  String get tutorialStepServeCustomer =>
      'カウンターのお客さんをタップして注文を受け、作ったらもう一度タップして提供しよう。';

  @override
  String brewPanelTitle(String drink) {
    return '抽出中：$drink';
  }

  @override
  String get serveHint => 'できあがり！お客さんをタップして提供しよう。';

  @override
  String get perfectServe => 'パーフェクト！';

  @override
  String get drink_espresso => 'エスプレッソ';

  @override
  String get drink_americano => 'アメリカーノ';

  @override
  String get drink_latte => 'ラテ';

  @override
  String get drink_cappuccino => 'カプチーノ';

  @override
  String get drink_mocha => 'モカ';

  @override
  String get drink_cold_brew => 'コールドブリュー';
}
