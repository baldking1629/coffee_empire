enum RewardedAdType {
  caffeineRush('caffeine_rush'),
  offlineDouble('offline_double'),
  emergencyFund('emergency_fund'),
  labSpeedup('lab_speedup');

  const RewardedAdType(this.id);

  final String id;
}

enum PurchaseStatus { success, cancelled, failed }

class PurchaseResult {
  const PurchaseResult(this.productId, this.status);

  final String productId;
  final PurchaseStatus status;

  bool get isSuccess => status == PurchaseStatus.success;
}

abstract class MonetizationService {
  Future<bool> showRewardedAd(RewardedAdType type);

  Future<PurchaseResult> purchase(String productId);

  Future<void> restorePurchases();

  bool isOwned(String productId);
}

class MockMonetizationService implements MonetizationService {
  MockMonetizationService({
    this.adDuration = const Duration(seconds: 2),
    Iterable<String> ownedProducts = const [],
  }) : _owned = {...ownedProducts};

  final Duration adDuration;
  final Set<String> _owned;

  @override
  Future<bool> showRewardedAd(RewardedAdType type) async {
    await Future<void>.delayed(adDuration);
    return true;
  }

  @override
  Future<PurchaseResult> purchase(String productId) async {
    _owned.add(productId);
    return PurchaseResult(productId, PurchaseStatus.success);
  }

  @override
  Future<void> restorePurchases() async {}

  @override
  bool isOwned(String productId) => _owned.contains(productId);
}
