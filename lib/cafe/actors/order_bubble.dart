import 'dart:ui';

import 'package:flame/components.dart';

import '../../app/theme/app_colors.dart';
import '../../pixel/sprite_atlas.dart';
import '../world/pixel_sprite_component.dart';

class OrderBubble extends PositionComponent {
  OrderBubble({required this.atlas, required String drinkIconId})
    : super(size: Vector2(16, 16), anchor: Anchor.bottomCenter) {
    add(
      PixelSpriteComponent(
        atlas: atlas,
        spriteId: 'order_bubble',
        anchor: Anchor.topLeft,
      ),
    );
    add(
      _icon = PixelSpriteComponent(
        atlas: atlas,
        spriteId: drinkIconId,
        anchor: Anchor.topLeft,
        position: Vector2(2, 0),
      ),
    );
  }

  static const double barWidth = 12;

  final SpriteAtlas atlas;
  late final PixelSpriteComponent _icon;
  double patienceRatio = 1;
  bool ready = false;
  bool dimmed = false;

  @override
  void render(Canvas canvas) {
    if (ready) {
      canvas.drawRect(
        Rect.fromLTWH(_icon.x - 1, _icon.y - 1, 14, 12),
        Paint()..color = AppColors.gold,
      );
    }
  }

  @override
  void renderTree(Canvas canvas) {
    super.renderTree(canvas);
    canvas.save();
    canvas.translate(position.x - size.x / 2, position.y - size.y);
    final color = dimmed
        ? AppColors.textSecondary
        : patienceRatio > 0.6
        ? AppColors.mint
        : patienceRatio > 0.3
        ? AppColors.gold
        : AppColors.danger;
    canvas
      ..drawRect(
        const Rect.fromLTWH(2, 11, barWidth, 2),
        Paint()..color = AppColors.machineDark,
      )
      ..drawRect(
        Rect.fromLTWH(2, 11, barWidth * patienceRatio.clamp(0, 1), 2),
        Paint()..color = color,
      );
    canvas.restore();
  }
}
