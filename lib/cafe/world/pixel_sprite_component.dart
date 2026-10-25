import 'dart:ui';

import 'package:flame/components.dart';

import '../../pixel/palette_set.dart';
import '../../pixel/sprite_atlas.dart';

class PixelSpriteComponent extends PositionComponent {
  PixelSpriteComponent({
    required this.atlas,
    required this.spriteId,
    this.animation,
    this.paletteKey = PaletteCatalog.baseSet,
    this.flipX = false,
    this.animate = false,
    super.position,
    super.anchor = Anchor.bottomCenter,
    super.priority,
  }) {
    final definition = atlas.definition(spriteId);
    size = Vector2(definition.width.toDouble(), definition.height.toDouble());
  }

  static final Paint pixelPaint = Paint()
    ..filterQuality = FilterQuality.none
    ..isAntiAlias = false;

  final SpriteAtlas atlas;
  String spriteId;
  String? animation;
  String paletteKey;
  bool flipX;
  bool animate;
  double _elapsed = 0;

  int get frame =>
      animate ? (_elapsed * atlas.definition(spriteId).fps).floor() : 0;

  @override
  void update(double dt) {
    if (animate) _elapsed += dt;
  }

  @override
  void render(Canvas canvas) {
    final image = atlas.get(
      spriteId,
      animation: animation,
      frame: frame,
      paletteKey: paletteKey,
      flipX: flipX,
    );
    canvas.drawImage(image, Offset.zero, pixelPaint);
  }
}
