part of 'game_cubit.dart';

mixin _CosmeticCommands on _GameCubitCore {
  CosmeticsRules get cosmeticsRules => engine.cosmeticsRules;

  CosmeticProgress get _progress => CosmeticProgress(
    shopLevels: state.shopLevels,
    achievements: state.achievements,
    vip: state.store.isVip,
  );

  bool isCosmeticUnlocked(CosmeticConfig cosmetic) =>
      cosmeticsRules.isUnlocked(cosmetic, state.cosmetics, _progress);

  CosmeticConfig? equippedCosmetic(CosmeticType type) =>
      cosmeticsRules.equipped(state.cosmetics, type);

  CosmeticConfig? outfitFor(String slot) =>
      cosmeticsRules.outfitFor(state.cosmetics, slot);

  int get visibleEquipmentLevel {
    for (final shop in engine.config.shops.reversed) {
      if ((state.shopLevels[shop.id] ?? 0) > 0) {
        return state.equipment[shop.id] ?? 0;
      }
    }
    return 0;
  }

  Future<bool> equipCosmetic(String id, {String? slot}) {
    final cosmetic = engine.config.cosmetics.byId(id);
    if (cosmetic == null || !isCosmeticUnlocked(cosmetic)) {
      _play(FeedbackKind.placeInvalid);
      return _commit(null);
    }
    if (cosmetic.type == CosmeticType.outfit &&
        !engine.config.cosmetics.outfitSlots.contains(slot)) {
      return _commit(null);
    }
    return _commit(
      state.copyWith(cosmetics: state.cosmetics.equip(cosmetic, slot: slot)),
      feedback: FeedbackKind.place,
      onSuccess: () => _log(AnalyticsEvents.cosmeticEquipped, {'id': id}),
    );
  }

  Future<bool> unlockCosmetic(String id) {
    final cosmetic = engine.config.cosmetics.byId(id);
    if (cosmetic == null ||
        cosmetic.unlock.kind != CosmeticUnlockKind.goldenBeans ||
        isCosmeticUnlocked(cosmetic) ||
        state.goldenBeans < cosmetic.unlock.amount) {
      return _commit(null);
    }
    return _commit(
      state.copyWith(
        goldenBeans: state.goldenBeans - cosmetic.unlock.amount,
        cosmetics: state.cosmetics.withUnlocked(id),
      ),
      feedback: FeedbackKind.purchase,
      onSuccess: () => _log(AnalyticsEvents.cosmeticUnlocked, {'id': id}),
    );
  }
}
