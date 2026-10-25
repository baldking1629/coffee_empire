import 'dart:ui';

import 'package:equatable/equatable.dart';

import '../pixel/palette_set.dart';

class SceneLook extends Equatable {
  const SceneLook({
    this.floorPaletteKey = PaletteCatalog.baseSet,
    this.signSpriteId = 'sign',
    this.lightTint = const Color(0xFFFFFFFF),
    this.lightIntensity = 0,
    this.playerOutfit = PaletteCatalog.baseSet,
    this.npcOutfits = const [],
    this.machineLevel = 0,
  });

  final String floorPaletteKey;
  final String signSpriteId;
  final Color lightTint;
  final double lightIntensity;
  final String playerOutfit;
  final List<String> npcOutfits;
  final int machineLevel;

  String npcOutfit(int index) =>
      index < npcOutfits.length ? npcOutfits[index] : PaletteCatalog.baseSet;

  @override
  List<Object?> get props => [
    floorPaletteKey,
    signSpriteId,
    lightTint,
    lightIntensity,
    playerOutfit,
    npcOutfits,
    machineLevel,
  ];
}
