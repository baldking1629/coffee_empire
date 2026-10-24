import 'package:flutter/rendering.dart';

import '../../../app/theme/app_colors.dart';

class ProgressRoadPainter extends CustomPainter {
  const ProgressRoadPainter({
    required this.nodeInset,
    required this.nodeAtStart,
    required this.rtl,
    required this.incomingUnlocked,
    required this.outgoingUnlocked,
    this.hasIncoming = true,
    this.hasOutgoing = true,
  });

  static const double roadWidth = 10;
  static const double dashLength = 10;
  static const double gapLength = 8;

  final double nodeInset;
  final bool nodeAtStart;
  final bool rtl;
  final bool hasIncoming;
  final bool hasOutgoing;
  final bool incomingUnlocked;
  final bool outgoingUnlocked;

  double _nodeX(double width) {
    final fromLeft = nodeAtStart != rtl;
    return fromLeft ? nodeInset : width - nodeInset;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final midX = size.width / 2;
    final nodeX = _nodeX(size.width);
    final centerY = size.height / 2;
    if (hasIncoming) {
      final incoming = Path()
        ..moveTo(midX, 0)
        ..cubicTo(midX, centerY * 0.5, nodeX, centerY * 0.5, nodeX, centerY);
      _paintRoad(canvas, incoming, size, unlocked: incomingUnlocked);
    }
    if (hasOutgoing) {
      final outgoing = Path()
        ..moveTo(nodeX, centerY)
        ..cubicTo(nodeX, centerY * 1.5, midX, centerY * 1.5, midX, size.height);
      _paintRoad(canvas, outgoing, size, unlocked: outgoingUnlocked);
    }
  }

  void _paintRoad(
    Canvas canvas,
    Path path,
    Size size, {
    required bool unlocked,
  }) {
    if (!unlocked) {
      final dashPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = roadWidth * 0.6
        ..strokeCap = StrokeCap.round
        ..color = AppColors.cardBorder;
      for (final metric in path.computeMetrics()) {
        var distance = 0.0;
        while (distance < metric.length) {
          final end = distance + dashLength;
          canvas.drawPath(metric.extractPath(distance, end), dashPaint);
          distance = end + gapLength;
        }
      }
      return;
    }
    final bounds = Offset.zero & size;
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = roadWidth * 2
        ..strokeCap = StrokeCap.round
        ..color = AppColors.primaryGradientStart.withValues(alpha: 0.18)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = roadWidth
        ..strokeCap = StrokeCap.round
        ..shader = const LinearGradient(
          begin: Alignment(0, -1),
          end: Alignment(0, 1),
          colors: [
            AppColors.primaryGradientStart,
            AppColors.primaryGradientEnd,
          ],
        ).createShader(bounds),
    );
  }

  @override
  bool shouldRepaint(ProgressRoadPainter oldDelegate) =>
      oldDelegate.nodeInset != nodeInset ||
      oldDelegate.nodeAtStart != nodeAtStart ||
      oldDelegate.rtl != rtl ||
      oldDelegate.hasIncoming != hasIncoming ||
      oldDelegate.hasOutgoing != hasOutgoing ||
      oldDelegate.incomingUnlocked != incomingUnlocked ||
      oldDelegate.outgoingUnlocked != outgoingUnlocked;
}
