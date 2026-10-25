import 'dart:ui';

import 'package:flame/components.dart';

import '../../config/cafe_config.dart';
import '../../pixel/sprite_atlas.dart';
import '../camera_fit.dart';
import 'pixel_sprite_component.dart';

class FloorLayer extends PositionComponent {
  FloorLayer({
    required this.atlas,
    required this.layout,
    required this.paletteKey,
  }) : super(priority: -1000);

  static const String floorSprite = 'floor_tile';
  static const String wallSprite = 'wall_tile';

  final SpriteAtlas atlas;
  final CafeLayoutConfig layout;
  String paletteKey;

  @override
  void render(Canvas canvas) {
    const tile = CameraFit.tilePixels;
    final floor = atlas.get(floorSprite, paletteKey: paletteKey);
    final wall = atlas.get(wallSprite, paletteKey: paletteKey);
    for (var y = 0; y < layout.rows; y++) {
      for (var x = 0; x < layout.cols; x++) {
        canvas.drawImage(
          y == 0 ? wall : floor,
          Offset((x * tile).toDouble(), (y * tile).toDouble()),
          PixelSpriteComponent.pixelPaint,
        );
      }
    }
  }
}
