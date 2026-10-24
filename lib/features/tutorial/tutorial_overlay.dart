import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_theme.dart';
import '../../core/services/notification_service.dart';
import '../../l10n/app_localizations.dart';
import '../game/game_cubit.dart';
import '../game/game_state.dart';
import 'tutorial_rules.dart';

class TutorialBanner extends StatelessWidget {
  const TutorialBanner({super.key});

  static const Key skipKey = Key('tutorial_skip');
  static const Key finishKey = Key('tutorial_finish');

  String _instruction(AppLocalizations l10n, int step) => switch (step) {
    TutorialSteps.tapCup => l10n.tutorialStepTapCup,
    TutorialSteps.buyFirstShop => l10n.tutorialStepBuyFirstShop,
    TutorialSteps.buySecondShop => l10n.tutorialStepBuySecondShop,
    TutorialSteps.hireManager => l10n.tutorialStepHireManager,
    TutorialSteps.openLab => l10n.tutorialStepOpenLab,
    _ => l10n.tutorialStepFinish,
  };

  Future<void> _finish(BuildContext context) async {
    final cubit = context.read<GameCubit>();
    final notifications = context.read<NotificationService?>();
    await notifications?.requestPermission();
    await cubit.completeTutorial();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<GameCubit, GameState, int>(
      selector: (state) => state.tutorialStep,
      builder: (context, step) {
        if (step >= TutorialSteps.done) return const SizedBox.shrink();
        final l10n = AppLocalizations.of(context);
        final finishing = step == TutorialSteps.finish;
        return Container(
          margin: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
          padding: const EdgeInsetsDirectional.all(12),
          decoration: AppTheme.cardDecoration(borderColor: AppColors.gold),
          child: Row(
            children: [
              const Icon(LucideIcons.graduationCap, color: AppColors.gold),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.tutorialTitle(step + 1, TutorialSteps.done),
                      style: const TextStyle(
                        color: AppColors.gold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _instruction(l10n, step),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (finishing)
                FilledButton(
                  key: finishKey,
                  onPressed: () => _finish(context),
                  child: Text(
                    l10n.tutorialFinish,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              else
                TextButton(
                  key: skipKey,
                  onPressed: context.read<GameCubit>().completeTutorial,
                  child: Text(
                    l10n.tutorialSkip,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
