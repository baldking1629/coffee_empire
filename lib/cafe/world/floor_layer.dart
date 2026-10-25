import 'dart:ui';

import 'package:flame/components.dart';

import '../../pixel/sprite_atlas.dart';
import '../camera_fit.dart';
import 'pixel_sprite_component.dart';

class FloorLayer extends PositionComponent {
  FloorLayer({
    required this.atlas,
    required this.cols,
    required this.rows,
    required this.paletteKey,
  }) : super(priority: -1000);

  static const String floorSprite = 'floor_tile';
  static const String wallSprite = 'wall_tile';

  final SpriteAtlas atlas;
  int cols;
  int rows;
  String paletteKey;

  @override
  void render(Canvas canvas) {
    const tile = CameraFit.tilePixels;
    final floor = atlas.get(floorSprite, paletteKey: paletteKey);
    final wall = atlas.get(wallSprite, paletteKey: paletteKey);
    for (var y = 0; y < rows; y++) {
      for (var x = 0; x < cols; x++) {
        canvas.drawImage(
          y == 0 ? wall : floor,
          Offset((x * tile).toDouble(), (y * tile).toDouble()),
          PixelSpriteComponent.pixelPaint,
        );
      }
    }
  }
}
