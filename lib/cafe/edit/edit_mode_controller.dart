import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../config/cafe_config.dart';
import '../../engine/layout_rules.dart';
import '../../features/game/game_cubit.dart';

class EditSession extends Equatable {
  const EditSession({
    required this.candidate,
    required this.fromInventory,
    required this.verdict,
  });

  final LayoutItem candidate;
  final bool fromInventory;
  final PlacementVerdict verdict;

  bool get isValid => verdict == PlacementVerdict.valid;

  @override
  List<Object?> get props => [candidate, fromInventory, verdict];
}

class EditModeController {
  EditModeController({required this.cubit});

  static const String ghostUid = 'placement_ghost';

  final GameCubit cubit;
  final ValueNotifier<bool> active = ValueNotifier(false);
  final ValueNotifier<EditSession?> session = ValueNotifier(null);

  CafeCatalog get _catalog => cubit.engine.config.cafe;

  void enter() => active.value = true;

  void exit() {
    session.value = null;
    active.value = false;
  }

  LayoutItem? itemAt(GridCell cell) {
    for (final item in cubit.state.cafeLayout.items) {
      final shape = _catalog.shapeOf(item.itemId);
      if (shape != null && item.cellsFor(shape).contains(cell)) return item;
    }
    return null;
  }

  void pickAt(GridCell cell) {
    if (session.value != null) {
      moveTo(cell);
      return;
    }
    final item = itemAt(cell);
    if (item != null) _show(item, fromInventory: false);
  }

  void startPlacing(String itemId) {
    final room = cubit.cafeRoom;
    final start = LayoutItem(uid: ghostUid, itemId: itemId, x: 0, y: 0);
    for (var y = room.queueHead.y; y < room.rows; y++) {
      for (var x = 0; x < room.cols; x++) {
        final candidate = start.copyWith(x: x, y: y);
        if (cubit.placementVerdict(candidate) == PlacementVerdict.valid) {
          _show(candidate, fromInventory: true);
          return;
        }
      }
    }
    _show(
      start.copyWith(x: room.queueHead.x + 1, y: room.queueHead.y + 1),
      fromInventory: true,
    );
  }

  void moveTo(GridCell cell) {
    final current = session.value;
    if (current == null ||
        current.candidate.x == cell.x && current.candidate.y == cell.y) {
      return;
    }
    _show(
      current.candidate.copyWith(x: cell.x, y: cell.y),
      fromInventory: current.fromInventory,
    );
  }

  bool get canRotate {
    final current = session.value;
    if (current == null) return false;
    return _catalog.furniture[current.candidate.itemId]?.rotatable ?? false;
  }

  void rotate() {
    final current = session.value;
    if (current == null || !canRotate) return;
    _show(
      current.candidate.copyWith(
        rotation: (current.candidate.rotation + 1) % 2,
      ),
      fromInventory: current.fromInventory,
    );
  }

  Future<bool> confirm() async {
    final current = session.value;
    if (current == null) return false;
    final candidate = current.candidate;
    final placed = current.fromInventory
        ? await cubit.placeFromInventory(
            candidate.itemId,
            x: candidate.x,
            y: candidate.y,
            rotation: candidate.rotation,
          )
        : await cubit.moveFurniture(candidate);
    if (placed) session.value = null;
    return placed;
  }

  Future<void> store() async {
    final current = session.value;
    if (current == null) return;
    if (!current.fromInventory) {
      await cubit.storeFurniture(current.candidate.uid);
    }
    session.value = null;
  }

  void cancel() => session.value = null;

  void refresh() {
    final current = session.value;
    if (current == null) return;
    _show(current.candidate, fromInventory: current.fromInventory);
  }

  void _show(LayoutItem candidate, {required bool fromInventory}) {
    session.value = EditSession(
      candidate: candidate,
      fromInventory: fromInventory,
      verdict: cubit.placementVerdict(candidate),
    );
  }

  void dispose() {
    active.dispose();
    session.dispose();
  }
}
