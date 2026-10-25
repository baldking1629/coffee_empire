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
import 'widgets/bottom_nav.dart';
import 'widgets/cafe_view.dart';
import 'widgets/cash_header.dart';
import 'widgets/offline_earnings_listener.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const int cafeTab = 0;
  static const Key panelKey = Key('home_tab_panel');

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = HomeScreen.cafeTab;

  void _selectTab(int index) {
    setState(() => _selectedTab = index);
    context.read<GameCubit>().notifyTabOpened(index);
  }

  @override
  Widget build(BuildContext context) {
    final onCafe = _selectedTab == HomeScreen.cafeTab;
    return OfflineEarningsListener(
      child: Scaffold(
        body: AchievementListener(
          child: GameBackground(
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  const CashHeader(),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: CafeView(
                            active: onCafe,
                            bottomOverlay: onCafe
                                ? const TutorialBanner()
                                : null,
                          ),
                        ),
                        Positioned.fill(
                          child: Offstage(
                            offstage: onCafe,
                            child: GameBackground(
                              key: HomeScreen.panelKey,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  top: 8,
                                ),
                                child: IndexedStack(
                                  index: onCafe ? 0 : _selectedTab - 1,
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
                        ),
                        if (!onCafe)
                          const PositionedDirectional(
                            start: 0,
                            end: 0,
                            bottom: 0,
                            child: TutorialBanner(),
                          ),
                      ],
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
