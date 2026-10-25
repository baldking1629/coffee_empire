import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

import '../../app/theme/app_colors.dart';
import '../../config/cafe_config.dart';
import '../../engine/cafe_layout.dart';
import '../../pixel/sprite_atlas.dart';
import '../camera_fit.dart';
import '../world/furniture_component.dart';
import 'edit_mode_controller.dart';

class EditGrid extends PositionComponent with TapCallbacks, DragCallbacks {
  EditGrid({required this.controller, required CafeRoom room})
    : super(priority: 1 << 19) {
    resize(room);
  }

  final EditModeController controller;
  int _cols = 0;
  int _rows = 0;
  int _firstEditableRow = 0;

  static final Paint _linePaint = Paint()
    ..color = AppColors.textPrimary.withValues(alpha: 0.25)
    ..strokeWidth = 0.5;
  static final Paint _staffShade = Paint()
    ..color = AppColors.lockedShade.withValues(alpha: 0.35);

  void resize(CafeRoom room) {
    _cols = room.cols;
    _rows = room.rows;
    _firstEditableRow = room.queueHead.y;
    size = Vector2(
      (_cols * CameraFit.tilePixels).toDouble(),
      (_rows * CameraFit.tilePixels).toDouble(),
    );
  }

  GridCell _cellAt(Vector2 local) => (
    x: (local.x / CameraFit.tilePixels).floor().clamp(0, _cols - 1),
    y: (local.y / CameraFit.tilePixels).floor().clamp(0, _rows - 1),
  );

  @override
  void onTapDown(TapDownEvent event) =>
      controller.pickAt(_cellAt(event.localPosition));

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    final cell = _cellAt(event.localPosition);
    if (controller.session.value == null) controller.pickAt(cell);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) =>
      controller.moveTo(_cellAt(event.localEndPosition));

  @override
  void render(Canvas canvas) {
    const tile = CameraFit.tilePixels;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.x, (_firstEditableRow * tile).toDouble()),
      _staffShade,
    );
    for (var x = 0; x <= _cols; x++) {
      final dx = (x * tile).toDouble();
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.y), _linePaint);
    }
    for (var y = 0; y <= _rows; y++) {
      final dy = (y * tile).toDouble();
      canvas.drawLine(Offset(0, dy), Offset(size.x, dy), _linePaint);
    }
  }
}

class PlacementGhost extends PositionComponent {
  PlacementGhost({
    required this.atlas,
    required this.session,
    required this.shape,
  }) : super(priority: 1 << 20) {
    _sprite = FurnitureComponent(
      atlas: atlas,
      item: session.candidate,
      shape: shape,
    );
    add(_sprite);
  }

  final SpriteAtlas atlas;
  final FixtureConfig shape;
  EditSession session;
  late final FurnitureComponent _sprite;

  static final Paint _validPaint = Paint()
    ..color = AppColors.mint.withValues(alpha: 0.35);
  static final Paint _invalidPaint = Paint()
    ..color = AppColors.danger.withValues(alpha: 0.45);

  void show(EditSession next) {
    session = next;
    _sprite.placeAt(next.candidate);
  }

  @override
  void render(Canvas canvas) {
    const tile = CameraFit.tilePixels;
    final paint = session.isValid ? _validPaint : _invalidPaint;
    for (final cell in session.candidate.cellsFor(shape)) {
      canvas.drawRect(
        Rect.fromLTWH(
          (cell.x * tile).toDouble(),
          (cell.y * tile).toDouble(),
          tile.toDouble(),
          tile.toDouble(),
        ),
        paint,
      );
    }
  }
}

class EditOverlay extends Component {
  EditOverlay({
    required this.atlas,
    required this.catalog,
    required this.controller,
    required this.onHide,
    required CafeRoom room,
  }) : grid = EditGrid(controller: controller, room: room);

  final SpriteAtlas atlas;
  final CafeCatalog catalog;
  final EditModeController controller;
  final void Function(String? uid) onHide;
  final EditGrid grid;
  PlacementGhost? _ghost;

  @override
  void onMount() {
    super.onMount();
    add(grid);
    controller.session.addListener(_sync);
    _sync();
  }

  @override
  void onRemove() {
    controller.session.removeListener(_sync);
    onHide(null);
    super.onRemove();
  }

  void _sync() {
    final session = controller.session.value;
    final shape = session == null
        ? null
        : catalog.shapeOf(session.candidate.itemId);
    if (session == null || shape == null) {
      _ghost?.removeFromParent();
      _ghost = null;
      onHide(null);
      return;
    }
    onHide(session.fromInventory ? null : session.candidate.uid);
    final ghost = _ghost;
    if (ghost != null && ghost.shape == shape) {
      ghost.show(session);
      return;
    }
    ghost?.removeFromParent();
    add(_ghost = PlacementGhost(atlas: atlas, session: session, shape: shape));
  }
}
