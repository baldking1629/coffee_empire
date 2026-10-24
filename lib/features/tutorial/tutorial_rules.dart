import '../../config/economy_config.dart';
import '../game/game_state.dart';

abstract final class TutorialSteps {
  static const int tapCup = 0;
  static const int buyFirstShop = 1;
  static const int buySecondShop = 2;
  static const int hireManager = 3;
  static const int openLab = 4;
  static const int finish = 5;
  static const int done = 6;

  static const int labTabIndex = 1;
}

class TutorialRules {
  const TutorialRules(this.shops);

  final List<ShopConfig> shops;

  bool isActive(GameState state) => state.tutorialStep < TutorialSteps.done;

  bool _isMet(GameState state, int step, {int? openedTab}) => switch (step) {
    TutorialSteps.tapCup => state.stats.totalTaps > 0,
    TutorialSteps.buyFirstShop => (state.shopLevels[shops[0].id] ?? 0) >= 1,
    TutorialSteps.buySecondShop => (state.shopLevels[shops[1].id] ?? 0) >= 1,
    TutorialSteps.hireManager => state.managers.values.any((hired) => hired),
    TutorialSteps.openLab => openedTab == TutorialSteps.labTabIndex,
    _ => false,
  };

  int advance(GameState state, {int? openedTab}) {
    var step = state.tutorialStep;
    while (step < TutorialSteps.finish &&
        _isMet(state, step, openedTab: openedTab)) {
      step++;
    }
    return step;
  }
}
