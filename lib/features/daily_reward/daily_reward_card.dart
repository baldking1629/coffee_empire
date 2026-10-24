import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/formatters.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_theme.dart';
import '../../engine/daily_reward_math.dart';
import '../../l10n/app_localizations.dart';
import '../game/game_cubit.dart';
import '../game/game_state.dart';

typedef DailyRewardCardData = ({
  DailyRewardStatus status,
  String amount,
  int remainingSeconds,
});

class DailyRewardCard extends StatelessWidget {
  const DailyRewardCard({super.key});

  static const Key claimKey = Key('claim_daily_reward');

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameCubit>();
    final math = cubit.dailyRewards.math;
    return BlocSelector<GameCubit, GameState, DailyRewardCardData>(
      selector: (state) {
        final now = cubit.clock.now();
        final status = cubit.dailyRewards.status(state, now);
        final availableAt = status.availableAt;
        return (
          status: status,
          amount: numberFormatterOf(
            context,
            scientific: state.settings.scientific,
          ).formatMoney(math.cashReward(status.dayIndex, state.incomePerSec)),
          remainingSeconds: availableAt == null
              ? 0
              : availableAt.difference(now).inSeconds,
        );
      },
      builder: (context, data) {
        final l10n = AppLocalizations.of(context);
        final status = data.status;
        final beans = math.goldenBeansReward(status.dayIndex);
        return Container(
          padding: const EdgeInsetsDirectional.all(12),
          decoration: AppTheme.cardDecoration(
            borderColor: status.claimable
                ? AppColors.mint
                : AppColors.cardBorder,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Icon(LucideIcons.calendarCheck, color: AppColors.mint),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l10n.dailyRewardTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (var day = 0; day < math.cycleLength; day++)
                    Chip(
                      visualDensity: VisualDensity.compact,
                      label: Text(l10n.dailyRewardDay(day + 1)),
                      backgroundColor: day == status.dayIndex
                          ? AppColors.copper
                          : AppColors.surface,
                      side: BorderSide(
                        color: math.goldenBeansReward(day) > 0
                            ? AppColors.gold
                            : AppColors.cardBorder,
                      ),
                    ),
                ],
              ),
              if (beans > 0)
                Text(
                  l10n.dailyRewardBean(beans),
                  style: const TextStyle(color: AppColors.gold),
                ),
              const SizedBox(height: 8),
              FilledButton(
                key: claimKey,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.mint,
                  foregroundColor: AppColors.background,
                ),
                onPressed: status.claimable ? cubit.claimDailyReward : null,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    status.claimable
                        ? l10n.dailyRewardClaim(data.amount)
                        : l10n.dailyRewardNext(
                            durationFormatterOf(context).format(
                              Duration(
                                seconds: data.remainingSeconds > 0
                                    ? data.remainingSeconds
                                    : 0,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
