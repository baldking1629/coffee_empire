import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../core/bignumber/big_number.dart';
import 'json_readers.dart';

enum AchievementType {
  lifetimeEarnings,
  shopLevel,
  recipeMastery,
  franchises,
  prestigeCount,
  totalTaps,
}

class AchievementConfig extends Equatable {
  const AchievementConfig({
    required this.id,
    required this.type,
    required this.threshold,
  });

  factory AchievementConfig.fromJson(JsonMap json) => AchievementConfig(
    id: readString(json, 'id'),
    type: AchievementType.values.byName(readString(json, 'type')),
    threshold: readBig(json, 'threshold'),
  );

  final String id;
  final AchievementType type;
  final BigNumber threshold;

  @override
  List<Object?> get props => [id, type, threshold];
}

class AchievementCatalog extends Equatable {
  const AchievementCatalog({
    required this.masteryScore,
    required this.achievements,
  });

  factory AchievementCatalog.fromJson(JsonMap json) => AchievementCatalog(
    masteryScore: readInt(json, 'masteryScore'),
    achievements: readList(json, 'achievements', AchievementConfig.fromJson),
  );

  factory AchievementCatalog.fromJsonString(String source) =>
      AchievementCatalog.fromJson(jsonDecode(source) as JsonMap);

  static const AchievementCatalog empty = AchievementCatalog(
    masteryScore: 100,
    achievements: [],
  );

  final int masteryScore;
  final List<AchievementConfig> achievements;

  @override
  List<Object?> get props => [masteryScore, achievements];
}
