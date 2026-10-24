import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../achievements/achievements_screen.dart';
import '../daily_reward/daily_reward_card.dart';
import '../settings/settings_screen.dart';
import 'widgets/iap_section.dart';
import 'widgets/rewarded_ads_section.dart';

class StoreTab extends StatelessWidget {
  const StoreTab({super.key});

  static const Key achievementsKey = Key('open_achievements');
  static const Key settingsKey = Key('open_settings');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    void open(Widget screen) => Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => screen));
    return ListView(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
      children: [
        const DailyRewardCard(),
        const SizedBox(height: 16),
        const RewardedAdsSection(),
        const SizedBox(height: 16),
        const IapSection(),
        const SizedBox(height: 8),
        ListTile(
          key: achievementsKey,
          leading: const Icon(LucideIcons.trophy, color: AppColors.gold),
          title: Text(l10n.achievementsTitle),
          trailing: const _ForwardChevron(),
          onTap: () => open(const AchievementsScreen()),
        ),
        ListTile(
          key: settingsKey,
          leading: const Icon(
            LucideIcons.settings,
            color: AppColors.textSecondary,
          ),
          title: Text(l10n.settingsTitle),
          trailing: const _ForwardChevron(),
          onTap: () => open(const SettingsScreen()),
        ),
      ],
    );
  }
}

class _ForwardChevron extends StatelessWidget {
  const _ForwardChevron();

  @override
  Widget build(BuildContext context) {
    return Transform.flip(
      flipX: Directionality.of(context) == TextDirection.rtl,
      child: const Icon(LucideIcons.chevronRight),
    );
  }
}
