import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/formatters.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/widgets/bouncy_button.dart';
import '../../../config/economy_config.dart';
import '../../../engine/shop_math.dart';
import '../../../l10n/app_localizations.dart';
import '../../game/game_cubit.dart';
import '../../game/game_state.dart';
import '../shop_labels.dart';
import 'shop_station_data.dart';
import 'shop_upgrades.dart';

class ShopStationPanel extends StatelessWidget {
  const ShopStationPanel({
    super.key,
    required this.shop,
    required this.index,
    required this.buyAmount,
  });

  final ShopConfig shop;
  final int index;
  final BuyAmount buyAmount;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameCubit>();
    final math = cubit.shopMath;
    return BlocSelector<GameCubit, GameState, ShopStationData>(
      selector: (state) =>
          selectShopStation(cubit, state, shop, index, buyAmount),
      builder: (context, data) {
        final l10n = AppLocalizations.of(context);
        final textTheme = Theme.of(context).textTheme;
        final formatter = numberFormatterOf(
          context,
          scientific: data.scientific,
        );
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Icon(
                      shopIcon(shop.id),
                      color: AppColors.primaryGradientStart,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        shopName(l10n, shop.id),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      l10n.shopLevel(data.level),
                      style: textTheme.titleSmall?.copyWith(
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
                Text(
                  l10n.incomePerSecond(formatter.formatMoney(data.income)),
                  style: textTheme.bodyMedium?.copyWith(color: AppColors.mint),
                ),
                const SizedBox(height: 12),
                _MilestoneBar(level: data.level, math: math),
                const SizedBox(height: 12),
                BouncyButton(
                  key: Key('panel_buy_shop_${shop.id}'),
                  canAfford: data.plan.affordable,
                  onPressed: () => cubit.buyShopLevels(shop.id, buyAmount),
                  onDenied: cubit.reportInsufficientFunds,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      l10n.buyLevels(
                        data.plan.count,
                        formatter.formatMoney(data.plan.cost),
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ShopUpgrades(
                  shopId: shop.id,
                  hasManager: data.hasManager,
                  managerCost: formatter.formatMoney(math.managerCost(shop)),
                  managerAffordable: data.managerAffordable,
                  equipmentOwned: data.equipmentOwned,
                  equipmentTierCount: math.equipmentTierCount,
                  nextEquipmentCost:
                      data.equipmentOwned < math.equipmentTierCount
                      ? formatter.formatMoney(
                          math.equipmentCost(shop, data.equipmentOwned),
                        )
                      : null,
                  equipmentAffordable: data.equipmentAffordable,
                  onHireManager: () => cubit.hireManager(shop.id),
                  onBuyEquipment: () => cubit.buyEquipment(shop.id),
                  onDenied: cubit.reportInsufficientFunds,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MilestoneBar extends StatelessWidget {
  const _MilestoneBar({required this.level, required this.math});

  final int level;
  final ShopMath math;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final next = math.nextMilestone(level);
    final previous = math.previousMilestone(level) ?? 0;
    final progress = next == null
        ? 1.0
        : (level - previous) / (next - previous);
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: AppColors.card,
              color: AppColors.gold,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            next == null ? l10n.milestoneMaxed : l10n.nextMilestone(next),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: AppColors.textSecondary),
          ),
        ),
      ],
    );
  }
}
