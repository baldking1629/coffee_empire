import 'package:flame/components.dart';
import 'package:flame/events.dart';

import '../../engine/cafe_customer.dart';
import '../../pixel/palette_set.dart';
import '../../pixel/sprite_atlas.dart';
import '../camera_fit.dart';
import '../world/furniture_component.dart';
import '../world/pixel_sprite_component.dart';
import 'order_bubble.dart';

class CustomerComponent extends PixelSpriteComponent with TapCallbacks {
  CustomerComponent({
    required super.atlas,
    required this.customer,
    required this.drinkIconId,
    required this.onTapped,
  }) : super(
         spriteId: bodies[customer.look % bodies.length],
         paletteKey: paletteFor(customer.look),
         animation: 'idle_down',
         animate: true,
       );

  static const List<String> bodies = [
    'customer_a',
    'customer_b',
    'customer_c',
    'customer_d',
  ];
  static const List<String> skins = [
    'skin_light',
    'skin_tan',
    'skin_brown',
    'skin_dark',
  ];
  static const List<String> hairs = [
    'hair_black',
    'hair_blonde',
    'hair_red',
    'hair_gray',
  ];
  static const List<String> shirts = [
    'shirt_red',
    'shirt_green',
    'shirt_yellow',
    'shirt_purple',
  ];
  static const double tapPadding = 6;

  static String paletteFor(int look) => PaletteCatalog.keyOf([
    skins[(look >> 2) % skins.length],
    hairs[(look >> 4) % hairs.length],
    shirts[(look >> 6) % shirts.length],
  ]);

  final CafeCustomer customer;
  final String drinkIconId;
  final void Function(int customerId) onTapped;
  OrderBubble? _bubble;

  SpriteAtlas get spriteAtlas => atlas;

  void sync() {
    const tile = CameraFit.tilePixels;
    position = Vector2((customer.x + 0.5) * tile, (customer.y + 1) * tile - 2);
    priority = FurnitureComponent.depthOf(customer.y.ceil() + 1) + 1;
    final facing = customer.facing;
    if (customer.isMoving) {
      animation = facing.y < 0
          ? 'walk_up'
          : facing.y > 0
          ? 'walk_down'
          : 'walk_side';
      flipX = facing.x < 0;
    } else {
      animation = 'idle_down';
      flipX = false;
    }
    _syncBubble();
  }

  void _syncBubble() {
    final waiting = customer.isWaitingForOrder && !customer.isMoving;
    if (!waiting) {
      _bubble?.removeFromParent();
      _bubble = null;
      return;
    }
    final bubble =
        _bubble ??
        (OrderBubble(atlas: atlas, drinkIconId: drinkIconId)
          ..position = Vector2(size.x / 2, -1));
    if (_bubble == null) {
      _bubble = bubble;
      add(bubble);
    }
    bubble
      ..patienceRatio = customer.patience / customerPatienceSeconds
      ..ready = customer.orderReady
      ..dimmed = customer.claim == OrderClaim.barista;
  }

  double customerPatienceSeconds = 1;

  @override
  bool containsLocalPoint(Vector2 point) =>
      point.x >= -tapPadding &&
      point.x <= size.x + tapPadding &&
      point.y >= -size.y * 0.5 &&
      point.y <= size.y;

  @override
  void onTapDown(TapDownEvent event) => onTapped(customer.id);
}
