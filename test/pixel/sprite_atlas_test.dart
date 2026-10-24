import 'dart:ui' as ui;

import 'package:coffee_empire/pixel/palette_set.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/sprite_files.dart';

Future<List<int>> rgbaAt(ui.Image image, int x, int y) async {
  final bytes = await image.toByteData();
  final data = bytes?.buffer.asUint8List() ?? <int>[];
  final offset = (y * image.width + x) * 4;
  return data.sublist(offset, offset + 4);
}

void main() {
  testWidgets('same key is drawn once and served from the cache', (
    tester,
  ) async {
    final atlas = loadAtlas();
    final first = atlas.get('chair');
    final again = atlas.get('chair');
    expect(identical(first, again), isTrue);
    expect(atlas.cachedCount, 1);
    atlas.get('chair', flipX: true);
    expect(atlas.cachedCount, 2);
  });

  testWidgets('palette overlay swaps colors without new sprite data', (
    tester,
  ) async {
    await tester.runAsync(() async {
      final atlas = loadAtlas();
      final marble = atlas.palettes.resolve(
        PaletteCatalog.keyOf(['floor_marble']),
      );
      final base = atlas.get('floor_tile');
      final swapped = atlas.get(
        'floor_tile',
        paletteKey: PaletteCatalog.keyOf(['floor_marble']),
      );
      expect(identical(base, swapped), isFalse);
      final expected = marble['floor_a'];
      final pixel = await rgbaAt(swapped, 0, 0);
      expect(pixel, [
        ((expected?.r ?? 0) * 255).round(),
        ((expected?.g ?? 0) * 255).round(),
        ((expected?.b ?? 0) * 255).round(),
        255,
      ]);
    });
  });

  testWidgets('warm-up draws every frame of every sprite once', (tester) async {
    final atlas = loadAtlas();
    final expected = atlas.sprites.values.fold<int>(
      0,
      (sum, sprite) =>
          sum +
          sprite.animations.values.fold<int>(
            0,
            (s, frames) => s + frames.length,
          ),
    );
    expect(atlas.warmUp(), expected);
    expect(atlas.cachedCount, expected);
    atlas.warmUp();
    expect(atlas.cachedCount, expected);
  });

  test('frame index wraps and unknown ids are rejected', () {
    final atlas = loadAtlas();
    expect(
      atlas.definition('coin').frame('spin', 5),
      atlas.definition('coin').frame('spin', 1),
    );
    expect(() => atlas.definition('missing'), throwsArgumentError);
    expect(() => atlas.palettes.resolve('base+nope'), throwsArgumentError);
  });
}
