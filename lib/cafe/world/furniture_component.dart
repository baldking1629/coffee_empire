import 'package:flame/components.dart';

import '../../config/cafe_config.dart';
import '../camera_fit.dart';
import 'pixel_sprite_component.dart';

class FurnitureComponent extends PixelSpriteComponent {
  FurnitureComponent({
    required super.atlas,
    required this.item,
    required this.fixture,
    super.paletteKey,
  }) : super(
         spriteId: fixture.spriteId,
         position: bottomCenterOf(
           item.x,
           item.y,
           fixture.width,
           fixture.height,
         ),
         priority: depthOf(
           item.y + fixture.height,
           onCounter: fixture.id == registerId,
         ),
       );

  static const String registerId = 'cash_register';

  final LayoutItem item;
  final FixtureConfig fixture;

  static Vector2 bottomCenterOf(int x, int y, int width, int height) {
    const tile = CameraFit.tilePixels;
    return Vector2((x + width / 2) * tile, ((y + height) * tile).toDouble());
  }

  static int depthOf(int bottomRow, {bool onCounter = false}) =>
      bottomRow * CameraFit.tilePixels * 4 + (onCounter ? 2 : 0);
}

class DoorComponent extends PixelSpriteComponent {
  DoorComponent({required super.atlas, required GridCell door})
    : super(
        spriteId: 'door',
        position: FurnitureComponent.bottomCenterOf(door.x, door.y, 1, 1),
        priority: -500,
      );
}
