import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'json_readers.dart';

typedef GridCell = ({int x, int y});

GridCell readCell(JsonMap json) =>
    (x: readInt(json, 'x'), y: readInt(json, 'y'));

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
    drinks,
  ];
}

class FixtureConfig extends Equatable {
  const FixtureConfig({
    required this.id,
    required this.spriteId,
    required this.width,
    required this.height,
    required this.isSeat,
    required this.blocksWalk,
  });

  factory FixtureConfig.fromJson(JsonMap json) {
    final footprint = readMap(json, 'footprint');
    return FixtureConfig(
      id: readString(json, 'id'),
      spriteId: readString(json, 'spriteId'),
      width: readInt(footprint, 'w'),
      height: readInt(footprint, 'h'),
      isSeat: json['isSeat'] as bool,
      blocksWalk: json['blocksWalk'] as bool,
    );
  }

  final String id;
  final String spriteId;
  final int width;
  final int height;
  final bool isSeat;
  final bool blocksWalk;

  @override
  List<Object?> get props => [id, spriteId, width, height, isSeat, blocksWalk];
}

class LayoutItem extends Equatable {
  const LayoutItem({
    required this.uid,
    required this.itemId,
    required this.x,
    required this.y,
    required this.rotation,
  });

  factory LayoutItem.fromJson(JsonMap json) => LayoutItem(
    uid: readString(json, 'uid'),
    itemId: readString(json, 'itemId'),
    x: readInt(json, 'x'),
    y: readInt(json, 'y'),
    rotation: readInt(json, 'rotation'),
  );

  final String uid;
  final String itemId;
  final int x;
  final int y;
  final int rotation;

  @override
  List<Object?> get props => [uid, itemId, x, y, rotation];
}

class CafeLayoutConfig extends Equatable {
  const CafeLayoutConfig({
    required this.roomTier,
    required this.cols,
    required this.rows,
    required this.door,
    required this.queueHead,
    required this.playerStation,
    required this.baristaStations,
    required this.machine,
    required this.items,
  });

  factory CafeLayoutConfig.fromJson(JsonMap json) => CafeLayoutConfig(
    roomTier: readInt(json, 'roomTier'),
    cols: readInt(json, 'cols'),
    rows: readInt(json, 'rows'),
    door: readCell(readMap(json, 'door')),
    queueHead: readCell(readMap(json, 'queueHead')),
    playerStation: readCell(readMap(json, 'playerStation')),
    baristaStations: readList(json, 'baristaStations', readCell),
    machine: readCell(readMap(json, 'machine')),
    items: readList(json, 'items', LayoutItem.fromJson),
  );

  final int roomTier;
  final int cols;
  final int rows;
  final GridCell door;
  final GridCell queueHead;
  final GridCell playerStation;
  final List<GridCell> baristaStations;
  final GridCell machine;
  final List<LayoutItem> items;

  @override
  List<Object?> get props => [
    roomTier,
    cols,
    rows,
    door,
    queueHead,
    playerStation,
    baristaStations,
    machine,
    items,
  ];
}

class CafeCatalog extends Equatable {
  const CafeCatalog({required this.fixtures, required this.defaultLayout});

  factory CafeCatalog.fromJsonString(String source) {
    final json = jsonDecode(source) as JsonMap;
    return CafeCatalog(
      fixtures: {
        for (final fixture in readList(
          json,
          'fixtures',
          FixtureConfig.fromJson,
        ))
          fixture.id: fixture,
      },
      defaultLayout: CafeLayoutConfig.fromJson(readMap(json, 'defaultLayout')),
    );
  }

  final Map<String, FixtureConfig> fixtures;
  final CafeLayoutConfig defaultLayout;

  @override
  List<Object?> get props => [fixtures, defaultLayout];
}
