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

  CafeRoom get room => _room;

  @override
  Future<void> onLoad() async => _build();

  void rebuild(CafeRoom room, List<LayoutItem> items) {
    _room = room;
    _items = items;
    if (isLoaded) _build();
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
      FloorLayer(
        atlas: atlas,
        cols: _room.cols,
        rows: _room.rows,
        paletteKey: 'base',
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
      _furniture[item.uid] = component;
      add(component);
    }
  }
}
