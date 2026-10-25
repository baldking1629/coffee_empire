import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/formatters.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_theme.dart';
import '../../app/widgets/bouncy_button.dart';
import '../../cafe/edit/edit_mode_controller.dart';
import '../../config/cafe_config.dart';
import '../../l10n/app_localizations.dart';
import '../../pixel/pixel_image.dart';
import '../../pixel/sprite_atlas.dart';
import '../game/game_cubit.dart';
import '../game/game_state.dart';
import '../shops/shop_labels.dart';
import 'furniture_labels.dart';

Future<void> showFurnitureCatalog(
  BuildContext context,
  EditModeController editor,
) => showModalBottomSheet<void>(
  context: context,
  backgroundColor: AppColors.surface,
  isScrollControlled: true,
  showDragHandle: true,
  builder: (_) => FractionallySizedBox(
    heightFactor: 0.8,
    child: FurnitureCatalogSheet(editor: editor),
  ),
);

class FurnitureCatalogSheet extends StatelessWidget {
  const FurnitureCatalogSheet({super.key, required this.editor});

  static Key buyKey(String id) => Key('buy_furniture_$id');
  static Key placeKey(String id) => Key('place_furniture_$id');

  final EditModeController editor;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<GameCubit>();
    final furniture = cubit.engine.config.cafe.furniture.values.toList();
    return BlocBuilder<GameCubit, GameState>(
      buildWhen: (previous, current) =>
          previous.cash != current.cash ||
          previous.inventory != current.inventory ||
          previous.cafeLayout != current.cafeLayout ||
          previous.shopLevels != current.shopLevels,
      builder: (context, state) => ListView(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 24),
        children: [
          Text(
            l10n.furnitureCatalog,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 4),
          Text(
            l10n.cafeAppealSummary(
              cubit.appeal,
              cubit.appealMultiplier.toStringAsFixed(2),
            ),
            style: const TextStyle(color: AppColors.gold),
          ),
          for (final category in FurnitureCategory.values) ...[
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 16, bottom: 8),
              child: Text(
                furnitureCategoryName(l10n, category),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            for (final item in furniture)
              if (item.category == category)
                Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: 8),
                  child: _FurnitureRow(item: item, editor: editor),
                ),
          ],
        ],
      ),
    );
  }
}

class _FurnitureRow extends StatelessWidget {
  const _FurnitureRow({required this.item, required this.editor});

  final FurnitureConfig item;
  final EditModeController editor;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<GameCubit>();
    final atlas = context.read<SpriteAtlas>();
    final state = cubit.state;
    final unlocked = cubit.isFurnitureUnlocked(item);
    final owned = state.inventory[item.id] ?? 0;
    final cost = cubit.layoutRules.costOf(item);
    final formatter = numberFormatterOf(
      context,
      scientific: state.settings.scientific,
    );
    final shops = cubit.engine.config.shops;
    final unlockShop = shops[item.unlockShopIndex.clamp(0, shops.length - 1)];
    return Container(
      padding: const EdgeInsetsDirectional.all(10),
      decoration: AppTheme.cardDecoration(),
      child: Row(
        children: [
          SizedBox.square(
            dimension: 48,
            child: FittedBox(
              child: PixelImage(
                image: atlas.get(item.spriteId, paletteKey: item.paletteKey),
                scale: 2,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  furnitureName(l10n, item.id),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  unlocked
                      ? l10n.furnitureAppeal(item.appeal)
                      : l10n.furnitureLocked(shopName(l10n, unlockShop.id)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: unlocked ? AppColors.gold : AppColors.textSecondary,
                  ),
                ),
                if (owned > 0)
                  Text(
                    l10n.furnitureOwned(owned),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: AppColors.mint),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (!unlocked)
            const Icon(LucideIcons.lock, color: AppColors.textSecondary)
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BouncyButton(
                  key: FurnitureCatalogSheet.buyKey(item.id),
                  compact: true,
                  canAfford: state.cash >= cost,
                  onPressed: () => cubit.buyFurniture(item.id),
                  onDenied: cubit.reportInsufficientFunds,
                  child: Text(
                    formatter.formatMoney(cost),
                    maxLines: 1,
                    textDirection: TextDirection.ltr,
                  ),
                ),
                if (owned > 0) ...[
                  const SizedBox(height: 6),
                  BouncyButton(
                    key: FurnitureCatalogSheet.placeKey(item.id),
                    compact: true,
                    style: BouncyButtonStyle.secondary,
                    onPressed: () {
                      Navigator.of(context).pop();
                      editor.startPlacing(item.id);
                    },
                    child: Text(l10n.editPlace, maxLines: 1),
                  ),
                ],
              ],
            ),
        ],
      ),
    );
  }
}
