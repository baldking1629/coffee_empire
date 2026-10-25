import 'dart:math';

class CameraFit {
  const CameraFit({
    required this.scale,
    required this.offsetX,
    required this.offsetY,
    required this.needsPan,
  });

  factory CameraFit.compute({
    required double viewWidth,
    required double viewHeight,
    required int cols,
    required int rows,
    int tileSize = tilePixels,
    int minScale = 2,
  }) {
    final roomWidth = cols * tileSize;
    final roomHeight = rows * tileSize;
    final fitted = min(viewWidth / roomWidth, viewHeight / roomHeight).floor();
    final scale = max(minScale, fitted);
    final visibleWidth = viewWidth / scale;
    final visibleHeight = viewHeight / scale;
    return CameraFit(
      scale: scale,
      offsetX: (visibleWidth - roomWidth) / 2,
      offsetY: (visibleHeight - roomHeight) / 2,
      needsPan: roomWidth > visibleWidth || roomHeight > visibleHeight,
    );
  }

  static const int tilePixels = 16;

  final int scale;
  final double offsetX;
  final double offsetY;
  final bool needsPan;
}
