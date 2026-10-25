import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../app/formatters.dart';
import '../../../cafe/cafe_bridge.dart';
import '../../../cafe/cafe_game.dart';
import '../../../config/economy_config.dart';
import '../../../l10n/app_localizations.dart';
import '../../../pixel/sprite_atlas.dart';
import '../../cafe_hud/brew_panel.dart';
import '../../cafe_hud/service_hud.dart';
import '../../customize/edit_toolbar.dart';
import '../../customize/scene_corner_button.dart';
import '../../customize/theme_picker.dart';
import '../../game/game_cubit.dart';

class CafeView extends StatefulWidget {
  const CafeView({super.key, required this.active, this.bottomOverlay});

  static const Key editButtonKey = Key('edit_layout_button');
  static const Key appearanceButtonKey = Key('appearance_button');

  final bool active;
  final Widget? bottomOverlay;

  @override
  State<CafeView> createState() => CafeViewState();
}

class CafeViewState extends State<CafeView> {
  late final GameCubit _cubit = context.read<GameCubit>();
  late final CafeBridge bridge = CafeBridge(cubit: _cubit);
  late final CafeGame game = CafeGame(
    atlas: context.read<SpriteAtlas>(),
    catalog: _cubit.engine.config.cafe,
    service: context.read<EconomyConfig>().service,
    bridge: bridge,
    room: _cubit.cafeRoom,
    items: _cubit.state.cafeLayout.items,
  );
  late final AppLifecycleListener _lifecycle;
  bool _editing = false;

  bool get isEditing => _editing;

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(onResume: bridge.resetCafe);
    if (!widget.active) game.pauseEngine();
  }

  @override
  void didUpdateWidget(CafeView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.active == widget.active) return;
    if (widget.active) {
      game.resumeEngine();
    } else {
      setEditing(false);
      game.pauseEngine();
    }
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    bridge.dispose();
    super.dispose();
  }

  void setEditing(bool editing) {
    if (_editing == editing) return;
    bridge.setEditing(editing);
    if (mounted) setState(() => _editing = editing);
  }

  @override
  Widget build(BuildContext context) {
    final formatter = numberFormatterOf(
      context,
      scientific: _cubit.state.settings.scientific,
    );
    final l10n = AppLocalizations.of(context);
    bridge
      ..formatGain = ((amount) =>
          l10n.floatingGain(formatter.formatMoney(amount)))
      ..perfectLabel = l10n.perfectServe
      ..reduceMotion = MediaQuery.disableAnimationsOf(context);
    return Stack(
      children: [
        Positioned.fill(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: RepaintBoundary(child: GameWidget(game: game)),
          ),
        ),
        if (!_editing)
          if (widget.bottomOverlay case final overlay?)
            PositionedDirectional(start: 0, end: 0, bottom: 0, child: overlay),
        PositionedDirectional(
          top: 0,
          start: 0,
          end: 0,
          child: ServiceHud(bridge: bridge),
        ),
        PositionedDirectional(
          top: 8,
          end: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SceneCornerButton(
                key: CafeView.editButtonKey,
                icon: _editing ? LucideIcons.check : LucideIcons.hammer,
                label: _editing ? l10n.editDone : l10n.editLayout,
                highlighted: _editing,
                onPressed: () => setEditing(!_editing),
              ),
              if (!_editing) ...[
                const SizedBox(height: 8),
                SceneCornerButton(
                  key: CafeView.appearanceButtonKey,
                  icon: LucideIcons.palette,
                  label: l10n.appearanceButton,
                  onPressed: () => showAppearanceSheet(context),
                ),
              ],
            ],
          ),
        ),
        PositionedDirectional(
          start: 0,
          end: 0,
          bottom: 0,
          child: _editing
              ? EditToolbar(
                  editor: bridge.editor,
                  onDone: () => setEditing(false),
                )
              : BrewPanel(bridge: bridge),
        ),
      ],
    );
  }
}
