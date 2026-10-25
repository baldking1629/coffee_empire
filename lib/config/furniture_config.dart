import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'json_readers.dart';

typedef GridCell = ({int x, int y});

GridCell readCell(JsonMap json) =>
    (x: readInt(json, 'x'), y: readInt(json, 'y'));

enum FurnitureCategory { seating, table, decor, lighting, counter }

class FixtureConfig extends Equatable {
  const FixtureConfig({
    required this.id,
    required this.spriteId,
    required this.width,
    required this.height,
    required this.isSeat,
    required this.blocksWalk,
    this.paletteKey = 'base',
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
      paletteKey: json['paletteKey'] as String? ?? 'base',
    );
  }

  final String id;
  final String spriteId;
  final int width;
  final int height;
  final bool isSeat;
  final bool blocksWalk;
  final String paletteKey;

  @override
  List<Object?> get props => [
    id,
    spriteId,
    width,
    height,
    isSeat,
    blocksWalk,
    paletteKey,
  ];
}

class FurnitureConfig extends FixtureConfig {
  const FurnitureConfig({
    required super.id,
    required super.spriteId,
    required super.width,
    required super.height,
    required super.isSeat,
    required super.blocksWalk,
    required this.nameKey,
    required this.category,
    required this.appeal,
    required this.costMult,
    required this.unlockShopIndex,
    required this.rotatable,
    super.paletteKey,
  });

  factory FurnitureConfig.fromJson(JsonMap json) {
    final shape = FixtureConfig.fromJson(json);
    return FurnitureConfig(
      id: shape.id,
      spriteId: shape.spriteId,
      width: shape.width,
      height: shape.height,
      isSeat: shape.isSeat,
      blocksWalk: shape.blocksWalk,
      paletteKey: shape.paletteKey,
      nameKey: readString(json, 'nameKey'),
      category: FurnitureCategory.values.byName(readString(json, 'category')),
      appeal: readInt(json, 'appeal'),
      costMult: readDouble(json, 'costMult'),
      unlockShopIndex: readInt(json, 'unlockShopIndex'),
      rotatable: json['rotatable'] as bool,
    );
  }

  final String nameKey;
  final FurnitureCategory category;
  final int appeal;
  final double costMult;
  final int unlockShopIndex;
  final bool rotatable;

  @override
  List<Object?> get props => [
    ...super.props,
    nameKey,
    category,
    appeal,
    costMult,
    unlockShopIndex,
    rotatable,
  ];
}

class LayoutItem extends Equatable {
  const LayoutItem({
    required this.uid,
    required this.itemId,
    required this.x,
    required this.y,
    this.rotation = 0,
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

  bool get isTurned => rotation.isOdd;

  LayoutItem copyWith({int? x, int? y, int? rotation}) => LayoutItem(
    uid: uid,
    itemId: itemId,
    x: x ?? this.x,
    y: y ?? this.y,
    rotation: rotation ?? this.rotation,
  );

  List<GridCell> cellsFor(FixtureConfig shape) {
    final width = isTurned ? shape.height : shape.width;
    final height = isTurned ? shape.width : shape.height;
    return [
      for (var dy = 0; dy < height; dy++)
        for (var dx = 0; dx < width; dx++) (x: x + dx, y: y + dy),
    ];
  }

  JsonMap toJson() => {
    'uid': uid,
    'itemId': itemId,
    'x': x,
    'y': y,
    'rotation': rotation,
  };

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
    required this.fixedItems,
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
    fixedItems: readList(json, 'fixedItems', LayoutItem.fromJson),
    items: readList(json, 'items', LayoutItem.fromJson),
  );

  static const CafeLayoutConfig empty = CafeLayoutConfig(
    roomTier: 1,
    cols: 1,
    rows: 2,
    door: (x: 0, y: 1),
    queueHead: (x: 0, y: 0),
    playerStation: (x: 0, y: 0),
    baristaStations: [],
    machine: (x: 0, y: 0),
    fixedItems: [],
    items: [],
  );

  final int roomTier;
  final int cols;
  final int rows;
  final GridCell door;
  final GridCell queueHead;
  final GridCell playerStation;
  final List<GridCell> baristaStations;
  final GridCell machine;
  final List<LayoutItem> fixedItems;
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
    fixedItems,
    items,
  ];
}

class CafeCatalog extends Equatable {
  const CafeCatalog({
    required this.fixtures,
    required this.furniture,
    required this.defaultLayout,
  });

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
      furniture: {
        for (final item in readList(json, 'items', FurnitureConfig.fromJson))
          item.id: item,
      },
      defaultLayout: CafeLayoutConfig.fromJson(readMap(json, 'defaultLayout')),
    );
  }

  static const CafeCatalog empty = CafeCatalog(
    fixtures: {},
    furniture: {},
    defaultLayout: CafeLayoutConfig.empty,
  );

  final Map<String, FixtureConfig> fixtures;
  final Map<String, FurnitureConfig> furniture;
  final CafeLayoutConfig defaultLayout;

  FixtureConfig? shapeOf(String itemId) =>
      furniture[itemId] ?? fixtures[itemId];

  @override
  List<Object?> get props => [fixtures, furniture, defaultLayout];
}
