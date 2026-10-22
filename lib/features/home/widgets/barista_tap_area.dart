import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/theme/app_colors.dart';
import '../../../engine/barista_math.dart';
import '../../../l10n/app_localizations.dart';
import '../../game/game_cubit.dart';
import '../../game/game_state.dart';
import 'coffee_cup_painter.dart';

class BaristaTapArea extends StatefulWidget {
  const BaristaTapArea({super.key});

  static const Key cupKey = Key('barista_cup');

  @override
  State<BaristaTapArea> createState() => _BaristaTapAreaState();
}

class _BaristaTapAreaState extends State<BaristaTapArea>
    with TickerProviderStateMixin {
  late final AnimationController _steam = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat();
  late final AnimationController _press = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 120),
    lowerBound: 0.94,
    upperBound: 1,
    value: 1,
  );

  @override
  void dispose() {
    _steam.dispose();
    _press.dispose();
    super.dispose();
  }

  void _handleTap() {
    context.read<GameCubit>().tapCup();
    _press.value = _press.lowerBound;
    _press.forward();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocSelector<GameCubit, GameState, BaristaState>(
      selector: (state) => state.barista,
      builder: (context, barista) {
        final rushActive = barista.rushEndsAt != null;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 24,
              child: _ComboBadge(combo: barista.combo, rushActive: rushActive),
            ),
            Flexible(
              child: Semantics(
                button: true,
                label: l10n.cupSemanticLabel((barista.cupFill * 100).round()),
                child: GestureDetector(
                  key: BaristaTapArea.cupKey,
                  behavior: HitTestBehavior.opaque,
                  onTapDown: (_) => _handleTap(),
                  child: ScaleTransition(
                    scale: _press,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(end: barista.cupFill),
                        duration: const Duration(milliseconds: 150),
                        builder: (context, fill, _) => AnimatedBuilder(
                          animation: _steam,
                          builder: (context, _) => CustomPaint(
                            painter: CoffeeCupPainter(
                              fill: fill,
                              steamPhase: _steam.value,
                              rushGlow: rushActive ? 1 : 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Text(
              l10n.tapToBrew,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
            ),
          ],
        );
      },
    );
  }
}

class _ComboBadge extends StatelessWidget {
  const _ComboBadge({required this.combo, required this.rushActive});

  final int combo;
  final bool rushActive;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final text = rushActive
        ? l10n.baristaRush
        : combo > 0
        ? l10n.comboLabel(combo)
        : '';
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: Text(
        text,
        key: ValueKey(text),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: rushActive ? AppColors.copper : AppColors.gold,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
