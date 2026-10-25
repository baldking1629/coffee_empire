import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:coffee_empire/engine/barista_math.dart';
import 'package:coffee_empire/engine/service_math.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_economy.dart';

void main() {
  final config = loadTestEconomy();
  final math = ServiceMath(service: config.service, tap: config.tap);
  final start = DateTime.utc(2026, 1, 1);

  test(
    'payout is ten seconds of income times drink multiplier, at least \$1',
    () {
      final zero = math.playerPayout(
        incomePerSec: BigNumber.zero,
        drinkMult: 1,
        patienceRatio: 0.1,
        rushActive: false,
      );
      expect(zero.amount, BigNumber.one);
      final latte = math.playerPayout(
        incomePerSec: BigNumber.fromInt(100),
        drinkMult: 1.3,
        patienceRatio: 0.5,
        rushActive: false,
      );
      expect(latte.amount.toDouble(), closeTo(100 * 10 * 1.3, 1e-9));
      expect(latte.perfect, isFalse);
    },
  );

  test('perfect service adds the tip and Rush doubles it', () {
    final perfect = math.playerPayout(
      incomePerSec: BigNumber.fromInt(100),
      drinkMult: 1,
      patienceRatio: 0.7,
      rushActive: false,
    );
    expect(perfect.perfect, isTrue);
    expect(perfect.amount.toDouble(), closeTo(1000 * 1.5, 1e-9));
    final rush = math.playerPayout(
      incomePerSec: BigNumber.fromInt(100),
      drinkMult: 1,
      patienceRatio: 0.9,
      rushActive: true,
    );
    expect(rush.amount.toDouble(), closeTo(1000 * 1.5 * 2, 1e-9));
  });

  test('auto serve pays the efficiency share, more for VIP', () {
    final npc = math.autoServePayout(
      incomePerSec: BigNumber.fromInt(100),
      drinkMult: 1,
      vip: false,
    );
    final vip = math.autoServePayout(
      incomePerSec: BigNumber.fromInt(100),
      drinkMult: 1,
      vip: true,
    );
    expect(npc.toDouble(), closeTo(500, 1e-9));
    expect(vip.toDouble(), closeTo(750, 1e-9));
    expect(math.autoServeSeconds(1), closeTo(8, 1e-9));
    expect(math.autoServeSeconds(3), closeTo(8 / 1.2, 1e-9));
    expect(math.visibleBaristas(7), 3);
  });

  test('combo grows inside the window, resets outside, 5 starts Rush', () {
    var barista = BaristaState.idle;
    var rushStarted = false;
    for (var i = 0; i <= 5; i++) {
      final outcome = math.registerDelivery(
        barista,
        start.add(Duration(seconds: i * 3)),
      );
      barista = outcome.barista;
      rushStarted = outcome.rushStarted;
    }
    expect(rushStarted, isTrue);
    expect(
      barista.isRushActive(start.add(const Duration(seconds: 16))),
      isTrue,
    );
    final late = math.registerDelivery(
      barista,
      start.add(const Duration(minutes: 2)),
    );
    expect(late.barista.combo, 0);
    expect(
      math
          .breakCombo(const BaristaState(combo: 3, lastCupFilledAt: null))
          .combo,
      0,
    );
  });

  test('brew step doubles during Rush and arrival speeds up with appeal', () {
    expect(math.brewStep(rushActive: false), closeTo(0.1, 1e-12));
    expect(math.brewStep(rushActive: true), closeTo(0.2, 1e-12));
    expect(math.arrivalSeconds(0), 6);
    expect(math.arrivalSeconds(1000), config.service.minArrivalSeconds);
  });
}
