import '../../config/cosmetics_config.dart';
import '../../l10n/app_localizations.dart';

String cosmeticName(AppLocalizations l10n, String id) => switch (id) {
  'floor_classic' => l10n.cosmetic_floor_classic,
  'floor_marble' => l10n.cosmetic_floor_marble,
  'floor_dark_wood' => l10n.cosmetic_floor_dark_wood,
  'floor_checker' => l10n.cosmetic_floor_checker,
  'floor_terracotta' => l10n.cosmetic_floor_terracotta,
  'floor_mint' => l10n.cosmetic_floor_mint,
  'wall_cream' => l10n.cosmetic_wall_cream,
  'wall_sage' => l10n.cosmetic_wall_sage,
  'wall_navy' => l10n.cosmetic_wall_navy,
  'wall_rose' => l10n.cosmetic_wall_rose,
  'wall_brick' => l10n.cosmetic_wall_brick,
  'wall_charcoal' => l10n.cosmetic_wall_charcoal,
  'sign_classic' => l10n.cosmetic_sign_classic,
  'sign_round' => l10n.cosmetic_sign_round,
  'sign_chalk' => l10n.cosmetic_sign_chalk,
  'sign_neon' => l10n.cosmetic_sign_neon,
  'light_neutral' => l10n.cosmetic_light_neutral,
  'light_warm' => l10n.cosmetic_light_warm,
  'light_cool' => l10n.cosmetic_light_cool,
  'light_neon' => l10n.cosmetic_light_neon,
  'outfit_green' => l10n.cosmetic_outfit_green,
  'outfit_red' => l10n.cosmetic_outfit_red,
  'outfit_navy' => l10n.cosmetic_outfit_navy,
  'outfit_pink' => l10n.cosmetic_outfit_pink,
  'outfit_black' => l10n.cosmetic_outfit_black,
  'outfit_purple' => l10n.cosmetic_outfit_purple,
  'outfit_teal' => l10n.cosmetic_outfit_teal,
  'outfit_gold' => l10n.cosmetic_outfit_gold,
  _ => id,
};

String cosmeticTypeName(AppLocalizations l10n, CosmeticType type) =>
    switch (type) {
      CosmeticType.floor => l10n.cosmeticTypeFloor,
      CosmeticType.wall => l10n.cosmeticTypeWall,
      CosmeticType.sign => l10n.cosmeticTypeSign,
      CosmeticType.light => l10n.cosmeticTypeLight,
      CosmeticType.outfit => l10n.cosmeticTypeOutfit,
    };

String outfitSlotName(AppLocalizations l10n, int index) =>
    index == 0 ? l10n.outfitSlotPlayer : l10n.outfitSlotBarista(index);
