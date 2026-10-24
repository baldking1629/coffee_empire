// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'Coffee Empire';

  @override
  String durationDays(int value) {
    return '$value일';
  }

  @override
  String durationHours(int value) {
    return '$value시간';
  }

  @override
  String durationMinutes(int value) {
    return '$value분';
  }

  @override
  String durationSeconds(int value) {
    return '$value초';
  }

  @override
  String get tabShops => '매장';

  @override
  String get tabLab => '연구개발';

  @override
  String get tabGrowth => '성장';

  @override
  String get tabStore => '상점';

  @override
  String incomePerSecond(String amount) {
    return '$amount/초';
  }

  @override
  String comboLabel(int count) {
    return '콤보 x$count';
  }

  @override
  String get baristaRush => '바리스타 러시!';

  @override
  String get tapToBrew => '컵을 탭해 추출하세요';

  @override
  String cupSemanticLabel(int percent) {
    return '커피잔, $percent% 채워짐';
  }

  @override
  String get shop_street_cart => '길거리 카트';

  @override
  String get shop_corner_booth => '코너 부스';

  @override
  String get shop_boutique_cafe => '부티크 카페';

  @override
  String get shop_campus_coworking => '캠퍼스 코워킹';

  @override
  String get shop_drive_thru => '드라이브스루';

  @override
  String get shop_city_roastery => '시티 로스터리';

  @override
  String get shop_airport_lounge => '공항 라운지';

  @override
  String get shop_robotic_kiosk => '로봇 키오스크';

  @override
  String get shop_capsule_store => '캡슐 스토어';

  @override
  String get shop_global_mega_roastery => '글로벌 메가 로스터리';

  @override
  String get buyAmountOne => 'x1';

  @override
  String get buyAmountTen => 'x10';

  @override
  String get buyAmountMax => '최대';

  @override
  String get managerHired => '매니저 고용됨';

  @override
  String get milestoneMaxed => '모든 마일스톤 달성';

  @override
  String get equipmentEspressoMachine => '에스프레소 머신';

  @override
  String get equipmentDiamondGrinder => '다이아몬드 그라인더';

  @override
  String get equipmentSmartSystem => '스마트 시스템';

  @override
  String shopLevel(int level) {
    return 'Lv. $level';
  }

  @override
  String buyLevels(int count, String cost) {
    return 'x$count 구매 · $cost';
  }

  @override
  String hireManager(String cost) {
    return '매니저 고용 · $cost';
  }

  @override
  String buyEquipment(String name, String cost) {
    return '$name · $cost';
  }

  @override
  String nextMilestone(int level) {
    return 'Lv. $level에서 수입 ×2';
  }

  @override
  String shopLocked(String shop) {
    return '$shop 구매 후 잠금 해제';
  }

  @override
  String equipmentAllOwned(String name) {
    return '$name · 보유 중';
  }

  @override
  String get recipe_espresso_classic => '클래식 에스프레소';

  @override
  String get recipe_cappuccino => '카푸치노';

  @override
  String get recipe_cold_brew => '콜드브루';

  @override
  String get recipe_flat_white => '플랫 화이트';

  @override
  String get recipe_capsule_house_blend => '하우스 블렌드 캡슐';

  @override
  String get recipe_ethiopian_pour_over => '에티오피아 핸드드립';

  @override
  String get recipe_nitro_mocha => '니트로 모카';

  @override
  String get recipe_capsule_signature_reserve => '시그니처 리저브 캡슐';

  @override
  String get flavorAcidity => '산미';

  @override
  String get flavorBody => '바디감';

  @override
  String get flavorAroma => '향';

  @override
  String get flavorCaffeine => '카페인';

  @override
  String hintTooLow(String attribute) {
    return '$attribute이(가) 너무 낮아요';
  }

  @override
  String hintTooHigh(String attribute) {
    return '$attribute이(가) 너무 높아요';
  }

  @override
  String get hintOnTrack => '잘하고 있어요!';

  @override
  String recipeBestScore(int score) {
    return '최고: $score';
  }

  @override
  String recipeLastResult(int score, String hint) {
    return '최근 테스트: $score · $hint';
  }

  @override
  String get recipeCapsuleTag => '캡슐';

  @override
  String unlockRecipe(String cost) {
    return '잠금 해제 · $cost';
  }

  @override
  String startTest(String cost) {
    return '테스트 · $cost';
  }

  @override
  String brewingRemaining(String time) {
    return '추출 중… $time';
  }

  @override
  String get anotherBrewActive => '다른 테스트가 진행 중입니다';

  @override
  String get openRecipe => '개발하기';

  @override
  String get capsuleTitle => '캡슐 머신';

  @override
  String capsuleLocked(int score, int hype) {
    return '$score점 이상 레시피와 브랜드 인지도 $hype 필요';
  }

  @override
  String capsuleOwned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count대',
    );
    return '$_temp0';
  }

  @override
  String brandHypeValue(int hype) {
    return '브랜드 인지도: $hype';
  }

  @override
  String labBonusValue(int percent) {
    return '연구 보너스: +$percent%';
  }

  @override
  String get flavorProfileTitle => '풍미 프로필';

  @override
  String get city_new_york => '뉴욕';

  @override
  String get city_tokyo => '도쿄';

  @override
  String get city_london => '런던';

  @override
  String get city_istanbul => '이스탄불';

  @override
  String get city_sao_paulo => '상파울루';

  @override
  String get city_paris => '파리';

  @override
  String get city_dubai => '두바이';

  @override
  String get city_shanghai => '상하이';

  @override
  String get city_mexico_city => '멕시코시티';

  @override
  String get city_seoul => '서울';

  @override
  String get city_berlin => '베를린';

  @override
  String get city_madrid => '마드리드';

  @override
  String get city_rome => '로마';

  @override
  String get city_toronto => '토론토';

  @override
  String get city_sydney => '시드니';

  @override
  String get city_mumbai => '뭄바이';

  @override
  String get city_cairo => '카이로';

  @override
  String get city_jakarta => '자카르타';

  @override
  String get city_amsterdam => '암스테르담';

  @override
  String get city_singapore => '싱가포르';

  @override
  String get city_bangkok => '방콕';

  @override
  String get city_buenos_aires => '부에노스아이레스';

  @override
  String get city_bogota => '보고타';

  @override
  String get city_lagos => '라고스';

  @override
  String get city_vienna => '빈';

  @override
  String get city_lisbon => '리스본';

  @override
  String get city_reykjavik => '레이캬비크';

  @override
  String get city_addis_ababa => '아디스아바바';

  @override
  String get city_nairobi => '나이로비';

  @override
  String get city_hanoi => '하노이';

  @override
  String get country_US => '미국';

  @override
  String get country_JP => '일본';

  @override
  String get country_GB => '영국';

  @override
  String get country_TR => '튀르키예';

  @override
  String get country_BR => '브라질';

  @override
  String get country_FR => '프랑스';

  @override
  String get country_AE => '아랍에미리트';

  @override
  String get country_CN => '중국';

  @override
  String get country_MX => '멕시코';

  @override
  String get country_KR => '대한민국';

  @override
  String get country_DE => '독일';

  @override
  String get country_ES => '스페인';

  @override
  String get country_IT => '이탈리아';

  @override
  String get country_CA => '캐나다';

  @override
  String get country_AU => '오스트레일리아';

  @override
  String get country_IN => '인도';

  @override
  String get country_EG => '이집트';

  @override
  String get country_ID => '인도네시아';

  @override
  String get country_NL => '네덜란드';

  @override
  String get country_SG => '싱가포르';

  @override
  String get country_TH => '태국';

  @override
  String get country_AR => '아르헨티나';

  @override
  String get country_CO => '콜롬비아';

  @override
  String get country_NG => '나이지리아';

  @override
  String get country_AT => '오스트리아';

  @override
  String get country_PT => '포르투갈';

  @override
  String get country_IS => '아이슬란드';

  @override
  String get country_ET => '에티오피아';

  @override
  String get country_KE => '케냐';

  @override
  String get country_VN => '베트남';

  @override
  String get region_europe => '유럽';

  @override
  String get region_asia_pacific => '아시아·태평양';

  @override
  String get region_americas => '아메리카';

  @override
  String get region_mea => '중동·아프리카';

  @override
  String get franchiseTitle => '프랜차이즈';

  @override
  String franchiseRoyalty(String amount) {
    return '로열티: $amount/초';
  }

  @override
  String franchisePerSlot(String amount) {
    return '슬롯당 +$amount/초';
  }

  @override
  String franchiseRequiresHype(int hype) {
    return '브랜드 인지도 $hype 필요';
  }

  @override
  String franchiseOpen(String cost) {
    return '개점 · $cost';
  }

  @override
  String franchiseComplete(String multiplier) {
    return '도시 완성 ×$multiplier';
  }

  @override
  String get prestigeTitle => '황금 원두';

  @override
  String prestigeOwned(int beans, String multiplier) {
    return '황금 원두 $beans개 · 수입 ×$multiplier';
  }

  @override
  String prestigeProgress(String earned, String threshold) {
    return '이번 회차 수익 $earned / $threshold';
  }

  @override
  String prestigeButton(int beans) {
    return '제국 매각 · +$beans';
  }

  @override
  String get prestigeConfirmTitle => '새 제국을 시작할까요?';

  @override
  String prestigeConfirmBody(int beans, String multiplier) {
    return '황금 원두 $beans개를 얻습니다. 수입 배수가 ×$multiplier가 됩니다. 매장, 매니저, 장비, 캡슐 머신, 프랜차이즈가 초기화됩니다.';
  }

  @override
  String get confirm => '확인';

  @override
  String get cancel => '취소';

  @override
  String get offlineTitle => '다시 오신 걸 환영해요!';

  @override
  String offlineBody(String duration, String amount) {
    return '$duration 동안 자리를 비운 사이 제국이 $amount를 벌었습니다.';
  }

  @override
  String get offlineCollect => '받기';

  @override
  String get offlineCollectDouble => '광고 보고 2배 받기';

  @override
  String get adPlaying => '광고 재생 중…';

  @override
  String get notificationChannelName => '커피 알림';

  @override
  String get notifOfflineTitle => '매장이 가득 찼어요!';

  @override
  String get notifOfflineBody => '오프라인 수익이 한도에 도달했습니다. 돌아와서 받으세요.';

  @override
  String get notifDailyTitle => '일일 보상 준비 완료';

  @override
  String get notifDailyBody => '오늘의 커피 보너스가 기다리고 있어요.';

  @override
  String get notifRushTitle => '카페인 러시 종료';

  @override
  String get notifRushBody => '광고를 하나 더 보고 수입 2배를 유지하세요.';

  @override
  String get rewardedTitle => '무료 부스트';

  @override
  String get rewardCaffeineRushTitle => '카페인 러시';

  @override
  String get rewardCaffeineRushBody => '4시간 동안 모든 수입 ×2 (최대 8시간)';

  @override
  String get rewardEmergencyFundTitle => '비상 자금';

  @override
  String rewardEmergencyFundBody(String amount) {
    return '$amount 즉시 받기';
  }

  @override
  String get rewardLabSpeedupTitle => '연구소 가속';

  @override
  String get rewardLabSpeedupBody => '진행 중인 연구 테스트를 즉시 완료';

  @override
  String get watchAd => '광고 보기';

  @override
  String readyIn(String time) {
    return '$time 후 가능';
  }

  @override
  String get unavailable => '사용 불가';

  @override
  String boostActive(String multiplier, String time) {
    return '×$multiplier $time';
  }

  @override
  String get shopTitle => '프리미엄';

  @override
  String get vipTitle => '마스터 로스터 VIP';

  @override
  String get vipBody => '영구 수입 ×2, 12시간 오프라인 한도, 자동으로 탭하는 바리스타';

  @override
  String get starterPackTitle => '에스프레소 스타터 팩';

  @override
  String get starterPackBody => '영구 수입 ×1.25와 2시간 분량의 수입을 현금으로';

  @override
  String get timeSkipTitle => '24시간 건너뛰기';

  @override
  String timeSkipBody(String amount) {
    return '$amount 즉시 받기';
  }

  @override
  String get buyProduct => '구매';

  @override
  String get owned => '보유 중';

  @override
  String get restorePurchases => '구매 복원';

  @override
  String get noForcedAds => '강제 광고 없음 — 보상형 광고는 언제나 선택 사항입니다.';

  @override
  String get dailyRewardTitle => '일일 보상';

  @override
  String dailyRewardDay(int day) {
    return '$day일차';
  }

  @override
  String dailyRewardClaim(String amount) {
    return '$amount 받기';
  }

  @override
  String dailyRewardNext(String time) {
    return '다음 보상까지 $time';
  }

  @override
  String dailyRewardBean(int beans) {
    return '황금 원두 +$beans';
  }

  @override
  String tutorialTitle(int step, int total) {
    return '바리스타 교육 $step/$total';
  }

  @override
  String get tutorialStepTapCup => '커피잔을 탭해 첫 잔을 추출하세요.';

  @override
  String get tutorialStepBuyFirstShop => '매장 탭에서 길거리 카트를 구매하세요.';

  @override
  String get tutorialStepBuySecondShop => '두 번째 매장인 코너 부스를 여세요.';

  @override
  String get tutorialStepHireManager => '매니저를 고용해 매장 수입을 3배로 늘리세요.';

  @override
  String get tutorialStepOpenLab => '연구개발 탭을 열어 레시피를 찾아보세요.';

  @override
  String get tutorialStepFinish => '제국을 세울 준비가 됐어요! 보상을 놓치지 않도록 알림을 켜세요.';

  @override
  String get tutorialSkip => '건너뛰기';

  @override
  String get tutorialFinish => '시작하기!';

  @override
  String get achievementsTitle => '업적';

  @override
  String achievementsProgress(int unlocked, int total, int percent) {
    return '$unlocked/$total 달성 · 수입 +$percent%';
  }

  @override
  String achievementUnlocked(String name) {
    return '업적 달성: $name';
  }

  @override
  String achDescLifetime(String amount) {
    return '총 $amount 벌기';
  }

  @override
  String achDescShopLevel(int level) {
    return '아무 매장이나 Lv. $level 달성';
  }

  @override
  String achDescRecipes(int score, int count) {
    return '레시피 $count개에서 $score점 이상 받기';
  }

  @override
  String achDescFranchises(int count) {
    return '프랜차이즈 슬롯 $count개 보유';
  }

  @override
  String achDescPrestige(int count) {
    return '새 제국을 $count번 시작';
  }

  @override
  String achDescTaps(int count) {
    return '컵을 $count번 탭하기';
  }

  @override
  String get achievement_first_dollars => '첫 달러';

  @override
  String get achievement_small_business => '작은 사업';

  @override
  String get achievement_coffee_mogul => '커피 거물';

  @override
  String get achievement_bean_tycoon => '원두 재벌';

  @override
  String get achievement_caffeine_empire => '카페인 제국';

  @override
  String get achievement_growing_shop => '성장하는 매장';

  @override
  String get achievement_busy_counter => '바쁜 카운터';

  @override
  String get achievement_centurion => '백인대장';

  @override
  String get achievement_legendary_branch => '전설의 지점';

  @override
  String get achievement_first_masterpiece => '첫 걸작';

  @override
  String get achievement_lab_regular => '연구소 단골';

  @override
  String get achievement_master_brewer => '마스터 브루어';

  @override
  String get achievement_first_franchise => '첫 프랜차이즈';

  @override
  String get achievement_regional_brand => '지역 브랜드';

  @override
  String get achievement_global_chain => '글로벌 체인';

  @override
  String get achievement_world_domination => '세계 정복';

  @override
  String get achievement_fresh_start => '새 출발';

  @override
  String get achievement_serial_founder => '연쇄 창업가';

  @override
  String get achievement_eager_barista => '열정 바리스타';

  @override
  String get achievement_tireless_barista => '지치지 않는 바리스타';

  @override
  String get settingsTitle => '설정';

  @override
  String get settingsLanguage => '언어';

  @override
  String get languageSystem => '시스템';

  @override
  String get settingsSound => '소리';

  @override
  String get settingsHaptics => '진동';

  @override
  String get settingsNotifications => '알림';

  @override
  String get settingsScientific => '과학적 표기법';

  @override
  String get settingsReset => '진행 상황 초기화';

  @override
  String get resetConfirmTitle => '모든 진행 상황을 초기화할까요?';

  @override
  String get resetConfirmBody => '황금 원두와 구매 내역을 포함한 저장 데이터가 삭제됩니다. 되돌릴 수 없습니다.';

  @override
  String get resetConfirm => '초기화';

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
  String get stationUpgradesHint => '탭하여 매니저와 장비 보기';

  @override
  String get spriteGalleryTitle => '스프라이트 갤러리';
}
