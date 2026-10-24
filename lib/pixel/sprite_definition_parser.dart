import 'dart:convert';

import 'sprite_definition.dart';

typedef JsonMap = Map<String, dynamic>;

class SpriteDefinitionParser {
  const SpriteDefinitionParser();

  static const int defaultFps = 6;

  List<SpriteDefinition> parseSheet(String sheet, String source) {
    final json = jsonDecode(source) as JsonMap;
    return (json['sprites'] as List<dynamic>)
        .cast<JsonMap>()
        .map((sprite) => parseSprite(sheet, sprite))
        .toList();
  }

  SpriteDefinition parseSprite(String sheet, JsonMap json) {
    final animations = (json['animations'] as JsonMap).map(
      (name, frames) => MapEntry(
        name,
        (frames as List<dynamic>)
            .map((frame) => (frame as List<dynamic>).cast<String>().toList())
            .toList(),
      ),
    );
    return SpriteDefinition(
      id: json['id'] as String,
      sheet: sheet,
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
      anchor: SpriteAnchor.values.byName(
        json['anchor'] as String? ?? SpriteAnchor.bottomCenter.name,
      ),
      fps: (json['fps'] as num?)?.toInt() ?? defaultFps,
      palette: (json['palette'] as JsonMap).map(
        (symbol, slot) => MapEntry(symbol, slot as String),
      ),
      animations: animations,
    );
  }
}
