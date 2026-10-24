import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/widgets/game_background.dart';
import '../achievements/achievement_listener.dart';
import '../game/game_cubit.dart';
import '../growth/growth_tab.dart';
import '../lab/lab_tab.dart';
import '../shops/shops_tab.dart';
import '../store/store_tab.dart';
import '../tutorial/tutorial_overlay.dart';
import 'widgets/barista_tap_area.dart';
import 'widgets/bottom_nav.dart';
import 'widgets/cash_header.dart';
import 'widgets/offline_earnings_listener.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;

  void _selectTab(int index) {
    setState(() => _selectedTab = index);
    context.read<GameCubit>().notifyTabOpened(index);
  }

  @override
  Widget build(BuildContext context) {
    return OfflineEarningsListener(
      child: Scaffold(
        body: AchievementListener(
          child: GameBackground(
            child: SafeArea(
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
                  const TutorialBanner(),
                  Expanded(
                    flex: 5,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: KeyedSubtree(
                        key: ValueKey(_selectedTab),
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNav(
          selectedIndex: _selectedTab,
          onSelected: _selectTab,
        ),
      ),
    );
  }
}
