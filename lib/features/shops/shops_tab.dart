import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/economy_config.dart';
import '../../engine/shop_math.dart';
import 'widgets/buy_amount_selector.dart';
import 'widgets/shop_card.dart';

class ShopsTab extends StatefulWidget {
  const ShopsTab({super.key});

  @override
  State<ShopsTab> createState() => _ShopsTabState();
}

class _ShopsTabState extends State<ShopsTab> {
  BuyAmount _buyAmount = BuyAmount.one;

  @override
  Widget build(BuildContext context) {
    final shops = context.read<EconomyConfig>().shops;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
          child: BuyAmountSelector(
            selected: _buyAmount,
            onChanged: (amount) => setState(() => _buyAmount = amount),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
            itemCount: shops.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) => ShopCard(
              key: ValueKey(shops[index].id),
              shop: shops[index],
              index: index,
              previousShopId: index == 0 ? null : shops[index - 1].id,
              buyAmount: _buyAmount,
            ),
          ),
        ),
      ],
    );
  }
}
