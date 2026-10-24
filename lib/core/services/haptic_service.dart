import 'package:flutter/services.dart';

abstract class HapticService {
  Future<void> selection();

  Future<void> light();

  Future<void> medium();

  Future<void> heavy();
}

class PlatformHapticService implements HapticService {
  const PlatformHapticService();

  @override
  Future<void> selection() => HapticFeedback.selectionClick();

  @override
  Future<void> light() => HapticFeedback.lightImpact();

  @override
  Future<void> medium() => HapticFeedback.mediumImpact();

  @override
  Future<void> heavy() => HapticFeedback.heavyImpact();
}

class SilentHapticService implements HapticService {
  const SilentHapticService();

  @override
  Future<void> selection() async {}

  @override
  Future<void> light() async {}

  @override
  Future<void> medium() async {}

  @override
  Future<void> heavy() async {}
}
