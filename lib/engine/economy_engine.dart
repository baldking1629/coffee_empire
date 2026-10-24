import 'package:equatable/equatable.dart';

import '../config/economy_config.dart';
import '../core/bignumber/big_number.dart';
import 'franchise_math.dart';
import 'lab_math.dart';
import 'offline_math.dart';
import 'prestige_math.dart';
import 'shop_math.dart';

class IncomeInputs extends Equatable {
  const IncomeInputs({
    this.shopLevels = const {},
    this.managers = const {},
    this.equipment = const {},
    this.goldenBeans = 0,
    this.recipeBestScores = const {},
    this.capsuleMachines = 0,
    this.franchises = const {},
  });

  final Map<String, int> shopLevels;
  final Map<String, bool> managers;
  final Map<String, int> equipment;
  final int goldenBeans;
  final Map<String, int> recipeBestScores;
  final int capsuleMachines;
  final Map<String, int> franchises;

  @override
  List<Object?> get props => [
    shopLevels,
    managers,
    equipment,
    goldenBeans,
    recipeBestScores,
    capsuleMachines,
    franchises,
  ];
}

class EconomyEngine {
  EconomyEngine(this.config)
    : shopMath = ShopMath(config.shopRules),
      labMath = LabMath(lab: config.lab, capsule: config.capsule),
      franchiseMath = FranchiseMath(config.franchise),
      prestigeMath = PrestigeMath(config.prestige),
      offlineMath = OfflineMath(config.offline);

  final EconomyConfig config;
  final ShopMath shopMath;
  final LabMath labMath;
  final FranchiseMath franchiseMath;
  final PrestigeMath prestigeMath;
  final OfflineMath offlineMath;

  BigNumber shopsIncomePerSec(IncomeInputs inputs) {
    var total = BigNumber.zero;
    for (final shop in config.shops) {
      total += shopMath.shopIncomePerSec(
        shop,
        level: inputs.shopLevels[shop.id] ?? 0,
        hasManager: inputs.managers[shop.id] ?? false,
        equipmentOwned: inputs.equipment[shop.id] ?? 0,
      );
    }
    return total;
  }

  BigNumber globalMultiplier(IncomeInputs inputs) =>
      prestigeMath.beanMultiplier(inputs.goldenBeans) *
      labMath.labBonusMultiplier(inputs.recipeBestScores);

  BigNumber totalIncomePerSec(IncomeInputs inputs) {
    final shopsSum = shopsIncomePerSec(inputs);
    final base =
        shopsSum +
        labMath.capsuleIncomePerSec(
          inputs.capsuleMachines,
          inputs.recipeBestScores,
        ) +
        franchiseMath.royaltyIncome(inputs.franchises, shopsSum);
    return base * globalMultiplier(inputs);
  }

  BigNumber earningsFor(BigNumber incomePerSec, double deltaSeconds) {
    if (deltaSeconds <= 0 || incomePerSec.isZero) return BigNumber.zero;
    return incomePerSec * BigNumber.fromDouble(deltaSeconds);
  }

  int brandHype(BigNumber lifetimeEarnings) {
    if (lifetimeEarnings <= BigNumber.zero) return 0;
    return ((lifetimeEarnings + BigNumber.one).log10() * 10 + 1e-9).floor();
  }
}
