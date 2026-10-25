import '../config/cafe_config.dart';

class CafeFloorPlan {
  const CafeFloorPlan({
    required this.cols,
    required this.rows,
    required this.door,
    required this.lane,
    required this.seats,
    required this.blocked,
  });

  factory CafeFloorPlan.fromLayout(
    CafeLayoutConfig layout,
    Map<String, FixtureConfig> fixtures, {
    required int laneLength,
  }) {
    final blocked = <GridCell>{
      for (var y = 0; y < layout.queueHead.y; y++)
        for (var x = 0; x < layout.cols; x++) (x: x, y: y),
    };
    final seats = <GridCell>[];
    for (final item in layout.items) {
      final fixture = fixtures[item.itemId];
      if (fixture == null) continue;
      for (var dy = 0; dy < fixture.height; dy++) {
        for (var dx = 0; dx < fixture.width; dx++) {
          final cell = (x: item.x + dx, y: item.y + dy);
          if (fixture.blocksWalk) blocked.add(cell);
          if (fixture.isSeat) seats.add(cell);
        }
      }
    }
    final lane = [
      for (var i = 0; i < laneLength; i++)
        (x: layout.queueHead.x, y: layout.queueHead.y + i),
    ];
    return CafeFloorPlan(
      cols: layout.cols,
      rows: layout.rows,
      door: layout.door,
      lane: lane,
      seats: seats,
      blocked: blocked,
    );
  }

  final int cols;
  final int rows;
  final GridCell door;
  final List<GridCell> lane;
  final List<GridCell> seats;
  final Set<GridCell> blocked;
}
