import 'package:coffee_empire/config/economy_config.dart';
import 'package:coffee_empire/engine/cosmetics_rules.dart';
import 'package:coffee_empire/engine/economy_engine.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/sprite_files.dart';
import '../helpers/test_economy.dart';

void main() {
  final economy = loadTestEconomy();
  final catalog = economy.cosmetics;
  final rules = EconomyEngine(economy).cosmeticsRules;
  const nothing = CosmeticProgress(
    shopLevels: {},
    achievements: {},
    vip: false,
  );

  CosmeticConfig byId(String id) => catalog.byId(id)!;

  test('catalog meets the minimum counts with unique ids', () {
    expect(catalog.ofType(CosmeticType.floor), hasLength(6));
    expect(catalog.ofType(CosmeticType.wall), hasLength(6));
    expect(catalog.ofType(CosmeticType.sign), hasLength(4));
    expect(catalog.ofType(CosmeticType.light), hasLength(4));
    expect(catalog.ofType(CosmeticType.outfit), hasLength(8));
    expect(catalog.cosmetics.map((c) => c.id).toSet(), hasLength(28));
    expect(catalog.outfitSlots, hasLength(4));
    for (final type in CosmeticType.values) {
      expect(catalog.defaultFor(type), isNotNull, reason: type.name);
    }
  });

  test('every cosmetic is a palette swap of existing sprites', () {
    final palettes = loadPalettes();
    final sprites = {for (final sprite in loadSprites()) sprite.id};
    for (final cosmetic in catalog.cosmetics) {
      expect(palettes.sets, contains(cosmetic.paletteSetId));
      if (cosmetic.type == CosmeticType.sign) {
        expect(sprites, contains(cosmetic.spriteId));
      }
    }
  });

  test('unlock rules follow their kind', () {
    expect(
      rules.isUnlocked(byId('floor_classic'), CafeCosmetics.empty, nothing),
      isTrue,
    );
    expect(
      rules.isUnlocked(byId('floor_marble'), CafeCosmetics.empty, nothing),
      isFalse,
    );
    expect(
      rules.isUnlocked(
        byId('floor_marble'),
        CafeCosmetics.empty,
        CosmeticProgress(
          shopLevels: {economy.shops[2].id: 1},
          achievements: const {},
          vip: false,
        ),
      ),
      isTrue,
    );
    expect(
      rules.isUnlocked(
        byId('floor_checker'),
        CafeCosmetics.empty,
        const CosmeticProgress(
          shopLevels: {},
          achievements: {'small_business'},
          vip: false,
        ),
      ),
      isTrue,
    );
    expect(
      rules.isUnlocked(
        byId('outfit_gold'),
        CafeCosmetics.empty,
        const CosmeticProgress(shopLevels: {}, achievements: {}, vip: true),
      ),
      isTrue,
    );
    expect(
      rules.isUnlocked(byId('sign_neon'), CafeCosmetics.empty, nothing),
      isFalse,
    );
    expect(
      rules.isUnlocked(
        byId('sign_neon'),
        const CafeCosmetics(unlocked: {'sign_neon'}),
        nothing,
      ),
      isTrue,
    );
  });

  test('defaults are worn until something else is equipped', () {
    expect(
      rules.equipped(CafeCosmetics.empty, CosmeticType.floor)?.id,
      'floor_classic',
    );
    expect(rules.outfitFor(CafeCosmetics.empty, 'npc_2')?.id, 'outfit_green');
    final dressed = CafeCosmetics.empty
        .equip(byId('floor_marble'))
        .equip(byId('outfit_red'), slot: 'npc_2');
    expect(rules.equipped(dressed, CosmeticType.floor)?.id, 'floor_marble');
    expect(rules.outfitFor(dressed, 'npc_2')?.id, 'outfit_red');
    expect(rules.outfitFor(dressed, 'player')?.id, 'outfit_green');
  });

  test('appeal counts equipped themes only', () {
    expect(rules.appealOf(CafeCosmetics.empty), 0);
    final themed = CafeCosmetics.empty
        .equip(byId('floor_terracotta'))
        .equip(byId('sign_neon'))
        .equip(byId('outfit_red'), slot: 'player');
    expect(rules.appealOf(themed), 7);
  });

  test('json round trip', () {
    final cosmetics = CafeCosmetics.empty
        .equip(byId('wall_brick'))
        .equip(byId('outfit_teal'), slot: 'npc_1')
        .withUnlocked('wall_brick');
    expect(CafeCosmetics.fromJson(cosmetics.toJson()), cosmetics);
  });
}
