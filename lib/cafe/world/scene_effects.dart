import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/painting.dart';

import '../../app/theme/app_colors.dart';
import '../../engine/cafe_customer.dart';
import '../../pixel/sprite_atlas.dart';
import '../camera_fit.dart';
import 'pixel_sprite_component.dart';

class SceneEffects {
  SceneEffects({
    required this.atlas,
    required this.world,
    required this.viewfinder,
  });

  final SpriteAtlas atlas;
  final World world;
  final Viewfinder viewfinder;

  Vector2 _headOf(CafeCustomer customer) => Vector2(
    (customer.x + 0.5) * CameraFit.tilePixels,
    customer.y * CameraFit.tilePixels - 12,
  );

  void serve(
    CafeCustomer customer, {
    required String gainText,
    required String? perfectText,
    required bool shake,
    required bool reduceMotion,
  }) {
    final head = _headOf(customer);
    if (!reduceMotion) {
      for (var i = 0; i < 4; i++) {
        world.add(
          PixelSpriteComponent(
              atlas: atlas,
              spriteId: 'coin',
              animate: true,
              anchor: Anchor.center,
              position: head + Vector2((i - 1.5) * 4, 0),
              priority: 1 << 20,
            )
            ..add(
              MoveEffect.to(
                Vector2(8, 4),
                EffectController(
                  duration: 0.6 + i * 0.05,
                  curve: Curves.easeIn,
                ),
              ),
            )
            ..add(RemoveEffect(delay: 0.7 + i * 0.05)),
        );
      }
    }
    _floatText(gainText, head, AppColors.mint, reduceMotion: reduceMotion);
    if (perfectText != null) {
      _floatText(
        perfectText,
        head - Vector2(0, 10),
        AppColors.gold,
        reduceMotion: reduceMotion,
      );
      for (final dx in [-8.0, 0.0, 8.0]) {
        world.add(
          PixelSpriteComponent(
              atlas: atlas,
              spriteId: 'star',
              anchor: Anchor.center,
              position: head + Vector2(dx, -4),
              priority: 1 << 20,
            )
            ..add(
              MoveEffect.by(Vector2(dx, -10), EffectController(duration: 0.5)),
            )
            ..add(RemoveEffect(delay: 0.6)),
        );
      }
    }
    if (shake && !reduceMotion) _shake();
  }

  void lost(CafeCustomer customer) {
    world.add(
      PixelSpriteComponent(
          atlas: atlas,
          spriteId: 'heart_broken',
          anchor: Anchor.center,
          position: _headOf(customer),
          priority: 1 << 20,
        )
        ..add(MoveEffect.by(Vector2(0, -8), EffectController(duration: 0.8)))
        ..add(RemoveEffect(delay: 1)),
    );
  }

  void _floatText(
    String text,
    Vector2 at,
    Color color, {
    required bool reduceMotion,
  }) {
    final label = TextComponent(
      text: text,
      anchor: Anchor.bottomCenter,
      position: at.clone(),
      priority: 1 << 21,
      textRenderer: TextPaint(
        style: TextStyle(
          color: color,
          fontSize: 7,
          fontWeight: FontWeight.w900,
          shadows: const [
            Shadow(color: AppColors.shadow, offset: Offset(0.5, 0.5)),
          ],
        ),
      ),
    );
    if (!reduceMotion) {
      label.add(
        MoveEffect.by(Vector2(0, -16), EffectController(duration: 0.9)),
      );
    }
    label.add(RemoveEffect(delay: 0.9));
    world.add(label);
  }

  void _shake() {
    viewfinder.add(
      SequenceEffect([
        MoveEffect.by(Vector2(2, 0), EffectController(duration: 0.04)),
        MoveEffect.by(Vector2(-4, 0), EffectController(duration: 0.07)),
        MoveEffect.by(Vector2(2, 0), EffectController(duration: 0.04)),
      ]),
    );
  }
}
