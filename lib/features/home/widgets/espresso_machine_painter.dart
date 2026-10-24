import 'dart:math' as math;

import 'package:flutter/rendering.dart';

import '../../../app/theme/app_colors.dart';

class EspressoMachinePainter extends CustomPainter {
  const EspressoMachinePainter({required this.pour, required this.rushGlow});

  final double pour;
  final double rushGlow;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    _paintBody(canvas, w, h);
    _paintGroupHead(canvas, w, h);
    _paintDripTray(canvas, w, h);
    if (pour > 0 && pour < 1) _paintPour(canvas, w, h);
  }

  void _paintBody(Canvas canvas, double w, double h) {
    final body = RRect.fromRectAndRadius(
      Rect.fromLTRB(w * 0.1, h * 0.02, w * 0.9, h * 0.97),
      Radius.circular(w * 0.06),
    );
    canvas.drawRRect(
      body,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment(0, -1),
          end: Alignment(0, 1),
          colors: [AppColors.machineBody, AppColors.machineDark],
        ).createShader(body.outerRect),
    );
    final panel = RRect.fromRectAndRadius(
      Rect.fromLTRB(w * 0.14, h * 0.04, w * 0.86, h * 0.12),
      Radius.circular(w * 0.03),
    );
    canvas.drawRRect(panel, Paint()..color = AppColors.machineDark);
    final gaugeColor =
        Color.lerp(AppColors.gold, AppColors.copper, rushGlow) ??
        AppColors.gold;
    for (final x in [0.26, 0.74]) {
      final center = Offset(w * x, h * 0.08);
      canvas.drawCircle(
        center,
        w * 0.025,
        Paint()..color = AppColors.machineMetal,
      );
      canvas.drawCircle(center, w * 0.016, Paint()..color = gaugeColor);
    }
  }

  void _paintGroupHead(Canvas canvas, double w, double h) {
    final head = RRect.fromRectAndRadius(
      Rect.fromLTRB(w * 0.38, h * 0.13, w * 0.62, h * 0.2),
      Radius.circular(w * 0.02),
    );
    canvas.drawRRect(head, Paint()..color = AppColors.machineMetal);
    final spout = Path()
      ..moveTo(w * 0.44, h * 0.2)
      ..lineTo(w * 0.56, h * 0.2)
      ..lineTo(w * 0.52, h * 0.25)
      ..lineTo(w * 0.48, h * 0.25)
      ..close();
    canvas.drawPath(spout, Paint()..color = AppColors.machineMetal);
  }

  void _paintDripTray(Canvas canvas, double w, double h) {
    final tray = RRect.fromRectAndRadius(
      Rect.fromLTRB(w * 0.14, h * 0.91, w * 0.86, h * 0.96),
      Radius.circular(w * 0.015),
    );
    canvas.drawRRect(tray, Paint()..color = AppColors.machineMetal);
  }

  void _paintPour(Canvas canvas, double w, double h) {
    final strength = math.sin(pour * math.pi);
    final streamPaint = Paint()
      ..color = AppColors.coffeeLight.withValues(alpha: strength)
      ..strokeWidth = w * (0.025 + rushGlow * 0.01)
      ..strokeCap = StrokeCap.round;
    final top = Offset(w * 0.5, h * 0.25);
    final bottom = Offset(w * 0.5, h * (0.25 + 0.5 * math.min(1, pour * 2)));
    canvas.drawLine(top, bottom, streamPaint);
    final dropPaint = Paint()
      ..color = AppColors.coffeeDark.withValues(alpha: strength);
    for (var drop = 0; drop < 2; drop++) {
      final progress = (pour * 1.5 + drop * 0.35) % 1.0;
      canvas.drawCircle(
        Offset(w * 0.5, h * (0.25 + 0.5 * progress)),
        w * 0.012,
        dropPaint,
      );
    }
  }

  @override
  bool shouldRepaint(EspressoMachinePainter oldDelegate) =>
      oldDelegate.pour != pour || oldDelegate.rushGlow != rushGlow;
}
