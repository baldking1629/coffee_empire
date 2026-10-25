import 'package:equatable/equatable.dart';

import '../config/cafe_config.dart';

class CafeLayout extends Equatable {
  const CafeLayout({this.roomTier = 1, this.items = const []});

  factory CafeLayout.fromJson(Map<String, dynamic> json) => CafeLayout(
    roomTier: (json['roomTier'] as num).toInt(),
    items: [
      for (final item in json['items'] as List<dynamic>)
        LayoutItem.fromJson(item as Map<String, dynamic>),
    ],
  );

  static const CafeLayout empty = CafeLayout();

  final int roomTier;
  final List<LayoutItem> items;

  LayoutItem? byUid(String uid) {
    for (final item in items) {
      if (item.uid == uid) return item;
    }
    return null;
  }

  CafeLayout copyWith({int? roomTier, List<LayoutItem>? items}) => CafeLayout(
    roomTier: roomTier ?? this.roomTier,
    items: items ?? this.items,
  );

  CafeLayout withItem(LayoutItem placed) => copyWith(
    items: [
      for (final item in items)
        if (item.uid != placed.uid) item,
      placed,
    ],
  );

  CafeLayout without(String uid) => copyWith(
    items: [
      for (final item in items)
        if (item.uid != uid) item,
    ],
  );

  Map<String, dynamic> toJson() => {
    'roomTier': roomTier,
    'items': [for (final item in items) item.toJson()],
  };

  @override
  List<Object?> get props => [roomTier, items];
}

class CafeRoom extends Equatable {
  const CafeRoom({
    required this.tier,
    required this.cols,
    required this.rows,
    required this.door,
    required this.queueHead,
    required this.playerStation,
    required this.baristaStations,
    required this.machine,
    required this.fixedItems,
  });

  factory CafeRoom.forTier(
    CafeLayoutConfig base,
    CafeRulesConfig rules,
    int tier,
  ) {
    final growth = (tier - 1) * rules.tilesPerRoomTier;
    final rows = base.rows + growth;
    return CafeRoom(
      tier: tier,
      cols: base.cols + growth,
      rows: rows,
      door: (x: base.door.x, y: rows - 1),
      queueHead: base.queueHead,
      playerStation: base.playerStation,
      baristaStations: base.baristaStations,
      machine: base.machine,
      fixedItems: base.fixedItems,
    );
  }

  final int tier;
  final int cols;
  final int rows;
  final GridCell door;
  final GridCell queueHead;
  final GridCell playerStation;
  final List<GridCell> baristaStations;
  final GridCell machine;
  final List<LayoutItem> fixedItems;

  bool contains(GridCell cell) =>
      cell.x >= 0 && cell.y >= 0 && cell.x < cols && cell.y < rows;

  List<GridCell> laneCells(int length) => [
    for (var i = 0; i < length; i++) (x: queueHead.x, y: queueHead.y + i),
  ];

  @override
  List<Object?> get props => [
    tier,
    cols,
    rows,
    door,
    queueHead,
    playerStation,
    baristaStations,
    machine,
    fixedItems,
  ];
}
