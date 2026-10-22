import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../app/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../shop_labels.dart';

class ShopUpgrades extends StatelessWidget {
  const ShopUpgrades({
    super.key,
    required this.shopId,
    required this.hasManager,
    required this.managerCost,
    required this.managerAffordable,
    required this.equipmentOwned,
    required this.equipmentTierCount,
    required this.nextEquipmentCost,
    required this.equipmentAffordable,
    required this.onHireManager,
    required this.onBuyEquipment,
  });

  final String shopId;
  final bool hasManager;
  final String managerCost;
  final bool managerAffordable;
  final int equipmentOwned;
  final int equipmentTierCount;
  final String? nextEquipmentCost;
  final bool equipmentAffordable;
  final VoidCallback onHireManager;
  final VoidCallback onBuyEquipment;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final nextCost = nextEquipmentCost;
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: [
        if (hasManager)
          _OwnedChip(icon: LucideIcons.userCheck, label: l10n.managerHired)
        else
          _UpgradeButton(
            key: Key('hire_manager_$shopId'),
            icon: LucideIcons.userPlus,
            label: l10n.hireManager(managerCost),
            onPressed: managerAffordable ? onHireManager : null,
          ),
        if (nextCost == null)
          _OwnedChip(
            icon: LucideIcons.wrench,
            label: l10n.equipmentAllOwned(
              equipmentName(l10n, equipmentTierCount - 1),
            ),
          )
        else
          _UpgradeButton(
            key: Key('buy_equipment_$shopId'),
            icon: LucideIcons.wrench,
            label: l10n.buyEquipment(
              equipmentName(l10n, equipmentOwned),
              nextCost,
            ),
            onPressed: equipmentAffordable ? onBuyEquipment : null,
          ),
        for (var tier = 0; tier < equipmentTierCount; tier++)
          Icon(
            LucideIcons.star,
            size: 14,
            color: tier < equipmentOwned
                ? AppColors.gold
                : AppColors.cardBorder,
          ),
      ],
    );
  }
}

class _UpgradeButton extends StatelessWidget {
  const _UpgradeButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
      style: OutlinedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        foregroundColor: AppColors.gold,
        side: const BorderSide(color: AppColors.cardBorder),
      ),
    );
  }
}

class _OwnedChip extends StatelessWidget {
  const _OwnedChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      visualDensity: VisualDensity.compact,
      avatar: Icon(icon, size: 16, color: AppColors.mint),
      label: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
      backgroundColor: AppColors.surface,
      side: const BorderSide(color: AppColors.cardBorder),
    );
  }
}
