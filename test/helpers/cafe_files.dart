import 'dart:io';

import 'package:coffee_empire/config/economy_config.dart';
import 'package:coffee_empire/pixel/sprite_atlas.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sprite_files.dart';

CafeCatalog loadCafeCatalog() => CafeCatalog.fromJsonString(
  File('assets/config/furniture.json').readAsStringSync(),
);

final SpriteAtlas testAtlas = loadAtlas();

List<RepositoryProvider<Object>> cafeProviders() => [
  RepositoryProvider<SpriteAtlas>.value(value: testAtlas),
];
