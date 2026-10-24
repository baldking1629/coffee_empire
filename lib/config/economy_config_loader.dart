import 'package:flutter/services.dart';

import 'achievement_config.dart';
import 'economy_config.dart';

class EconomyConfigLoader {
  const EconomyConfigLoader(this.bundle);

  static const String assetPath = 'assets/config/economy.json';
  static const String achievementsPath = 'assets/config/achievements.json';

  final AssetBundle bundle;

  Future<EconomyConfig> load() async {
    final source = await bundle.loadString(assetPath);
    return EconomyConfig.fromJsonString(source);
  }

  Future<AchievementCatalog> loadAchievements() async {
    final source = await bundle.loadString(achievementsPath);
    return AchievementCatalog.fromJsonString(source);
  }
}
