import 'dart:ui' as ui;

import 'package:coffee_empire/pixel/sprite_rasterizer.dart';
import 'package:flutter_test/flutter_test.dart';

Future<List<int>> rgbaAt(ui.Image image, int x, int y) async {
  final bytes = await image.toByteData();
  final data = bytes?.buffer.asUint8List() ?? <int>[];
  final offset = (y * image.width + x) * 4;
  return data.sublist(offset, offset + 4);
}

void main() {
  const red = ui.Color(0xFFFF0000);
  const green = ui.Color(0xFF00FF00);
  const rows = ['r..g', '.rg.', '.gr.', 'g..r'];
  const symbols = {'r': 'red', 'g': 'green'};
  const colors = {'red': red, 'green': green};

  testWidgets('4x4 grid becomes the expected pixels', (tester) async {
    await tester.runAsync(() async {
      final image = const SpriteRasterizer().rasterize(
        rows: rows,
        width: 4,
        height: 4,
        symbols: symbols,
        colors: colors,
      );
      expect(image.width, 4);
      expect(image.height, 4);
      expect(await rgbaAt(image, 0, 0), [255, 0, 0, 255]);
      expect(await rgbaAt(image, 3, 0), [0, 255, 0, 255]);
      expect(await rgbaAt(image, 1, 0), [0, 0, 0, 0]);
      expect(await rgbaAt(image, 2, 1), [0, 255, 0, 255]);
      expect(await rgbaAt(image, 3, 3), [255, 0, 0, 255]);
    });
  });

  testWidgets('flipX mirrors the grid', (tester) async {
    await tester.runAsync(() async {
      final image = const SpriteRasterizer().rasterize(
        rows: rows,
        width: 4,
        height: 4,
        symbols: symbols,
        colors: colors,
        flipX: true,
      );
      expect(await rgbaAt(image, 0, 0), [0, 255, 0, 255]);
      expect(await rgbaAt(image, 3, 0), [255, 0, 0, 255]);
    });
  });

  test('a symbol without a color fails loudly', () {
    expect(
      () => const SpriteRasterizer().rasterize(
        rows: const ['x'],
        width: 1,
        height: 1,
        symbols: const {},
        colors: colors,
      ),
      throwsStateError,
    );
  });
}
