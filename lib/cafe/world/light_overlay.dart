import 'dart:ui';

import 'package:flame/components.dart';

import '../camera_fit.dart';

class LightOverlay extends PositionComponent {
  LightOverlay() : super(priority: 1 << 18);

  final Paint _paint = Paint()..blendMode = BlendMode.srcOver;
  double _intensity = 0;

  double get intensity => _intensity;

  void setRoom(int cols, int rows) => size = Vector2(
    (cols * CameraFit.tilePixels).toDouble(),
    (rows * CameraFit.tilePixels).toDouble(),
  );

  void setLight(Color tint, double intensity) {
    _intensity = intensity;
    _paint.color = tint.withValues(alpha: intensity.clamp(0, 1));
  }

  @override
  void render(Canvas canvas) {
    if (_intensity <= 0) return;
    canvas.drawRect(size.toRect(), _paint);
  }
}
