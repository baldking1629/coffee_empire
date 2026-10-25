import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_theme.dart';
import '../../app/widgets/bouncy_button.dart';
import '../../config/economy_config.dart';
import '../../l10n/app_localizations.dart';
import '../../pixel/palette_set.dart';
import '../../pixel/pixel_image.dart';
import '../../pixel/sprite_atlas.dart';
import '../achievements/achievement_labels.dart';
import '../game/game_cubit.dart';
import '../shops/shop_labels.dart';
import 'cosmetic_labels.dart';

class CosmeticTile extends StatelessWidget {
  const CosmeticTile({
    super.key,
    required this.cosmetic,
    required this.equipped,
    required this.onEquip,
  });

  static Key tileKey(String id) => Key('cosmetic_$id');
  static Key unlockKey(String id) => Key('unlock_cosmetic_$id');

  final CosmeticConfig cosmetic;
  final bool equipped;
  final VoidCallback onEquip;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<GameCubit>();
    final unlocked = cubit.isCosmeticUnlocked(cosmetic);
    return GestureDetector(
      key: tileKey(cosmetic.id),
      behavior: HitTestBehavior.opaque,
      onTap: unlocked ? onEquip : null,
      child: Container(
        padding: const EdgeInsetsDirectional.all(8),
        decoration: AppTheme.cardDecoration(
          borderColor: equipped ? AppColors.gold : AppColors.cardBorder,
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                    opacity: unlocked ? 1 : 0.4,
                    child: CosmeticPreview(cosmetic: cosmetic),
                  ),
                  if (equipped)
                    const PositionedDirectional(
                      top: 0,
                      end: 0,
                      child: Icon(LucideIcons.check, color: AppColors.gold),
                    ),
                  if (!unlocked)
                    const Icon(LucideIcons.lock, color: AppColors.textPrimary),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              cosmeticName(l10n, cosmetic.id),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (!unlocked) _lockLabel(context, l10n, cubit),
          ],
        ),
      ),
    );
  }

  Widget _lockLabel(
    BuildContext context,
    AppLocalizations l10n,
    GameCubit cubit,
  ) {
    final unlock = cosmetic.unlock;
    if (unlock.kind == CosmeticUnlockKind.goldenBeans) {
      return Padding(
        padding: const EdgeInsetsDirectional.only(top: 4),
        child: BouncyButton(
          key: unlockKey(cosmetic.id),
          compact: true,
          canAfford: cubit.state.goldenBeans >= unlock.amount,
          onPressed: () => cubit.unlockCosmetic(cosmetic.id),
          onDenied: cubit.reportInsufficientFunds,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(l10n.cosmeticUnlockBeans(unlock.amount), maxLines: 1),
          ),
        ),
      );
    }
    final shops = cubit.engine.config.shops;
    final text = switch (unlock.kind) {
      CosmeticUnlockKind.shopIndex => l10n.cosmeticLockShop(
        shopName(l10n, shops[unlock.amount.clamp(0, shops.length - 1)].id),
      ),
      CosmeticUnlockKind.achievement => l10n.cosmeticLockAchievement(
        achievementName(l10n, unlock.achievementId ?? ''),
      ),
      _ => l10n.cosmeticLockVip,
    };
    return Text(
      text,
      maxLines: 2,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(color: AppColors.textSecondary, fontSize: 11),
    );
  }
}

class CosmeticPreview extends StatelessWidget {
  const CosmeticPreview({super.key, required this.cosmetic});

  final CosmeticConfig cosmetic;

  @override
  Widget build(BuildContext context) {
    final atlas = context.read<SpriteAtlas>();
    final key = PaletteCatalog.keyOf([cosmetic.paletteSetId]);
    final (spriteId, animation) = switch (cosmetic.type) {
      CosmeticType.floor || CosmeticType.light => ('floor_tile', null),
      CosmeticType.wall => ('wall_tile', null),
      CosmeticType.sign => (cosmetic.spriteId ?? 'sign', null),
      CosmeticType.outfit => ('barista', 'idle_down'),
    };
    final image = atlas.get(spriteId, animation: animation, paletteKey: key);
    final tint = atlas.palettes.resolve(key)['light_tint'];
    return FittedBox(
      child: Stack(
        children: [
          PixelImage(image: image, scale: 3),
          if (cosmetic.type == CosmeticType.light && tint != null)
            Positioned.fill(
              child: ColoredBox(
                color: tint.withValues(alpha: cosmetic.intensity * 3),
              ),
            ),
        ],
      ),
    );
  }
}
