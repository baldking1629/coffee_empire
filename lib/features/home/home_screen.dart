import 'package:flutter/material.dart';

import '../growth/growth_tab.dart';
import '../lab/lab_tab.dart';
import '../shops/shops_tab.dart';
import '../store/store_tab.dart';
import 'widgets/barista_tap_area.dart';
import 'widgets/bottom_nav.dart';
import 'widgets/cash_header.dart';
import 'widgets/offline_earnings_listener.dart';

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
    return OfflineEarningsListener(
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const CashHeader(),
              const Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 8),
                  child: BaristaTapArea(),
                ),
              ),
              Expanded(
                flex: 5,
                child: IndexedStack(
                  index: _selectedTab,
                  children: const [
                    ShopsTab(),
                    LabTab(),
                    GrowthTab(),
                    StoreTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNav(
          selectedIndex: _selectedTab,
          onSelected: (index) => setState(() => _selectedTab = index),
        ),
      ),
    );
  }
}
