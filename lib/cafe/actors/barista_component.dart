import 'package:flame/components.dart';

import '../../config/cafe_config.dart';
import '../../engine/cafe_customer.dart';
import '../../pixel/palette_set.dart';
import '../camera_fit.dart';
import '../world/furniture_component.dart';
import '../world/pixel_sprite_component.dart';

class BaristaComponent extends PixelSpriteComponent {
  BaristaComponent({
    required super.atlas,
    required this.station,
    required this.machine,
    String outfit = PaletteCatalog.baseSet,
  }) : super(
         spriteId: 'barista',
         animation: 'idle_down',
         animate: true,
         paletteKey: PaletteCatalog.keyOf([outfit]),
       ) {
    _placeAt(station.x.toDouble());
  }

  static const String vipOutfit = 'outfit_gold';

  final GridCell station;
  final GridCell machine;
  bool brewing = false;

  double get _machineSide =>
      (station.x < machine.x ? machine.x - 1 : machine.x + 1).toDouble();

  void _placeAt(double cellX) {
    const tile = CameraFit.tilePixels;
    position = Vector2((cellX + 0.5) * tile, (station.y + 1) * tile - 2);
    priority = FurnitureComponent.depthOf(station.y + 1) + 1;
  }

  void showPlayer({required bool isBrewing}) {
    brewing = isBrewing;
    animation = isBrewing ? 'prepare' : 'idle_down';
    _placeAt(station.x.toDouble());
  }

  void showWorker(BaristaWorker? worker) {
    if (worker == null || !worker.isBusy) {
      animation = 'idle_down';
      flipX = false;
      _placeAt(station.x.toDouble());
      return;
    }
    final progress = worker.progress;
    final start = station.x.toDouble();
    final end = _machineSide;
    if (progress < 0.25) {
      _walk(start + (end - start) * progress / 0.25, end - start);
    } else if (progress < 0.75) {
      animation = 'prepare';
      flipX = false;
      _placeAt(end);
    } else {
      _walk(end + (start - end) * (progress - 0.75) / 0.25, start - end);
    }
  }

  void _walk(double cellX, double direction) {
    animation = 'walk_side';
    flipX = direction < 0;
    _placeAt(cellX);
  }
}
