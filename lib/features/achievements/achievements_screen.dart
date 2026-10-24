import 'package:flutter/material.dart';
import '../../app/widgets/game_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/formatters.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import '../game/game_cubit.dart';
import '../game/game_state.dart';
import 'achievement_labels.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<GameCubit>();
    final math = cubit.engine.achievementMath;
    final catalog = math.catalog;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: Text(l10n.achievementsTitle),
      ),
      body: GameBackground(
        child: BlocSelector<GameCubit, GameState, (Set<String>, bool)>(
          selector: (state) => (state.achievements, state.settings.scientific),
          builder: (context, data) {
            final (unlocked, scientific) = data;
            final formatter = numberFormatterOf(
              context,
              scientific: scientific,
            );
            final percent =
                ((math.multiplier(unlocked.length).toDouble() - 1) * 100)
                    .round();
            return ListView(
              padding: const EdgeInsetsDirectional.all(16),
              children: [
                Text(
                  l10n.achievementsProgress(
                    unlocked.length,
                    catalog.achievements.length,
                    percent,
                  ),
                  style: const TextStyle(color: AppColors.gold),
                ),
                for (final achievement in catalog.achievements) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsetsDirectional.all(12),
                    decoration: AppTheme.cardDecoration(
                      borderColor: unlocked.contains(achievement.id)
                          ? AppColors.gold
                          : AppColors.cardBorder,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          unlocked.contains(achievement.id)
                              ? LucideIcons.trophy
                              : LucideIcons.circle,
                          color: unlocked.contains(achievement.id)
                              ? AppColors.gold
                              : AppColors.textSecondary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                achievementName(l10n, achievement.id),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                achievementDescription(
                                  l10n,
                                  achievement,
                                  masteryScore: catalog.masteryScore,
                                  formattedAmount: formatter.formatMoney(
                                    achievement.threshold,
                                  ),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
