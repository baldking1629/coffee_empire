import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:coffee_empire/config/economy_config.dart';
import 'package:coffee_empire/engine/shop_math.dart';
import 'package:coffee_empire/features/game/game_state.dart';
import 'package:coffee_empire/features/game/save_migrations.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/cubit_harness.dart';

void main() {
  test('locked cosmetics cannot be equipped, unlocked ones can', () async {
    final harness = CubitHarness();
    final cubit = harness.build(harness.stateWithCash('1e6'));
    expect(await cubit.equipCosmetic('floor_marble'), isFalse);
    expect(cubit.equippedCosmetic(CosmeticType.floor)?.id, 'floor_classic');

    for (final shop in harness.config.shops.take(3)) {
      await cubit.buyShopLevels(shop.id, BuyAmount.one);
    }
    expect(await cubit.equipCosmetic('floor_marble'), isTrue);
    expect(cubit.equippedCosmetic(CosmeticType.floor)?.id, 'floor_marble');
    expect(cubit.state.cosmetics.floorId, 'floor_marble');
  });

  test('golden bean cosmetics spend beans once', () async {
    final harness = CubitHarness();
    final cubit = harness.build(
      harness.stateWithCash('5').copyWith(goldenBeans: 12),
    );
    expect(await cubit.equipCosmetic('sign_neon'), isFalse);
    expect(await cubit.unlockCosmetic('sign_neon'), isTrue);
    expect(cubit.state.goldenBeans, 2);
    expect(await cubit.unlockCosmetic('sign_neon'), isFalse);
    expect(await cubit.unlockCosmetic('floor_terracotta'), isFalse);
    expect(cubit.state.goldenBeans, 2);
    expect(await cubit.equipCosmetic('sign_neon'), isTrue);
    expect(await cubit.unlockCosmetic('floor_marble'), isFalse);
  });

  test('outfits are chosen per barista slot', () async {
    final harness = CubitHarness();
    final cubit = harness.build(
      harness.stateWithCash('5').copyWith(goldenBeans: 3),
    );
    await cubit.unlockCosmetic('outfit_purple');
    expect(await cubit.equipCosmetic('outfit_purple', slot: 'npc_1'), isTrue);
    expect(await cubit.equipCosmetic('outfit_purple', slot: 'nobody'), isFalse);
    expect(cubit.outfitFor('npc_1')?.id, 'outfit_purple');
    expect(cubit.outfitFor('player')?.id, 'outfit_green');
  });

  test('themes add appeal to income', () async {
    final harness = CubitHarness();
    final cubit = harness.build(
      harness
          .stateWithCash('5')
          .copyWith(goldenBeans: 5, shopLevels: const {'street_cart': 10}),
    );
    await cubit.unlockCosmetic('floor_terracotta');
    final before = cubit.state.incomePerSec.toDouble();
    await cubit.equipCosmetic('floor_terracotta');
    expect(cubit.appeal, 3);
    expect(
      cubit.state.incomePerSec.toDouble(),
      closeTo(before * cubit.appealMultiplier, 1e-9),
    );
  });

  test(
    'cosmetics survive prestige, save round trip and v7 migration',
    () async {
      final harness = CubitHarness();
      final cubit = harness.build(
        harness
            .stateWithCash('5')
            .copyWith(goldenBeans: 5, runEarnings: BigNumber.parse('1e14')),
      );
      await cubit.unlockCosmetic('wall_brick');
      await cubit.equipCosmetic('wall_brick');
      final cosmetics = cubit.state.cosmetics;
      expect(await cubit.prestige(), isTrue);
      expect(cubit.state.cosmetics, cosmetics);
      expect(GameState.fromJson(cubit.state.toJson()).cosmetics, cosmetics);

      final v7 = Map<String, dynamic>.of(cubit.state.toJson())
        ..remove('cosmetics')
        ..['schemaVersion'] = 7;
      final migrated = GameState.fromJson(const SaveMigrations().migrate(v7));
      expect(migrated.cosmetics.floorId, isNull);
      expect(migrated.cosmetics.unlocked, isEmpty);
    },
  );

  test('machine look follows the newest open shop equipment', () async {
    final harness = CubitHarness();
    final cubit = harness.build(harness.stateWithCash('1e9'));
    expect(cubit.visibleEquipmentLevel, 0);
    await cubit.buyShopLevels('street_cart', BuyAmount.one);
    await cubit.buyEquipment('street_cart');
    expect(cubit.visibleEquipmentLevel, 1);
    await cubit.buyShopLevels('corner_booth', BuyAmount.one);
    expect(cubit.visibleEquipmentLevel, 0);
  });
}
