import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../app/formatters.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/widgets/bouncy_button.dart';
import '../../../config/economy_config.dart';
import '../../../core/bignumber/big_number.dart';
import '../../../engine/shop_math.dart';
import '../../../l10n/app_localizations.dart';
import '../../game/game_cubit.dart';
import '../../game/game_state.dart';
import '../shop_labels.dart';
import 'shop_upgrades.dart';

typedef ShopCardData = ({
  int level,
  bool available,
  bool hasManager,
  int equipmentOwned,
  PurchasePlan plan,
  bool managerAffordable,
  bool equipmentAffordable,
  BigNumber income,
  bool scientific,
});

class ShopCard extends StatelessWidget {
  const ShopCard({
    super.key,
    required this.shop,
    required this.index,
    required this.previousShopId,
    required this.buyAmount,
  });

  final ShopConfig shop;
  final int index;
  final String? previousShopId;
  final BuyAmount buyAmount;

  ShopCardData _select(GameCubit cubit, GameState state) {
    final math = cubit.shopMath;
    final level = state.shopLevels[shop.id] ?? 0;
    final hasManager = state.managers[shop.id] ?? false;
    final equipmentOwned = state.equipment[shop.id] ?? 0;
    final canEquip = equipmentOwned < math.equipmentTierCount;
    return (
      level: level,
      available: math.isShopAvailable(cubit.shopLevelList, index),
      hasManager: hasManager,
      equipmentOwned: equipmentOwned,
      plan: math.purchasePlan(shop, level, state.cash, buyAmount),
      managerAffordable: state.cash >= math.managerCost(shop),
      equipmentAffordable:
          canEquip && state.cash >= math.equipmentCost(shop, equipmentOwned),
      income: math.shopIncomePerSec(
        shop,
        level: level,
        hasManager: hasManager,
        equipmentOwned: equipmentOwned,
      ),
      scientific: state.settings.scientific,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameCubit>();
    return BlocSelector<GameCubit, GameState, ShopCardData>(
      selector: (state) => _select(cubit, state),
      builder: (context, data) => RepaintBoundary(
        child: data.available
            ? _buildOpen(context, cubit, data)
            : _buildLocked(context),
      ),
    );
  }

  Widget _buildLocked(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final previous = previousShopId;
    return Container(
      padding: const EdgeInsetsDirectional.all(12),
      decoration: AppTheme.cardDecoration(),
      child: Row(
        children: [
          const Icon(LucideIcons.lock, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              previous == null
                  ? shopName(l10n, shop.id)
                  : l10n.shopLocked(shopName(l10n, previous)),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOpen(BuildContext context, GameCubit cubit, ShopCardData data) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final formatter = numberFormatterOf(context, scientific: data.scientific);
    final math = cubit.shopMath;
    final owned = data.level > 0;
    return Container(
      padding: const EdgeInsetsDirectional.all(12),
      decoration: AppTheme.cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.surface,
                child: Icon(
                  shopIcon(shop.id),
                  size: 18,
                  color: AppColors.copper,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shopName(l10n, shop.id),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      l10n.incomePerSecond(formatter.formatMoney(data.income)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.mint,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                l10n.shopLevel(data.level),
                style: textTheme.labelLarge?.copyWith(color: AppColors.gold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _MilestoneBar(level: data.level, math: math),
          const SizedBox(height: 8),
          BouncyButton(
            key: Key('buy_shop_${shop.id}'),
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
          if (owned) ...[
            const SizedBox(height: 8),
            ShopUpgrades(
              shopId: shop.id,
              hasManager: data.hasManager,
              managerCost: formatter.formatMoney(math.managerCost(shop)),
              managerAffordable: data.managerAffordable,
              equipmentOwned: data.equipmentOwned,
              equipmentTierCount: math.equipmentTierCount,
              nextEquipmentCost: data.equipmentOwned < math.equipmentTierCount
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
        ],
      ),
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
              backgroundColor: AppColors.surface,
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
