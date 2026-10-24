import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class InsufficientFundsFlash extends StatefulWidget {
  const InsufficientFundsFlash({
    super.key,
    required this.signals,
    required this.child,
  });

  static const Key flashKey = Key('insufficient_funds_flash');
  static const Duration duration = Duration(milliseconds: 300);

  final Stream<void> signals;
  final Widget child;

  @override
  State<InsufficientFundsFlash> createState() => _InsufficientFundsFlashState();
}

class _InsufficientFundsFlashState extends State<InsufficientFundsFlash>
    with SingleTickerProviderStateMixin {
  late final AnimationController _flash = AnimationController(
    vsync: this,
    duration: InsufficientFundsFlash.duration,
  );
  late StreamSubscription<void> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = widget.signals.listen((_) => _trigger());
  }

  @override
  void didUpdateWidget(InsufficientFundsFlash oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.signals != widget.signals) {
      _subscription.cancel();
      _subscription = widget.signals.listen((_) => _trigger());
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    _flash.dispose();
    super.dispose();
  }

  void _trigger() {
    if (!mounted) return;
    _flash.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final animate = !MediaQuery.disableAnimationsOf(context);
    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: IgnorePointer(
            child: AnimatedBuilder(
              animation: _flash,
              builder: (context, _) {
                if (!_flash.isAnimating) return const SizedBox.shrink();
                final strength = animate
                    ? 1 - (2 * _flash.value - 1).abs()
                    : 1.0;
                return DecoratedBox(
                  key: InsufficientFundsFlash.flashKey,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.danger.withValues(alpha: strength),
                      width: 4,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
