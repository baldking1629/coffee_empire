import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:coffee_empire/engine/boost_math.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_economy.dart';

void main() {
  final config = loadTestEconomy();
  final math = BoostMath(rewarded: config.rewarded, iap: config.iap);
  final now = DateTime.utc(2026, 1, 1, 12);

  test('caffeine rush doubles income only while active', () {
    final boost = ActiveBoost(
      type: ActiveBoost.caffeineRush,
      endsAt: now.add(const Duration(minutes: 1)),
    );
    expect(math.boostMultiplier([boost], now), 2);
    expect(
      math.boostMultiplier([boost], now.add(const Duration(minutes: 2))),
      1,
    );
    expect(math.boostMultiplier(const [], now), 1);
  });

  test('watching again adds 4 hours up to 8 hours total', () {
    final first = math.extendCaffeineRush(null, now);
    expect(first, now.add(const Duration(hours: 4)));
    final second = math.extendCaffeineRush(
      first,
      now.add(const Duration(hours: 1)),
    );
    expect(second, now.add(const Duration(hours: 8)));
    final third = math.extendCaffeineRush(
      second,
      now.add(const Duration(hours: 1)),
    );
    expect(third, now.add(const Duration(hours: 9)));
  });

  test('cooldown blocks until it ends', () {
    final end = math.cooldownEnd(now);
    expect(math.isOnCooldown(end, now), isTrue);
    expect(math.isOnCooldown(end, end), isFalse);
    expect(math.isOnCooldown(null, now), isFalse);
  });

  test('emergency fund is ten minutes of income with a minimum', () {
    expect(
      math.emergencyFund(BigNumber.zero),
      config.rewarded.emergencyFundMin,
    );
    expect(math.emergencyFund(BigNumber.fromInt(10)), BigNumber.fromInt(6000));
  });

  test('VIP and starter pack multipliers', () {
    expect(math.vipMultiplier(vip: true), 2);
    expect(math.vipMultiplier(vip: false), 1);
    expect(math.starterPackMultiplier(owned: true), 1.25);
  });

  test('boost json round-trip', () {
    final boost = ActiveBoost(type: ActiveBoost.caffeineRush, endsAt: now);
    expect(ActiveBoost.fromJson(boost.toJson()), boost);
  });
}
