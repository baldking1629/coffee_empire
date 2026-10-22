import 'package:coffee_empire/config/economy_config.dart';
import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:coffee_empire/engine/barista_math.dart';
import 'package:flutter_test/flutter_test.dart';

const tapConfig = TapConfig(
  tapFillStep: 0.1,
  tapPayoutSeconds: 10,
  minTapPayout: BigNumber.one,
  comboWindowSeconds: 5,
  rushComboThreshold: 5,
  rushDurationSeconds: 15,
  rushMultiplier: 2,
  autoTapPerSecond: 1,
);

void main() {
  const math = BaristaMath(tapConfig);
  final start = DateTime.utc(2026, 1, 1);

  ({BaristaState barista, List<TapOutcome> fills}) fillCups(
    BaristaState initial,
    int cups,
    DateTime Function(int cup) timeOfCup, {
    BigNumber? income,
  }) {
    var barista = initial;
    final fills = <TapOutcome>[];
    for (var cup = 0; cup < cups; cup++) {
      while (true) {
        final outcome = math.tap(
          barista,
          income ?? BigNumber.zero,
          timeOfCup(cup),
        );
        barista = outcome.barista;
        if (outcome.cupFilled) {
          fills.add(outcome);
          break;
        }
      }
    }
    return (barista: barista, fills: fills);
  }

  test('ten taps fill the cup and pay at least the minimum', () {
    var barista = BaristaState.idle;
    for (var i = 0; i < 9; i++) {
      final outcome = math.tap(barista, BigNumber.zero, start);
      expect(outcome.cupFilled, isFalse);
      expect(outcome.payout, BigNumber.zero);
      barista = outcome.barista;
    }
    expect(barista.cupFill, closeTo(0.9, 1e-9));
    final outcome = math.tap(barista, BigNumber.zero, start);
    expect(outcome.cupFilled, isTrue);
    expect(outcome.payout, BigNumber.one);
    expect(outcome.barista.cupFill, 0);
  });

  test('payout equals ten seconds of income', () {
    final payout = math.cupPayout(BigNumber.fromInt(50), rushActive: false);
    expect(payout, BigNumber.fromInt(500));
  });

  test('combo grows within the window and resets after it', () {
    final quick = fillCups(
      BaristaState.idle,
      4,
      (cup) => start.add(Duration(seconds: cup * 4)),
    );
    expect(quick.barista.combo, 3);
    final late = math.settle(
      quick.barista,
      start.add(const Duration(seconds: 30)),
    );
    expect(late.combo, 0);
    expect(late.lastCupFilledAt, isNull);
  });

  test('combo 5 starts Barista Rush which doubles step and payout', () {
    final result = fillCups(
      BaristaState.idle,
      6,
      (cup) => start.add(Duration(seconds: cup * 2)),
    );
    expect(result.fills.last.rushStarted, isTrue);
    final rushAt = start.add(const Duration(seconds: 10));
    expect(result.barista.rushEndsAt, rushAt.add(const Duration(seconds: 15)));
    expect(result.barista.combo, 0);

    final duringRush = rushAt.add(const Duration(seconds: 1));
    final step = math.tap(result.barista, BigNumber.zero, duringRush);
    expect(step.barista.cupFill, closeTo(0.2, 1e-9));
    expect(
      math.cupPayout(BigNumber.fromInt(50), rushActive: true),
      BigNumber.fromInt(1000),
    );
  });

  test('rush expires after its duration', () {
    final rushing = BaristaState(
      rushEndsAt: start.add(const Duration(seconds: 15)),
    );
    expect(rushing.isRushActive(start), isTrue);
    final settled = math.settle(
      rushing,
      start.add(const Duration(seconds: 16)),
    );
    expect(settled.rushEndsAt, isNull);
  });

  test('clock moved backwards resets combo and caps rush safely', () {
    final barista = BaristaState(
      combo: 3,
      lastCupFilledAt: start,
      rushEndsAt: start.add(const Duration(seconds: 10)),
    );
    final past = start.subtract(const Duration(hours: 2));
    final settled = math.settle(barista, past);
    expect(settled.combo, 0);
    expect(settled.rushEndsAt, isNull);
    final outcome = math.tap(settled, BigNumber.zero, past);
    expect(outcome.payout.isNegative, isFalse);
  });
}
