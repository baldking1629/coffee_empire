import 'package:flutter/material.dart';

import 'widgets/franchise_section.dart';
import 'widgets/prestige_card.dart';

class GrowthTab extends StatelessWidget {
  const GrowthTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
      children: const [
        PrestigeCard(),
        SizedBox(height: 16),
        FranchiseSection(),
      ],
    );
  }
}
