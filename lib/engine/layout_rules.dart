import 'dart:math';

import '../config/economy_config.dart';
import '../core/bignumber/big_number.dart';
import 'cafe_floor_plan.dart';
import 'cafe_layout.dart';
import 'grid_pathfinding.dart';

enum PlacementVerdict {
  valid,
  unknownItem,
  outOfBounds,
  staffArea,
  overlaps,
  blocksLane,
  blocksPath,
}

class LayoutRules {
  const LayoutRules({
    required this.catalog,
    required this.rules,
    required this.shops,
    required this.laneLength,
  });

  final CafeCatalog catalog;
  final CafeRulesConfig rules;
  final List<ShopConfig> shops;
  final int laneLength;

  int roomTierFor(int openedShops, {int current = 1}) {
    final earned = 1 + openedShops ~/ rules.shopsPerRoomTier;
    return min(rules.maxRoomTier, max(current, earned));
  }

  CafeRoom roomFor(int tier) =>
      CafeRoom.forTier(catalog.defaultLayout, rules, tier);

  bool isUnlocked(FurnitureConfig item, Map<String, int> shopLevels) {
    if (item.unlockShopIndex <= 0) return true;
    if (item.unlockShopIndex >= shops.length) return false;
    return (shopLevels[shops[item.unlockShopIndex].id] ?? 0) > 0;
  }

  BigNumber costOf(FurnitureConfig item) {
    final index = item.unlockShopIndex.clamp(0, shops.length - 1);
    return shops[index].baseCost * BigNumber.fromDouble(item.costMult);
  }

  CafeFloorPlan planFor(CafeRoom room, Iterable<LayoutItem> items) =>
      CafeFloorPlan.build(
        room: room,
        items: items,
        catalog: catalog,
        laneLength: laneLength,
      );

  PlacementVerdict verdict({
    required CafeRoom room,
    required List<LayoutItem> items,
    required LayoutItem candidate,
  }) {
    final shape = catalog.furniture[candidate.itemId];
    if (shape == null) return PlacementVerdict.unknownItem;
    final cells = candidate.cellsFor(shape);
    if (!cells.every(room.contains)) return PlacementVerdict.outOfBounds;
    if (cells.any((cell) => cell.y < room.queueHead.y)) {
      return PlacementVerdict.staffArea;
    }
    final lane = room.laneCells(laneLength).toSet()..add(room.door);
    if (cells.any(lane.contains)) return PlacementVerdict.blocksLane;
    final others = [
      for (final item in items)
        if (item.uid != candidate.uid) item,
    ];
    final occupied = <GridCell>{
      for (final item in [...room.fixedItems, ...others])
        if (catalog.shapeOf(item.itemId) case final other?)
          ...item.cellsFor(other),
    };
    if (cells.any(occupied.contains)) return PlacementVerdict.overlaps;
    final plan = planFor(room, [...others, candidate]);
    final reachable = GridPathfinder(
      cols: room.cols,
      rows: room.rows,
    ).reachableFrom(room.door, plan.blocked);
    final targets = [...plan.lane, ...plan.seats];
    if (!targets.every(reachable.contains)) return PlacementVerdict.blocksPath;
    return PlacementVerdict.valid;
  }
}
