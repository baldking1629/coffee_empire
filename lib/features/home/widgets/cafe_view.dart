import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/formatters.dart';
import '../../../cafe/cafe_bridge.dart';
import '../../../cafe/cafe_game.dart';
import '../../../config/economy_config.dart';
import '../../../l10n/app_localizations.dart';
import '../../../pixel/sprite_atlas.dart';
import '../../cafe_hud/brew_panel.dart';
import '../../cafe_hud/service_hud.dart';
import '../../game/game_cubit.dart';

class CafeView extends StatefulWidget {
  const CafeView({super.key, required this.active, this.bottomOverlay});

  final bool active;
  final Widget? bottomOverlay;

  @override
  State<CafeView> createState() => CafeViewState();
}

class CafeViewState extends State<CafeView> {
  late final CafeBridge bridge = CafeBridge(cubit: context.read<GameCubit>());
  late final CafeGame game = CafeGame(
    atlas: context.read<SpriteAtlas>(),
    catalog: context.read<CafeCatalog>(),
    service: context.read<EconomyConfig>().service,
    bridge: bridge,
  );
  late final AppLifecycleListener _lifecycle;

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
      game.pauseEngine();
    }
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    bridge.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameCubit>();
    final formatter = numberFormatterOf(
      context,
      scientific: cubit.state.settings.scientific,
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
        if (widget.bottomOverlay case final overlay?)
          PositionedDirectional(start: 0, end: 0, bottom: 0, child: overlay),
        PositionedDirectional(
          top: 0,
          start: 0,
          end: 0,
          child: ServiceHud(bridge: bridge),
        ),
        PositionedDirectional(
          start: 0,
          end: 0,
          bottom: 0,
          child: BrewPanel(bridge: bridge),
        ),
      ],
    );
  }
}
