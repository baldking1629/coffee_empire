part of 'game_cubit.dart';

mixin _LayoutCommands on _GameCubitCore {
  static const Uuid _uuid = Uuid();

  LayoutRules get layoutRules => engine.layoutRules;

  CafeRoom get cafeRoom => layoutRules.roomFor(state.cafeLayout.roomTier);

  int get appeal => totalAppealOf(state);

  double get appealMultiplier => engine.appealMath.multiplier(appeal);

  bool isFurnitureUnlocked(FurnitureConfig item) =>
      layoutRules.isUnlocked(item, state.shopLevels);

  PlacementVerdict placementVerdict(LayoutItem candidate) =>
      layoutRules.verdict(
        room: cafeRoom,
        items: state.cafeLayout.items,
        candidate: candidate,
      );

  Future<bool> buyFurniture(String itemId) {
    final item = engine.config.cafe.furniture[itemId];
    if (item == null || !isFurnitureUnlocked(item)) return _commit(null);
    final cost = layoutRules.costOf(item);
    if (state.cash < cost) return _commit(null);
    return _commit(
      state
          .spend(cost)
          .copyWith(inventory: _adjusted(state.inventory, itemId, 1)),
      feedback: FeedbackKind.purchase,
      onSuccess: () =>
          _log(AnalyticsEvents.furnitureBought, {'itemId': itemId}),
    );
  }

  Future<bool> placeFromInventory(
    String itemId, {
    required int x,
    required int y,
    int rotation = 0,
  }) {
    if ((state.inventory[itemId] ?? 0) <= 0) return _commit(null);
    final candidate = LayoutItem(
      uid: _uuid.v4(),
      itemId: itemId,
      x: x,
      y: y,
      rotation: rotation,
    );
    if (!_accepts(candidate)) return _commit(null);
    return _commitLayout(
      state.cafeLayout.withItem(candidate),
      _adjusted(state.inventory, itemId, -1),
    );
  }

  Future<bool> moveFurniture(LayoutItem moved) {
    if (state.cafeLayout.byUid(moved.uid) == null) return _commit(null);
    if (!_accepts(moved)) return _commit(null);
    return _commitLayout(state.cafeLayout.withItem(moved), state.inventory);
  }

  Future<bool> storeFurniture(String uid) {
    final item = state.cafeLayout.byUid(uid);
    if (item == null) return _commit(null);
    return _commitLayout(
      state.cafeLayout.without(uid),
      _adjusted(state.inventory, item.itemId, 1),
    );
  }

  bool _accepts(LayoutItem candidate) {
    if (placementVerdict(candidate) == PlacementVerdict.valid) return true;
    _play(FeedbackKind.placeInvalid);
    return false;
  }

  Future<bool> _commitLayout(CafeLayout layout, Map<String, int> inventory) =>
      _commit(
        state.copyWith(cafeLayout: layout, inventory: inventory),
        feedback: FeedbackKind.place,
        onSuccess: () => _log(AnalyticsEvents.layoutChanged, {
          'itemCount': layout.items.length,
        }),
      );

  Map<String, int> _adjusted(Map<String, int> source, String id, int delta) {
    final count = (source[id] ?? 0) + delta;
    return {
      for (final entry in source.entries)
        if (entry.key != id) entry.key: entry.value,
      if (count > 0) id: count,
    };
  }
}
