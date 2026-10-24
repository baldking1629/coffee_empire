import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/formatters.dart';
import '../../app/theme/app_colors.dart';
import '../../config/economy_config.dart';
import '../../core/services/monetization_service.dart';
import '../../core/bignumber/big_number.dart';
import '../../engine/lab_math.dart';
import '../../l10n/app_localizations.dart';
import '../game/game_cubit.dart';
import '../game/game_state.dart';
import '../home/widgets/rewarded_ad_runner.dart';
import 'lab_labels.dart';
import 'lab_state.dart';
import 'widgets/brew_countdown.dart';
import 'widgets/flavor_radar.dart';

typedef RecipeScreenData = ({
  RecipeProgress progress,
  ActiveBrew? activeBrew,
  BigNumber testCost,
  bool canAfford,
  bool scientific,
});

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key, required this.recipe});

  static const Key testButtonKey = Key('start_test_button');

  final RecipeConfig recipe;

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  FlavorProfile _sliders = FlavorProfile.neutral;

  @override
  void initState() {
    super.initState();
    final brew = context.read<GameCubit>().state.lab.activeBrew;
    if (brew != null && brew.recipeId == widget.recipe.id) {
      _sliders = brew.sliders;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<GameCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: Text(
          recipeName(l10n, widget.recipe.id),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: BlocSelector<GameCubit, GameState, RecipeScreenData>(
        selector: (state) {
          final cost = cubit.lab.testCost(widget.recipe, state);
          return (
            progress: state.lab.progressOf(widget.recipe.id),
            activeBrew: state.lab.activeBrew,
            testCost: cost,
            canAfford: state.cash >= cost,
            scientific: state.settings.scientific,
          );
        },
        builder: (context, data) => ListView(
          padding: const EdgeInsetsDirectional.all(16),
          children: [
            Text(
              l10n.flavorProfileTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 240, child: FlavorRadar(profile: _sliders)),
            for (final attribute in FlavorAttribute.values)
              _FlavorSlider(
                label: flavorName(l10n, attribute),
                value: _sliders.values[attribute.index],
                enabled: data.activeBrew == null,
                onChanged: (value) => setState(
                  () => _sliders = _sliders.withValue(attribute.index, value),
                ),
              ),
            const SizedBox(height: 8),
            _ResultSummary(progress: data.progress),
            const SizedBox(height: 16),
            _buildAction(context, cubit, data),
          ],
        ),
      ),
    );
  }

  Widget _buildAction(
    BuildContext context,
    GameCubit cubit,
    RecipeScreenData data,
  ) {
    final l10n = AppLocalizations.of(context);
    final brew = data.activeBrew;
    if (brew != null && brew.recipeId == widget.recipe.id) {
      return Column(
        children: [
          BrewCountdown(endsAt: brew.endsAt, clock: cubit.clock),
          const SizedBox(height: 8),
          OutlinedButton(
            key: const Key('lab_speedup_button'),
            onPressed: () =>
                watchAdForReward(context, RewardedAdType.labSpeedup),
            child: Text(l10n.rewardLabSpeedupTitle),
          ),
        ],
      );
    }
    if (brew != null) {
      return Text(
        l10n.anotherBrewActive,
        textAlign: TextAlign.center,
        style: const TextStyle(color: AppColors.textSecondary),
      );
    }
    final cost = numberFormatterOf(
      context,
      scientific: data.scientific,
    ).formatMoney(data.testCost);
    return FilledButton(
      key: RecipeScreen.testButtonKey,
      style: FilledButton.styleFrom(backgroundColor: AppColors.copper),
      onPressed: data.canAfford
          ? () => cubit.startBrew(widget.recipe.id, _sliders)
          : null,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(l10n.startTest(cost)),
      ),
    );
  }
}

class _FlavorSlider extends StatelessWidget {
  const _FlavorSlider({
    required this.label,
    required this.value,
    required this.enabled,
    required this.onChanged,
  });

  final String label;
  final int value;
  final bool enabled;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
        Expanded(
          flex: 5,
          child: Slider(
            value: value.toDouble(),
            max: 100,
            divisions: 100,
            activeColor: AppColors.copper,
            onChanged: enabled ? (v) => onChanged(v.round()) : null,
          ),
        ),
        SizedBox(
          width: 32,
          child: Text(
            '$value',
            textAlign: TextAlign.end,
            textDirection: TextDirection.ltr,
          ),
        ),
      ],
    );
  }
}

class _ResultSummary extends StatelessWidget {
  const _ResultSummary({required this.progress});

  final RecipeProgress progress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final lastScore = progress.lastScore;
    final lastHint = progress.lastHint;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.recipeBestScore(progress.bestScore),
          style: const TextStyle(color: AppColors.mint),
        ),
        if (lastScore != null && lastHint != null)
          Text(
            l10n.recipeLastResult(lastScore, hintText(l10n, lastHint)),
            style: const TextStyle(color: AppColors.textSecondary),
          ),
      ],
    );
  }
}
