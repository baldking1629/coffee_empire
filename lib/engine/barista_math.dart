import 'package:equatable/equatable.dart';

import '../config/economy_config.dart';
import '../core/bignumber/big_number.dart';

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

class TapOutcome extends Equatable {
  const TapOutcome({
    required this.barista,
    required this.payout,
    required this.cupFilled,
    required this.rushStarted,
  });

  final BaristaState barista;
  final BigNumber payout;
  final bool cupFilled;
  final bool rushStarted;

  @override
  List<Object?> get props => [barista, payout, cupFilled, rushStarted];
}

class BaristaMath {
  const BaristaMath(this.config);

  final TapConfig config;

  Duration get _comboWindow =>
      Duration(milliseconds: (config.comboWindowSeconds * 1000).round());

  Duration get _rushDuration =>
      Duration(milliseconds: (config.rushDurationSeconds * 1000).round());

  BigNumber cupPayout(BigNumber incomePerSec, {required bool rushActive}) {
    final base = (incomePerSec * BigNumber.fromDouble(config.tapPayoutSeconds))
        .clampMin(config.minTapPayout);
    return rushActive
        ? base * BigNumber.fromDouble(config.rushMultiplier)
        : base;
  }

  TapOutcome tap(BaristaState current, BigNumber incomePerSec, DateTime now) {
    final settled = settle(current, now);
    final rushActive = settled.isRushActive(now);
    final step = rushActive
        ? config.tapFillStep * config.rushMultiplier
        : config.tapFillStep;
    final filled = settled.cupFill + step;
    // Small epsilon absorbs accumulated floating-point error from repeated steps.
    if (filled < 1 - 1e-9) {
      return TapOutcome(
        barista: settled.copyWith(cupFill: filled),
        payout: BigNumber.zero,
        cupFilled: false,
        rushStarted: false,
      );
    }
    final payout = cupPayout(incomePerSec, rushActive: rushActive);
    final combo = settled.lastCupFilledAt == null ? 0 : settled.combo + 1;
    final startsRush = !rushActive && combo >= config.rushComboThreshold;
    return TapOutcome(
      barista: BaristaState(
        combo: startsRush ? 0 : combo,
        lastCupFilledAt: now,
        rushEndsAt: startsRush ? now.add(_rushDuration) : settled.rushEndsAt,
      ),
      payout: payout,
      cupFilled: true,
      rushStarted: startsRush,
    );
  }

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
