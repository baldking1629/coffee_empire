import 'package:flutter/foundation.dart';

abstract final class AnalyticsEvents {
  static const String tutorialStep = 'tutorial_step';
  static const String tutorialComplete = 'tutorial_complete';
  static const String shopUnlocked = 'shop_unlocked';
  static const String managerHired = 'manager_hired';
  static const String recipeBrewed = 'recipe_brewed';
  static const String capsuleUnlocked = 'capsule_unlocked';
  static const String franchiseOpened = 'franchise_opened';
  static const String prestige = 'prestige';
  static const String rewardedShown = 'rewarded_shown';
  static const String rewardedCompleted = 'rewarded_completed';
  static const String iapPurchase = 'iap_purchase';
  static const String offlineModal = 'offline_modal';
  static const String dailyRewardClaimed = 'daily_reward_claimed';
  static const String saveCorrupt = 'save_corrupt';
  static const String sessionStart = 'session_start';
}

abstract class AnalyticsService {
  void logEvent(String name, [Map<String, Object> parameters = const {}]);
}

class DebugAnalyticsService implements AnalyticsService {
  const DebugAnalyticsService();

  @override
  void logEvent(String name, [Map<String, Object> parameters = const {}]) {
    debugPrint('[analytics] $name $parameters');
  }
}
