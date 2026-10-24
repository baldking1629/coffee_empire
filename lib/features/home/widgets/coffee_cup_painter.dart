import 'dart:math' as math;

import 'package:flutter/rendering.dart';

import '../../../app/theme/app_colors.dart';

class CoffeeCupPainter extends CustomPainter {
  const CoffeeCupPainter({
    required this.fill,
    required this.steamPhase,
    required this.rushGlow,
  });

  final double fill;
  final double steamPhase;
  final double rushGlow;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    if (rushGlow > 0) _paintRushGlow(canvas, size);
    _paintSaucer(canvas, w, h);
    final body = Path()
      ..moveTo(w * 0.22, h * 0.38)
      ..lineTo(w * 0.78, h * 0.38)
      ..lineTo(w * 0.70, h * 0.84)
      ..quadraticBezierTo(w * 0.5, h * 0.9, w * 0.30, h * 0.84)
      ..close();
    _paintHandle(canvas, w, h);
    canvas.drawPath(
      body,
      Paint()
        ..shader = const LinearGradient(
          colors: [AppColors.cupBody, AppColors.cupShade],
        ).createShader(Rect.fromLTWH(w * 0.22, h * 0.38, w * 0.56, h * 0.5)),
    );
    _paintCoffee(canvas, body, w, h);
    canvas.drawPath(
      body,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = AppColors.caramel,
    );
    if (fill > 0.05 || rushGlow > 0) _paintSteam(canvas, w, h);
  }

  void _paintRushGlow(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.6);
    canvas.drawCircle(
      center,
      size.width * 0.48,
      Paint()
        ..shader =
            RadialGradient(
              colors: [
                AppColors.copper.withValues(alpha: 0.55 * rushGlow),
                AppColors.copper.withValues(alpha: 0),
              ],
            ).createShader(
              Rect.fromCircle(center: center, radius: size.width * 0.48),
            ),
    );
  }

  void _paintSaucer(Canvas canvas, double w, double h) {
    final saucer = Rect.fromCenter(
      center: Offset(w * 0.5, h * 0.88),
      width: w * 0.8,
      height: h * 0.1,
    );
    canvas.drawOval(saucer, Paint()..color = AppColors.cupShade);
    canvas.drawOval(
      saucer.deflate(w * 0.03),
      Paint()..color = AppColors.cupBody,
    );
  }

  void _paintHandle(Canvas canvas, double w, double h) {
    final handle = Path()
      ..moveTo(w * 0.75, h * 0.48)
      ..cubicTo(w * 0.95, h * 0.44, w * 0.95, h * 0.72, w * 0.71, h * 0.72);
    canvas.drawPath(
      handle,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.045
        ..strokeCap = StrokeCap.round
        ..color = AppColors.cupShade,
    );
  }

  void _paintCoffee(Canvas canvas, Path body, double w, double h) {
    final clamped = fill.clamp(0.0, 1.0);
    if (clamped <= 0) return;
    const top = 0.40;
    const bottom = 0.88;
    final surfaceY = h * (bottom - (bottom - top) * clamped);
    canvas.save();
    canvas.clipPath(body);
    canvas.drawRect(
      Rect.fromLTRB(0, surfaceY, w, h),
      Paint()
        ..shader = LinearGradient(
          begin: const Alignment(0, -1),
          end: const Alignment(0, 1),
          colors: [
            Color.lerp(
                  AppColors.coffeeLight,
                  AppColors.copper,
                  rushGlow * 0.4,
                ) ??
                AppColors.coffeeLight,
            AppColors.coffeeDark,
          ],
        ).createShader(Rect.fromLTRB(0, surfaceY, w, h)),
    );
    canvas.restore();
  }

  void _paintSteam(Canvas canvas, double w, double h) {
    final plumes = rushGlow > 0 ? 5 : 3;
    final intensity = (fill.clamp(0.0, 1.0) + rushGlow * 0.5).clamp(0.0, 1.0);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * (0.018 + rushGlow * 0.008)
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < plumes; i++) {
      final phase = (steamPhase + i / plumes) % 1.0;
      final x = w * (0.34 + 0.32 * i / (plumes - 1));
      final rise = h * 0.14 * phase;
      final baseY = h * 0.35 - rise;
      paint.color = AppColors.steam.withValues(
        alpha: AppColors.steam.a * (1 - phase) * intensity,
      );
      final path = Path()..moveTo(x, baseY);
      const segments = 3;
      for (var segment = 1; segment <= segments; segment++) {
        final y = baseY - h * 0.05 * segment;
        final wave = math.sin((phase * 2 + segment * 0.7 + i) * math.pi);
        final controlX = x + wave * w * 0.035;
        path.quadraticBezierTo(controlX, y + h * 0.025, x + wave * w * 0.01, y);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CoffeeCupPainter oldDelegate) =>
      oldDelegate.fill != fill ||
      oldDelegate.steamPhase != steamPhase ||
      oldDelegate.rushGlow != rushGlow;
}
