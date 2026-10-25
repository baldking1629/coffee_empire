import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';

class PixelImage extends StatelessWidget {
  const PixelImage({super.key, required this.image, required this.scale});

  final ui.Image image;
  final int scale;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(
        (image.width * scale).toDouble(),
        (image.height * scale).toDouble(),
      ),
      painter: _PixelImagePainter(image),
    );
  }
}

class _PixelImagePainter extends CustomPainter {
  const _PixelImagePainter(this.image);

  final ui.Image image;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      Offset.zero & size,
      Paint()
        ..filterQuality = ui.FilterQuality.none
        ..isAntiAlias = false,
    );
  }

  @override
  bool shouldRepaint(_PixelImagePainter oldDelegate) =>
      !identical(oldDelegate.image, image);
}
