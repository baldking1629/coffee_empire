import 'package:equatable/equatable.dart';

enum SpriteAnchor { bottomCenter, center, topLeft }

typedef SpriteFrame = List<String>;

class SpriteDefinition extends Equatable {
  const SpriteDefinition({
    required this.id,
    required this.sheet,
    required this.width,
    required this.height,
    required this.anchor,
    required this.fps,
    required this.palette,
    required this.animations,
  });

  static const String transparent = '.';
  static const String defaultAnimation = 'default';

  final String id;
  final String sheet;
  final int width;
  final int height;
  final SpriteAnchor anchor;
  final int fps;
  final Map<String, String> palette;
  final Map<String, List<SpriteFrame>> animations;

  String get firstAnimation => animations.containsKey(defaultAnimation)
      ? defaultAnimation
      : animations.keys.first;

  List<SpriteFrame> framesOf(String animation) =>
      animations[animation] ?? animations[firstAnimation] ?? const [];

  int frameCount(String animation) => framesOf(animation).length;

  SpriteFrame frame(String animation, int index) {
    final frames = framesOf(animation);
    return frames[index % frames.length];
  }

  @override
  List<Object?> get props => [
    id,
    sheet,
    width,
    height,
    anchor,
    fps,
    palette,
    animations,
  ];
}
