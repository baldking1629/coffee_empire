import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';
import 'widgets/barista_tap_area.dart';
import 'widgets/bottom_nav.dart';
import 'widgets/cash_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const int tabCount = 4;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const CashHeader(),
            const Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsetsDirectional.symmetric(vertical: 8),
                child: BaristaTapArea(),
              ),
            ),
            Expanded(
              flex: 4,
              child: IndexedStack(
                index: _selectedTab,
                children: List.generate(
                  HomeScreen.tabCount,
                  (_) => const _ComingSoonTab(),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(
        selectedIndex: _selectedTab,
        onSelected: (index) => setState(() => _selectedTab = index),
      ),
    );
  }
}

class _ComingSoonTab extends StatelessWidget {
  const _ComingSoonTab();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppLocalizations.of(context).comingSoon,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(color: AppColors.textSecondary),
      ),
    );
  }
}
