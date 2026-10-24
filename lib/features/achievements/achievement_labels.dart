import '../../config/achievement_config.dart';
import '../../l10n/app_localizations.dart';

String achievementName(AppLocalizations l10n, String id) => switch (id) {
  'first_dollars' => l10n.achievement_first_dollars,
  'small_business' => l10n.achievement_small_business,
  'coffee_mogul' => l10n.achievement_coffee_mogul,
  'bean_tycoon' => l10n.achievement_bean_tycoon,
  'caffeine_empire' => l10n.achievement_caffeine_empire,
  'growing_shop' => l10n.achievement_growing_shop,
  'busy_counter' => l10n.achievement_busy_counter,
  'centurion' => l10n.achievement_centurion,
  'legendary_branch' => l10n.achievement_legendary_branch,
  'first_masterpiece' => l10n.achievement_first_masterpiece,
  'lab_regular' => l10n.achievement_lab_regular,
  'master_brewer' => l10n.achievement_master_brewer,
  'first_franchise' => l10n.achievement_first_franchise,
  'regional_brand' => l10n.achievement_regional_brand,
  'global_chain' => l10n.achievement_global_chain,
  'world_domination' => l10n.achievement_world_domination,
  'fresh_start' => l10n.achievement_fresh_start,
  'serial_founder' => l10n.achievement_serial_founder,
  'eager_barista' => l10n.achievement_eager_barista,
  'tireless_barista' => l10n.achievement_tireless_barista,
  _ => id,
};

String achievementDescription(
  AppLocalizations l10n,
  AchievementConfig achievement, {
  required int masteryScore,
  required String formattedAmount,
}) {
  final count = achievement.threshold.toDouble().round();
  return switch (achievement.type) {
    AchievementType.lifetimeEarnings => l10n.achDescLifetime(formattedAmount),
    AchievementType.shopLevel => l10n.achDescShopLevel(count),
    AchievementType.recipeMastery => l10n.achDescRecipes(masteryScore, count),
    AchievementType.franchises => l10n.achDescFranchises(count),
    AchievementType.prestigeCount => l10n.achDescPrestige(count),
    AchievementType.totalTaps => l10n.achDescTaps(count),
  };
}
