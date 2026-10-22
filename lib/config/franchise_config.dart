import 'package:equatable/equatable.dart';

import '../core/bignumber/big_number.dart';
import 'json_readers.dart';

class CityConfig extends Equatable {
  const CityConfig({
    required this.id,
    required this.countryCode,
    required this.region,
    required this.slots,
    required this.requiredHype,
    required this.baseCost,
    required this.royaltyShare,
  });

  factory CityConfig.fromJson(JsonMap json) => CityConfig(
    id: readString(json, 'id'),
    countryCode: readString(json, 'countryCode'),
    region: readString(json, 'region'),
    slots: readInt(json, 'slots'),
    requiredHype: readInt(json, 'requiredHype'),
    baseCost: readBig(json, 'baseCost'),
    royaltyShare: readDouble(json, 'royaltyShare'),
  );

  final String id;
  final String countryCode;
  final String region;
  final int slots;
  final int requiredHype;
  final BigNumber baseCost;
  final double royaltyShare;

  @override
  List<Object?> get props => [
    id,
    countryCode,
    region,
    slots,
    requiredHype,
    baseCost,
    royaltyShare,
  ];
}

class FranchiseConfig extends Equatable {
  const FranchiseConfig({
    required this.slotCostGrowth,
    required this.completionMultiplier,
    required this.cities,
  });

  factory FranchiseConfig.fromJson(JsonMap json) => FranchiseConfig(
    slotCostGrowth: readDouble(json, 'slotCostGrowth'),
    completionMultiplier: readDouble(json, 'completionMultiplier'),
    cities: readList(json, 'cities', CityConfig.fromJson),
  );

  final double slotCostGrowth;
  final double completionMultiplier;
  final List<CityConfig> cities;

  @override
  List<Object?> get props => [slotCostGrowth, completionMultiplier, cities];
}

class PrestigeConfig extends Equatable {
  const PrestigeConfig({
    required this.threshold,
    required this.scale,
    required this.beanBonus,
  });

  factory PrestigeConfig.fromJson(JsonMap json) => PrestigeConfig(
    threshold: readBig(json, 'threshold'),
    scale: readDouble(json, 'scale'),
    beanBonus: readDouble(json, 'beanBonus'),
  );

  final BigNumber threshold;
  final double scale;
  final double beanBonus;

  @override
  List<Object?> get props => [threshold, scale, beanBonus];
}
