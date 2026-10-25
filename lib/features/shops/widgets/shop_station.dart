import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_theme.dart';
import '../../../config/economy_config.dart';
import '../../../engine/shop_math.dart';
import '../../game/game_cubit.dart';
import '../../game/game_state.dart';
import 'progress_road_painter.dart';
import 'shop_station_cards.dart';
import 'shop_station_data.dart';
import 'shop_station_panel.dart';

class ShopStation extends StatefulWidget {
  const ShopStation({
    super.key,
    required this.shops,
    required this.index,
    required this.buyAmount,
  });

  static const double nodeSize = 72;
  static const double nodeInset = 16 + nodeSize / 2;

  static Key glowKey(String shopId) => Key('station_glow_$shopId');
  static Key cardKey(String shopId) => Key('station_card_$shopId');

  final List<ShopConfig> shops;
  final int index;
  final BuyAmount buyAmount;

  ShopConfig get shop => shops[index];

  bool get nodeAtStart => index.isEven;

  @override
  State<ShopStation> createState() => _ShopStationState();
}

class _ShopStationState extends State<ShopStation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _glow = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );

  @override
  void dispose() {
    _glow.dispose();
    super.dispose();
  }

  void _celebrate() {
    if (MediaQuery.disableAnimationsOf(context)) return;
    _glow.forward(from: 0);
  }

  void _openPanel(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => ShopStationPanel(
        shop: widget.shop,
        index: widget.index,
        buyAmount: widget.buyAmount,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameCubit>();
    final shopId = widget.shop.id;
    final rtl = Directionality.of(context) == TextDirection.rtl;
    final isLast = widget.index == widget.shops.length - 1;
    return BlocListener<GameCubit, GameState>(
      listenWhen: (previous, current) =>
          (previous.shopLevels[shopId] ?? 0) == 0 &&
          (current.shopLevels[shopId] ?? 0) > 0,
      listener: (_, _) => _celebrate(),
      child: Stack(
        children: [
          Positioned.fill(
            child: BlocSelector<GameCubit, GameState, (bool, bool)>(
              selector: (state) => (
                isStationReachable(state, widget.shops, widget.index),
                !isLast &&
                    isStationReachable(state, widget.shops, widget.index + 1),
              ),
              builder: (context, reach) => RepaintBoundary(
                child: CustomPaint(
                  painter: ProgressRoadPainter(
                    nodeInset: ShopStation.nodeInset,
                    nodeAtStart: widget.nodeAtStart,
                    rtl: rtl,
                    hasIncoming: widget.index > 0,
                    hasOutgoing: !isLast,
                    incomingUnlocked: reach.$1,
                    outgoingUnlocked: reach.$2,
                  ),
                ),
              ),
            ),
          ),
          BlocSelector<GameCubit, GameState, ShopStationData>(
            selector: (state) => selectShopStation(
              cubit,
              state,
              widget.shop,
              widget.index,
              widget.buyAmount,
            ),
            builder: (context, data) => Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              child: Row(
                textDirection: widget.nodeAtStart
                    ? Directionality.of(context)
                    : (rtl ? TextDirection.ltr : TextDirection.rtl),
                children: [
                  StationNode(
                    shop: widget.shop,
                    data: data,
                    math: cubit.shopMath,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Directionality(
                      textDirection: Directionality.of(context),
                      child: _buildCard(context, cubit, data),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    GameCubit cubit,
    ShopStationData data,
  ) {
    final card = switch (data.status) {
      StationStatus.locked => LockedStationCard(shopId: widget.shop.id),
      _ => OpenStationCard(
        shop: widget.shop,
        data: data,
        buyAmount: widget.buyAmount,
        onOpenPanel: data.status == StationStatus.open
            ? () => _openPanel(context)
            : null,
      ),
    };
    return AnimatedBuilder(
      animation: _glow,
      builder: (context, child) {
        if (!_glow.isAnimating) return child ?? const SizedBox.shrink();
        final pulse = 1 - (2 * _glow.value - 1).abs();
        return Transform.scale(
          scale: 1 + pulse * 0.06,
          child: DecoratedBox(
            key: ShopStation.glowKey(widget.shop.id),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppTheme.cardRadius),
              boxShadow: [
                BoxShadow(
                  color: AppColors.gold.withValues(alpha: 0.7 * pulse),
                  blurRadius: 24 * pulse,
                  spreadRadius: 4 * pulse,
                ),
              ],
            ),
            child: child,
          ),
        );
      },
      child: KeyedSubtree(
        key: ShopStation.cardKey(widget.shop.id),
        child: card,
      ),
    );
  }
}
