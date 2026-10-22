import 'package:coffee_empire/core/time/clock.dart';

class FakeClock implements Clock {
  FakeClock(this.current);

  DateTime current;

  void advance(Duration duration) => current = current.add(duration);

  @override
  DateTime now() => current;
}
