import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import '../../pixel/palette_set.dart';
import '../../pixel/sprite_atlas.dart';
import '../../pixel/pixel_image.dart';
import '../../pixel/sprite_definition.dart';

class SpriteGalleryScreen extends StatefulWidget {
  const SpriteGalleryScreen({super.key});

  static const int scale = 4;

  @override
  State<SpriteGalleryScreen> createState() => _SpriteGalleryScreenState();
}

class _SpriteGalleryScreenState extends State<SpriteGalleryScreen>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker = createTicker(
    (elapsed) => setState(() => _elapsed = elapsed),
  )..start();
  Duration _elapsed = Duration.zero;
  final Set<String> _overlays = {};

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final atlas = context.read<SpriteAtlas>();
    final paletteKey = PaletteCatalog.keyOf(_overlays);
    final overlayNames = atlas.palettes.sets.keys
        .where((name) => name != PaletteCatalog.baseSet)
        .toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: Text(AppLocalizations.of(context).spriteGalleryTitle),
      ),
      body: ListView(
        padding: const EdgeInsetsDirectional.all(16),
        children: [
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final name in overlayNames)
                FilterChip(
                  label: Text(name),
                  selected: _overlays.contains(name),
                  onSelected: (selected) => setState(
                    () =>
                        selected ? _overlays.add(name) : _overlays.remove(name),
                  ),
                ),
            ],
          ),
          for (final sheet in SpriteAtlas.sheetFiles) ...[
            const SizedBox(height: 16),
            Text(sheet, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final id in atlas.idsInSheet(sheet))
                  _SpriteCard(
                    sprite: atlas.definition(id),
                    atlas: atlas,
                    paletteKey: paletteKey,
                    elapsed: _elapsed,
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _SpriteCard extends StatelessWidget {
  const _SpriteCard({
    required this.sprite,
    required this.atlas,
    required this.paletteKey,
    required this.elapsed,
  });

  final SpriteDefinition sprite;
  final SpriteAtlas atlas;
  final String paletteKey;
  final Duration elapsed;

  @override
  Widget build(BuildContext context) {
    final frameIndex =
        (elapsed.inMilliseconds * sprite.fps / Duration.millisecondsPerSecond)
            .floor();
    return Container(
      key: Key('gallery_${sprite.id}'),
      padding: const EdgeInsetsDirectional.all(8),
      decoration: AppTheme.cardDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            spacing: 8,
            children: [
              for (final animation in sprite.animations.keys)
                PixelImage(
                  image: atlas.get(
                    sprite.id,
                    animation: animation,
                    frame: frameIndex,
                    paletteKey: paletteKey,
                  ),
                  scale: SpriteGalleryScreen.scale,
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(sprite.id, style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
    );
  }
}
