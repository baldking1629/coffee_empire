import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/bignumber/big_number.dart';
import '../../../core/format/number_formatter.dart';
import '../../../l10n/app_localizations.dart';
import '../../game/game_cubit.dart';
import '../../game/game_state.dart';

typedef CashHeaderData = ({
  BigNumber cash,
  BigNumber incomePerSec,
  bool scientific,
  bool rushActive,
});

class CashHeader extends StatelessWidget {
  const CashHeader({super.key});

  static const Key cashTextKey = Key('cash_text');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    return BlocSelector<GameCubit, GameState, CashHeaderData>(
      selector: (state) => (
        cash: state.cash,
        incomePerSec: state.incomePerSec,
        scientific: state.settings.scientific,
        rushActive: state.barista.rushEndsAt != null,
      ),
      builder: (context, data) {
        final formatter = NumberFormatter(
          languageCode: languageCode,
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
                      child: Text(
                        formatter.formatMoney(data.cash),
                        key: cashTextKey,
                        textDirection: TextDirection.ltr,
                        style: textTheme.headlineMedium?.copyWith(
                          color: AppColors.mint,
                          fontWeight: FontWeight.bold,
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
              if (data.rushActive) const _BoostIndicator(),
            ],
          ),
        );
      },
    );
  }
}

class _BoostIndicator extends StatelessWidget {
  const _BoostIndicator();

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
          const Icon(LucideIcons.zap, size: 16, color: AppColors.copper),
          const SizedBox(width: 4),
          Text(
            AppLocalizations.of(context).baristaRush,
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
