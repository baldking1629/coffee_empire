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

  test('combo expires after the window', () {
    final barista = BaristaState(combo: 3, lastCupFilledAt: start);
    expect(
      math.settle(barista, start.add(const Duration(seconds: 4))).combo,
      3,
    );
    final late = math.settle(barista, start.add(const Duration(seconds: 30)));
    expect(late.combo, 0);
    expect(late.lastCupFilledAt, isNull);
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
    final settled = math.settle(
      barista,
      start.subtract(const Duration(hours: 2)),
    );
    expect(settled.combo, 0);
    expect(settled.rushEndsAt, isNull);
  });
}
