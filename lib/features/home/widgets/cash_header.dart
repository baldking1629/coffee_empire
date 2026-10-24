import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../app/formatters.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/bignumber/big_number.dart';
import '../../../engine/boost_math.dart';
import '../../../l10n/app_localizations.dart';
import '../../game/game_cubit.dart';
import '../../game/game_state.dart';
import 'counting_money_text.dart';

typedef CashHeaderData = ({
  BigNumber cash,
  BigNumber incomePerSec,
  bool scientific,
  bool rushActive,
  int caffeineRushMinutes,
});

class CashHeader extends StatelessWidget {
  const CashHeader({super.key});

  static const Key cashTextKey = Key('cash_text');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<GameCubit>();
    return BlocSelector<GameCubit, GameState, CashHeaderData>(
      selector: (state) {
        final rush = state.store.boostOf(ActiveBoost.caffeineRush);
        final remaining = rush?.endsAt.difference(cubit.clock.now());
        return (
          cash: state.cash,
          incomePerSec: state.incomePerSec,
          scientific: state.settings.scientific,
          rushActive: state.barista.rushEndsAt != null,
          caffeineRushMinutes: remaining == null || remaining.isNegative
              ? 0
              : remaining.inMinutes + 1,
        );
      },
      builder: (context, data) {
        final formatter = numberFormatterOf(
          context,
          scientific: data.scientific,
        );
        final textTheme = Theme.of(context).textTheme;
        return Container(
          margin: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          decoration: AppTheme.cardDecoration(),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: AlignmentDirectional.centerStart,
                      child: CountingMoneyText(
                        value: data.cash,
                        formatter: formatter,
                        textKey: cashTextKey,
                        style: textTheme.headlineMedium?.copyWith(
                          color: AppColors.mint,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Text(
                      l10n.incomePerSecond(
                        formatter.formatMoney(data.incomePerSec),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (data.caffeineRushMinutes > 0)
                    _BoostIndicator(
                      key: const Key('caffeine_rush_indicator'),
                      icon: LucideIcons.coffee,
                      label: l10n.boostActive(
                        formatter.format(
                          BigNumber.fromDouble(
                            cubit.engine.config.rewarded.caffeineRushMultiplier,
                          ),
                        ),
                        durationFormatterOf(
                          context,
                        ).format(Duration(minutes: data.caffeineRushMinutes)),
                      ),
                    ),
                  if (data.rushActive && data.caffeineRushMinutes > 0)
                    const SizedBox(height: 4),
                  if (data.rushActive)
                    _BoostIndicator(
                      icon: LucideIcons.zap,
                      label: l10n.baristaRush,
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BoostIndicator extends StatelessWidget {
  const _BoostIndicator({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.copper.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        border: Border.all(color: AppColors.copper),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.copper),
          const SizedBox(width: 4),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.copper,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
