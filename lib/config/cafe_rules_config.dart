import 'package:equatable/equatable.dart';

import 'json_readers.dart';

class CafeRulesConfig extends Equatable {
  const CafeRulesConfig({
    required this.appealBonus,
    required this.appealCap,
    required this.maxRoomTier,
    required this.shopsPerRoomTier,
    required this.tilesPerRoomTier,
  });

  factory CafeRulesConfig.fromJson(JsonMap json) => CafeRulesConfig(
    appealBonus: readDouble(json, 'appealBonus'),
    appealCap: readDouble(json, 'appealCap'),
    maxRoomTier: readInt(json, 'maxRoomTier'),
    shopsPerRoomTier: readInt(json, 'shopsPerRoomTier'),
    tilesPerRoomTier: readInt(json, 'tilesPerRoomTier'),
  );

  final double appealBonus;
  final double appealCap;
  final int maxRoomTier;
  final int shopsPerRoomTier;
  final int tilesPerRoomTier;

  @override
  List<Object?> get props => [
    appealBonus,
    appealCap,
    maxRoomTier,
    shopsPerRoomTier,
    tilesPerRoomTier,
  ];
}
