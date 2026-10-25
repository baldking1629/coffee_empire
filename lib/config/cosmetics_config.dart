import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'json_readers.dart';

enum CosmeticType { floor, wall, sign, light, outfit }

enum CosmeticUnlockKind {
  defaultUnlocked,
  shopIndex,
  achievement,
  goldenBeans,
  vip,
}

class CosmeticUnlock extends Equatable {
  const CosmeticUnlock({
    required this.kind,
    this.amount = 0,
    this.achievementId,
  });

  factory CosmeticUnlock.fromJson(JsonMap json) {
    final kind = readString(json, 'kind');
    final value = json['value'];
    return CosmeticUnlock(
      kind: kind == 'default'
          ? CosmeticUnlockKind.defaultUnlocked
          : CosmeticUnlockKind.values.byName(kind),
      amount: value is num ? value.toInt() : 0,
      achievementId: value is String ? value : null,
    );
  }

  final CosmeticUnlockKind kind;
  final int amount;
  final String? achievementId;

  @override
  List<Object?> get props => [kind, amount, achievementId];
}

class CosmeticConfig extends Equatable {
  const CosmeticConfig({
    required this.id,
    required this.nameKey,
    required this.type,
    required this.paletteSetId,
    required this.appeal,
    required this.unlock,
    this.spriteId,
    this.intensity = 0,
  });

  factory CosmeticConfig.fromJson(JsonMap json) => CosmeticConfig(
    id: readString(json, 'id'),
    nameKey: readString(json, 'nameKey'),
    type: CosmeticType.values.byName(readString(json, 'type')),
    paletteSetId: readString(json, 'paletteSetId'),
    appeal: readInt(json, 'appeal'),
    unlock: CosmeticUnlock.fromJson(readMap(json, 'unlock')),
    spriteId: json['spriteId'] as String?,
    intensity: (json['intensity'] as num?)?.toDouble() ?? 0,
  );

  final String id;
  final String nameKey;
  final CosmeticType type;
  final String paletteSetId;
  final int appeal;
  final CosmeticUnlock unlock;
  final String? spriteId;
  final double intensity;

  @override
  List<Object?> get props => [
    id,
    nameKey,
    type,
    paletteSetId,
    appeal,
    unlock,
    spriteId,
    intensity,
  ];
}

class CosmeticsCatalog extends Equatable {
  const CosmeticsCatalog({required this.outfitSlots, required this.cosmetics});

  factory CosmeticsCatalog.fromJsonString(String source) {
    final json = jsonDecode(source) as JsonMap;
    return CosmeticsCatalog(
      outfitSlots: (json['outfitSlots'] as List<dynamic>).cast<String>(),
      cosmetics: readList(json, 'cosmetics', CosmeticConfig.fromJson),
    );
  }

  static const CosmeticsCatalog empty = CosmeticsCatalog(
    outfitSlots: [],
    cosmetics: [],
  );

  final List<String> outfitSlots;
  final List<CosmeticConfig> cosmetics;

  CosmeticConfig? byId(String? id) {
    for (final cosmetic in cosmetics) {
      if (cosmetic.id == id) return cosmetic;
    }
    return null;
  }

  List<CosmeticConfig> ofType(CosmeticType type) => [
    for (final cosmetic in cosmetics)
      if (cosmetic.type == type) cosmetic,
  ];

  CosmeticConfig? defaultFor(CosmeticType type) {
    for (final cosmetic in ofType(type)) {
      if (cosmetic.unlock.kind == CosmeticUnlockKind.defaultUnlocked) {
        return cosmetic;
      }
    }
    return null;
  }

  @override
  List<Object?> get props => [outfitSlots, cosmetics];
}
