import 'package:coffee_empire/pixel/palette_set.dart';
import 'package:coffee_empire/pixel/sprite_definition.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/sprite_files.dart';

const requiredSprites = [
  'floor_tile',
  'wall_tile',
  'door',
  'counter',
  'cash_register',
  'table',
  'table_long',
  'chair',
  'plant',
  'sign',
  'espresso_machine_0',
  'espresso_machine_1',
  'espresso_machine_2',
  'espresso_machine_3',
  'steam',
  'customer_a',
  'customer_b',
  'customer_c',
  'customer_d',
  'barista',
  'order_bubble',
  'drink_espresso',
  'drink_americano',
  'drink_latte',
  'drink_cappuccino',
  'drink_mocha',
  'drink_cold_brew',
  'coin',
  'heart',
  'heart_broken',
  'star',
  'lock',
  'building_street_cart',
  'building_corner_booth',
  'building_boutique_cafe',
  'building_campus_coworking',
  'building_drive_thru',
  'building_city_roastery',
  'building_airport_lounge',
  'building_robotic_kiosk',
  'building_capsule_store',
  'building_global_mega_roastery',
];

void main() {
  final sprites = loadSprites();
  final palettes = loadPalettes();

  test('sprite ids are unique and the base set is complete', () {
    final ids = sprites.map((s) => s.id).toList();
    expect(ids.toSet(), hasLength(ids.length));
    expect(ids, containsAll(requiredSprites));
  });

  for (final sprite in sprites) {
    test('${sprite.id} has well-formed frames and palette symbols', () {
      expect(sprite.animations, isNotEmpty);
      for (final entry in sprite.animations.entries) {
        expect(entry.value, isNotEmpty, reason: entry.key);
        for (final frame in entry.value) {
          expect(frame, hasLength(sprite.height), reason: entry.key);
          for (final row in frame) {
            expect(row.length, sprite.width, reason: '${entry.key}: $row');
            for (final symbol in row.split('')) {
              if (symbol == SpriteDefinition.transparent) continue;
              expect(sprite.palette.keys, contains(symbol), reason: entry.key);
            }
          }
        }
      }
      expect(palettes.slots, containsAll(sprite.palette.values));
    });
  }

  test('characters have the required animations', () {
    for (final id in ['customer_a', 'customer_b', 'customer_c', 'customer_d']) {
      final sprite = sprites.firstWhere((s) => s.id == id);
      expect(
        sprite.animations.keys,
        containsAll(['idle_down', 'walk_down', 'walk_up', 'walk_side']),
      );
      expect(sprite.frameCount('walk_down'), 4);
      expect(sprite.frameCount('idle_down'), 2);
    }
    final barista = sprites.firstWhere((s) => s.id == 'barista');
    expect(barista.frameCount('prepare'), 4);
    expect(sprites.firstWhere((s) => s.id == 'steam').frameCount('default'), 3);
  });

  test('base palette defines every slot and overlays only known slots', () {
    final base = palettes.sets[PaletteCatalog.baseSet] ?? const {};
    expect(base.keys.toSet(), palettes.slots.toSet());
    for (final entry in palettes.sets.entries) {
      expect(palettes.slots, containsAll(entry.value.keys), reason: entry.key);
      final resolved = palettes.resolve(PaletteCatalog.keyOf([entry.key]));
      expect(resolved.keys.toSet(), palettes.slots.toSet(), reason: entry.key);
    }
  });

  test('palette swaps give at least 16 customer looks', () {
    int count(String prefix) =>
        palettes.sets.keys.where((name) => name.startsWith(prefix)).length + 1;
    expect(
      4 * count('skin_') * count('hair_') * count('shirt_'),
      greaterThanOrEqualTo(16),
    );
  });
}
