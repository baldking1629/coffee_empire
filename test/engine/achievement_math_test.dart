import 'package:coffee_empire/config/achievement_config.dart';
import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:coffee_empire/engine/achievement_math.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final catalog = AchievementCatalog(
    masteryScore: 90,
    achievements: [
      AchievementConfig(
        id: 'rich',
        type: AchievementType.lifetimeEarnings,
        threshold: BigNumber.parse('1e6'),
      ),
      AchievementConfig(
        id: 'level',
        type: AchievementType.shopLevel,
        threshold: BigNumber.fromInt(25),
      ),
      AchievementConfig(
        id: 'chef',
        type: AchievementType.recipeMastery,
        threshold: BigNumber.fromInt(2),
      ),
      AchievementConfig(
        id: 'chain',
        type: AchievementType.franchises,
        threshold: BigNumber.fromInt(3),
      ),
      const AchievementConfig(
        id: 'again',
        type: AchievementType.prestigeCount,
        threshold: BigNumber.one,
      ),
      AchievementConfig(
        id: 'taps',
        type: AchievementType.totalTaps,
        threshold: BigNumber.fromInt(100),
      ),
    ],
  );
  final math = AchievementMath(catalog, bonusPerAchievement: 0.01);

  AchievementProgress progress({
    String lifetime = '0',
    int level = 0,
    List<int> scores = const [],
    int slots = 0,
    int prestiges = 0,
    int taps = 0,
  }) => AchievementProgress(
    lifetimeEarnings: BigNumber.parse(lifetime),
    maxShopLevel: level,
    recipeBestScores: scores,
    franchiseSlots: slots,
    prestigeCount: prestiges,
    totalTaps: taps,
  );

  test('nothing unlocked at the start', () {
    expect(math.newlyUnlocked({}, progress()), isEmpty);
  });

  test('each type unlocks at its threshold', () {
    final unlocked = math.newlyUnlocked(
      {},
      progress(
        lifetime: '1e6',
        level: 25,
        scores: [95, 90, 50],
        slots: 3,
        prestiges: 1,
        taps: 100,
      ),
    );
    expect(unlocked, ['rich', 'level', 'chef', 'chain', 'again', 'taps']);
  });

  test('just below thresholds stays locked and owned ones are skipped', () {
    final unlocked = math.newlyUnlocked(
      {'rich'},
      progress(
        lifetime: '1e7',
        level: 24,
        scores: [95, 89],
        slots: 2,
        taps: 99,
      ),
    );
    expect(unlocked, isEmpty);
  });

  test('each achievement adds one percent income', () {
    expect(math.multiplier(0), BigNumber.one);
    expect(math.multiplier(20).toDouble(), closeTo(1.2, 1e-12));
  });
}
