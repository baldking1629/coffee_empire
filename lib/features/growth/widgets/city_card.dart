import 'package:flutter/material.dart';
import '../../../app/widgets/bouncy_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/formatters.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_theme.dart';
import '../../../config/economy_config.dart';
import '../../../core/bignumber/big_number.dart';
import '../../../l10n/app_localizations.dart';
import '../../game/game_cubit.dart';
import '../../game/game_state.dart';
import '../growth_labels.dart';

typedef CityCardData = ({
  int owned,
  bool unlocked,
  BigNumber nextCost,
  bool affordable,
  BigNumber perSlot,
  bool scientific,
});

class CityCard extends StatelessWidget {
  const CityCard({super.key, required this.city});

  final CityConfig city;

  CityCardData _select(GameCubit cubit, GameState state) {
    final engine = cubit.engine;
    final inputs = cubit.incomeInputsOf(state);
    final owned = cubit.franchise.ownedIn(state, city.id);
    final nextCost = cubit.franchise.nextSlotCost(state, city);
    return (
      owned: owned,
      unlocked: engine.franchiseMath.isCityUnlocked(
        city,
        engine.brandHype(state.lifetimeEarnings),
      ),
      nextCost: nextCost,
      affordable: owned < city.slots && state.cash >= nextCost,
      perSlot:
          engine.shopsIncomePerSec(inputs) *
          BigNumber.fromDouble(city.royaltyShare) *
          engine.globalMultiplier(inputs),
      scientific: state.settings.scientific,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameCubit>();
    return BlocSelector<GameCubit, GameState, CityCardData>(
      selector: (state) => _select(cubit, state),
      builder: (context, data) {
        final l10n = AppLocalizations.of(context);
        final formatter = numberFormatterOf(
          context,
          scientific: data.scientific,
        );
        final complete = data.owned >= city.slots;
        final textTheme = Theme.of(context).textTheme;
        return Opacity(
          opacity: data.unlocked ? 1 : 0.6,
          child: Container(
            padding: const EdgeInsetsDirectional.all(12),
            decoration: AppTheme.cardDecoration(
              borderColor: complete ? AppColors.gold : AppColors.cardBorder,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text(
                      flagEmoji(city.countryCode),
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cityName(l10n, city.id),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            countryName(l10n, city.countryCode),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _SlotDots(owned: data.owned, slots: city.slots),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.franchisePerSlot(formatter.formatMoney(data.perSlot)),
                  style: const TextStyle(color: AppColors.mint),
                ),
                const SizedBox(height: 8),
                if (!data.unlocked)
                  Text(
                    l10n.franchiseRequiresHype(city.requiredHype),
                    style: const TextStyle(color: AppColors.textSecondary),
                  )
                else if (complete)
                  Text(
                    l10n.franchiseComplete(
                      formatter.format(
                        BigNumber.fromDouble(
                          cubit.franchise.math.config.completionMultiplier,
                        ),
                      ),
                    ),
                    style: const TextStyle(color: AppColors.gold),
                  )
                else
                  BouncyButton(
                    key: Key('open_franchise_${city.id}'),
                    canAfford: data.affordable,
                    onPressed: () => cubit.openFranchise(city.id),
                    onDenied: cubit.reportInsufficientFunds,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        l10n.franchiseOpen(
                          formatter.formatMoney(data.nextCost),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SlotDots extends StatelessWidget {
  const _SlotDots({required this.owned, required this.slots});

  final int owned;
  final int slots;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var slot = 0; slot < slots; slot++)
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 4),
            child: Icon(
              Icons.circle,
              size: 10,
              color: slot < owned ? AppColors.gold : AppColors.cardBorder,
            ),
          ),
      ],
    );
  }
}
