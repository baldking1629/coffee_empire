import 'package:equatable/equatable.dart';

import '../config/economy_config.dart';

class CafeCosmetics extends Equatable {
  const CafeCosmetics({
    this.floorId,
    this.wallId,
    this.signId,
    this.lightId,
    this.outfits = const {},
    this.unlocked = const {},
  });

  factory CafeCosmetics.fromJson(Map<String, dynamic> json) => CafeCosmetics(
    floorId: json['floorId'] as String?,
    wallId: json['wallId'] as String?,
    signId: json['signId'] as String?,
    lightId: json['lightId'] as String?,
    outfits: (json['outfits'] as Map<String, dynamic>).map(
      (slot, id) => MapEntry(slot, id as String),
    ),
    unlocked: (json['unlocked'] as List<dynamic>).cast<String>().toSet(),
  );

  static const CafeCosmetics empty = CafeCosmetics();

  final String? floorId;
  final String? wallId;
  final String? signId;
  final String? lightId;
  final Map<String, String> outfits;
  final Set<String> unlocked;

  String? equippedId(CosmeticType type) => switch (type) {
    CosmeticType.floor => floorId,
    CosmeticType.wall => wallId,
    CosmeticType.sign => signId,
    CosmeticType.light => lightId,
    CosmeticType.outfit => null,
  };

  CafeCosmetics equip(CosmeticConfig cosmetic, {String? slot}) => CafeCosmetics(
    floorId: cosmetic.type == CosmeticType.floor ? cosmetic.id : floorId,
    wallId: cosmetic.type == CosmeticType.wall ? cosmetic.id : wallId,
    signId: cosmetic.type == CosmeticType.sign ? cosmetic.id : signId,
    lightId: cosmetic.type == CosmeticType.light ? cosmetic.id : lightId,
    outfits: cosmetic.type == CosmeticType.outfit && slot != null
        ? {...outfits, slot: cosmetic.id}
        : outfits,
    unlocked: unlocked,
  );

  CafeCosmetics withUnlocked(String id) => CafeCosmetics(
    floorId: floorId,
    wallId: wallId,
    signId: signId,
    lightId: lightId,
    outfits: outfits,
    unlocked: {...unlocked, id},
  );

  Map<String, dynamic> toJson() => {
    'floorId': floorId,
    'wallId': wallId,
    'signId': signId,
    'lightId': lightId,
    'outfits': outfits,
    'unlocked': unlocked.toList(),
  };

  @override
  List<Object?> get props => [
    floorId,
    wallId,
    signId,
    lightId,
    outfits,
    unlocked,
  ];
}

class CosmeticProgress {
  const CosmeticProgress({
    required this.shopLevels,
    required this.achievements,
    required this.vip,
  });

  final Map<String, int> shopLevels;
  final Set<String> achievements;
  final bool vip;
}

class CosmeticsRules {
  const CosmeticsRules({required this.catalog, required this.shops});

  final CosmeticsCatalog catalog;
  final List<ShopConfig> shops;

  bool isUnlocked(
    CosmeticConfig cosmetic,
    CafeCosmetics owned,
    CosmeticProgress progress,
  ) {
    if (owned.unlocked.contains(cosmetic.id)) return true;
    final unlock = cosmetic.unlock;
    return switch (unlock.kind) {
      CosmeticUnlockKind.defaultUnlocked => true,
      CosmeticUnlockKind.shopIndex =>
        unlock.amount < shops.length &&
            (progress.shopLevels[shops[unlock.amount].id] ?? 0) > 0,
      CosmeticUnlockKind.achievement => progress.achievements.contains(
        unlock.achievementId,
      ),
      CosmeticUnlockKind.goldenBeans => false,
      CosmeticUnlockKind.vip => progress.vip,
    };
  }

  CosmeticConfig? equipped(CafeCosmetics owned, CosmeticType type) =>
      catalog.byId(owned.equippedId(type)) ?? catalog.defaultFor(type);

  CosmeticConfig? outfitFor(CafeCosmetics owned, String slot) =>
      catalog.byId(owned.outfits[slot]) ??
      catalog.defaultFor(CosmeticType.outfit);

  int appealOf(CafeCosmetics owned) => [
    CosmeticType.floor,
    CosmeticType.wall,
    CosmeticType.sign,
    CosmeticType.light,
  ].fold(0, (total, type) => total + (equipped(owned, type)?.appeal ?? 0));
}
