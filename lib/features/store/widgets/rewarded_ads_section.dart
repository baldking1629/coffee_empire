import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../app/formatters.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/services/monetization_service.dart';
import '../../../l10n/app_localizations.dart';
import '../../game/game_cubit.dart';
import '../../game/game_state.dart';
import '../../home/widgets/rewarded_ad_runner.dart';

typedef RewardedTileData = ({
  bool canWatch,
  int cooldownSeconds,
  String detail,
});

class RewardedAdsSection extends StatelessWidget {
  const RewardedAdsSection({super.key});

  static const List<RewardedAdType> listedTypes = [
    RewardedAdType.caffeineRush,
    RewardedAdType.emergencyFund,
    RewardedAdType.labSpeedup,
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.rewardedTitle,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        for (final type in listedTypes) ...[
          const SizedBox(height: 8),
          _RewardedTile(type: type),
        ],
      ],
    );
  }
}

class _RewardedTile extends StatelessWidget {
  const _RewardedTile({required this.type});

  final RewardedAdType type;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameCubit>();
    final l10n = AppLocalizations.of(context);
    return BlocSelector<GameCubit, GameState, RewardedTileData>(
      selector: (state) {
        final now = cubit.clock.now();
        final cooldownEnd = cubit.store.cooldownEnd(state, type);
        final remaining = cooldownEnd == null
            ? 0
            : cooldownEnd.difference(now).inSeconds;
        final formatter = numberFormatterOf(
          context,
          scientific: state.settings.scientific,
        );
        return (
          canWatch: cubit.store.canWatch(state, type, now),
          cooldownSeconds: remaining > 0 ? remaining : 0,
          detail: type == RewardedAdType.emergencyFund
              ? formatter.formatMoney(
                  cubit.engine.boostMath.emergencyFund(state.incomePerSec),
                )
              : '',
        );
      },
      builder: (context, data) {
        final (icon, title, body) = switch (type) {
          RewardedAdType.caffeineRush => (
            LucideIcons.zap,
            l10n.rewardCaffeineRushTitle,
            l10n.rewardCaffeineRushBody,
          ),
          RewardedAdType.emergencyFund => (
            LucideIcons.piggyBank,
            l10n.rewardEmergencyFundTitle,
            l10n.rewardEmergencyFundBody(data.detail),
          ),
          RewardedAdType.labSpeedup => (
            LucideIcons.flaskConical,
            l10n.rewardLabSpeedupTitle,
            l10n.rewardLabSpeedupBody,
          ),
          RewardedAdType.offlineDouble => (
            LucideIcons.moon,
            l10n.offlineCollectDouble,
            '',
          ),
        };
        final status = data.cooldownSeconds > 0
            ? l10n.readyIn(
                durationFormatterOf(
                  context,
                ).format(Duration(seconds: data.cooldownSeconds)),
              )
            : data.canWatch
            ? l10n.watchAd
            : l10n.unavailable;
        return Container(
          padding: const EdgeInsetsDirectional.all(12),
          decoration: AppTheme.cardDecoration(),
          child: Row(
            children: [
              Icon(icon, color: AppColors.copper),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: FilledButton(
                  key: Key('watch_ad_${type.id}'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.copper,
                    visualDensity: VisualDensity.compact,
                  ),
                  onPressed: data.canWatch
                      ? () => watchAdForReward(context, type)
                      : null,
                  child: FittedBox(fit: BoxFit.scaleDown, child: Text(status)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
