import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

enum BouncyButtonStyle { primary, secondary }

class BouncyButton extends StatefulWidget {
  const BouncyButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.canAfford = true,
    this.onDenied,
    this.style = BouncyButtonStyle.primary,
    this.compact = false,
  });

  static const double pressedScale = 0.94;

  final Widget child;
  final VoidCallback? onPressed;
  final bool canAfford;
  final VoidCallback? onDenied;
  final BouncyButtonStyle style;
  final bool compact;

  bool get isEnabled => onPressed != null;

  @override
  State<BouncyButton> createState() => _BouncyButtonState();
}

class _BouncyButtonState extends State<BouncyButton>
    with TickerProviderStateMixin {
  static const double _shakeDistance = 8;
  static const double _shakeWaves = 4;

  late final AnimationController _scale = AnimationController(
    vsync: this,
    lowerBound: 0.85,
    upperBound: 1.15,
    value: 1,
  );
  late final AnimationController _shake = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );
  late final AnimationController _glow = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  );

  bool get _animationsEnabled => !MediaQuery.disableAnimationsOf(context);

  @override
  void dispose() {
    _scale.dispose();
    _shake.dispose();
    _glow.dispose();
    super.dispose();
  }

  void _pressDown() {
    if (!_animationsEnabled) return;
    _scale.animateTo(
      BouncyButton.pressedScale,
      duration: const Duration(milliseconds: 80),
      curve: Curves.easeOut,
    );
  }

  void _release() {
    if (!_animationsEnabled) {
      _scale.value = 1;
      return;
    }
    _scale.animateTo(
      1,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutBack,
    );
  }

  void _handleTap() {
    _release();
    if (widget.canAfford) {
      if (_animationsEnabled) _glow.forward(from: 0);
      widget.onPressed?.call();
    } else {
      if (_animationsEnabled) _shake.forward(from: 0);
      widget.onDenied?.call();
    }
  }

  BoxDecoration _decoration(double glow) {
    final primary = widget.style == BouncyButtonStyle.primary;
    final glowColor = primary ? AppColors.primaryGradientStart : AppColors.gold;
    return BoxDecoration(
      gradient: primary ? AppTheme.primaryGradient : AppTheme.cardGradient,
      borderRadius: BorderRadius.circular(AppTheme.buttonRadius),
      border: primary ? null : Border.all(color: AppColors.caramel),
      boxShadow: [
        if (widget.canAfford && widget.isEnabled)
          BoxShadow(
            color: glowColor.withValues(
              alpha: (primary ? 0.35 : 0.15) + glow * 0.5,
            ),
            blurRadius: 10 + glow * 14,
            spreadRadius: glow * 2,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final primary = widget.style == BouncyButtonStyle.primary;
    final foreground = primary ? AppColors.textOnPrimary : AppColors.gold;
    final dimmed = !widget.isEnabled || !widget.canAfford;
    final padding = widget.compact
        ? const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 8)
        : const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 12);
    return Semantics(
      button: true,
      enabled: widget.isEnabled,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: widget.isEnabled ? (_) => _pressDown() : null,
        onTapCancel: widget.isEnabled ? _release : null,
        onTap: widget.isEnabled ? _handleTap : null,
        child: AnimatedBuilder(
          animation: Listenable.merge([_shake, _glow]),
          builder: (context, child) {
            final shakeOffset =
                math.sin(_shake.value * math.pi * _shakeWaves) *
                _shakeDistance *
                (1 - _shake.value);
            final glow = math.sin(_glow.value * math.pi);
            return Transform.translate(
              offset: Offset(_shake.isAnimating ? shakeOffset : 0, 0),
              child: ScaleTransition(
                scale: _scale,
                child: Opacity(
                  opacity: dimmed ? 0.45 : 1,
                  child: DecoratedBox(
                    decoration: _decoration(glow),
                    child: child,
                  ),
                ),
              ),
            );
          },
          child: Padding(
            padding: padding,
            child: IconTheme.merge(
              data: IconThemeData(color: foreground, size: 18),
              child: DefaultTextStyle.merge(
                style: TextStyle(
                  color: foreground,
                  fontWeight: FontWeight.bold,
                  fontSize: widget.compact ? 13 : 15,
                ),
                textAlign: TextAlign.center,
                child: Center(
                  widthFactor: 1,
                  heightFactor: 1,
                  child: widget.child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
