import 'package:equatable/equatable.dart';

import '../../engine/boost_math.dart';

abstract final class ProductIds {
  static const String vip = 'master_roaster_vip';
  static const String timeSkip = 'time_skip_24h';
  static const String starterPack = 'starter_pack_espresso';

  static const Set<String> consumables = {timeSkip};
}

class StoreState extends Equatable {
  const StoreState({
    this.boosts = const [],
    this.purchases = const {},
    this.rewardedCooldowns = const {},
  });

  final List<ActiveBoost> boosts;
  final Set<String> purchases;
  final Map<String, DateTime> rewardedCooldowns;

  bool get isVip => purchases.contains(ProductIds.vip);

  bool get hasStarterPack => purchases.contains(ProductIds.starterPack);

  ActiveBoost? boostOf(String type) {
    for (final boost in boosts) {
      if (boost.type == type) return boost;
    }
    return null;
  }

  StoreState withBoost(ActiveBoost boost) => copyWith(
    boosts: [
      for (final existing in boosts)
        if (existing.type != boost.type) existing,
      boost,
    ],
  );

  StoreState withoutExpiredBoosts(DateTime now) => copyWith(
    boosts: [
      for (final b in boosts)
        if (b.isActive(now)) b,
    ],
  );

  StoreState copyWith({
    List<ActiveBoost>? boosts,
    Set<String>? purchases,
    Map<String, DateTime>? rewardedCooldowns,
  }) => StoreState(
    boosts: boosts ?? this.boosts,
    purchases: purchases ?? this.purchases,
    rewardedCooldowns: rewardedCooldowns ?? this.rewardedCooldowns,
  );

  @override
  List<Object?> get props => [boosts, purchases, rewardedCooldowns];
}
