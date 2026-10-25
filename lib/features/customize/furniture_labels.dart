import '../../config/cafe_config.dart';
import '../../l10n/app_localizations.dart';

String furnitureName(AppLocalizations l10n, String id) => switch (id) {
  'chair' => l10n.furniture_chair,
  'stool' => l10n.furniture_stool,
  'chair_white' => l10n.furniture_chair_white,
  'bench' => l10n.furniture_bench,
  'armchair' => l10n.furniture_armchair,
  'sofa' => l10n.furniture_sofa,
  'table' => l10n.furniture_table,
  'table_round' => l10n.furniture_table_round,
  'table_long' => l10n.furniture_table_long,
  'table_bar' => l10n.furniture_table_bar,
  'table_marble' => l10n.furniture_table_marble,
  'plant' => l10n.furniture_plant,
  'painting' => l10n.furniture_painting,
  'shelf' => l10n.furniture_shelf,
  'rug' => l10n.furniture_rug,
  'bookcase' => l10n.furniture_bookcase,
  'record_player' => l10n.furniture_record_player,
  'neon_sign' => l10n.furniture_neon_sign,
  'aquarium' => l10n.furniture_aquarium,
  'floor_lamp' => l10n.furniture_floor_lamp,
  'lantern' => l10n.furniture_lantern,
  'light_pillar' => l10n.furniture_light_pillar,
  'pastry_case' => l10n.furniture_pastry_case,
  'drink_fridge' => l10n.furniture_drink_fridge,
  _ => id,
};

String furnitureCategoryName(
  AppLocalizations l10n,
  FurnitureCategory category,
) => switch (category) {
  FurnitureCategory.seating => l10n.furnitureCategorySeating,
  FurnitureCategory.table => l10n.furnitureCategoryTable,
  FurnitureCategory.decor => l10n.furnitureCategoryDecor,
  FurnitureCategory.lighting => l10n.furnitureCategoryLighting,
  FurnitureCategory.counter => l10n.furnitureCategoryCounter,
};
