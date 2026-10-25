import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_theme.dart';
import '../../cafe/cafe_bridge.dart';
import '../../engine/barista_math.dart';
import '../../l10n/app_localizations.dart';
import '../game/game_cubit.dart';
import '../game/game_state.dart';

class ServiceHud extends StatelessWidget {
  const ServiceHud({super.key, required this.bridge});

  static const Key serveHintKey = Key('serve_hint');

  final CafeBridge bridge;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsetsDirectional.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocSelector<GameCubit, GameState, BaristaState>(
            selector: (state) => state.barista,
            builder: (context, barista) {
              final rush = barista.rushEndsAt != null;
              if (!rush && barista.combo == 0) return const SizedBox.shrink();
              return _Pill(
                text: rush ? l10n.baristaRush : l10n.comboLabel(barista.combo),
                color: rush ? AppColors.copper : AppColors.gold,
              );
            },
          ),
          ValueListenableBuilder<PlayerOrder?>(
            valueListenable: bridge.playerOrder,
            builder: (context, order, _) {
              if (order == null || !order.ready) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsetsDirectional.only(top: 6),
                child: _Pill(
                  key: serveHintKey,
                  text: l10n.serveHint,
                  color: AppColors.mint,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({super.key, required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(AppTheme.buttonRadius),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
