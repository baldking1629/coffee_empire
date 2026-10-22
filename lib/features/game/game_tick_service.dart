import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../core/time/clock.dart';

class GameTickService {
  GameTickService({
    required Clock clock,
    required this.onTick,
    required this.onBackgroundGap,
    required this.backgroundGapSeconds,
    this.interval = const Duration(seconds: 1),
  }) : _clock = clock;

  final Clock _clock;
  final void Function(double deltaSeconds) onTick;
  final void Function(double gapSeconds) onBackgroundGap;
  final int backgroundGapSeconds;
  final Duration interval;

  Timer? _timer;
  DateTime? _lastTickAt;

  bool get isRunning => _timer != null;

  void start() {
    if (isRunning) return;
    _lastTickAt = _clock.now();
    _timer = Timer.periodic(interval, (_) => handleTimerFired());
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    _lastTickAt = null;
  }

  @visibleForTesting
  void handleTimerFired() {
    final now = _clock.now();
    final last = _lastTickAt ?? now;
    _lastTickAt = now;
    final elapsedSeconds =
        now.difference(last).inMicroseconds / Duration.microsecondsPerSecond;
    final delta = elapsedSeconds < 0 ? 0.0 : elapsedSeconds;
    if (delta > backgroundGapSeconds) {
      onBackgroundGap(delta);
    } else {
      onTick(delta);
    }
  }
}
