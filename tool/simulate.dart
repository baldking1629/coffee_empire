import 'dart:io';

import 'package:coffee_empire/config/economy_config.dart';
import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:coffee_empire/engine/shop_math.dart';

const List<double?> targetMinutesByShop = [
  null,
  1,
  4,
  12,
  35,
  120,
  360,
  1440,
  2880,
  5760,
];
const double prestigeTargetMinutes = 2880;
const double tolerance = 0.3;
const double maxSimulatedSeconds = 400 * 3600;

class _Upgrade {
  const _Upgrade(this.cost, this.apply);

  final BigNumber cost;
  final void Function() apply;
}

class _PassiveBot {
  _PassiveBot(this.config)
    : math = ShopMath(config.shopRules),
      levels = List.filled(config.shops.length, 0),
      managers = List.filled(config.shops.length, false),
      equipment = List.filled(config.shops.length, 0),
      cash = config.startingCash;

  final EconomyConfig config;
  final ShopMath math;
  final List<int> levels;
  final List<bool> managers;
  final List<int> equipment;
  final Map<int, double> firstPurchaseSeconds = {};
  BigNumber cash;
  BigNumber runEarnings = BigNumber.zero;
  double elapsedSeconds = 0;
  double? prestigeSeconds;

  BigNumber get incomePerSec {
    var total = BigNumber.zero;
    for (var i = 0; i < config.shops.length; i++) {
      total += math.shopIncomePerSec(
        config.shops[i],
        level: levels[i],
        hasManager: managers[i],
        equipmentOwned: equipment[i],
      );
    }
    return total;
  }

  List<_Upgrade> get availableUpgrades {
    final upgrades = <_Upgrade>[];
    for (var i = 0; i < config.shops.length; i++) {
      if (!math.isShopAvailable(levels, i)) continue;
      final shop = config.shops[i];
      final index = i;
      upgrades.add(
        _Upgrade(math.costOfNext(shop, levels[i]), () {
          firstPurchaseSeconds.putIfAbsent(index, () => elapsedSeconds);
          levels[index]++;
        }),
      );
      if (levels[i] == 0) continue;
      if (!managers[i]) {
        upgrades.add(
          _Upgrade(math.managerCost(shop), () => managers[index] = true),
        );
      }
      if (equipment[i] < math.equipmentTierCount) {
        upgrades.add(
          _Upgrade(
            math.equipmentCost(shop, equipment[i]),
            () => equipment[index]++,
          ),
        );
      }
    }
    return upgrades;
  }

  void earn(double seconds) {
    final earned = incomePerSec * BigNumber.fromDouble(seconds);
    cash += earned;
    runEarnings += earned;
    elapsedSeconds += seconds;
    if (prestigeSeconds == null && runEarnings >= config.prestige.threshold) {
      prestigeSeconds = elapsedSeconds;
    }
  }

  void run() {
    while (elapsedSeconds < maxSimulatedSeconds) {
      final cheapest = availableUpgrades.reduce(
        (a, b) => a.cost <= b.cost ? a : b,
      );
      if (cash < cheapest.cost) {
        final income = incomePerSec;
        if (income.isZero) return;
        final waitSeconds = ((cheapest.cost - cash) / income).toDouble();
        earn(waitSeconds < 1 ? 1 : waitSeconds.ceilToDouble());
        continue;
      }
      cash -= cheapest.cost;
      cheapest.apply();
      final allShopsOwned = firstPurchaseSeconds.length == config.shops.length;
      if (allShopsOwned && prestigeSeconds != null) return;
    }
  }
}

String formatMinutes(double? minutes) {
  if (minutes == null) return '-';
  if (minutes < 60) return '${minutes.toStringAsFixed(1)} min';
  return '${(minutes / 60).toStringAsFixed(2)} h';
}

String verdict(double? actualMinutes, double? targetMinutes) {
  if (targetMinutes == null) return '';
  if (actualMinutes == null) return 'NOT REACHED';
  final ratio = actualMinutes / targetMinutes;
  return (ratio - 1).abs() <= tolerance
      ? 'OK'
      : 'OUT (${ratio.toStringAsFixed(2)}x)';
}

void main() {
  final source = File('assets/config/economy.json').readAsStringSync();
  final config = EconomyConfig.fromJsonString(source);
  final bot = _PassiveBot(config)..run();

  stdout.writeln(
    '${'#'.padRight(3)}${'shop'.padRight(24)}${'first buy'.padRight(14)}'
    '${'target'.padRight(12)}status',
  );
  for (var i = 0; i < config.shops.length; i++) {
    final seconds = bot.firstPurchaseSeconds[i];
    final actual = seconds == null ? null : seconds / 60;
    final target = targetMinutesByShop[i];
    stdout.writeln(
      '${'${i + 1}'.padRight(3)}${config.shops[i].id.padRight(24)}'
      '${formatMinutes(actual).padRight(14)}'
      '${formatMinutes(target).padRight(12)}${verdict(actual, target)}',
    );
  }
  final prestige = bot.prestigeSeconds;
  final prestigeMinutes = prestige == null ? null : prestige / 60;
  stdout.writeln(
    '   ${'first prestige'.padRight(24)}${formatMinutes(prestigeMinutes).padRight(14)}'
    '${formatMinutes(prestigeTargetMinutes).padRight(12)}'
    '${verdict(prestigeMinutes, prestigeTargetMinutes)}',
  );
}
