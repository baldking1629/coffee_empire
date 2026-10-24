import 'package:coffee_empire/config/economy_config.dart';
import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:coffee_empire/engine/offline_math.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const math = OfflineMath(
    OfflineConfig(
      minAwaySeconds: 60,
      capSeconds: 4 * 3600,
      vipCapSeconds: 12 * 3600,
      efficiency: 1,
    ),
  );
  final income = BigNumber.fromInt(10);

  test('30 seconds away shows no modal', () {
    final result = math.compute(
      awaySeconds: 30,
      incomePerSec: income,
      vip: false,
    );
    expect(result.showModal, isFalse);
    expect(result.amount, BigNumber.fromInt(300));
  });

  test('5 hours away credits only 4 hours', () {
    final result = math.compute(
      awaySeconds: 5 * 3600,
      incomePerSec: income,
      vip: false,
    );
    expect(result.showModal, isTrue);
    expect(result.creditedSeconds, 4 * 3600);
    expect(result.amount, BigNumber.fromInt(10 * 4 * 3600));
  });

  test('VIP credits up to 12 hours', () {
    final result = math.compute(
      awaySeconds: 20 * 3600,
      incomePerSec: income,
      vip: true,
    );
    expect(result.creditedSeconds, 12 * 3600);
  });

  test('negative away time earns nothing', () {
    final result = math.compute(
      awaySeconds: -3600,
      incomePerSec: income,
      vip: false,
    );
    expect(result, OfflineEarnings.none);
  });
}
