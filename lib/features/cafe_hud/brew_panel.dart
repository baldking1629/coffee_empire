import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_theme.dart';
import '../../cafe/cafe_bridge.dart';
import '../../engine/barista_math.dart';
import '../../l10n/app_localizations.dart';
import '../../pixel/pixel_image.dart';
import '../../pixel/sprite_atlas.dart';
import '../game/game_cubit.dart';
import '../game/game_state.dart';
import '../home/widgets/coffee_cup_painter.dart';
import '../home/widgets/espresso_machine_painter.dart';

String drinkName(AppLocalizations l10n, String drinkId) => switch (drinkId) {
  'espresso' => l10n.drink_espresso,
  'americano' => l10n.drink_americano,
  'latte' => l10n.drink_latte,
  'cappuccino' => l10n.drink_cappuccino,
  'mocha' => l10n.drink_mocha,
  'cold_brew' => l10n.drink_cold_brew,
  _ => drinkId,
};

class BrewPanel extends StatefulWidget {
  const BrewPanel({super.key, required this.bridge});

  static const Key tapKey = Key('brew_panel_tap');

  final CafeBridge bridge;

  @override
  State<BrewPanel> createState() => _BrewPanelState();
}

class _BrewPanelState extends State<BrewPanel> with TickerProviderStateMixin {
  late final AnimationController _pour = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 350),
  );
  late final AnimationController _steam = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat();

  @override
  void dispose() {
    _pour.dispose();
    _steam.dispose();
    super.dispose();
  }

  void _brew() {
    final full = context.read<GameCubit>().brewTap();
    if (!MediaQuery.disableAnimationsOf(context)) _pour.forward(from: 0);
    if (full) widget.bridge.onBrewed();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<PlayerOrder?>(
      valueListenable: widget.bridge.playerOrder,
      builder: (context, order, _) {
        if (order == null || order.ready) return const SizedBox.shrink();
        final l10n = AppLocalizations.of(context);
        final atlas = context.read<SpriteAtlas>();
        final iconId =
            context
                .read<GameCubit>()
                .engine
                .config
                .service
                .drinkById(order.drinkId)
                ?.iconSpriteId ??
            'drink_espresso';
        return GestureDetector(
          key: BrewPanel.tapKey,
          behavior: HitTestBehavior.opaque,
          onTapDown: (_) => _brew(),
          child: Container(
            margin: const EdgeInsetsDirectional.all(12),
            padding: const EdgeInsetsDirectional.all(12),
            decoration: AppTheme.cardDecoration(borderColor: AppColors.copper),
            child: Row(
              children: [
                PixelImage(image: atlas.get(iconId), scale: 3),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        l10n.brewPanelTitle(drinkName(l10n, order.drinkId)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        l10n.tapToBrew,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                SizedBox.square(
                  dimension: 96,
                  child: BlocSelector<GameCubit, GameState, BaristaState>(
                    selector: (state) => state.barista,
                    builder: (context, barista) => RepaintBoundary(
                      child: AnimatedBuilder(
                        animation: Listenable.merge([_pour, _steam]),
                        builder: (context, _) => CustomPaint(
                          painter: EspressoMachinePainter(
                            pour: _pour.value,
                            rushGlow: barista.rushEndsAt != null ? 1 : 0,
                          ),
                          foregroundPainter: CoffeeCupPainter(
                            fill: barista.cupFill,
                            steamPhase: _steam.value,
                            rushGlow: barista.rushEndsAt != null ? 1 : 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
