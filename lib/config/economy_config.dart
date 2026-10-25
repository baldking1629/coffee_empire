import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../core/bignumber/big_number.dart';
import 'cafe_config.dart';
import 'franchise_config.dart';
import 'json_readers.dart';
import 'lab_config.dart';
import 'reward_config.dart';
import 'shop_config.dart';

export 'cafe_config.dart';
export 'franchise_config.dart';
export 'lab_config.dart';
export 'reward_config.dart';
export 'shop_config.dart';

class EconomyConfig extends Equatable {
  const EconomyConfig({
    required this.startingCash,
    required this.backgroundGapSeconds,
    required this.autosaveIntervalSeconds,
    required this.achievementBonus,
    required this.shopRules,
    required this.shops,
    required this.tap,
    required this.lab,
    required this.capsule,
    required this.franchise,
    required this.prestige,
    required this.offline,
    required this.rewarded,
    required this.iap,
    required this.dailyReward,
    required this.service,
  });

  factory EconomyConfig.fromJson(JsonMap json) => EconomyConfig(
    startingCash: readBig(json, 'startingCash'),
    backgroundGapSeconds: readInt(json, 'backgroundGapSeconds'),
    autosaveIntervalSeconds: readInt(json, 'autosaveIntervalSeconds'),
    achievementBonus: readDouble(json, 'achievementBonus'),
    shopRules: ShopRulesConfig.fromJson(json),
    shops: readList(json, 'shops', ShopConfig.fromJson),
    tap: TapConfig.fromJson(readMap(json, 'tap')),
    lab: LabConfig.fromJson(readMap(json, 'lab')),
    capsule: CapsuleConfig.fromJson(readMap(json, 'capsule')),
    franchise: FranchiseConfig.fromJson(readMap(json, 'franchise')),
    prestige: PrestigeConfig.fromJson(readMap(json, 'prestige')),
    offline: OfflineConfig.fromJson(readMap(json, 'offline')),
    rewarded: RewardedConfig.fromJson(readMap(json, 'rewarded')),
    iap: IapConfig.fromJson(readMap(json, 'iap')),
    dailyReward: DailyRewardConfig.fromJson(readMap(json, 'dailyReward')),
    service: ServiceConfig.fromJson(readMap(json, 'service')),
  );

  factory EconomyConfig.fromJsonString(String source) =>
      EconomyConfig.fromJson(jsonDecode(source) as JsonMap);

  final BigNumber startingCash;
  final int backgroundGapSeconds;
  final int autosaveIntervalSeconds;
  final double achievementBonus;
  final ShopRulesConfig shopRules;
  final List<ShopConfig> shops;
  final TapConfig tap;
  final LabConfig lab;
  final CapsuleConfig capsule;
  final FranchiseConfig franchise;
  final PrestigeConfig prestige;
  final OfflineConfig offline;
  final RewardedConfig rewarded;
  final IapConfig iap;
  final DailyRewardConfig dailyReward;
  final ServiceConfig service;

  @override
  List<Object?> get props => [
    startingCash,
    backgroundGapSeconds,
    autosaveIntervalSeconds,
    achievementBonus,
    shopRules,
    shops,
    tap,
    lab,
    capsule,
    franchise,
    prestige,
    offline,
    rewarded,
    iap,
    dailyReward,
    service,
  ];
}
