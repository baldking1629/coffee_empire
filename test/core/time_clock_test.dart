import 'package:coffee_empire/core/time/clock.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_clock.dart';

void main() {
  test('SystemClock returns UTC time', () {
    expect(const SystemClock().now().isUtc, isTrue);
  });

  test('FakeClock advances deterministically', () {
    final clock = FakeClock(DateTime.utc(2026, 1, 1));
    clock.advance(const Duration(seconds: 90));
    expect(clock.now(), DateTime.utc(2026, 1, 1, 0, 1, 30));
  });
}
