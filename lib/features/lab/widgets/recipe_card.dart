import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../app/formatters.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_theme.dart';
import '../../../config/economy_config.dart';
import '../../../l10n/app_localizations.dart';
import '../../game/game_cubit.dart';
import '../../game/game_state.dart';
import '../lab_labels.dart';
import '../lab_state.dart';
import '../recipe_screen.dart';
import 'brew_countdown.dart';

typedef RecipeCardData = ({
  bool unlocked,
  bool canAffordUnlock,
  RecipeProgress progress,
  ActiveBrew? activeBrew,
  bool scientific,
});

class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key, required this.recipe});

  final RecipeConfig recipe;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameCubit>();
    return BlocSelector<GameCubit, GameState, RecipeCardData>(
      selector: (state) => (
        unlocked: state.lab.isUnlocked(recipe),
        canAffordUnlock: state.cash >= recipe.unlockCost,
        progress: state.lab.progressOf(recipe.id),
        activeBrew: state.lab.activeBrew,
        scientific: state.settings.scientific,
      ),
      builder: (context, data) => _buildCard(context, cubit, data),
    );
  }

  Widget _buildCard(
    BuildContext context,
    GameCubit cubit,
    RecipeCardData data,
  ) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final activeBrew = data.activeBrew;
    final brewingThis = activeBrew != null && activeBrew.recipeId == recipe.id;
    final lastScore = data.progress.lastScore;
    final lastHint = data.progress.lastHint;
    return Container(
      padding: const EdgeInsetsDirectional.all(12),
      decoration: AppTheme.cardDecoration(
        borderColor: data.progress.bestScore >= 100
            ? AppColors.gold
            : AppColors.cardBorder,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                recipe.isCapsule
                    ? LucideIcons.package
                    : LucideIcons.flaskConical,
                color: AppColors.copper,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  recipeName(l10n, recipe.id),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (recipe.isCapsule)
                Text(
                  l10n.recipeCapsuleTag,
                  style: const TextStyle(color: AppColors.gold),
                ),
            ],
          ),
          if (data.unlocked) ...[
            const SizedBox(height: 4),
            Text(
              l10n.recipeBestScore(data.progress.bestScore),
              style: const TextStyle(color: AppColors.mint),
            ),
            if (lastScore != null && lastHint != null)
              Text(
                l10n.recipeLastResult(lastScore, hintText(l10n, lastHint)),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
          ],
          const SizedBox(height: 8),
          if (!data.unlocked)
            FilledButton(
              key: Key('unlock_recipe_${recipe.id}'),
              onPressed: data.canAffordUnlock
                  ? () => cubit.unlockRecipe(recipe.id)
                  : null,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  l10n.unlockRecipe(
                    numberFormatterOf(
                      context,
                      scientific: data.scientific,
                    ).formatMoney(recipe.unlockCost),
                  ),
                ),
              ),
            )
          else if (brewingThis)
            BrewCountdown(endsAt: activeBrew.endsAt, clock: cubit.clock)
          else
            OutlinedButton.icon(
              key: Key('open_recipe_${recipe.id}'),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => RecipeScreen(recipe: recipe),
                ),
              ),
              icon: const Icon(LucideIcons.slidersHorizontal, size: 16),
              label: Text(
                l10n.openRecipe,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }
}
