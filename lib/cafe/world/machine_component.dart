import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';

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
  int _level = 0;

  int get level => _level;

  void showLevel(int value, {required bool celebrate}) {
    final upgraded = value > _level;
    _level = value;
    spriteId = spriteFor(value);
    if (upgraded && celebrate) _sparkle();
  }

  void _sparkle() {
    for (var i = 0; i < 5; i++) {
      final start = Vector2(size.x / 2, size.y / 2);
      add(
        PixelSpriteComponent(
            atlas: atlas,
            spriteId: 'star',
            anchor: Anchor.center,
            position: start,
          )
          ..add(
            MoveEffect.by(
              Vector2((i - 2) * 6, -14 - (i % 2) * 6),
              EffectController(duration: 0.5, curve: Curves.easeOut),
            ),
          )
          ..add(RemoveEffect(delay: 0.6)),
      );
    }
    add(
      PixelSpriteComponent(
          atlas: atlas,
          spriteId: 'steam',
          animate: true,
          position: Vector2(size.x / 2, 2),
        )
        ..add(MoveEffect.by(Vector2(0, -10), EffectController(duration: 0.8)))
        ..add(RemoveEffect(delay: 0.8)),
    );
  }

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
