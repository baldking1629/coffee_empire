import 'dart:ui';
import 'dart:math';

import 'package:flame/components.dart';

import '../../config/cafe_config.dart';
import '../camera_fit.dart';
import 'pixel_sprite_component.dart';

class FurnitureComponent extends PixelSpriteComponent {
  FurnitureComponent({
    required super.atlas,
    required this.item,
    required this.shape,
  }) : super(spriteId: shape.spriteId, paletteKey: shape.paletteKey) {
    placeAt(item);
  }

  static const String registerId = 'cash_register';

  LayoutItem item;
  final FixtureConfig shape;
  bool hidden = false;

  bool get _swapsFootprint => item.isTurned && shape.width != shape.height;

  void placeAt(LayoutItem target) {
    item = target;
    final width = _swapsFootprint ? shape.height : shape.width;
    final height = _swapsFootprint ? shape.width : shape.height;
    flipX = item.isTurned && !_swapsFootprint;
    if (_swapsFootprint) {
      anchor = Anchor.center;
      angle = pi / 2;
      position = Vector2(
        (item.x + width / 2) * CameraFit.tilePixels,
        (item.y + height / 2) * CameraFit.tilePixels,
      );
    } else {
      anchor = Anchor.bottomCenter;
      angle = 0;
      position = bottomCenterOf(item.x, item.y, width, height);
    }
    priority = depthOf(
      item.y + height,
      onCounter: shape.id == registerId,
      flat: !shape.blocksWalk && !shape.isSeat,
    );
  }

  @override
  void renderTree(Canvas canvas) {
    if (!hidden) super.renderTree(canvas);
  }

  static Vector2 bottomCenterOf(int x, int y, int width, int height) {
    const tile = CameraFit.tilePixels;
    return Vector2((x + width / 2) * tile, ((y + height) * tile).toDouble());
  }

  static int depthOf(
    int bottomRow, {
    bool onCounter = false,
    bool flat = false,
  }) =>
      flat ? -400 : bottomRow * CameraFit.tilePixels * 4 + (onCounter ? 2 : 0);
}

class DoorComponent extends PixelSpriteComponent {
  DoorComponent({required super.atlas, required GridCell door})
    : super(
        spriteId: 'door',
        position: FurnitureComponent.bottomCenterOf(door.x, door.y, 1, 1),
        priority: -500,
      );
}
