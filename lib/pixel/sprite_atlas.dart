import 'dart:ui' as ui;

import 'package:flutter/services.dart';

import 'palette_set.dart';
import 'sprite_definition.dart';
import 'sprite_definition_parser.dart';
import 'sprite_rasterizer.dart';

class SpriteAtlas {
  SpriteAtlas({
    required List<SpriteDefinition> sprites,
    required this.palettes,
    this.rasterizer = const SpriteRasterizer(),
  }) : sprites = {for (final sprite in sprites) sprite.id: sprite};

  static const String directory = 'assets/sprites';
  static const String paletteFile = 'palettes';
  static const List<String> sheetFiles = [
    'tiles',
    'furniture',
    'machines',
    'characters',
    'ui_icons',
  ];

  static Future<SpriteAtlas> load(AssetBundle bundle) async {
    const parser = SpriteDefinitionParser();
    final palettes = PaletteCatalog.fromJsonString(
      await bundle.loadString('$directory/$paletteFile.json'),
    );
    final sprites = <SpriteDefinition>[];
    for (final sheet in sheetFiles) {
      final source = await bundle.loadString('$directory/$sheet.json');
      sprites.addAll(parser.parseSheet(sheet, source));
    }
    return SpriteAtlas(sprites: sprites, palettes: palettes);
  }

  final Map<String, SpriteDefinition> sprites;
  final PaletteCatalog palettes;
  final SpriteRasterizer rasterizer;
  final Map<String, ui.Image> _cache = {};

  int get cachedCount => _cache.length;

  Iterable<String> idsInSheet(String sheet) => sprites.values
      .where((sprite) => sprite.sheet == sheet)
      .map((sprite) => sprite.id);

  SpriteDefinition definition(String spriteId) {
    final sprite = sprites[spriteId];
    if (sprite == null) {
      throw ArgumentError.value(spriteId, 'spriteId', 'unknown sprite');
    }
    return sprite;
  }

  ui.Image get(
    String spriteId, {
    String? animation,
    int frame = 0,
    String paletteKey = PaletteCatalog.baseSet,
    bool flipX = false,
  }) {
    final sprite = definition(spriteId);
    final animationName = animation ?? sprite.firstAnimation;
    final frameIndex = frame % sprite.frameCount(animationName);
    final key = '$spriteId|$animationName|$frameIndex|$paletteKey|$flipX';
    return _cache.putIfAbsent(
      key,
      () => rasterizer.rasterize(
        rows: sprite.frame(animationName, frameIndex),
        width: sprite.width,
        height: sprite.height,
        symbols: sprite.palette,
        colors: palettes.resolve(paletteKey),
        flipX: flipX,
      ),
    );
  }

  int warmUp({String paletteKey = PaletteCatalog.baseSet}) {
    var drawn = 0;
    for (final sprite in sprites.values) {
      for (final animation in sprite.animations.keys) {
        for (var frame = 0; frame < sprite.frameCount(animation); frame++) {
          get(
            sprite.id,
            animation: animation,
            frame: frame,
            paletteKey: paletteKey,
          );
          drawn++;
        }
      }
    }
    return drawn;
  }
}
