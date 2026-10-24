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
  DateTime? _stoppedAt;

  bool get isRunning => _timer != null;

  void start() {
    if (isRunning) return;
    final stoppedAt = _stoppedAt;
    _stoppedAt = null;
    _lastTickAt = stoppedAt ?? _clock.now();
    _timer = Timer.periodic(interval, (_) => handleTimerFired());
    if (stoppedAt != null) handleTimerFired();
  }

  void stop() {
    if (!isRunning) return;
    _timer?.cancel();
    _timer = null;
    _stoppedAt = _clock.now();
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
