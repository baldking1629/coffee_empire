import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

class SceneCornerButton extends StatelessWidget {
  const SceneCornerButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.highlighted = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onPressed,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
          child: CustomPaint(
            painter: PixelFramePainter(
              fill: highlighted
                  ? AppColors.primaryGradientStart
                  : AppColors.card,
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    size: 18,
                    color: highlighted
                        ? AppColors.textOnPrimary
                        : AppColors.textPrimary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: highlighted
                          ? AppColors.textOnPrimary
                          : AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PixelFramePainter extends CustomPainter {
  const PixelFramePainter({required this.fill, this.step = 3});

  final Color fill;
  final double step;

  Path _steppedPath(Rect rect) {
    final s = step;
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
  void paint(Canvas canvas, Size size) {
    final body = Offset.zero & Size(size.width, size.height - step);
    canvas.drawPath(
      _steppedPath(body.shift(Offset(0, step))),
      Paint()..color = AppColors.lockedShade,
    );
    canvas.drawPath(_steppedPath(body), Paint()..color = fill);
    canvas.drawPath(
      _steppedPath(body.deflate(1)),
      Paint()
        ..color = AppColors.cardBorder
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(PixelFramePainter oldDelegate) =>
      oldDelegate.fill != fill || oldDelegate.step != step;
}
