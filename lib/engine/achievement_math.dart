import 'package:equatable/equatable.dart';

import '../config/achievement_config.dart';
import '../core/bignumber/big_number.dart';

class AchievementProgress extends Equatable {
  const AchievementProgress({
    required this.lifetimeEarnings,
    required this.maxShopLevel,
    required this.recipeBestScores,
    required this.franchiseSlots,
    required this.prestigeCount,
    required this.totalTaps,
  });

  final BigNumber lifetimeEarnings;
  final int maxShopLevel;
  final Iterable<int> recipeBestScores;
  final int franchiseSlots;
  final int prestigeCount;
  final int totalTaps;

  @override
  List<Object?> get props => [
    lifetimeEarnings,
    maxShopLevel,
    recipeBestScores,
    franchiseSlots,
    prestigeCount,
    totalTaps,
  ];
}

class AchievementMath {
  const AchievementMath(this.catalog, {required this.bonusPerAchievement});

  final AchievementCatalog catalog;
  final double bonusPerAchievement;

  BigNumber progressValue(
    AchievementType type,
    AchievementProgress progress,
  ) => switch (type) {
    AchievementType.lifetimeEarnings => progress.lifetimeEarnings,
    AchievementType.shopLevel => BigNumber.fromInt(progress.maxShopLevel),
    AchievementType.recipeMastery => BigNumber.fromInt(
      progress.recipeBestScores
          .where((score) => score >= catalog.masteryScore)
          .length,
    ),
    AchievementType.franchises => BigNumber.fromInt(progress.franchiseSlots),
    AchievementType.prestigeCount => BigNumber.fromInt(progress.prestigeCount),
    AchievementType.totalTaps => BigNumber.fromInt(progress.totalTaps),
  };

  bool isMet(AchievementConfig achievement, AchievementProgress progress) =>
      progressValue(achievement.type, progress) >= achievement.threshold;

  List<String> newlyUnlocked(Set<String> owned, AchievementProgress progress) =>
      [
        for (final achievement in catalog.achievements)
          if (!owned.contains(achievement.id) && isMet(achievement, progress))
            achievement.id,
      ];

  BigNumber multiplier(int unlockedCount) =>
      BigNumber.fromDouble(1 + unlockedCount * bonusPerAchievement);
}
