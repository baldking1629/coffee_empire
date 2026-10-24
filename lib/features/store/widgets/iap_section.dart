import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../app/formatters.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/services/monetization_service.dart';
import '../../../l10n/app_localizations.dart';
import '../../game/game_cubit.dart';
import '../../game/game_state.dart';
import '../store_state.dart';

class IapSection extends StatelessWidget {
  const IapSection({super.key});

  static const List<String> productOrder = [
    ProductIds.vip,
    ProductIds.starterPack,
    ProductIds.timeSkip,
  ];

  Future<void> _restore(BuildContext context) async {
    final service = context.read<MonetizationService>();
    final cubit = context.read<GameCubit>();
    await service.restorePurchases();
    await cubit.restorePurchases(productOrder.where(service.isOwned));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.shopTitle,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        for (final productId in productOrder) ...[
          const SizedBox(height: 8),
          _ProductTile(productId: productId),
        ],
        const SizedBox(height: 8),
        TextButton.icon(
          key: const Key('restore_purchases'),
          onPressed: () => _restore(context),
          icon: const Icon(LucideIcons.rotateCcw, size: 16),
          label: Text(l10n.restorePurchases),
        ),
        Text(
          l10n.noForcedAds,
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class _ProductTile extends StatelessWidget {
  const _ProductTile({required this.productId});

  final String productId;

  Future<void> _buy(BuildContext context) async {
    final service = context.read<MonetizationService>();
    final cubit = context.read<GameCubit>();
    final result = await service.purchase(productId);
    if (result.isSuccess) await cubit.applyPurchase(productId);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameCubit>();
    final l10n = AppLocalizations.of(context);
    return BlocSelector<GameCubit, GameState, (bool, String)>(
      selector: (state) => (
        cubit.store.canPurchase(state, productId),
        numberFormatterOf(
          context,
          scientific: state.settings.scientific,
        ).formatMoney(cubit.store.timeSkipValue(state)),
      ),
      builder: (context, data) {
        final (canBuy, timeSkipValue) = data;
        final (icon, title, body) = switch (productId) {
          ProductIds.vip => (LucideIcons.crown, l10n.vipTitle, l10n.vipBody),
          ProductIds.starterPack => (
            LucideIcons.gift,
            l10n.starterPackTitle,
            l10n.starterPackBody,
          ),
          _ => (
            LucideIcons.fastForward,
            l10n.timeSkipTitle,
            l10n.timeSkipBody(timeSkipValue),
          ),
        };
        final highlight = productId == ProductIds.vip;
        return Container(
          padding: const EdgeInsetsDirectional.all(12),
          decoration: AppTheme.cardDecoration(
            borderColor: highlight ? AppColors.gold : AppColors.cardBorder,
          ),
          child: Row(
            children: [
              Icon(icon, color: AppColors.gold),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      body,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: FilledButton(
                  key: Key('buy_product_$productId'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    foregroundColor: AppColors.background,
                    visualDensity: VisualDensity.compact,
                  ),
                  onPressed: canBuy ? () => _buy(context) : null,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(canBuy ? l10n.buyProduct : l10n.owned),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
