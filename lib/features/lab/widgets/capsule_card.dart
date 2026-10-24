import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../app/formatters.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_theme.dart';
import '../../../config/economy_config.dart';
import '../../../core/bignumber/big_number.dart';
import '../../../engine/shop_math.dart';
import '../../../l10n/app_localizations.dart';
import '../../game/game_cubit.dart';
import '../../game/game_state.dart';
import '../../shops/widgets/buy_amount_selector.dart';

typedef CapsuleCardData = ({
  bool unlocked,
  int machines,
  PurchasePlan plan,
  BigNumber income,
  bool scientific,
});

class CapsuleCard extends StatefulWidget {
  const CapsuleCard({super.key});

  @override
  State<CapsuleCard> createState() => _CapsuleCardState();
}

class _CapsuleCardState extends State<CapsuleCard> {
  BuyAmount _amount = BuyAmount.one;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameCubit>();
    final capsule = context.read<EconomyConfig>().capsule;
    return BlocSelector<GameCubit, GameState, CapsuleCardData>(
      selector: (state) => (
        unlocked: cubit.lab.isCapsuleUnlocked(state),
        machines: state.lab.capsuleMachines,
        plan: cubit.lab.capsulePlan(state, _amount),
        income: cubit.lab.math.capsuleIncomePerSec(
          state.lab.capsuleMachines,
          state.lab.bestScores,
        ),
        scientific: state.settings.scientific,
      ),
      builder: (context, data) {
        final l10n = AppLocalizations.of(context);
        final formatter = numberFormatterOf(
          context,
          scientific: data.scientific,
        );
        return Container(
          padding: const EdgeInsetsDirectional.all(12),
          decoration: AppTheme.cardDecoration(borderColor: AppColors.copper),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Icon(LucideIcons.package, color: AppColors.copper),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l10n.capsuleTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (data.unlocked) Text(l10n.capsuleOwned(data.machines)),
                ],
              ),
              const SizedBox(height: 8),
              if (!data.unlocked)
                Text(
                  l10n.capsuleLocked(capsule.unlockScore, capsule.unlockHype),
                  style: const TextStyle(color: AppColors.textSecondary),
                )
              else ...[
                Text(
                  l10n.incomePerSecond(formatter.formatMoney(data.income)),
                  style: const TextStyle(color: AppColors.mint),
                ),
                const SizedBox(height: 8),
                BuyAmountSelector(
                  selected: _amount,
                  onChanged: (amount) => setState(() => _amount = amount),
                ),
                const SizedBox(height: 8),
                FilledButton(
                  key: const Key('buy_capsule_machines'),
                  onPressed: data.plan.affordable
                      ? () => cubit.buyCapsuleMachines(_amount)
                      : null,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      l10n.buyLevels(
                        data.plan.count,
                        formatter.formatMoney(data.plan.cost),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
