import 'dart:collection';

import '../config/cafe_config.dart';

class GridPathfinder {
  const GridPathfinder({required this.cols, required this.rows});

  static const List<GridCell> _directions = [
    (x: 1, y: 0),
    (x: -1, y: 0),
    (x: 0, y: 1),
    (x: 0, y: -1),
  ];

  final int cols;
  final int rows;

  bool isInside(GridCell cell) =>
      cell.x >= 0 && cell.y >= 0 && cell.x < cols && cell.y < rows;

  Set<GridCell> reachableFrom(GridCell start, Set<GridCell> blocked) {
    if (!isInside(start) || blocked.contains(start)) return const {};
    final visited = <GridCell>{start};
    final frontier = Queue<GridCell>()..add(start);
    while (frontier.isNotEmpty) {
      final current = frontier.removeFirst();
      for (final step in _directions) {
        final next = (x: current.x + step.x, y: current.y + step.y);
        if (!isInside(next) || blocked.contains(next)) continue;
        if (visited.add(next)) frontier.add(next);
      }
    }
    return visited;
  }

  List<GridCell>? findPath({
    required GridCell from,
    required GridCell to,
    required Set<GridCell> blocked,
  }) {
    if (!isInside(from) || !isInside(to) || blocked.contains(to)) return null;
    if (from == to) return [from];
    final previous = <GridCell, GridCell>{};
    final visited = <GridCell>{from};
    final frontier = Queue<GridCell>()..add(from);
    while (frontier.isNotEmpty) {
      final current = frontier.removeFirst();
      for (final step in _directions) {
        final next = (x: current.x + step.x, y: current.y + step.y);
        if (!isInside(next) ||
            visited.contains(next) ||
            blocked.contains(next)) {
          continue;
        }
        visited.add(next);
        previous[next] = current;
        if (next == to) return _walkBack(previous, from, to);
        frontier.add(next);
      }
    }
    return null;
  }

  List<GridCell> _walkBack(
    Map<GridCell, GridCell> previous,
    GridCell from,
    GridCell to,
  ) {
    final path = <GridCell>[to];
    var cursor = to;
    while (cursor != from) {
      final step = previous[cursor];
      if (step == null) break;
      path.add(step);
      cursor = step;
    }
    return path.reversed.toList();
  }
}
