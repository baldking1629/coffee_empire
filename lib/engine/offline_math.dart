import 'package:equatable/equatable.dart';

import '../config/economy_config.dart';
import '../core/bignumber/big_number.dart';

class OfflineEarnings extends Equatable {
  const OfflineEarnings({
    required this.awaySeconds,
    required this.creditedSeconds,
    required this.amount,
    required this.showModal,
  });

  static const OfflineEarnings none = OfflineEarnings(
    awaySeconds: 0,
    creditedSeconds: 0,
    amount: BigNumber.zero,
    showModal: false,
  );

  final double awaySeconds;
  final double creditedSeconds;
  final BigNumber amount;
  final bool showModal;

  @override
  List<Object?> get props => [awaySeconds, creditedSeconds, amount, showModal];
}

class OfflineMath {
  const OfflineMath(this.config);

  final OfflineConfig config;

  int capSeconds({required bool vip}) =>
      vip ? config.vipCapSeconds : config.capSeconds;

  OfflineEarnings compute({
    required double awaySeconds,
    required BigNumber incomePerSec,
    required bool vip,
  }) {
    if (awaySeconds <= 0) return OfflineEarnings.none;
    final cap = capSeconds(vip: vip).toDouble();
    final credited = awaySeconds < cap ? awaySeconds : cap;
    final amount =
        incomePerSec * BigNumber.fromDouble(credited * config.efficiency);
    return OfflineEarnings(
      awaySeconds: awaySeconds,
      creditedSeconds: credited,
      amount: amount,
      showModal: awaySeconds >= config.minAwaySeconds,
    );
  }
}
