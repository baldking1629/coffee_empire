import 'package:equatable/equatable.dart';

import 'json_readers.dart';

export 'cafe_rules_config.dart';
export 'furniture_config.dart';

class DrinkConfig extends Equatable {
  const DrinkConfig({
    required this.id,
    required this.nameKey,
    required this.iconSpriteId,
    required this.drinkMult,
    required this.unlockShopIndex,
  });

  factory DrinkConfig.fromJson(JsonMap json) => DrinkConfig(
    id: readString(json, 'id'),
    nameKey: readString(json, 'nameKey'),
    iconSpriteId: readString(json, 'iconSpriteId'),
    drinkMult: readDouble(json, 'drinkMult'),
    unlockShopIndex: readInt(json, 'unlockShopIndex'),
  );

  final String id;
  final String nameKey;
  final String iconSpriteId;
  final double drinkMult;
  final int unlockShopIndex;

  @override
  List<Object?> get props => [
    id,
    nameKey,
    iconSpriteId,
    drinkMult,
    unlockShopIndex,
  ];
}

class ServiceConfig extends Equatable {
  const ServiceConfig({
    required this.baseArrivalSeconds,
    required this.minArrivalSeconds,
    required this.arrivalAppealBonus,
    required this.queueCapacity,
    required this.patienceSeconds,
    required this.seatSeconds,
    required this.orderValueSeconds,
    required this.perfectPatienceRatio,
    required this.perfectTipRatio,
    required this.autoServeSeconds,
    required this.autoServeEfficiency,
    required this.vipAutoServeEfficiency,
    required this.maxVisibleBaristas,
    required this.maxCustomers,
    required this.walkCellsPerSecond,
    required this.managerSpeedBonus,
    required this.baristaTakesHeadBelowPatience,
    required this.bigPayoutSeconds,
    required this.drinks,
  });

  factory ServiceConfig.fromJson(JsonMap json) => ServiceConfig(
    baseArrivalSeconds: readDouble(json, 'baseArrivalSeconds'),
    minArrivalSeconds: readDouble(json, 'minArrivalSeconds'),
    arrivalAppealBonus: readDouble(json, 'arrivalAppealBonus'),
    queueCapacity: readInt(json, 'queueCapacity'),
    patienceSeconds: readDouble(json, 'patienceSeconds'),
    seatSeconds: readDouble(json, 'seatSeconds'),
    orderValueSeconds: readDouble(json, 'orderValueSeconds'),
    perfectPatienceRatio: readDouble(json, 'perfectPatienceRatio'),
    perfectTipRatio: readDouble(json, 'perfectTipRatio'),
    autoServeSeconds: readDouble(json, 'autoServeSeconds'),
    autoServeEfficiency: readDouble(json, 'autoServeEfficiency'),
    vipAutoServeEfficiency: readDouble(json, 'vipAutoServeEfficiency'),
    maxVisibleBaristas: readInt(json, 'maxVisibleBaristas'),
    maxCustomers: readInt(json, 'maxCustomers'),
    walkCellsPerSecond: readDouble(json, 'walkCellsPerSecond'),
    managerSpeedBonus: readDouble(json, 'managerSpeedBonus'),
    baristaTakesHeadBelowPatience: readDouble(
      json,
      'baristaTakesHeadBelowPatience',
    ),
    bigPayoutSeconds: readDouble(json, 'bigPayoutSeconds'),
    drinks: readList(json, 'drinks', DrinkConfig.fromJson),
  );

  final double baseArrivalSeconds;
  final double minArrivalSeconds;
  final double arrivalAppealBonus;
  final int queueCapacity;
  final double patienceSeconds;
  final double seatSeconds;
  final double orderValueSeconds;
  final double perfectPatienceRatio;
  final double perfectTipRatio;
  final double autoServeSeconds;
  final double autoServeEfficiency;
  final double vipAutoServeEfficiency;
  final int maxVisibleBaristas;
  final int maxCustomers;
  final double walkCellsPerSecond;
  final double managerSpeedBonus;
  final double baristaTakesHeadBelowPatience;
  final double bigPayoutSeconds;
  final List<DrinkConfig> drinks;

  DrinkConfig? drinkById(String id) {
    for (final drink in drinks) {
      if (drink.id == id) return drink;
    }
    return null;
  }

  @override
  List<Object?> get props => [
    baseArrivalSeconds,
    minArrivalSeconds,
    arrivalAppealBonus,
    queueCapacity,
    patienceSeconds,
    seatSeconds,
    orderValueSeconds,
    perfectPatienceRatio,
    perfectTipRatio,
    autoServeSeconds,
    autoServeEfficiency,
    vipAutoServeEfficiency,
    maxVisibleBaristas,
    maxCustomers,
    walkCellsPerSecond,
    managerSpeedBonus,
    baristaTakesHeadBelowPatience,
    bigPayoutSeconds,
    drinks,
  ];
}
