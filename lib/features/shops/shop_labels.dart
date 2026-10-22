import 'package:flutter/widgets.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../l10n/app_localizations.dart';

String shopName(AppLocalizations l10n, String shopId) => switch (shopId) {
  'street_cart' => l10n.shop_street_cart,
  'corner_booth' => l10n.shop_corner_booth,
  'boutique_cafe' => l10n.shop_boutique_cafe,
  'campus_coworking' => l10n.shop_campus_coworking,
  'drive_thru' => l10n.shop_drive_thru,
  'city_roastery' => l10n.shop_city_roastery,
  'airport_lounge' => l10n.shop_airport_lounge,
  'robotic_kiosk' => l10n.shop_robotic_kiosk,
  'capsule_store' => l10n.shop_capsule_store,
  'global_mega_roastery' => l10n.shop_global_mega_roastery,
  _ => shopId,
};

IconData shopIcon(String shopId) => switch (shopId) {
  'street_cart' => LucideIcons.coffee,
  'corner_booth' => LucideIcons.store,
  'boutique_cafe' => LucideIcons.cupSoda,
  'campus_coworking' => LucideIcons.laptop,
  'drive_thru' => LucideIcons.car,
  'city_roastery' => LucideIcons.flame,
  'airport_lounge' => LucideIcons.plane,
  'robotic_kiosk' => LucideIcons.bot,
  'capsule_store' => LucideIcons.package,
  'global_mega_roastery' => LucideIcons.globe,
  _ => LucideIcons.coffee,
};

String equipmentName(AppLocalizations l10n, int tier) => switch (tier) {
  0 => l10n.equipmentEspressoMachine,
  1 => l10n.equipmentDiamondGrinder,
  _ => l10n.equipmentSmartSystem,
};
