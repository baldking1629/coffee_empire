import 'dart:io';

import 'package:coffee_empire/pixel/palette_set.dart';
import 'package:coffee_empire/pixel/sprite_atlas.dart';
import 'package:coffee_empire/pixel/sprite_definition.dart';
import 'package:coffee_empire/pixel/sprite_definition_parser.dart';

String readSpriteFile(String name) =>
    File('${SpriteAtlas.directory}/$name.json').readAsStringSync();

PaletteCatalog loadPalettes() =>
    PaletteCatalog.fromJsonString(readSpriteFile(SpriteAtlas.paletteFile));

List<SpriteDefinition> loadSprites() => [
  for (final sheet in SpriteAtlas.sheetFiles)
    ...const SpriteDefinitionParser().parseSheet(sheet, readSpriteFile(sheet)),
];

SpriteAtlas loadAtlas() =>
    SpriteAtlas(sprites: loadSprites(), palettes: loadPalettes());
