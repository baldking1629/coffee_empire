import 'package:coffee_empire/engine/grid_pathfinding.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const finder = GridPathfinder(cols: 5, rows: 5);

  test('straight path includes start and goal', () {
    final path = finder.findPath(
      from: (x: 0, y: 0),
      to: (x: 3, y: 0),
      blocked: {},
    );
    expect(path, [(x: 0, y: 0), (x: 1, y: 0), (x: 2, y: 0), (x: 3, y: 0)]);
  });

  test('walks around an obstacle with only 4-way steps', () {
    final blocked = {(x: 2, y: 0), (x: 2, y: 1), (x: 2, y: 2)};
    final path = finder.findPath(
      from: (x: 0, y: 0),
      to: (x: 4, y: 0),
      blocked: blocked,
    );
    expect(path, isNotNull);
    expect(path?.first, (x: 0, y: 0));
    expect(path?.last, (x: 4, y: 0));
    expect(path?.any(blocked.contains), isFalse);
    final steps = path ?? const [];
    for (var i = 1; i < steps.length; i++) {
      final dx = (steps[i].x - steps[i - 1].x).abs();
      final dy = (steps[i].y - steps[i - 1].y).abs();
      expect(dx + dy, 1);
    }
    expect(steps.length, 11);
  });

  test('unreachable or blocked goals return null', () {
    final wall = {for (var y = 0; y < 5; y++) (x: 2, y: y)};
    expect(
      finder.findPath(from: (x: 0, y: 0), to: (x: 4, y: 4), blocked: wall),
      isNull,
    );
    expect(
      finder.findPath(from: (x: 0, y: 0), to: (x: 2, y: 2), blocked: wall),
      isNull,
    );
    expect(
      finder.findPath(from: (x: 0, y: 0), to: (x: 9, y: 9), blocked: {}),
      isNull,
    );
  });

  test('same cell is a one-step path', () {
    expect(finder.findPath(from: (x: 1, y: 1), to: (x: 1, y: 1), blocked: {}), [
      (x: 1, y: 1),
    ]);
  });
}
