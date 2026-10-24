import '../config/economy_config.dart';
import '../core/bignumber/big_number.dart';

class PrestigeMath {
  const PrestigeMath(this.config);

  final PrestigeConfig config;

  bool canPrestige(BigNumber runEarnings) => runEarnings >= config.threshold;

  int goldenBeansFor(BigNumber runEarnings) {
    if (!canPrestige(runEarnings)) return 0;
    final ratio = (runEarnings / config.threshold).sqrt();
    // Epsilon keeps exact square roots from flooring one bean short.
    return (ratio.toDouble() * config.scale + 1e-9).floor();
  }

  BigNumber beanMultiplier(int goldenBeans) =>
      BigNumber.fromDouble(1 + goldenBeans * config.beanBonus);
}
