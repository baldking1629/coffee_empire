import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/theme/app_colors.dart';
import '../../config/economy_config.dart';
import '../../l10n/app_localizations.dart';
import '../game/game_cubit.dart';
import '../game/game_state.dart';
import 'widgets/capsule_card.dart';
import 'widgets/recipe_card.dart';

class LabTab extends StatelessWidget {
  const LabTab({super.key});

  @override
  Widget build(BuildContext context) {
    final recipes = context.read<EconomyConfig>().lab.recipes;
    return ListView(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
      children: [
        const _LabSummary(),
        const SizedBox(height: 8),
        const CapsuleCard(),
        for (final recipe in recipes) ...[
          const SizedBox(height: 8),
          RecipeCard(key: ValueKey(recipe.id), recipe: recipe),
        ],
      ],
    );
  }
}

class _LabSummary extends StatelessWidget {
  const _LabSummary();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameCubit>();
    final l10n = AppLocalizations.of(context);
    return BlocSelector<GameCubit, GameState, (int, int)>(
      selector: (state) => (
        cubit.lab.brandHype(state),
        ((cubit.lab.math.labBonusMultiplier(state.lab.bestScores).toDouble() -
                    1) *
                100)
            .round(),
      ),
      builder: (context, data) => Wrap(
        spacing: 16,
        children: [
          Text(
            l10n.brandHypeValue(data.$1),
            style: const TextStyle(color: AppColors.gold),
          ),
          Text(
            l10n.labBonusValue(data.$2),
            style: const TextStyle(color: AppColors.mint),
          ),
        ],
      ),
    );
  }
}
