import 'dart:math' as math;

import 'package:flutter/painting.dart';

class PixelBorder extends OutlinedBorder {
  const PixelBorder({super.side, this.step = 3});

  final double step;

  Path _stepped(Rect rect) {
    final s = math.min(step, math.min(rect.width, rect.height) / 6);
    return Path()
      ..moveTo(rect.left + 2 * s, rect.top)
      ..lineTo(rect.right - 2 * s, rect.top)
      ..lineTo(rect.right - 2 * s, rect.top + s)
      ..lineTo(rect.right - s, rect.top + s)
      ..lineTo(rect.right - s, rect.top + 2 * s)
      ..lineTo(rect.right, rect.top + 2 * s)
      ..lineTo(rect.right, rect.bottom - 2 * s)
      ..lineTo(rect.right - s, rect.bottom - 2 * s)
      ..lineTo(rect.right - s, rect.bottom - s)
      ..lineTo(rect.right - 2 * s, rect.bottom - s)
      ..lineTo(rect.right - 2 * s, rect.bottom)
      ..lineTo(rect.left + 2 * s, rect.bottom)
      ..lineTo(rect.left + 2 * s, rect.bottom - s)
      ..lineTo(rect.left + s, rect.bottom - s)
      ..lineTo(rect.left + s, rect.bottom - 2 * s)
      ..lineTo(rect.left, rect.bottom - 2 * s)
      ..lineTo(rect.left, rect.top + 2 * s)
      ..lineTo(rect.left + s, rect.top + 2 * s)
      ..lineTo(rect.left + s, rect.top + s)
      ..lineTo(rect.left + 2 * s, rect.top + s)
      ..close();
  }

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.width);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      _stepped(rect.deflate(side.width));

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      _stepped(rect);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (side.style == BorderStyle.none || side.width == 0) return;
    canvas.drawPath(
      _stepped(rect.deflate(side.width / 2)),
      side.toPaint()..strokeJoin = StrokeJoin.miter,
    );
  }

  @override
  ShapeBorder scale(double t) =>
      PixelBorder(side: side.scale(t), step: step * t);

  @override
  PixelBorder copyWith({BorderSide? side}) =>
      PixelBorder(side: side ?? this.side, step: step);

  @override
  bool operator ==(Object other) =>
      other is PixelBorder && other.side == side && other.step == step;

  @override
  int get hashCode => Object.hash(side, step);
}
