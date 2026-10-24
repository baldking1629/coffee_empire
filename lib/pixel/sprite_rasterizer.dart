import 'dart:ui' as ui;

import 'sprite_definition.dart';

class SpriteRasterizer {
  const SpriteRasterizer();

  ui.Image rasterize({
    required SpriteFrame rows,
    required int width,
    required int height,
    required Map<String, String> symbols,
    required Map<String, ui.Color> colors,
    bool flipX = false,
  }) {
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);
    final paint = ui.Paint()..isAntiAlias = false;
    for (var y = 0; y < height; y++) {
      final row = rows[y];
      for (var x = 0; x < width; x++) {
        final symbol = row[x];
        if (symbol == SpriteDefinition.transparent) continue;
        final slot = symbols[symbol];
        final color = slot == null ? null : colors[slot];
        if (color == null) {
          throw StateError('Symbol "$symbol" has no color in this palette');
        }
        paint.color = color;
        final drawX = flipX ? width - 1 - x : x;
        canvas.drawRect(
          ui.Rect.fromLTWH(drawX.toDouble(), y.toDouble(), 1, 1),
          paint,
        );
      }
    }
    final picture = recorder.endRecording();
    final image = picture.toImageSync(width, height);
    picture.dispose();
    return image;
  }
}
