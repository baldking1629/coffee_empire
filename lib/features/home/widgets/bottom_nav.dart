import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../l10n/app_localizations.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onSelected,
      destinations: [
        NavigationDestination(
          icon: const Icon(LucideIcons.coffee),
          label: l10n.tabCafe,
        ),
        NavigationDestination(
          icon: const Icon(LucideIcons.store),
          label: l10n.tabShops,
        ),
        NavigationDestination(
          icon: const Icon(LucideIcons.flaskConical),
          label: l10n.tabLab,
        ),
        NavigationDestination(
          icon: const Icon(LucideIcons.trendingUp),
          label: l10n.tabGrowth,
        ),
        NavigationDestination(
          icon: const Icon(LucideIcons.shoppingBag),
          label: l10n.tabStore,
        ),
      ],
    );
  }
}
