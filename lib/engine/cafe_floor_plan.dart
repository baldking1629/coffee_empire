import '../config/cafe_config.dart';
import 'cafe_layout.dart';

class CafeFloorPlan {
  const CafeFloorPlan({
    required this.cols,
    required this.rows,
    required this.door,
    required this.lane,
    required this.seats,
    required this.blocked,
  });

  factory CafeFloorPlan.build({
    required CafeRoom room,
    required Iterable<LayoutItem> items,
    required CafeCatalog catalog,
    required int laneLength,
  }) {
    final blocked = <GridCell>{
      for (var y = 0; y < room.queueHead.y; y++)
        for (var x = 0; x < room.cols; x++) (x: x, y: y),
    };
    final seats = <GridCell>[];
    for (final item in [...room.fixedItems, ...items]) {
      final shape = catalog.shapeOf(item.itemId);
      if (shape == null) continue;
      for (final cell in item.cellsFor(shape)) {
        if (shape.blocksWalk) blocked.add(cell);
        if (shape.isSeat) seats.add(cell);
      }
    }
    return CafeFloorPlan(
      cols: room.cols,
      rows: room.rows,
      door: room.door,
      lane: room.laneCells(laneLength),
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
