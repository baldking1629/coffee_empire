import 'package:flame/components.dart';

import '../../config/cafe_config.dart';
import 'furniture_component.dart';
import 'pixel_sprite_component.dart';

class MachineComponent extends PixelSpriteComponent {
  MachineComponent({required super.atlas, required GridCell cell})
    : super(
        spriteId: spriteFor(0),
        position: FurnitureComponent.bottomCenterOf(cell.x, cell.y, 1, 1),
        priority: FurnitureComponent.depthOf(cell.y + 1),
      );

  static String spriteFor(int level) => 'espresso_machine_${level.clamp(0, 3)}';

  late final PixelSpriteComponent _steam = PixelSpriteComponent(
    atlas: atlas,
    spriteId: 'steam',
    animate: true,
    position: Vector2(size.x / 2, 2),
  );

  bool _brewing = false;

  set level(int value) => spriteId = spriteFor(value);

  set brewing(bool value) {
    if (value == _brewing) return;
    _brewing = value;
    if (value) {
      add(_steam);
    } else {
      _steam.removeFromParent();
    }
  }
}
