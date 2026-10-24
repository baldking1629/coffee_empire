import 'package:flutter/material.dart';

import '../daily_reward/daily_reward_card.dart';
import 'widgets/iap_section.dart';
import 'widgets/rewarded_ads_section.dart';

class StoreTab extends StatelessWidget {
  const StoreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
      children: const [
        DailyRewardCard(),
        SizedBox(height: 16),
        RewardedAdsSection(),
        SizedBox(height: 16),
        IapSection(),
      ],
    );
  }
}
