import 'package:coffee_empire/config/economy_config.dart';
import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:coffee_empire/engine/layout_rules.dart';
import 'package:coffee_empire/engine/shop_math.dart';
import 'package:coffee_empire/features/game/game_state.dart';
import 'package:coffee_empire/features/game/save_migrations.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/cubit_harness.dart';

void main() {
  test('a new cafe starts with the starter furniture placed', () {
    final harness = CubitHarness();
    final cubit = harness.build();
    expect(
      cubit.state.cafeLayout.items,
      harness.config.cafe.defaultLayout.items,
    );
    expect(cubit.state.cafeLayout.roomTier, 1);
    expect(cubit.state.inventory, isEmpty);
  });

  test('buying furniture spends cash and fills storage', () async {
    final harness = CubitHarness();
    final cubit = harness.build(harness.stateWithCash('1e6'));
    final cost = cubit.layoutRules.costOf(
      harness.config.cafe.furniture['stool']!,
    );
    expect(await cubit.buyFurniture('stool'), isTrue);
    expect(cubit.state.cash, BigNumber.parse('1e6') - cost);
    expect(cubit.state.inventory['stool'], 1);

    expect(await cubit.buyFurniture('armchair'), isFalse);
    final poor = harness.build(harness.stateWithCash('1'));
    expect(await poor.buyFurniture('stool'), isFalse);
    expect(poor.state.inventory, isEmpty);
  });

  test('placing, moving and storing keep storage and layout in sync', () async {
    final harness = CubitHarness();
    final cubit = harness.build(harness.stateWithCash('1e6'));
    await cubit.buyFurniture('stool');
    expect(await cubit.placeFromInventory('stool', x: 3, y: 6), isFalse);
    expect(cubit.state.inventory['stool'], 1);

    expect(await cubit.placeFromInventory('stool', x: 5, y: 8), isTrue);
    expect(cubit.state.inventory, isEmpty);
    final placed = cubit.state.cafeLayout.items.last;
    expect(placed.itemId, 'stool');

    expect(await cubit.moveFurniture(placed.copyWith(x: 1, y: 5)), isFalse);
    expect(await cubit.moveFurniture(placed.copyWith(x: 6, y: 8)), isTrue);
    expect(cubit.state.cafeLayout.byUid(placed.uid)?.x, 6);

    expect(await cubit.storeFurniture(placed.uid), isTrue);
    expect(cubit.state.cafeLayout.byUid(placed.uid), isNull);
    expect(cubit.state.inventory['stool'], 1);
  });

  test('placed decor raises income through appeal', () async {
    final harness = CubitHarness();
    final cubit = harness.build(
      harness
          .stateWithCash('1e9')
          .copyWith(
            shopLevels: {for (final shop in harness.config.shops) shop.id: 1},
          ),
    );
    final before = cubit.state.incomePerSec.toDouble();
    await cubit.buyFurniture('aquarium');
    await cubit.placeFromInventory('aquarium', x: 5, y: 7);
    expect(cubit.appeal, 6);
    expect(
      cubit.state.incomePerSec.toDouble(),
      closeTo(before * cubit.appealMultiplier, before * 1e-9),
    );
  });

  test(
    'opening shops grows the room, prestige keeps layout and storage',
    () async {
      final harness = CubitHarness();
      final cubit = harness.build(harness.stateWithCash('1e12'));
      await cubit.buyFurniture('stool');
      for (final shop in harness.config.shops.take(4)) {
        await cubit.buyShopLevels(shop.id, BuyAmount.one);
      }
      expect(cubit.state.cafeLayout.roomTier, 3);
      final layout = cubit.state.cafeLayout;
      final inventory = cubit.state.inventory;

      final rich = harness.build(
        cubit.state.copyWith(runEarnings: BigNumber.parse('1e14')),
      );
      expect(await rich.prestige(), isTrue);
      expect(rich.state.shopLevels, isEmpty);
      expect(rich.state.cafeLayout, layout);
      expect(rich.state.inventory, inventory);
      expect(rich.cafeRoom.cols, harness.config.cafe.defaultLayout.cols + 2);
    },
  );

  test('layout and storage survive a save round trip and migrate from v6', () {
    final harness = CubitHarness();
    final state = harness.build().state.copyWith(inventory: const {'sofa': 2});
    final restored = GameState.fromJson(state.toJson());
    expect(restored.cafeLayout, state.cafeLayout);
    expect(restored.inventory, {'sofa': 2});

    final v6 = Map<String, dynamic>.of(state.toJson())
      ..remove('cafeLayout')
      ..remove('inventory')
      ..['schemaVersion'] = 6;
    final migrated = GameState.fromJson(const SaveMigrations().migrate(v6));
    expect(migrated.cafeLayout.items, isEmpty);
    expect(harness.build(migrated).state.cafeLayout.items, isNotEmpty);
  });

  test('an invalid placement is refused with a verdict', () {
    final cubit = CubitHarness().build();
    expect(
      cubit.placementVerdict(
        const LayoutItem(uid: 'x', itemId: 'plant', x: 3, y: 5),
      ),
      PlacementVerdict.blocksLane,
    );
  });
}
