// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Coffee Empire';

  @override
  String durationDays(int value) {
    return '$value д';
  }

  @override
  String durationHours(int value) {
    return '$value ч';
  }

  @override
  String durationMinutes(int value) {
    return '$value мин';
  }

  @override
  String durationSeconds(int value) {
    return '$value с';
  }

  @override
  String get tabShops => 'Кофейни';

  @override
  String get tabLab => 'НИОКР';

  @override
  String get tabGrowth => 'Рост';

  @override
  String get tabStore => 'Магазин';

  @override
  String incomePerSecond(String amount) {
    return '$amount/с';
  }

  @override
  String comboLabel(int count) {
    return 'Комбо x$count';
  }

  @override
  String get baristaRush => 'Бариста-раш!';

  @override
  String get tapToBrew => 'Нажмите на чашку, чтобы сварить';

  @override
  String cupSemanticLabel(int percent) {
    return 'Чашка кофе, заполнена на $percent%';
  }

  @override
  String get shop_street_cart => 'Уличная тележка';

  @override
  String get shop_corner_booth => 'Угловой киоск';

  @override
  String get shop_boutique_cafe => 'Бутик-кафе';

  @override
  String get shop_campus_coworking => 'Коворкинг кампуса';

  @override
  String get shop_drive_thru => 'Драйв-тру';

  @override
  String get shop_city_roastery => 'Городская обжарка';

  @override
  String get shop_airport_lounge => 'Лаунж аэропорта';

  @override
  String get shop_robotic_kiosk => 'Робо-киоск';

  @override
  String get shop_capsule_store => 'Магазин капсул';

  @override
  String get shop_global_mega_roastery => 'Глобальная мегаобжарка';

  @override
  String get buyAmountOne => 'x1';

  @override
  String get buyAmountTen => 'x10';

  @override
  String get buyAmountMax => 'МАКС';

  @override
  String get managerHired => 'Менеджер нанят';

  @override
  String get milestoneMaxed => 'Все рубежи достигнуты';

  @override
  String get equipmentEspressoMachine => 'Эспрессо-машина';

  @override
  String get equipmentDiamondGrinder => 'Алмазная кофемолка';

  @override
  String get equipmentSmartSystem => 'Умная система';

  @override
  String shopLevel(int level) {
    return 'Ур. $level';
  }

  @override
  String buyLevels(int count, String cost) {
    return 'Купить x$count · $cost';
  }

  @override
  String hireManager(String cost) {
    return 'Нанять менеджера · $cost';
  }

  @override
  String buyEquipment(String name, String cost) {
    return '$name · $cost';
  }

  @override
  String nextMilestone(int level) {
    return 'Доход ×2 на ур. $level';
  }

  @override
  String shopLocked(String shop) {
    return 'Откроется после покупки: $shop';
  }

  @override
  String equipmentAllOwned(String name) {
    return '$name · Куплено';
  }

  @override
  String get recipe_espresso_classic => 'Классический эспрессо';

  @override
  String get recipe_cappuccino => 'Капучино';

  @override
  String get recipe_cold_brew => 'Колд брю';

  @override
  String get recipe_flat_white => 'Флэт уайт';

  @override
  String get recipe_capsule_house_blend => 'Капсула «Фирменная смесь»';

  @override
  String get recipe_ethiopian_pour_over => 'Эфиопский пуровер';

  @override
  String get recipe_nitro_mocha => 'Нитро-мокко';

  @override
  String get recipe_capsule_signature_reserve => 'Капсула «Резерв»';

  @override
  String get flavorAcidity => 'Кислотность';

  @override
  String get flavorBody => 'Плотность';

  @override
  String get flavorAroma => 'Аромат';

  @override
  String get flavorCaffeine => 'Кофеин';

  @override
  String hintTooLow(String attribute) {
    return '$attribute: слишком мало';
  }

  @override
  String hintTooHigh(String attribute) {
    return '$attribute: слишком много';
  }

  @override
  String get hintOnTrack => 'Вы на верном пути!';

  @override
  String recipeBestScore(int score) {
    return 'Рекорд: $score';
  }

  @override
  String recipeLastResult(int score, String hint) {
    return 'Последний тест: $score · $hint';
  }

  @override
  String get recipeCapsuleTag => 'Капсула';

  @override
  String unlockRecipe(String cost) {
    return 'Открыть · $cost';
  }

  @override
  String startTest(String cost) {
    return 'Тест · $cost';
  }

  @override
  String brewingRemaining(String time) {
    return 'Варится… $time';
  }

  @override
  String get anotherBrewActive => 'Уже идёт другой тест';

  @override
  String get openRecipe => 'Разработать';

  @override
  String get capsuleTitle => 'Капсульные машины';

  @override
  String capsuleLocked(int score, int hype) {
    return 'Нужен рецепт на $score+ и $hype узнаваемости бренда';
  }

  @override
  String capsuleOwned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count машины',
      many: '$count машин',
      few: '$count машины',
      one: '$count машина',
    );
    return '$_temp0';
  }

  @override
  String brandHypeValue(int hype) {
    return 'Узнаваемость бренда: $hype';
  }

  @override
  String labBonusValue(int percent) {
    return 'Бонус НИОКР: +$percent%';
  }

  @override
  String get flavorProfileTitle => 'Вкусовой профиль';

  @override
  String get city_new_york => 'Нью-Йорк';

  @override
  String get city_tokyo => 'Токио';

  @override
  String get city_london => 'Лондон';

  @override
  String get city_istanbul => 'Стамбул';

  @override
  String get city_sao_paulo => 'Сан-Паулу';

  @override
  String get city_paris => 'Париж';

  @override
  String get city_dubai => 'Дубай';

  @override
  String get city_shanghai => 'Шанхай';

  @override
  String get city_mexico_city => 'Мехико';

  @override
  String get city_seoul => 'Сеул';

  @override
  String get city_berlin => 'Берлин';

  @override
  String get city_madrid => 'Мадрид';

  @override
  String get city_rome => 'Рим';

  @override
  String get city_toronto => 'Торонто';

  @override
  String get city_sydney => 'Сидней';

  @override
  String get city_mumbai => 'Мумбаи';

  @override
  String get city_cairo => 'Каир';

  @override
  String get city_jakarta => 'Джакарта';

  @override
  String get city_amsterdam => 'Амстердам';

  @override
  String get city_singapore => 'Сингапур';

  @override
  String get city_bangkok => 'Бангкок';

  @override
  String get city_buenos_aires => 'Буэнос-Айрес';

  @override
  String get city_bogota => 'Богота';

  @override
  String get city_lagos => 'Лагос';

  @override
  String get city_vienna => 'Вена';

  @override
  String get city_lisbon => 'Лиссабон';

  @override
  String get city_reykjavik => 'Рейкьявик';

  @override
  String get city_addis_ababa => 'Аддис-Абеба';

  @override
  String get city_nairobi => 'Найроби';

  @override
  String get city_hanoi => 'Ханой';

  @override
  String get country_US => 'США';

  @override
  String get country_JP => 'Япония';

  @override
  String get country_GB => 'Великобритания';

  @override
  String get country_TR => 'Турция';

  @override
  String get country_BR => 'Бразилия';

  @override
  String get country_FR => 'Франция';

  @override
  String get country_AE => 'ОАЭ';

  @override
  String get country_CN => 'Китай';

  @override
  String get country_MX => 'Мексика';

  @override
  String get country_KR => 'Южная Корея';

  @override
  String get country_DE => 'Германия';

  @override
  String get country_ES => 'Испания';

  @override
  String get country_IT => 'Италия';

  @override
  String get country_CA => 'Канада';

  @override
  String get country_AU => 'Австралия';

  @override
  String get country_IN => 'Индия';

  @override
  String get country_EG => 'Египет';

  @override
  String get country_ID => 'Индонезия';

  @override
  String get country_NL => 'Нидерланды';

  @override
  String get country_SG => 'Сингапур';

  @override
  String get country_TH => 'Таиланд';

  @override
  String get country_AR => 'Аргентина';

  @override
  String get country_CO => 'Колумбия';

  @override
  String get country_NG => 'Нигерия';

  @override
  String get country_AT => 'Австрия';

  @override
  String get country_PT => 'Португалия';

  @override
  String get country_IS => 'Исландия';

  @override
  String get country_ET => 'Эфиопия';

  @override
  String get country_KE => 'Кения';

  @override
  String get country_VN => 'Вьетнам';

  @override
  String get region_europe => 'Европа';

  @override
  String get region_asia_pacific => 'Азия и Океания';

  @override
  String get region_americas => 'Америка';

  @override
  String get region_mea => 'Ближний Восток и Африка';

  @override
  String get franchiseTitle => 'Франшизы';

  @override
  String franchiseRoyalty(String amount) {
    return 'Роялти: $amount/с';
  }

  @override
  String franchisePerSlot(String amount) {
    return '+$amount/с за точку';
  }

  @override
  String franchiseRequiresHype(int hype) {
    return 'Нужно $hype узнаваемости бренда';
  }

  @override
  String franchiseOpen(String cost) {
    return 'Открыть · $cost';
  }

  @override
  String franchiseComplete(String multiplier) {
    return 'Город завершён ×$multiplier';
  }

  @override
  String get prestigeTitle => 'Золотые зёрна';

  @override
  String prestigeOwned(int beans, String multiplier) {
    return 'Золотых зёрен: $beans · доход ×$multiplier';
  }

  @override
  String prestigeProgress(String earned, String threshold) {
    return 'Доход за забег $earned / $threshold';
  }

  @override
  String prestigeButton(int beans) {
    return 'Продать империю · +$beans';
  }

  @override
  String get prestigeConfirmTitle => 'Начать новую империю?';

  @override
  String prestigeConfirmBody(int beans, String multiplier) {
    return 'Вы получите золотых зёрен: $beans. Множитель дохода станет ×$multiplier. Кофейни, менеджеры, оборудование, капсульные машины и франшизы будут сброшены.';
  }

  @override
  String get confirm => 'Подтвердить';

  @override
  String get cancel => 'Отмена';

  @override
  String get offlineTitle => 'С возвращением!';

  @override
  String offlineBody(String duration, String amount) {
    return 'Пока вас не было ($duration), ваша империя заработала $amount.';
  }

  @override
  String get offlineCollect => 'Забрать';

  @override
  String get offlineCollectDouble => 'Посмотреть рекламу, забрать x2';

  @override
  String get adPlaying => 'Идёт реклама…';

  @override
  String get notificationChannelName => 'Кофейные напоминания';

  @override
  String get notifOfflineTitle => 'Ваши кофейни переполнены!';

  @override
  String get notifOfflineBody =>
      'Офлайн-доход достиг предела. Вернитесь, чтобы забрать его.';

  @override
  String get notifDailyTitle => 'Ежедневная награда готова';

  @override
  String get notifDailyBody => 'Ваш ежедневный кофейный бонус ждёт.';

  @override
  String get notifRushTitle => 'Кофеиновый рывок закончился';

  @override
  String get notifRushBody =>
      'Посмотрите ещё одну рекламу, чтобы доход оставался удвоенным.';

  @override
  String get rewardedTitle => 'Бесплатные бусты';

  @override
  String get rewardCaffeineRushTitle => 'Кофеиновый рывок';

  @override
  String get rewardCaffeineRushBody => 'Весь доход ×2 на 4 часа (до 8 часов)';

  @override
  String get rewardEmergencyFundTitle => 'Резервный фонд';

  @override
  String rewardEmergencyFundBody(String amount) {
    return 'Мгновенно получите $amount';
  }

  @override
  String get rewardLabSpeedupTitle => 'Ускорение лаборатории';

  @override
  String get rewardLabSpeedupBody => 'Сразу завершить текущий тест НИОКР';

  @override
  String get watchAd => 'Смотреть';

  @override
  String readyIn(String time) {
    return 'Будет через $time';
  }

  @override
  String get unavailable => 'Недоступно';

  @override
  String boostActive(String multiplier, String time) {
    return '×$multiplier $time';
  }

  @override
  String get shopTitle => 'Премиум';

  @override
  String get vipTitle => 'VIP Мастер-обжарщик';

  @override
  String get vipBody =>
      'Постоянный доход ×2, офлайн-лимит 12 часов и бариста-автокликер';

  @override
  String get starterPackTitle => 'Стартовый набор «Эспрессо»';

  @override
  String get starterPackBody =>
      'Постоянный доход ×1,25 и доход за 2 часа наличными';

  @override
  String get timeSkipTitle => 'Перемотка на 24 ч';

  @override
  String timeSkipBody(String amount) {
    return 'Мгновенно получите $amount';
  }

  @override
  String get buyProduct => 'Купить';

  @override
  String get owned => 'Куплено';

  @override
  String get restorePurchases => 'Восстановить покупки';

  @override
  String get noForcedAds =>
      'Никакой навязчивой рекламы — реклама с наградой всегда по желанию.';

  @override
  String get dailyRewardTitle => 'Ежедневная награда';

  @override
  String dailyRewardDay(int day) {
    return 'День $day';
  }

  @override
  String dailyRewardClaim(String amount) {
    return 'Забрать $amount';
  }

  @override
  String dailyRewardNext(String time) {
    return 'Следующая награда через $time';
  }

  @override
  String dailyRewardBean(int beans) {
    return '+$beans золотое зерно';
  }

  @override
  String tutorialTitle(int step, int total) {
    return 'Обучение бариста $step/$total';
  }

  @override
  String get tutorialStepTapCup =>
      'Нажмите на чашку, чтобы сварить первый кофе.';

  @override
  String get tutorialStepBuyFirstShop =>
      'Купите уличную тележку во вкладке «Кофейни».';

  @override
  String get tutorialStepBuySecondShop =>
      'Откройте вторую точку: угловой киоск.';

  @override
  String get tutorialStepHireManager =>
      'Наймите менеджера, чтобы утроить доход кофейни.';

  @override
  String get tutorialStepOpenLab =>
      'Откройте вкладку НИОКР, чтобы найти рецепты.';

  @override
  String get tutorialStepFinish =>
      'Вы готовы строить империю! Включите напоминания, чтобы не пропускать награды.';

  @override
  String get tutorialSkip => 'Пропустить';

  @override
  String get tutorialFinish => 'Поехали!';

  @override
  String get achievementsTitle => 'Достижения';

  @override
  String achievementsProgress(int unlocked, int total, int percent) {
    return 'Открыто $unlocked/$total · доход +$percent%';
  }

  @override
  String achievementUnlocked(String name) {
    return 'Достижение открыто: $name';
  }

  @override
  String achDescLifetime(String amount) {
    return 'Заработайте всего $amount';
  }

  @override
  String achDescShopLevel(int level) {
    return 'Достигните $level уровня в любой кофейне';
  }

  @override
  String achDescRecipes(int score, int count) {
    return 'Наберите $score+ в рецептах: $count';
  }

  @override
  String achDescFranchises(int count) {
    return 'Владейте точками франшизы: $count';
  }

  @override
  String achDescPrestige(int count) {
    return 'Начните новую империю $count раз';
  }

  @override
  String achDescTaps(int count) {
    return 'Нажмите на чашку $count раз';
  }

  @override
  String get achievement_first_dollars => 'Первые доллары';

  @override
  String get achievement_small_business => 'Малый бизнес';

  @override
  String get achievement_coffee_mogul => 'Кофейный магнат';

  @override
  String get achievement_bean_tycoon => 'Зерновой король';

  @override
  String get achievement_caffeine_empire => 'Кофеиновая империя';

  @override
  String get achievement_growing_shop => 'Растущая кофейня';

  @override
  String get achievement_busy_counter => 'Оживлённая стойка';

  @override
  String get achievement_centurion => 'Центурион';

  @override
  String get achievement_legendary_branch => 'Легендарный филиал';

  @override
  String get achievement_first_masterpiece => 'Первый шедевр';

  @override
  String get achievement_lab_regular => 'Завсегдатай лаборатории';

  @override
  String get achievement_master_brewer => 'Мастер заваривания';

  @override
  String get achievement_first_franchise => 'Первая франшиза';

  @override
  String get achievement_regional_brand => 'Региональный бренд';

  @override
  String get achievement_global_chain => 'Глобальная сеть';

  @override
  String get achievement_world_domination => 'Мировое господство';

  @override
  String get achievement_fresh_start => 'Новый старт';

  @override
  String get achievement_serial_founder => 'Серийный основатель';

  @override
  String get achievement_eager_barista => 'Старательный бариста';

  @override
  String get achievement_tireless_barista => 'Неутомимый бариста';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsLanguage => 'Язык';

  @override
  String get languageSystem => 'Системный';

  @override
  String get settingsSound => 'Звук';

  @override
  String get settingsHaptics => 'Вибрация';

  @override
  String get settingsNotifications => 'Уведомления';

  @override
  String get settingsScientific => 'Научная запись';

  @override
  String get settingsReset => 'Сбросить прогресс';

  @override
  String get resetConfirmTitle => 'Сбросить весь прогресс?';

  @override
  String get resetConfirmBody =>
      'Это удалит сохранение, включая золотые зёрна и покупки. Отменить нельзя.';

  @override
  String get resetConfirm => 'Сбросить';

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
  String get stationUpgradesHint => 'Нажмите: менеджер и оборудование';

  @override
  String get spriteGalleryTitle => 'Галерея спрайтов';
}
