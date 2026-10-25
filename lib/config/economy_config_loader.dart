import 'package:flutter/services.dart';

import 'achievement_config.dart';
import 'economy_config.dart';

class EconomyConfigLoader {
  const EconomyConfigLoader(this.bundle);

  static const String assetPath = 'assets/config/economy.json';
  static const String achievementsPath = 'assets/config/achievements.json';
  static const String furniturePath = 'assets/config/furniture.json';
  static const String cosmeticsPath = 'assets/config/cosmetics.json';

  final AssetBundle bundle;

  Future<EconomyConfig> load() async {
    final source = await bundle.loadString(assetPath);
    final cafeSource = await bundle.loadString(furniturePath);
    final cosmeticsSource = await bundle.loadString(cosmeticsPath);
    return EconomyConfig.fromJsonString(
      source,
      cafeSource: cafeSource,
      cosmeticsSource: cosmeticsSource,
    );
  }

  Future<AchievementCatalog> loadAchievements() async {
    final source = await bundle.loadString(achievementsPath);
    return AchievementCatalog.fromJsonString(source);
  }
}
