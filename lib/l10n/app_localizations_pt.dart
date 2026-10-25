// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

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
  String get tabShops => 'Lojas';

  @override
  String get tabLab => 'P&D';

  @override
  String get tabGrowth => 'Crescimento';

  @override
  String get tabStore => 'Loja';

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
  String get tapToBrew => 'Toque na xícara para preparar';

  @override
  String cupSemanticLabel(int percent) {
    return 'Xícara de café, $percent% cheia';
  }

  @override
  String get shop_street_cart => 'Carrinho de Rua';

  @override
  String get shop_corner_booth => 'Quiosque da Esquina';

  @override
  String get shop_boutique_cafe => 'Café Boutique';

  @override
  String get shop_campus_coworking => 'Coworking do Campus';

  @override
  String get shop_drive_thru => 'Drive-Thru';

  @override
  String get shop_city_roastery => 'Torrefação Urbana';

  @override
  String get shop_airport_lounge => 'Lounge do Aeroporto';

  @override
  String get shop_robotic_kiosk => 'Quiosque Robótico';

  @override
  String get shop_capsule_store => 'Loja de Cápsulas';

  @override
  String get shop_global_mega_roastery => 'Megatorrefação Global';

  @override
  String get buyAmountOne => 'x1';

  @override
  String get buyAmountTen => 'x10';

  @override
  String get buyAmountMax => 'MÁX';

  @override
  String get managerHired => 'Gerente contratado';

  @override
  String get milestoneMaxed => 'Todos os marcos alcançados';

  @override
  String get equipmentEspressoMachine => 'Máquina de espresso';

  @override
  String get equipmentDiamondGrinder => 'Moedor de diamante';

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
    return 'Renda ×2 no Nv. $level';
  }

  @override
  String shopLocked(String shop) {
    return 'Desbloqueia ao comprar $shop';
  }

  @override
  String equipmentAllOwned(String name) {
    return '$name · Adquirido';
  }

  @override
  String get recipe_espresso_classic => 'Espresso Clássico';

  @override
  String get recipe_cappuccino => 'Cappuccino';

  @override
  String get recipe_cold_brew => 'Cold Brew';

  @override
  String get recipe_flat_white => 'Flat White';

  @override
  String get recipe_capsule_house_blend => 'Cápsula Blend da Casa';

  @override
  String get recipe_ethiopian_pour_over => 'Pour-Over Etíope';

  @override
  String get recipe_nitro_mocha => 'Nitro Mocha';

  @override
  String get recipe_capsule_signature_reserve => 'Cápsula Reserva Assinatura';

  @override
  String get flavorAcidity => 'Acidez';

  @override
  String get flavorBody => 'Corpo';

  @override
  String get flavorAroma => 'Aroma';

  @override
  String get flavorCaffeine => 'Cafeína';

  @override
  String hintTooLow(String attribute) {
    return '$attribute está baixo demais';
  }

  @override
  String hintTooHigh(String attribute) {
    return '$attribute está alto demais';
  }

  @override
  String get hintOnTrack => 'Você está no caminho certo!';

  @override
  String recipeBestScore(int score) {
    return 'Melhor: $score';
  }

  @override
  String recipeLastResult(int score, String hint) {
    return 'Último teste: $score · $hint';
  }

  @override
  String get recipeCapsuleTag => 'Cápsula';

  @override
  String unlockRecipe(String cost) {
    return 'Desbloquear · $cost';
  }

  @override
  String startTest(String cost) {
    return 'Testar · $cost';
  }

  @override
  String brewingRemaining(String time) {
    return 'Preparando… $time';
  }

  @override
  String get anotherBrewActive => 'Outro teste está em andamento';

  @override
  String get openRecipe => 'Desenvolver';

  @override
  String get capsuleTitle => 'Máquinas de cápsulas';

  @override
  String capsuleLocked(int score, int hype) {
    return 'Exige uma receita com $score+ e $hype de Prestígio da Marca';
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
    return 'Prestígio da Marca: $hype';
  }

  @override
  String labBonusValue(int percent) {
    return 'Bônus de P&D: +$percent%';
  }

  @override
  String get flavorProfileTitle => 'Perfil de sabor';

  @override
  String get city_new_york => 'Nova York';

  @override
  String get city_tokyo => 'Tóquio';

  @override
  String get city_london => 'Londres';

  @override
  String get city_istanbul => 'Istambul';

  @override
  String get city_sao_paulo => 'São Paulo';

  @override
  String get city_paris => 'Paris';

  @override
  String get city_dubai => 'Dubai';

  @override
  String get city_shanghai => 'Xangai';

  @override
  String get city_mexico_city => 'Cidade do México';

  @override
  String get city_seoul => 'Seul';

  @override
  String get city_berlin => 'Berlim';

  @override
  String get city_madrid => 'Madri';

  @override
  String get city_rome => 'Roma';

  @override
  String get city_toronto => 'Toronto';

  @override
  String get city_sydney => 'Sydney';

  @override
  String get city_mumbai => 'Mumbai';

  @override
  String get city_cairo => 'Cairo';

  @override
  String get city_jakarta => 'Jacarta';

  @override
  String get city_amsterdam => 'Amsterdã';

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
  String get city_vienna => 'Viena';

  @override
  String get city_lisbon => 'Lisboa';

  @override
  String get city_reykjavik => 'Reykjavík';

  @override
  String get city_addis_ababa => 'Adis Abeba';

  @override
  String get city_nairobi => 'Nairóbi';

  @override
  String get city_hanoi => 'Hanói';

  @override
  String get country_US => 'Estados Unidos';

  @override
  String get country_JP => 'Japão';

  @override
  String get country_GB => 'Reino Unido';

  @override
  String get country_TR => 'Turquia';

  @override
  String get country_BR => 'Brasil';

  @override
  String get country_FR => 'França';

  @override
  String get country_AE => 'Emirados Árabes Unidos';

  @override
  String get country_CN => 'China';

  @override
  String get country_MX => 'México';

  @override
  String get country_KR => 'Coreia do Sul';

  @override
  String get country_DE => 'Alemanha';

  @override
  String get country_ES => 'Espanha';

  @override
  String get country_IT => 'Itália';

  @override
  String get country_CA => 'Canadá';

  @override
  String get country_AU => 'Austrália';

  @override
  String get country_IN => 'Índia';

  @override
  String get country_EG => 'Egito';

  @override
  String get country_ID => 'Indonésia';

  @override
  String get country_NL => 'Países Baixos';

  @override
  String get country_SG => 'Singapura';

  @override
  String get country_TH => 'Tailândia';

  @override
  String get country_AR => 'Argentina';

  @override
  String get country_CO => 'Colômbia';

  @override
  String get country_NG => 'Nigéria';

  @override
  String get country_AT => 'Áustria';

  @override
  String get country_PT => 'Portugal';

  @override
  String get country_IS => 'Islândia';

  @override
  String get country_ET => 'Etiópia';

  @override
  String get country_KE => 'Quênia';

  @override
  String get country_VN => 'Vietnã';

  @override
  String get region_europe => 'Europa';

  @override
  String get region_asia_pacific => 'Ásia-Pacífico';

  @override
  String get region_americas => 'Américas';

  @override
  String get region_mea => 'Oriente Médio e África';

  @override
  String get franchiseTitle => 'Franquias';

  @override
  String franchiseRoyalty(String amount) {
    return 'Royalties: $amount/s';
  }

  @override
  String franchisePerSlot(String amount) {
    return '+$amount/s por unidade';
  }

  @override
  String franchiseRequiresHype(int hype) {
    return 'Exige $hype de Prestígio da Marca';
  }

  @override
  String franchiseOpen(String cost) {
    return 'Abrir · $cost';
  }

  @override
  String franchiseComplete(String multiplier) {
    return 'Cidade completa ×$multiplier';
  }

  @override
  String get prestigeTitle => 'Grãos de Ouro';

  @override
  String prestigeOwned(int beans, String multiplier) {
    return '$beans Grãos de Ouro · renda ×$multiplier';
  }

  @override
  String prestigeProgress(String earned, String threshold) {
    return 'Ganhos da rodada $earned / $threshold';
  }

  @override
  String prestigeButton(int beans) {
    return 'Vender o império · +$beans';
  }

  @override
  String get prestigeConfirmTitle => 'Começar um novo império?';

  @override
  String prestigeConfirmBody(int beans, String multiplier) {
    return 'Você ganhará $beans Grãos de Ouro. Seu multiplicador de renda passa a ser ×$multiplier. Lojas, gerentes, equipamentos, máquinas de cápsulas e franquias serão reiniciados.';
  }

  @override
  String get confirm => 'Confirmar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get offlineTitle => 'Bem-vindo de volta!';

  @override
  String offlineBody(String duration, String amount) {
    return 'Enquanto você esteve fora por $duration, seu império ganhou $amount.';
  }

  @override
  String get offlineCollect => 'Coletar';

  @override
  String get offlineCollectDouble => 'Ver anúncio, coletar 2x';

  @override
  String get adPlaying => 'Exibindo anúncio…';

  @override
  String get notificationChannelName => 'Lembretes de café';

  @override
  String get notifOfflineTitle => 'Suas lojas estão transbordando!';

  @override
  String get notifOfflineBody =>
      'Os ganhos offline chegaram ao limite. Volte para coletar.';

  @override
  String get notifDailyTitle => 'Recompensa diária pronta';

  @override
  String get notifDailyBody => 'Seu bônus diário de café está esperando.';

  @override
  String get notifRushTitle => 'Caffeine Rush terminou';

  @override
  String get notifRushBody => 'Veja outro anúncio para manter a renda dobrada.';

  @override
  String get rewardedTitle => 'Bônus grátis';

  @override
  String get rewardCaffeineRushTitle => 'Caffeine Rush';

  @override
  String get rewardCaffeineRushBody =>
      'Toda a renda ×2 por 4 horas (até 8 horas)';

  @override
  String get rewardEmergencyFundTitle => 'Fundo de emergência';

  @override
  String rewardEmergencyFundBody(String amount) {
    return 'Receba $amount na hora';
  }

  @override
  String get rewardLabSpeedupTitle => 'Acelerar laboratório';

  @override
  String get rewardLabSpeedupBody =>
      'Termine agora o teste de P&D em andamento';

  @override
  String get watchAd => 'Ver anúncio';

  @override
  String readyIn(String time) {
    return 'Pronto em $time';
  }

  @override
  String get unavailable => 'Indisponível';

  @override
  String boostActive(String multiplier, String time) {
    return '×$multiplier $time';
  }

  @override
  String get shopTitle => 'Premium';

  @override
  String get vipTitle => 'VIP Mestre Torrador';

  @override
  String get vipBody =>
      'Renda ×2 permanente, limite offline de 12 horas e um barista que toca sozinho';

  @override
  String get starterPackTitle => 'Pacote Inicial Espresso';

  @override
  String get starterPackBody =>
      'Renda ×1,25 permanente e 2 horas de renda em dinheiro';

  @override
  String get timeSkipTitle => 'Avanço de 24 h';

  @override
  String timeSkipBody(String amount) {
    return 'Receba $amount na hora';
  }

  @override
  String get buyProduct => 'Comprar';

  @override
  String get owned => 'Adquirido';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get noForcedAds =>
      'Sem anúncios obrigatórios: anúncios premiados são sempre opcionais.';

  @override
  String get dailyRewardTitle => 'Recompensa diária';

  @override
  String dailyRewardDay(int day) {
    return 'Dia $day';
  }

  @override
  String dailyRewardClaim(String amount) {
    return 'Coletar $amount';
  }

  @override
  String dailyRewardNext(String time) {
    return 'Próxima recompensa em $time';
  }

  @override
  String dailyRewardBean(int beans) {
    return '+$beans Grão de Ouro';
  }

  @override
  String tutorialTitle(int step, int total) {
    return 'Treinamento de barista $step/$total';
  }

  @override
  String get tutorialStepBuyFirstShop =>
      'Compre um Carrinho de Rua na aba Lojas.';

  @override
  String get tutorialStepBuySecondShop =>
      'Abra sua segunda loja: o Quiosque da Esquina.';

  @override
  String get tutorialStepHireManager =>
      'Contrate um gerente para triplicar a renda de uma loja.';

  @override
  String get tutorialStepOpenLab => 'Abra a aba P&D para descobrir receitas.';

  @override
  String get tutorialStepFinish =>
      'Você está pronto para construir seu império! Ative os lembretes para não perder nenhuma recompensa.';

  @override
  String get tutorialSkip => 'Pular';

  @override
  String get tutorialFinish => 'Vamos lá!';

  @override
  String get achievementsTitle => 'Conquistas';

  @override
  String achievementsProgress(int unlocked, int total, int percent) {
    return '$unlocked/$total desbloqueadas · renda +$percent%';
  }

  @override
  String achievementUnlocked(String name) {
    return 'Conquista desbloqueada: $name';
  }

  @override
  String achDescLifetime(String amount) {
    return 'Ganhe $amount no total';
  }

  @override
  String achDescShopLevel(int level) {
    return 'Chegue ao nível $level em qualquer loja';
  }

  @override
  String achDescRecipes(int score, int count) {
    return 'Faça $score+ em $count receitas';
  }

  @override
  String achDescFranchises(int count) {
    return 'Tenha $count unidades de franquia';
  }

  @override
  String achDescPrestige(int count) {
    return 'Comece um novo império $count vezes';
  }

  @override
  String achDescTaps(int count) {
    return 'Toque na xícara $count vezes';
  }

  @override
  String get achievement_first_dollars => 'Primeiros Dólares';

  @override
  String get achievement_small_business => 'Pequeno Negócio';

  @override
  String get achievement_coffee_mogul => 'Magnata do Café';

  @override
  String get achievement_bean_tycoon => 'Barão do Grão';

  @override
  String get achievement_caffeine_empire => 'Império da Cafeína';

  @override
  String get achievement_growing_shop => 'Loja em Crescimento';

  @override
  String get achievement_busy_counter => 'Balcão Movimentado';

  @override
  String get achievement_centurion => 'Centurião';

  @override
  String get achievement_legendary_branch => 'Filial Lendária';

  @override
  String get achievement_first_masterpiece => 'Primeira Obra-Prima';

  @override
  String get achievement_lab_regular => 'Frequentador do Laboratório';

  @override
  String get achievement_master_brewer => 'Mestre Barista';

  @override
  String get achievement_first_franchise => 'Primeira Franquia';

  @override
  String get achievement_regional_brand => 'Marca Regional';

  @override
  String get achievement_global_chain => 'Rede Global';

  @override
  String get achievement_world_domination => 'Domínio Mundial';

  @override
  String get achievement_fresh_start => 'Novo Começo';

  @override
  String get achievement_serial_founder => 'Fundador em Série';

  @override
  String get achievement_eager_barista => 'Barista Animado';

  @override
  String get achievement_tireless_barista => 'Barista Incansável';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get languageSystem => 'Sistema';

  @override
  String get settingsSound => 'Som';

  @override
  String get settingsHaptics => 'Vibração';

  @override
  String get settingsNotifications => 'Notificações';

  @override
  String get settingsScientific => 'Notação científica';

  @override
  String get settingsReset => 'Reiniciar progresso';

  @override
  String get resetConfirmTitle => 'Reiniciar todo o progresso?';

  @override
  String get resetConfirmBody =>
      'Isto apaga seu jogo salvo, incluindo Grãos de Ouro e compras. Não pode ser desfeito.';

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
  String get stationUpgradesHint => 'Toque para gerente e equipamentos';

  @override
  String get spriteGalleryTitle => 'Galeria de sprites';

  @override
  String get tabCafe => 'Café';

  @override
  String get tutorialStepServeCustomer =>
      'Toque no cliente do balcão, prepare a bebida e toque de novo para servir.';

  @override
  String brewPanelTitle(String drink) {
    return 'Preparando: $drink';
  }

  @override
  String get serveHint => 'Bebida pronta! Toque no cliente para servir.';

  @override
  String get perfectServe => 'Perfeito!';

  @override
  String get drink_espresso => 'Espresso';

  @override
  String get drink_americano => 'Americano';

  @override
  String get drink_latte => 'Latte';

  @override
  String get drink_cappuccino => 'Cappuccino';

  @override
  String get drink_mocha => 'Mocha';

  @override
  String get drink_cold_brew => 'Cold Brew';
}
