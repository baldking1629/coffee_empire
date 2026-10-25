import 'package:coffee_empire/config/economy_config.dart';
import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:coffee_empire/engine/cafe_layout.dart';
import 'package:coffee_empire/engine/economy_engine.dart';
import 'package:coffee_empire/engine/layout_rules.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_economy.dart';

void main() {
  final economy = loadTestEconomy();
  final rules = EconomyEngine(economy).layoutRules;
  final room = rules.roomFor(1);
  final starter = economy.cafe.defaultLayout.items;

  LayoutItem piece(String uid, String itemId, int x, int y, [int r = 0]) =>
      LayoutItem(uid: uid, itemId: itemId, x: x, y: y, rotation: r);

  PlacementVerdict check(LayoutItem candidate, [List<LayoutItem>? items]) =>
      rules.verdict(room: room, items: items ?? starter, candidate: candidate);

  test('catalog has 24 furniture pieces across every category', () {
    final furniture = economy.cafe.furniture.values;
    expect(furniture, hasLength(24));
    int count(FurnitureCategory category) =>
        furniture.where((item) => item.category == category).length;
    expect(count(FurnitureCategory.seating), 6);
    expect(count(FurnitureCategory.table), 5);
    expect(count(FurnitureCategory.decor), 8);
    expect(count(FurnitureCategory.lighting), 3);
    expect(count(FurnitureCategory.counter), 2);
  });

  test('the starter layout is valid piece by piece', () {
    for (final item in starter) {
      expect(check(item), PlacementVerdict.valid, reason: item.uid);
    }
  });

  test('a free floor cell accepts a piece', () {
    expect(check(piece('new', 'armchair', 5, 8)), PlacementVerdict.valid);
  });

  test('overlapping, out of bounds, staff area and lane are rejected', () {
    expect(check(piece('new', 'plant', 1, 5)), PlacementVerdict.overlaps);
    expect(check(piece('new', 'plant', 8, 5)), PlacementVerdict.outOfBounds);
    expect(check(piece('new', 'sofa', 7, 6)), PlacementVerdict.outOfBounds);
    expect(check(piece('new', 'plant', 4, 2)), PlacementVerdict.staffArea);
    expect(check(piece('new', 'plant', 3, 6)), PlacementVerdict.blocksLane);
    expect(check(piece('new', 'rug', 2, 6)), PlacementVerdict.blocksLane);
  });

  test('rotation swaps the footprint of long pieces', () {
    expect(check(piece('new', 'sofa', 5, 7)), PlacementVerdict.valid);
    expect(check(piece('new', 'sofa', 7, 6)), PlacementVerdict.outOfBounds);
    expect(check(piece('new', 'sofa', 7, 6, 1)), PlacementVerdict.valid);
  });

  test('cutting the door off from the queue lane is rejected', () {
    final wall = [
      ...starter,
      for (final x in [1, 2, 4, 5, 6]) piece('wall_$x', 'table', x, 8),
    ];
    expect(
      check(piece('new', 'table', 3, 8), wall),
      PlacementVerdict.blocksPath,
    );
  });

  test('walling in a chair is rejected', () {
    final items = [...starter, piece('plant_below', 'plant', 0, 6)];
    expect(
      check(piece('new', 'plant', 0, 4), items),
      PlacementVerdict.blocksPath,
    );
  });

  test('room tier grows every two shops, caps and never shrinks', () {
    expect(rules.roomTierFor(0), 1);
    expect(rules.roomTierFor(1), 1);
    expect(rules.roomTierFor(2), 2);
    expect(rules.roomTierFor(10), 6);
    expect(rules.roomTierFor(0, current: 4), 4);
  });

  test('a bigger room keeps every piece valid and moves the door down', () {
    final bigger = rules.roomFor(3);
    expect(bigger.cols, room.cols + 2);
    expect(bigger.rows, room.rows + 2);
    expect(bigger.door, (x: room.door.x, y: bigger.rows - 1));
    for (final item in starter) {
      expect(
        rules.verdict(room: bigger, items: starter, candidate: item),
        PlacementVerdict.valid,
      );
    }
  });

  test('price follows the unlocking shop base cost', () {
    final armchair = economy.cafe.furniture['armchair']!;
    expect(
      rules.costOf(armchair),
      economy.shops[armchair.unlockShopIndex].baseCost *
          BigNumber.fromDouble(armchair.costMult),
    );
    expect(rules.isUnlocked(armchair, const {}), isFalse);
    expect(rules.isUnlocked(armchair, {economy.shops[2].id: 1}), isTrue);
  });

  test('layout json round trip', () {
    final layout = CafeLayout(roomTier: 3, items: starter);
    expect(CafeLayout.fromJson(layout.toJson()), layout);
  });
}
