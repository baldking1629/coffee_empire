import 'package:coffee_empire/features/game/game_tick_service.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_clock.dart';

void main() {
  late FakeClock clock;
  late List<double> ticks;
  late List<double> gaps;
  late GameTickService service;

  setUp(() {
    clock = FakeClock(DateTime.utc(2026, 1, 1));
    ticks = [];
    gaps = [];
    service = GameTickService(
      clock: clock,
      onTick: ticks.add,
      onBackgroundGap: gaps.add,
      backgroundGapSeconds: 10,
    )..start();
  });

  tearDown(() => service.stop());

  test('delta is measured from the clock, not the timer', () {
    clock.advance(const Duration(milliseconds: 1500));
    service.handleTimerFired();
    clock.advance(const Duration(seconds: 1));
    service.handleTimerFired();
    expect(ticks, [1.5, 1.0]);
    expect(gaps, isEmpty);
  });

  test('clock moved backwards yields zero delta', () {
    clock.advance(const Duration(seconds: -3600));
    service.handleTimerFired();
    expect(ticks, [0]);
  });

  test('gap above threshold is routed to background handler', () {
    clock.advance(const Duration(seconds: 45));
    service.handleTimerFired();
    expect(ticks, isEmpty);
    expect(gaps, [45]);
  });

  test('resuming after a pause reports the paused time as a gap', () {
    service.stop();
    expect(service.isRunning, isFalse);
    clock.advance(const Duration(minutes: 30));
    service.start();
    expect(gaps, [1800]);
    clock.advance(const Duration(seconds: 1));
    service.handleTimerFired();
    expect(ticks, [1]);
  });

  test('short pause is credited as a normal tick', () {
    service.stop();
    clock.advance(const Duration(seconds: 4));
    service.start();
    expect(ticks, [4]);
    expect(gaps, isEmpty);
  });
}
