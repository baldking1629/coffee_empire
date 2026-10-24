import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../app/formatters.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/bignumber/big_number.dart';
import '../../../l10n/app_localizations.dart';
import '../../game/game_cubit.dart';
import '../../game/game_state.dart';

typedef PrestigeCardData = ({
  int beans,
  BigNumber runEarnings,
  int gain,
  bool canPrestige,
  bool scientific,
});

class PrestigeCard extends StatelessWidget {
  const PrestigeCard({super.key});

  static const Key buttonKey = Key('prestige_button');

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameCubit>();
    final rules = cubit.prestigeRules;
    return BlocSelector<GameCubit, GameState, PrestigeCardData>(
      selector: (state) => (
        beans: state.goldenBeans,
        runEarnings: state.runEarnings,
        gain: rules.previewGain(state),
        canPrestige: rules.math.canPrestige(state.runEarnings),
        scientific: state.settings.scientific,
      ),
      builder: (context, data) {
        final l10n = AppLocalizations.of(context);
        final formatter = numberFormatterOf(
          context,
          scientific: data.scientific,
        );
        final threshold = rules.math.config.threshold;
        final progress = (data.runEarnings / threshold).toDouble().clamp(
          0.0,
          1.0,
        );
        final multiplier = formatter.format(
          rules.math.beanMultiplier(data.beans),
        );
        return Container(
          padding: const EdgeInsetsDirectional.all(12),
          decoration: AppTheme.cardDecoration(borderColor: AppColors.gold),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Icon(LucideIcons.bean, color: AppColors.gold),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l10n.prestigeTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                l10n.prestigeOwned(data.beans, multiplier),
                style: const TextStyle(color: AppColors.gold),
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                color: AppColors.gold,
                backgroundColor: AppColors.surface,
              ),
              const SizedBox(height: 4),
              Text(
                l10n.prestigeProgress(
                  formatter.formatMoney(data.runEarnings),
                  formatter.formatMoney(threshold),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 8),
              FilledButton(
                key: buttonKey,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.gold,
                  foregroundColor: AppColors.background,
                ),
                onPressed: data.canPrestige
                    ? () => _confirm(
                        context,
                        cubit,
                        data,
                        formatter.format(rules.multiplierAfter(cubit.state)),
                      )
                    : null,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(l10n.prestigeButton(data.gain)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _confirm(
    BuildContext context,
    GameCubit cubit,
    PrestigeCardData data,
    String newMultiplier,
  ) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.card,
        title: Text(l10n.prestigeConfirmTitle),
        content: Text(l10n.prestigeConfirmBody(data.gain, newMultiplier)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            key: const Key('prestige_confirm'),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.confirm),
          ),
        ],
      ),
    );
    if (confirmed ?? false) await cubit.prestige();
  }
}
