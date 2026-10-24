// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Coffee Empire';

  @override
  String durationDays(int value) {
    return '$value d';
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
  String get tabShops => 'Tiendas';

  @override
  String get tabLab => 'I+D';

  @override
  String get tabGrowth => 'Crecimiento';

  @override
  String get tabStore => 'Tienda';

  @override
  String incomePerSecond(String amount) {
    return '$amount/s';
  }

  @override
  String comboLabel(int count) {
    return 'Combo x$count';
  }

  @override
  String get baristaRush => '¡Barista Rush!';

  @override
  String get tapToBrew => 'Toca la taza para preparar';

  @override
  String cupSemanticLabel(int percent) {
    return 'Taza de café, $percent% llena';
  }

  @override
  String get shop_street_cart => 'Carrito Callejero';

  @override
  String get shop_corner_booth => 'Puesto de Esquina';

  @override
  String get shop_boutique_cafe => 'Café Boutique';

  @override
  String get shop_campus_coworking => 'Coworking del Campus';

  @override
  String get shop_drive_thru => 'Autoservicio';

  @override
  String get shop_city_roastery => 'Tostadora Urbana';

  @override
  String get shop_airport_lounge => 'Sala VIP del Aeropuerto';

  @override
  String get shop_robotic_kiosk => 'Quiosco Robótico';

  @override
  String get shop_capsule_store => 'Tienda de Cápsulas';

  @override
  String get shop_global_mega_roastery => 'Megatostadora Global';

  @override
  String get buyAmountOne => 'x1';

  @override
  String get buyAmountTen => 'x10';

  @override
  String get buyAmountMax => 'MÁX';

  @override
  String get managerHired => 'Gerente contratado';

  @override
  String get milestoneMaxed => 'Todos los hitos alcanzados';

  @override
  String get equipmentEspressoMachine => 'Máquina de espresso';

  @override
  String get equipmentDiamondGrinder => 'Molino de diamante';

  @override
  String get equipmentSmartSystem => 'Sistema inteligente';

  @override
  String shopLevel(int level) {
    return 'Nv. $level';
  }

  @override
  String buyLevels(int count, String cost) {
    return 'Comprar x$count · $cost';
  }

  @override
  String hireManager(String cost) {
    return 'Contratar gerente · $cost';
  }

  @override
  String buyEquipment(String name, String cost) {
    return '$name · $cost';
  }

  @override
  String nextMilestone(int level) {
    return 'Ingresos ×2 en Nv. $level';
  }

  @override
  String shopLocked(String shop) {
    return 'Se desbloquea al comprar $shop';
  }

  @override
  String equipmentAllOwned(String name) {
    return '$name · Comprado';
  }

  @override
  String get recipe_espresso_classic => 'Espresso Clásico';

  @override
  String get recipe_cappuccino => 'Capuchino';

  @override
  String get recipe_cold_brew => 'Cold Brew';

  @override
  String get recipe_flat_white => 'Flat White';

  @override
  String get recipe_capsule_house_blend => 'Cápsula Mezcla de la Casa';

  @override
  String get recipe_ethiopian_pour_over => 'Pour-Over Etíope';

  @override
  String get recipe_nitro_mocha => 'Nitro Moca';

  @override
  String get recipe_capsule_signature_reserve => 'Cápsula Reserva Exclusiva';

  @override
  String get flavorAcidity => 'Acidez';

  @override
  String get flavorBody => 'Cuerpo';

  @override
  String get flavorAroma => 'Aroma';

  @override
  String get flavorCaffeine => 'Cafeína';

  @override
  String hintTooLow(String attribute) {
    return '$attribute está demasiado bajo';
  }

  @override
  String hintTooHigh(String attribute) {
    return '$attribute está demasiado alto';
  }

  @override
  String get hintOnTrack => '¡Vas por buen camino!';

  @override
  String recipeBestScore(int score) {
    return 'Mejor: $score';
  }

  @override
  String recipeLastResult(int score, String hint) {
    return 'Última prueba: $score · $hint';
  }

  @override
  String get recipeCapsuleTag => 'Cápsula';

  @override
  String unlockRecipe(String cost) {
    return 'Desbloquear · $cost';
  }

  @override
  String startTest(String cost) {
    return 'Probar · $cost';
  }

  @override
  String brewingRemaining(String time) {
    return 'Preparando… $time';
  }

  @override
  String get anotherBrewActive => 'Hay otra prueba en curso';

  @override
  String get openRecipe => 'Desarrollar';

  @override
  String get capsuleTitle => 'Máquinas de cápsulas';

  @override
  String capsuleLocked(int score, int hype) {
    return 'Requiere una receta con $score+ y $hype de Fama de Marca';
  }

  @override
  String capsuleOwned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count máquinas',
      one: '1 máquina',
    );
    return '$_temp0';
  }

  @override
  String brandHypeValue(int hype) {
    return 'Fama de Marca: $hype';
  }

  @override
  String labBonusValue(int percent) {
    return 'Bono de I+D: +$percent%';
  }

  @override
  String get flavorProfileTitle => 'Perfil de sabor';

  @override
  String get city_new_york => 'Nueva York';

  @override
  String get city_tokyo => 'Tokio';

  @override
  String get city_london => 'Londres';

  @override
  String get city_istanbul => 'Estambul';

  @override
  String get city_sao_paulo => 'São Paulo';

  @override
  String get city_paris => 'París';

  @override
  String get city_dubai => 'Dubái';

  @override
  String get city_shanghai => 'Shanghái';

  @override
  String get city_mexico_city => 'Ciudad de México';

  @override
  String get city_seoul => 'Seúl';

  @override
  String get city_berlin => 'Berlín';

  @override
  String get city_madrid => 'Madrid';

  @override
  String get city_rome => 'Roma';

  @override
  String get city_toronto => 'Toronto';

  @override
  String get city_sydney => 'Sídney';

  @override
  String get city_mumbai => 'Bombay';

  @override
  String get city_cairo => 'El Cairo';

  @override
  String get city_jakarta => 'Yakarta';

  @override
  String get city_amsterdam => 'Ámsterdam';

  @override
  String get city_singapore => 'Singapur';

  @override
  String get city_bangkok => 'Bangkok';

  @override
  String get city_buenos_aires => 'Buenos Aires';

  @override
  String get city_bogota => 'Bogotá';

  @override
  String get city_lagos => 'Lagos';

  @override
  String get city_vienna => 'Viena';

  @override
  String get city_lisbon => 'Lisboa';

  @override
  String get city_reykjavik => 'Reikiavik';

  @override
  String get city_addis_ababa => 'Adís Abeba';

  @override
  String get city_nairobi => 'Nairobi';

  @override
  String get city_hanoi => 'Hanói';

  @override
  String get country_US => 'Estados Unidos';

  @override
  String get country_JP => 'Japón';

  @override
  String get country_GB => 'Reino Unido';

  @override
  String get country_TR => 'Turquía';

  @override
  String get country_BR => 'Brasil';

  @override
  String get country_FR => 'Francia';

  @override
  String get country_AE => 'Emiratos Árabes Unidos';

  @override
  String get country_CN => 'China';

  @override
  String get country_MX => 'México';

  @override
  String get country_KR => 'Corea del Sur';

  @override
  String get country_DE => 'Alemania';

  @override
  String get country_ES => 'España';

  @override
  String get country_IT => 'Italia';

  @override
  String get country_CA => 'Canadá';

  @override
  String get country_AU => 'Australia';

  @override
  String get country_IN => 'India';

  @override
  String get country_EG => 'Egipto';

  @override
  String get country_ID => 'Indonesia';

  @override
  String get country_NL => 'Países Bajos';

  @override
  String get country_SG => 'Singapur';

  @override
  String get country_TH => 'Tailandia';

  @override
  String get country_AR => 'Argentina';

  @override
  String get country_CO => 'Colombia';

  @override
  String get country_NG => 'Nigeria';

  @override
  String get country_AT => 'Austria';

  @override
  String get country_PT => 'Portugal';

  @override
  String get country_IS => 'Islandia';

  @override
  String get country_ET => 'Etiopía';

  @override
  String get country_KE => 'Kenia';

  @override
  String get country_VN => 'Vietnam';

  @override
  String get region_europe => 'Europa';

  @override
  String get region_asia_pacific => 'Asia-Pacífico';

  @override
  String get region_americas => 'América';

  @override
  String get region_mea => 'Oriente Medio y África';

  @override
  String get franchiseTitle => 'Franquicias';

  @override
  String franchiseRoyalty(String amount) {
    return 'Regalías: $amount/s';
  }

  @override
  String franchisePerSlot(String amount) {
    return '+$amount/s por local';
  }

  @override
  String franchiseRequiresHype(int hype) {
    return 'Requiere $hype de Fama de Marca';
  }

  @override
  String franchiseOpen(String cost) {
    return 'Abrir · $cost';
  }

  @override
  String franchiseComplete(String multiplier) {
    return 'Ciudad completa ×$multiplier';
  }

  @override
  String get prestigeTitle => 'Granos de Oro';

  @override
  String prestigeOwned(int beans, String multiplier) {
    return '$beans Granos de Oro · ingresos ×$multiplier';
  }

  @override
  String prestigeProgress(String earned, String threshold) {
    return 'Ganancias de la partida $earned / $threshold';
  }

  @override
  String prestigeButton(int beans) {
    return 'Vender el imperio · +$beans';
  }

  @override
  String get prestigeConfirmTitle => '¿Empezar un nuevo imperio?';

  @override
  String prestigeConfirmBody(int beans, String multiplier) {
    return 'Ganarás $beans Granos de Oro. Tu multiplicador de ingresos será ×$multiplier. Se reinician tiendas, gerentes, equipos, máquinas de cápsulas y franquicias.';
  }

  @override
  String get confirm => 'Confirmar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get offlineTitle => '¡Bienvenido de nuevo!';

  @override
  String offlineBody(String duration, String amount) {
    return 'Mientras estuviste fuera $duration, tu imperio ganó $amount.';
  }

  @override
  String get offlineCollect => 'Cobrar';

  @override
  String get offlineCollectDouble => 'Ver anuncio, cobrar x2';

  @override
  String get adPlaying => 'Reproduciendo anuncio…';

  @override
  String get notificationChannelName => 'Recordatorios de café';

  @override
  String get notifOfflineTitle => '¡Tus tiendas están rebosando!';

  @override
  String get notifOfflineBody =>
      'Las ganancias sin conexión llegaron al límite. Vuelve a cobrarlas.';

  @override
  String get notifDailyTitle => 'Recompensa diaria lista';

  @override
  String get notifDailyBody => 'Tu bono diario de café te espera.';

  @override
  String get notifRushTitle => 'Caffeine Rush terminó';

  @override
  String get notifRushBody =>
      'Mira otro anuncio para seguir duplicando tus ingresos.';

  @override
  String get rewardedTitle => 'Impulsos gratis';

  @override
  String get rewardCaffeineRushTitle => 'Caffeine Rush';

  @override
  String get rewardCaffeineRushBody =>
      'Todos los ingresos ×2 durante 4 horas (hasta 8 horas)';

  @override
  String get rewardEmergencyFundTitle => 'Fondo de emergencia';

  @override
  String rewardEmergencyFundBody(String amount) {
    return 'Recibe $amount al instante';
  }

  @override
  String get rewardLabSpeedupTitle => 'Acelerar laboratorio';

  @override
  String get rewardLabSpeedupBody => 'Termina ahora la prueba de I+D en curso';

  @override
  String get watchAd => 'Ver anuncio';

  @override
  String readyIn(String time) {
    return 'Listo en $time';
  }

  @override
  String get unavailable => 'No disponible';

  @override
  String boostActive(String multiplier, String time) {
    return '×$multiplier $time';
  }

  @override
  String get shopTitle => 'Premium';

  @override
  String get vipTitle => 'VIP Maestro Tostador';

  @override
  String get vipBody =>
      'Ingresos ×2 permanentes, límite sin conexión de 12 horas y un barista que toca solo';

  @override
  String get starterPackTitle => 'Pack inicial Espresso';

  @override
  String get starterPackBody =>
      'Ingresos ×1,25 permanentes y 2 horas de ingresos en efectivo';

  @override
  String get timeSkipTitle => 'Salto de 24 h';

  @override
  String timeSkipBody(String amount) {
    return 'Recibe $amount al instante';
  }

  @override
  String get buyProduct => 'Comprar';

  @override
  String get owned => 'Comprado';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get noForcedAds =>
      'Sin anuncios obligatorios: los anuncios con recompensa son siempre opcionales.';

  @override
  String get dailyRewardTitle => 'Recompensa diaria';

  @override
  String dailyRewardDay(int day) {
    return 'Día $day';
  }

  @override
  String dailyRewardClaim(String amount) {
    return 'Cobrar $amount';
  }

  @override
  String dailyRewardNext(String time) {
    return 'Próxima recompensa en $time';
  }

  @override
  String dailyRewardBean(int beans) {
    return '+$beans Grano de Oro';
  }

  @override
  String tutorialTitle(int step, int total) {
    return 'Formación de barista $step/$total';
  }

  @override
  String get tutorialStepTapCup => 'Toca la taza para preparar tu primer café.';

  @override
  String get tutorialStepBuyFirstShop =>
      'Compra un Carrito Callejero en la pestaña Tiendas.';

  @override
  String get tutorialStepBuySecondShop =>
      'Abre tu segunda tienda: el Puesto de Esquina.';

  @override
  String get tutorialStepHireManager =>
      'Contrata un gerente para triplicar los ingresos de una tienda.';

  @override
  String get tutorialStepOpenLab =>
      'Abre la pestaña I+D para descubrir recetas.';

  @override
  String get tutorialStepFinish =>
      '¡Ya puedes construir tu imperio! Activa los recordatorios para no perderte ninguna recompensa.';

  @override
  String get tutorialSkip => 'Saltar';

  @override
  String get tutorialFinish => '¡Vamos!';

  @override
  String get achievementsTitle => 'Logros';

  @override
  String achievementsProgress(int unlocked, int total, int percent) {
    return '$unlocked/$total desbloqueados · ingresos +$percent%';
  }

  @override
  String achievementUnlocked(String name) {
    return 'Logro desbloqueado: $name';
  }

  @override
  String achDescLifetime(String amount) {
    return 'Gana $amount en total';
  }

  @override
  String achDescShopLevel(int level) {
    return 'Alcanza el nivel $level en cualquier tienda';
  }

  @override
  String achDescRecipes(int score, int count) {
    return 'Consigue $score+ en $count recetas';
  }

  @override
  String achDescFranchises(int count) {
    return 'Ten $count locales de franquicia';
  }

  @override
  String achDescPrestige(int count) {
    return 'Empieza un nuevo imperio $count veces';
  }

  @override
  String achDescTaps(int count) {
    return 'Toca la taza $count veces';
  }

  @override
  String get achievement_first_dollars => 'Primeros Dólares';

  @override
  String get achievement_small_business => 'Pequeño Negocio';

  @override
  String get achievement_coffee_mogul => 'Magnate del Café';

  @override
  String get achievement_bean_tycoon => 'Rey del Grano';

  @override
  String get achievement_caffeine_empire => 'Imperio de la Cafeína';

  @override
  String get achievement_growing_shop => 'Tienda en Crecimiento';

  @override
  String get achievement_busy_counter => 'Mostrador Ocupado';

  @override
  String get achievement_centurion => 'Centurión';

  @override
  String get achievement_legendary_branch => 'Sucursal Legendaria';

  @override
  String get achievement_first_masterpiece => 'Primera Obra Maestra';

  @override
  String get achievement_lab_regular => 'Habitual del Laboratorio';

  @override
  String get achievement_master_brewer => 'Maestro Cafetero';

  @override
  String get achievement_first_franchise => 'Primera Franquicia';

  @override
  String get achievement_regional_brand => 'Marca Regional';

  @override
  String get achievement_global_chain => 'Cadena Global';

  @override
  String get achievement_world_domination => 'Dominación Mundial';

  @override
  String get achievement_fresh_start => 'Nuevo Comienzo';

  @override
  String get achievement_serial_founder => 'Fundador en Serie';

  @override
  String get achievement_eager_barista => 'Barista Entusiasta';

  @override
  String get achievement_tireless_barista => 'Barista Incansable';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get languageSystem => 'Sistema';

  @override
  String get settingsSound => 'Sonido';

  @override
  String get settingsHaptics => 'Vibración';

  @override
  String get settingsNotifications => 'Notificaciones';

  @override
  String get settingsScientific => 'Notación científica';

  @override
  String get settingsReset => 'Reiniciar progreso';

  @override
  String get resetConfirmTitle => '¿Reiniciar todo el progreso?';

  @override
  String get resetConfirmBody =>
      'Esto borra tu partida, incluidos los Granos de Oro y las compras. No se puede deshacer.';

  @override
  String get resetConfirm => 'Reiniciar';

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
  String get stationUpgradesHint => 'Toca para gerente y equipos';

  @override
  String get spriteGalleryTitle => 'Galería de sprites';
}
