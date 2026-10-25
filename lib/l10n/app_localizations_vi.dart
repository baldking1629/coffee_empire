// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Coffee Empire';

  @override
  String durationDays(int value) {
    return '$value ng';
  }

  @override
  String durationHours(int value) {
    return '$value g';
  }

  @override
  String durationMinutes(int value) {
    return '$value ph';
  }

  @override
  String durationSeconds(int value) {
    return '$value gi';
  }

  @override
  String get tabShops => 'Cửa hàng';

  @override
  String get tabLab => 'R&D';

  @override
  String get tabGrowth => 'Phát triển';

  @override
  String get tabStore => 'Cửa hiệu';

  @override
  String incomePerSecond(String amount) {
    return '$amount/giây';
  }

  @override
  String comboLabel(int count) {
    return 'Combo x$count';
  }

  @override
  String get baristaRush => 'Barista Rush!';

  @override
  String get tapToBrew => 'Chạm vào tách để pha';

  @override
  String cupSemanticLabel(int percent) {
    return 'Tách cà phê, đầy $percent%';
  }

  @override
  String get shop_street_cart => 'Xe đẩy đường phố';

  @override
  String get shop_corner_booth => 'Quầy góc phố';

  @override
  String get shop_boutique_cafe => 'Quán cà phê boutique';

  @override
  String get shop_campus_coworking => 'Coworking khuôn viên';

  @override
  String get shop_drive_thru => 'Drive-thru';

  @override
  String get shop_city_roastery => 'Xưởng rang thành phố';

  @override
  String get shop_airport_lounge => 'Phòng chờ sân bay';

  @override
  String get shop_robotic_kiosk => 'Ki-ốt robot';

  @override
  String get shop_capsule_store => 'Cửa hàng viên nén';

  @override
  String get shop_global_mega_roastery => 'Siêu xưởng rang toàn cầu';

  @override
  String get buyAmountOne => 'x1';

  @override
  String get buyAmountTen => 'x10';

  @override
  String get buyAmountMax => 'TỐI ĐA';

  @override
  String get managerHired => 'Đã thuê quản lý';

  @override
  String get milestoneMaxed => 'Đã đạt mọi mốc';

  @override
  String get equipmentEspressoMachine => 'Máy espresso';

  @override
  String get equipmentDiamondGrinder => 'Máy xay kim cương';

  @override
  String get equipmentSmartSystem => 'Hệ thống thông minh';

  @override
  String shopLevel(int level) {
    return 'Cấp $level';
  }

  @override
  String buyLevels(int count, String cost) {
    return 'Mua x$count · $cost';
  }

  @override
  String hireManager(String cost) {
    return 'Thuê quản lý · $cost';
  }

  @override
  String buyEquipment(String name, String cost) {
    return '$name · $cost';
  }

  @override
  String nextMilestone(int level) {
    return 'Thu nhập ×2 ở cấp $level';
  }

  @override
  String shopLocked(String shop) {
    return 'Mở khóa sau khi mua $shop';
  }

  @override
  String equipmentAllOwned(String name) {
    return '$name · Đã sở hữu';
  }

  @override
  String get recipe_espresso_classic => 'Espresso cổ điển';

  @override
  String get recipe_cappuccino => 'Cappuccino';

  @override
  String get recipe_cold_brew => 'Cold brew';

  @override
  String get recipe_flat_white => 'Flat white';

  @override
  String get recipe_capsule_house_blend => 'Viên nén pha trộn nhà làm';

  @override
  String get recipe_ethiopian_pour_over => 'Pour-over Ethiopia';

  @override
  String get recipe_nitro_mocha => 'Nitro mocha';

  @override
  String get recipe_capsule_signature_reserve => 'Viên nén dự trữ đặc biệt';

  @override
  String get flavorAcidity => 'Độ chua';

  @override
  String get flavorBody => 'Độ đậm';

  @override
  String get flavorAroma => 'Hương thơm';

  @override
  String get flavorCaffeine => 'Caffeine';

  @override
  String hintTooLow(String attribute) {
    return '$attribute quá thấp';
  }

  @override
  String hintTooHigh(String attribute) {
    return '$attribute quá cao';
  }

  @override
  String get hintOnTrack => 'Bạn đang đi đúng hướng!';

  @override
  String recipeBestScore(int score) {
    return 'Cao nhất: $score';
  }

  @override
  String recipeLastResult(int score, String hint) {
    return 'Lần thử gần nhất: $score · $hint';
  }

  @override
  String get recipeCapsuleTag => 'Viên nén';

  @override
  String unlockRecipe(String cost) {
    return 'Mở khóa · $cost';
  }

  @override
  String startTest(String cost) {
    return 'Thử · $cost';
  }

  @override
  String brewingRemaining(String time) {
    return 'Đang pha… $time';
  }

  @override
  String get anotherBrewActive => 'Một lần thử khác đang chạy';

  @override
  String get openRecipe => 'Phát triển';

  @override
  String get capsuleTitle => 'Máy viên nén';

  @override
  String capsuleLocked(int score, int hype) {
    return 'Cần một công thức đạt $score+ và $hype Độ nổi tiếng thương hiệu';
  }

  @override
  String capsuleOwned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count máy',
    );
    return '$_temp0';
  }

  @override
  String brandHypeValue(int hype) {
    return 'Độ nổi tiếng: $hype';
  }

  @override
  String labBonusValue(int percent) {
    return 'Thưởng R&D: +$percent%';
  }

  @override
  String get flavorProfileTitle => 'Hồ sơ hương vị';

  @override
  String get city_new_york => 'New York';

  @override
  String get city_tokyo => 'Tokyo';

  @override
  String get city_london => 'Luân Đôn';

  @override
  String get city_istanbul => 'Istanbul';

  @override
  String get city_sao_paulo => 'São Paulo';

  @override
  String get city_paris => 'Paris';

  @override
  String get city_dubai => 'Dubai';

  @override
  String get city_shanghai => 'Thượng Hải';

  @override
  String get city_mexico_city => 'Thành phố Mexico';

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
  String get city_cairo => 'Cairo';

  @override
  String get city_jakarta => 'Jakarta';

  @override
  String get city_amsterdam => 'Amsterdam';

  @override
  String get city_singapore => 'Singapore';

  @override
  String get city_bangkok => 'Bangkok';

  @override
  String get city_buenos_aires => 'Buenos Aires';

  @override
  String get city_bogota => 'Bogotá';

  @override
  String get city_lagos => 'Lagos';

  @override
  String get city_vienna => 'Viên';

  @override
  String get city_lisbon => 'Lisbon';

  @override
  String get city_reykjavik => 'Reykjavík';

  @override
  String get city_addis_ababa => 'Addis Ababa';

  @override
  String get city_nairobi => 'Nairobi';

  @override
  String get city_hanoi => 'Hà Nội';

  @override
  String get country_US => 'Hoa Kỳ';

  @override
  String get country_JP => 'Nhật Bản';

  @override
  String get country_GB => 'Vương quốc Anh';

  @override
  String get country_TR => 'Thổ Nhĩ Kỳ';

  @override
  String get country_BR => 'Brazil';

  @override
  String get country_FR => 'Pháp';

  @override
  String get country_AE => 'Các Tiểu vương quốc Ả Rập Thống nhất';

  @override
  String get country_CN => 'Trung Quốc';

  @override
  String get country_MX => 'Mexico';

  @override
  String get country_KR => 'Hàn Quốc';

  @override
  String get country_DE => 'Đức';

  @override
  String get country_ES => 'Tây Ban Nha';

  @override
  String get country_IT => 'Ý';

  @override
  String get country_CA => 'Canada';

  @override
  String get country_AU => 'Úc';

  @override
  String get country_IN => 'Ấn Độ';

  @override
  String get country_EG => 'Ai Cập';

  @override
  String get country_ID => 'Indonesia';

  @override
  String get country_NL => 'Hà Lan';

  @override
  String get country_SG => 'Singapore';

  @override
  String get country_TH => 'Thái Lan';

  @override
  String get country_AR => 'Argentina';

  @override
  String get country_CO => 'Colombia';

  @override
  String get country_NG => 'Nigeria';

  @override
  String get country_AT => 'Áo';

  @override
  String get country_PT => 'Bồ Đào Nha';

  @override
  String get country_IS => 'Iceland';

  @override
  String get country_ET => 'Ethiopia';

  @override
  String get country_KE => 'Kenya';

  @override
  String get country_VN => 'Việt Nam';

  @override
  String get region_europe => 'Châu Âu';

  @override
  String get region_asia_pacific => 'Châu Á - Thái Bình Dương';

  @override
  String get region_americas => 'Châu Mỹ';

  @override
  String get region_mea => 'Trung Đông và Châu Phi';

  @override
  String get franchiseTitle => 'Nhượng quyền';

  @override
  String franchiseRoyalty(String amount) {
    return 'Phí bản quyền: $amount/giây';
  }

  @override
  String franchisePerSlot(String amount) {
    return '+$amount/giây mỗi điểm';
  }

  @override
  String franchiseRequiresHype(int hype) {
    return 'Cần $hype Độ nổi tiếng thương hiệu';
  }

  @override
  String franchiseOpen(String cost) {
    return 'Mở · $cost';
  }

  @override
  String franchiseComplete(String multiplier) {
    return 'Hoàn tất thành phố ×$multiplier';
  }

  @override
  String get prestigeTitle => 'Hạt Vàng';

  @override
  String prestigeOwned(int beans, String multiplier) {
    return '$beans Hạt Vàng · thu nhập ×$multiplier';
  }

  @override
  String prestigeProgress(String earned, String threshold) {
    return 'Thu nhập lượt này $earned / $threshold';
  }

  @override
  String prestigeButton(int beans) {
    return 'Bán đế chế · +$beans';
  }

  @override
  String get prestigeConfirmTitle => 'Bắt đầu đế chế mới?';

  @override
  String prestigeConfirmBody(int beans, String multiplier) {
    return 'Bạn sẽ nhận $beans Hạt Vàng. Hệ số thu nhập trở thành ×$multiplier. Cửa hàng, quản lý, thiết bị, máy viên nén và nhượng quyền sẽ được đặt lại.';
  }

  @override
  String get confirm => 'Xác nhận';

  @override
  String get cancel => 'Hủy';

  @override
  String get offlineTitle => 'Chào mừng trở lại!';

  @override
  String offlineBody(String duration, String amount) {
    return 'Trong $duration bạn vắng mặt, đế chế đã kiếm được $amount.';
  }

  @override
  String get offlineCollect => 'Nhận';

  @override
  String get offlineCollectDouble => 'Xem quảng cáo, nhận x2';

  @override
  String get adPlaying => 'Đang phát quảng cáo…';

  @override
  String get notificationChannelName => 'Nhắc nhở cà phê';

  @override
  String get notifOfflineTitle => 'Cửa hàng của bạn đầy ắp!';

  @override
  String get notifOfflineBody =>
      'Thu nhập ngoại tuyến đã chạm giới hạn. Quay lại để nhận.';

  @override
  String get notifDailyTitle => 'Phần thưởng ngày đã sẵn sàng';

  @override
  String get notifDailyBody => 'Phần thưởng cà phê hằng ngày đang chờ bạn.';

  @override
  String get notifRushTitle => 'Caffeine Rush đã kết thúc';

  @override
  String get notifRushBody => 'Xem thêm một quảng cáo để giữ thu nhập gấp đôi.';

  @override
  String get rewardedTitle => 'Tăng tốc miễn phí';

  @override
  String get rewardCaffeineRushTitle => 'Caffeine Rush';

  @override
  String get rewardCaffeineRushBody =>
      'Toàn bộ thu nhập ×2 trong 4 giờ (tối đa 8 giờ)';

  @override
  String get rewardEmergencyFundTitle => 'Quỹ khẩn cấp';

  @override
  String rewardEmergencyFundBody(String amount) {
    return 'Nhận ngay $amount';
  }

  @override
  String get rewardLabSpeedupTitle => 'Tăng tốc phòng thí nghiệm';

  @override
  String get rewardLabSpeedupBody => 'Hoàn tất ngay lần thử R&D đang chạy';

  @override
  String get watchAd => 'Xem quảng cáo';

  @override
  String readyIn(String time) {
    return 'Sẵn sàng sau $time';
  }

  @override
  String get unavailable => 'Không khả dụng';

  @override
  String boostActive(String multiplier, String time) {
    return '×$multiplier $time';
  }

  @override
  String get shopTitle => 'Cao cấp';

  @override
  String get vipTitle => 'VIP Bậc thầy rang xay';

  @override
  String get vipBody =>
      'Thu nhập ×2 vĩnh viễn, giới hạn ngoại tuyến 12 giờ và barista tự chạm';

  @override
  String get starterPackTitle => 'Gói khởi đầu Espresso';

  @override
  String get starterPackBody =>
      'Thu nhập ×1,25 vĩnh viễn cùng 2 giờ thu nhập bằng tiền mặt';

  @override
  String get timeSkipTitle => 'Tua nhanh 24 giờ';

  @override
  String timeSkipBody(String amount) {
    return 'Nhận ngay $amount';
  }

  @override
  String get buyProduct => 'Mua';

  @override
  String get owned => 'Đã sở hữu';

  @override
  String get restorePurchases => 'Khôi phục giao dịch';

  @override
  String get noForcedAds =>
      'Không có quảng cáo bắt buộc — quảng cáo có thưởng luôn là tùy chọn.';

  @override
  String get dailyRewardTitle => 'Phần thưởng hằng ngày';

  @override
  String dailyRewardDay(int day) {
    return 'Ngày $day';
  }

  @override
  String dailyRewardClaim(String amount) {
    return 'Nhận $amount';
  }

  @override
  String dailyRewardNext(String time) {
    return 'Phần thưởng tiếp theo sau $time';
  }

  @override
  String dailyRewardBean(int beans) {
    return '+$beans Hạt Vàng';
  }

  @override
  String tutorialTitle(int step, int total) {
    return 'Huấn luyện barista $step/$total';
  }

  @override
  String get tutorialStepBuyFirstShop =>
      'Mua một Xe đẩy đường phố ở thẻ Cửa hàng.';

  @override
  String get tutorialStepBuySecondShop => 'Mở cửa hàng thứ hai: Quầy góc phố.';

  @override
  String get tutorialStepHireManager =>
      'Thuê quản lý để tăng gấp ba thu nhập của một cửa hàng.';

  @override
  String get tutorialStepOpenLab => 'Mở thẻ R&D để khám phá công thức.';

  @override
  String get tutorialStepFinish =>
      'Bạn đã sẵn sàng xây dựng đế chế! Bật nhắc nhở để không bỏ lỡ phần thưởng nào.';

  @override
  String get tutorialSkip => 'Bỏ qua';

  @override
  String get tutorialFinish => 'Bắt đầu thôi!';

  @override
  String get achievementsTitle => 'Thành tựu';

  @override
  String achievementsProgress(int unlocked, int total, int percent) {
    return 'Đã mở $unlocked/$total · thu nhập +$percent%';
  }

  @override
  String achievementUnlocked(String name) {
    return 'Mở khóa thành tựu: $name';
  }

  @override
  String achDescLifetime(String amount) {
    return 'Kiếm tổng cộng $amount';
  }

  @override
  String achDescShopLevel(int level) {
    return 'Đạt cấp $level ở bất kỳ cửa hàng nào';
  }

  @override
  String achDescRecipes(int score, int count) {
    return 'Đạt $score+ ở $count công thức';
  }

  @override
  String achDescFranchises(int count) {
    return 'Sở hữu $count điểm nhượng quyền';
  }

  @override
  String achDescPrestige(int count) {
    return 'Bắt đầu đế chế mới $count lần';
  }

  @override
  String achDescTaps(int count) {
    return 'Chạm vào tách $count lần';
  }

  @override
  String get achievement_first_dollars => 'Những đồng đô đầu tiên';

  @override
  String get achievement_small_business => 'Kinh doanh nhỏ';

  @override
  String get achievement_coffee_mogul => 'Ông trùm cà phê';

  @override
  String get achievement_bean_tycoon => 'Vua hạt cà phê';

  @override
  String get achievement_caffeine_empire => 'Đế chế caffeine';

  @override
  String get achievement_growing_shop => 'Cửa hàng đang lớn';

  @override
  String get achievement_busy_counter => 'Quầy tấp nập';

  @override
  String get achievement_centurion => 'Bách phu trưởng';

  @override
  String get achievement_legendary_branch => 'Chi nhánh huyền thoại';

  @override
  String get achievement_first_masterpiece => 'Kiệt tác đầu tiên';

  @override
  String get achievement_lab_regular => 'Khách quen phòng thí nghiệm';

  @override
  String get achievement_master_brewer => 'Bậc thầy pha chế';

  @override
  String get achievement_first_franchise => 'Nhượng quyền đầu tiên';

  @override
  String get achievement_regional_brand => 'Thương hiệu khu vực';

  @override
  String get achievement_global_chain => 'Chuỗi toàn cầu';

  @override
  String get achievement_world_domination => 'Thống trị thế giới';

  @override
  String get achievement_fresh_start => 'Khởi đầu mới';

  @override
  String get achievement_serial_founder => 'Nhà sáng lập liên hoàn';

  @override
  String get achievement_eager_barista => 'Barista hăng hái';

  @override
  String get achievement_tireless_barista => 'Barista không biết mệt';

  @override
  String get settingsTitle => 'Cài đặt';

  @override
  String get settingsLanguage => 'Ngôn ngữ';

  @override
  String get languageSystem => 'Hệ thống';

  @override
  String get settingsSound => 'Âm thanh';

  @override
  String get settingsHaptics => 'Rung';

  @override
  String get settingsNotifications => 'Thông báo';

  @override
  String get settingsScientific => 'Ký hiệu khoa học';

  @override
  String get settingsReset => 'Đặt lại tiến trình';

  @override
  String get resetConfirmTitle => 'Đặt lại toàn bộ tiến trình?';

  @override
  String get resetConfirmBody =>
      'Thao tác này xóa dữ liệu lưu, bao gồm Hạt Vàng và giao dịch mua. Không thể hoàn tác.';

  @override
  String get resetConfirm => 'Đặt lại';

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
  String get stationUpgradesHint => 'Chạm để xem quản lý và thiết bị';

  @override
  String get spriteGalleryTitle => 'Thư viện sprite';

  @override
  String get tabCafe => 'Quán';

  @override
  String get tutorialStepServeCustomer =>
      'Chạm vào khách ở quầy, pha đồ uống rồi chạm lại để phục vụ.';

  @override
  String brewPanelTitle(String drink) {
    return 'Đang pha: $drink';
  }

  @override
  String get serveHint => 'Đồ uống xong! Chạm vào khách để phục vụ.';

  @override
  String get perfectServe => 'Hoàn hảo!';

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
  String get drink_cold_brew => 'Cold brew';

  @override
  String get editLayout => 'Sửa';

  @override
  String get editDone => 'Xong';

  @override
  String get editHint => 'Chạm vào đồ nội thất để di chuyển.';

  @override
  String get editRotate => 'Xoay';

  @override
  String get editStore => 'Cất kho';

  @override
  String get editPlace => 'Đặt';

  @override
  String get editCancel => 'Hủy';

  @override
  String get editInvalid => 'Không thể đặt ở đây';

  @override
  String get furnitureCatalog => 'Nội thất';

  @override
  String furnitureOwned(int count) {
    return 'Trong kho: $count';
  }

  @override
  String furnitureAppeal(int appeal) {
    return '+$appeal sức hút';
  }

  @override
  String furnitureLocked(String shop) {
    return 'Mở khóa với $shop';
  }

  @override
  String cafeAppealSummary(int appeal, String multiplier) {
    return 'Sức hút $appeal · thu nhập ×$multiplier';
  }

  @override
  String get furnitureCategorySeating => 'Chỗ ngồi';

  @override
  String get furnitureCategoryTable => 'Bàn';

  @override
  String get furnitureCategoryDecor => 'Trang trí';

  @override
  String get furnitureCategoryLighting => 'Chiếu sáng';

  @override
  String get furnitureCategoryCounter => 'Phụ kiện quầy';

  @override
  String get furniture_chair => 'Ghế gỗ';

  @override
  String get furniture_stool => 'Ghế đẩu';

  @override
  String get furniture_chair_white => 'Ghế trắng';

  @override
  String get furniture_bench => 'Ghế băng';

  @override
  String get furniture_armchair => 'Ghế bành';

  @override
  String get furniture_sofa => 'Sofa';

  @override
  String get furniture_table => 'Bàn';

  @override
  String get furniture_table_round => 'Bàn tròn';

  @override
  String get furniture_table_long => 'Bàn dài';

  @override
  String get furniture_table_bar => 'Bàn bar';

  @override
  String get furniture_table_marble => 'Bàn đá cẩm thạch';

  @override
  String get furniture_plant => 'Chậu cây';

  @override
  String get furniture_painting => 'Tranh';

  @override
  String get furniture_shelf => 'Kệ';

  @override
  String get furniture_rug => 'Thảm';

  @override
  String get furniture_bookcase => 'Tủ sách';

  @override
  String get furniture_record_player => 'Máy hát đĩa';

  @override
  String get furniture_neon_sign => 'Biển neon';

  @override
  String get furniture_aquarium => 'Bể cá';

  @override
  String get furniture_floor_lamp => 'Đèn cây';

  @override
  String get furniture_lantern => 'Đèn lồng';

  @override
  String get furniture_light_pillar => 'Cột đèn';

  @override
  String get furniture_pastry_case => 'Tủ bánh ngọt';

  @override
  String get furniture_drink_fridge => 'Tủ lạnh đồ uống';
}
