part of 'game_cubit.dart';

mixin _ProgressCommands on _GameCubitCore {
  Future<bool> buyShopLevels(String shopId, BuyAmount amount) {
    final firstPurchase = (state.shopLevels[shopId] ?? 0) == 0;
    return _commit(
      shops.buyLevels(state, shopId, amount),
      feedback: FeedbackKind.purchase,
      onSuccess: () {
        if (firstPurchase) _log(AnalyticsEvents.shopUnlocked, {'id': shopId});
      },
    );
  }

  Future<bool> hireManager(String shopId) => _commit(
    shops.hireManager(state, shopId),
    feedback: FeedbackKind.purchase,
    onSuccess: () => _log(AnalyticsEvents.managerHired, {'id': shopId}),
  );

  Future<bool> buyEquipment(String shopId) => _commit(
    shops.buyEquipment(state, shopId),
    feedback: FeedbackKind.purchase,
  );

  Future<bool> unlockRecipe(String recipeId) => _commit(
    lab.unlockRecipe(state, recipeId),
    feedback: FeedbackKind.purchase,
  );

  Future<bool> startBrew(String recipeId, FlavorProfile sliders) =>
      _commit(lab.startBrew(state, recipeId, sliders, clock.now()));

  Future<bool> finishBrewNow() async {
    final expired = lab.expireBrewNow(state, clock.now());
    if (expired == null) return false;
    emit(expired);
    return _completeDueBrew();
  }

  Future<bool> buyCapsuleMachines(BuyAmount amount) {
    final firstMachine = state.lab.capsuleMachines == 0;
    return _commit(
      lab.buyCapsuleMachines(state, amount),
      feedback: FeedbackKind.purchase,
      onSuccess: () {
        if (firstMachine) _log(AnalyticsEvents.capsuleUnlocked);
      },
    );
  }

  Future<bool> openFranchise(String cityId) {
    final slotIndex = franchise.ownedIn(state, cityId);
    return _commit(
      franchise.openFranchise(state, cityId),
      feedback: FeedbackKind.purchase,
      onSuccess: () => _log(AnalyticsEvents.franchiseOpened, {
        'cityId': cityId,
        'slotIndex': slotIndex,
      }),
    );
  }

  Future<bool> prestige() {
    final gain = prestigeRules.previewGain(state);
    return _commit(
      prestigeRules.prestige(state),
      feedback: FeedbackKind.prestige,
      onSuccess: () => _log(AnalyticsEvents.prestige, {
        'count': state.prestigeCount,
        'gain': gain,
      }),
    );
  }
}

mixin _StoreCommands on _GameCubitCore {
  Future<void> claimOfflineEarnings({required bool doubled}) async {
    final pending = state.pendingOffline;
    if (pending == null) return;
    _log(AnalyticsEvents.offlineModal, {
      'minutes': (pending.awaySeconds / Duration.secondsPerMinute).round(),
    });
    await _commit(_offline.claim(state, doubled: doubled));
  }

  Future<bool> applyRewardedAd(RewardedAdType type) async {
    final applied = await _commit(
      store.applyRewarded(state, type, clock.now()),
      onSuccess: () =>
          _log(AnalyticsEvents.rewardedCompleted, {'type': type.id}),
    );
    if (applied && type == RewardedAdType.labSpeedup) await _completeDueBrew();
    return applied;
  }

  Future<bool> applyPurchase(String productId) => _commit(
    store.applyPurchase(state, productId),
    feedback: FeedbackKind.purchase,
    onSuccess: () => _log(AnalyticsEvents.iapPurchase, {'id': productId}),
  );

  Future<void> restorePurchases(Iterable<String> ownedProducts) async {
    await _commit(store.restore(state, ownedProducts));
  }

  Future<bool> claimDailyReward() async {
    final claim = dailyRewards.claim(state, clock.now());
    if (claim == null) return false;
    return _commit(
      claim.state,
      feedback: FeedbackKind.purchase,
      onSuccess: () =>
          _log(AnalyticsEvents.dailyRewardClaimed, {'day': claim.dayIndex + 1}),
    );
  }
}

mixin _MetaCommands on _GameCubitCore {
  void notifyTabOpened(int tabIndex) {
    if (!tutorial.isActive(state)) return;
    final next = _evaluateProgress(state, openedTab: tabIndex);
    if (next != state) emit(next);
  }

  Future<void> completeTutorial() async {
    if (!tutorial.isActive(state)) return;
    _log(AnalyticsEvents.tutorialComplete);
    await _commit(state.copyWith(tutorialStep: TutorialSteps.done));
  }

  Future<void> updateSettings(GameSettings settings) =>
      _commit(state.copyWith(settings: settings));

  Future<void> resetProgress() async {
    await _repository.clear();
    emit(
      _withIncome(
        GameState.initial(
          startingCash: engine.config.startingCash,
        ).copyWith(settings: state.settings),
      ),
    );
    await save();
  }
}
