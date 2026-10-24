import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/formatters.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/bignumber/big_number.dart';
import '../../../l10n/app_localizations.dart';
import '../../game/game_cubit.dart';
import '../../game/game_state.dart';
import '../growth_labels.dart';
import 'city_card.dart';

class FranchiseSection extends StatefulWidget {
  const FranchiseSection({super.key});

  @override
  State<FranchiseSection> createState() => _FranchiseSectionState();
}

class _FranchiseSectionState extends State<FranchiseSection> {
  String? _region;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<GameCubit>();
    final cities = cubit.franchise.citiesByHype
        .where((city) => _region == null || city.region == _region)
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.franchiseTitle,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        BlocSelector<GameCubit, GameState, (BigNumber, int, bool)>(
          selector: (state) {
            final inputs = cubit.incomeInputsOf(state);
            final engine = cubit.engine;
            return (
              engine.franchiseMath.royaltyIncome(
                    state.franchises,
                    engine.shopsIncomePerSec(inputs),
                  ) *
                  engine.globalMultiplier(inputs),
              engine.brandHype(state.lifetimeEarnings),
              state.settings.scientific,
            );
          },
          builder: (context, data) => Wrap(
            spacing: 16,
            children: [
              Text(
                l10n.franchiseRoyalty(
                  numberFormatterOf(
                    context,
                    scientific: data.$3,
                  ).formatMoney(data.$1),
                ),
                style: const TextStyle(color: AppColors.mint),
              ),
              Text(
                l10n.brandHypeValue(data.$2),
                style: const TextStyle(color: AppColors.gold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            for (final region in regionOrder)
              FilterChip(
                label: Text(regionName(l10n, region)),
                selected: _region == region,
                selectedColor: AppColors.card,
                checkmarkColor: AppColors.gold,
                onSelected: (selected) =>
                    setState(() => _region = selected ? region : null),
              ),
          ],
        ),
        for (final city in cities) ...[
          const SizedBox(height: 8),
          CityCard(key: ValueKey(city.id), city: city),
        ],
      ],
    );
  }
}
