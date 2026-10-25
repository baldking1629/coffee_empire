import 'package:flame/components.dart';

import '../../config/cafe_config.dart';
import '../../engine/cafe_layout.dart';
import '../../pixel/sprite_atlas.dart';
import 'floor_layer.dart';
import 'furniture_component.dart';

class CafeRoomLayer extends Component {
  CafeRoomLayer({
    required this.atlas,
    required this.catalog,
    required CafeRoom room,
    required List<LayoutItem> items,
  }) : _room = room,
       _items = items;

  final SpriteAtlas atlas;
  final CafeCatalog catalog;
  CafeRoom _room;
  List<LayoutItem> _items;
  final Map<String, FurnitureComponent> _furniture = {};
  String? _hiddenUid;
  FloorLayer? _floor;
  String floorPaletteKey = 'base';
  String signSpriteId = signFixtureSprite;

  static const String signFixtureSprite = 'sign';
  static const String signItemId = 'sign';

  CafeRoom get room => _room;

  @override
  Future<void> onLoad() async => _build();

  void rebuild(CafeRoom room, List<LayoutItem> items) {
    _room = room;
    _items = items;
    if (isLoaded) _build();
  }

  void setLook({
    required String floorPaletteKey,
    required String signSpriteId,
  }) {
    if (floorPaletteKey == this.floorPaletteKey &&
        signSpriteId == this.signSpriteId) {
      return;
    }
    this.floorPaletteKey = floorPaletteKey;
    this.signSpriteId = signSpriteId;
    _floor?.paletteKey = floorPaletteKey;
    for (final component in _furniture.values) {
      if (component.item.itemId == signItemId) {
        component.spriteId = signSpriteId;
      }
    }
  }

  void hide(String? uid) {
    _hiddenUid = uid;
    for (final entry in _furniture.entries) {
      entry.value.hidden = entry.key == uid;
    }
  }

  void _build() {
    removeAll(children);
    _furniture.clear();
    add(
      _floor = FloorLayer(
        atlas: atlas,
        cols: _room.cols,
        rows: _room.rows,
        paletteKey: floorPaletteKey,
      ),
    );
    add(DoorComponent(atlas: atlas, door: _room.door));
    for (final item in [..._room.fixedItems, ..._items]) {
      final shape = catalog.shapeOf(item.itemId);
      if (shape == null) continue;
      final component = FurnitureComponent(
        atlas: atlas,
        item: item,
        shape: shape,
      )..hidden = item.uid == _hiddenUid;
      if (item.itemId == signItemId) component.spriteId = signSpriteId;
      _furniture[item.uid] = component;
      add(component);
    }
  }
}
