import 'package:equatable/equatable.dart';

import '../config/economy_config.dart';

class BaristaState extends Equatable {
  const BaristaState({
    this.cupFill = 0,
    this.combo = 0,
    this.lastCupFilledAt,
    this.rushEndsAt,
  });

  static const BaristaState idle = BaristaState();

  final double cupFill;
  final int combo;
  final DateTime? lastCupFilledAt;
  final DateTime? rushEndsAt;

  bool isRushActive(DateTime now) {
    final endsAt = rushEndsAt;
    return endsAt != null && now.isBefore(endsAt);
  }

  BaristaState copyWith({
    double? cupFill,
    int? combo,
    DateTime? Function()? lastCupFilledAt,
    DateTime? Function()? rushEndsAt,
  }) => BaristaState(
    cupFill: cupFill ?? this.cupFill,
    combo: combo ?? this.combo,
    lastCupFilledAt: lastCupFilledAt == null
        ? this.lastCupFilledAt
        : lastCupFilledAt(),
    rushEndsAt: rushEndsAt == null ? this.rushEndsAt : rushEndsAt(),
  );

  @override
  List<Object?> get props => [cupFill, combo, lastCupFilledAt, rushEndsAt];
}

class BaristaMath {
  const BaristaMath(this.config);

  final TapConfig config;

  Duration get _comboWindow =>
      Duration(milliseconds: (config.comboWindowSeconds * 1000).round());

  Duration get _rushDuration =>
      Duration(milliseconds: (config.rushDurationSeconds * 1000).round());

  BaristaState settle(BaristaState current, DateTime now) {
    var result = current;
    final lastFill = current.lastCupFilledAt;
    if (lastFill != null) {
      final sinceFill = now.difference(lastFill);
      if (sinceFill.isNegative || sinceFill > _comboWindow) {
        result = result.copyWith(combo: 0, lastCupFilledAt: () => null);
      }
    }
    final rushEndsAt = current.rushEndsAt;
    if (rushEndsAt != null) {
      final remaining = rushEndsAt.difference(now);
      if (remaining <= Duration.zero || remaining > _rushDuration) {
        result = result.copyWith(rushEndsAt: () => null);
      }
    }
    return result;
  }
}
