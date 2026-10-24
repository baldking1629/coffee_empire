import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../app/formatters.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/widgets/bouncy_button.dart';
import '../../../config/economy_config.dart';
import '../../../engine/shop_math.dart';
import '../../../l10n/app_localizations.dart';
import '../../game/game_cubit.dart';
import '../shop_labels.dart';
import 'shop_station.dart';
import 'shop_station_data.dart';

final Color lockedSurface = Color.alphaBlend(
  AppColors.lockedShade,
  AppColors.card,
);

class StationNode extends StatelessWidget {
  const StationNode({
    super.key,
    required this.shop,
    required this.data,
    required this.math,
  });

  final ShopConfig shop;
  final ShopStationData data;
  final ShopMath math;

  @override
  Widget build(BuildContext context) {
    final locked = data.status == StationStatus.locked;
    final next = math.nextMilestone(data.level);
    final previous = math.previousMilestone(data.level) ?? 0;
    final progress = next == null
        ? 1.0
        : (data.level - previous) / (next - previous);
    return SizedBox.square(
      dimension: ShopStation.nodeSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: locked ? null : AppTheme.cardGradient,
              color: locked ? lockedSurface : null,
              border: Border.all(
                color: data.status == StationStatus.available
                    ? AppColors.gold
                    : AppColors.cardBorder,
                width: 2,
              ),
              boxShadow: AppTheme.cardShadow,
            ),
            child: SizedBox.square(
              dimension: ShopStation.nodeSize,
              child: Icon(
                locked ? LucideIcons.lock : shopIcon(shop.id),
                color: locked
                    ? AppColors.textSecondary
                    : AppColors.primaryGradientStart,
                size: 24,
              ),
            ),
          ),
          if (data.status == StationStatus.open)
            SizedBox.square(
              dimension: ShopStation.nodeSize,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 3,
                color: AppColors.gold,
                backgroundColor: AppColors.surface,
              ),
            ),
        ],
      ),
    );
  }
}

class LockedStationCard extends StatelessWidget {
  const LockedStationCard({super.key, required this.shopId});

  final String shopId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(14),
      decoration: AppTheme.cardDecoration().copyWith(
        gradient: LinearGradient(colors: [lockedSurface, lockedSurface]),
      ),
      child: Row(
        children: [
          const Icon(
            LucideIcons.lock,
            color: AppColors.textSecondary,
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              AppLocalizations.of(context).lockedStationName,
              key: Key('locked_station_$shopId'),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OpenStationCard extends StatelessWidget {
  const OpenStationCard({
    super.key,
    required this.shop,
    required this.data,
    required this.buyAmount,
    required this.onOpenPanel,
  });

  final ShopConfig shop;
  final ShopStationData data;
  final BuyAmount buyAmount;
  final VoidCallback? onOpenPanel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<GameCubit>();
    final textTheme = Theme.of(context).textTheme;
    final formatter = numberFormatterOf(context, scientific: data.scientific);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onOpenPanel,
      child: Container(
        padding: const EdgeInsetsDirectional.all(12),
        decoration: AppTheme.cardDecoration(
          borderColor: data.status == StationStatus.available
              ? AppColors.gold
              : AppColors.cardBorder,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    shopName(l10n, shop.id),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  l10n.shopLevel(data.level),
                  style: textTheme.labelLarge?.copyWith(color: AppColors.gold),
                ),
              ],
            ),
            if (data.status == StationStatus.open)
              Text(
                l10n.incomePerSecond(formatter.formatMoney(data.income)),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodySmall?.copyWith(color: AppColors.mint),
              ),
            const SizedBox(height: 8),
            BouncyButton(
              key: Key('buy_shop_${shop.id}'),
              compact: true,
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
            if (onOpenPanel != null) ...[
              const SizedBox(height: 6),
              Text(
                l10n.stationUpgradesHint,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: textTheme.labelSmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
