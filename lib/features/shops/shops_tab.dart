import 'package:flutter/material.dart';

import '../../engine/shop_math.dart';
import 'widgets/buy_amount_selector.dart';
import 'widgets/shop_progress_path.dart';

class ShopsTab extends StatefulWidget {
  const ShopsTab({super.key});

  @override
  State<ShopsTab> createState() => _ShopsTabState();
}

class _ShopsTabState extends State<ShopsTab> {
  BuyAmount _buyAmount = BuyAmount.one;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
          child: BuyAmountSelector(
            selected: _buyAmount,
            onChanged: (amount) => setState(() => _buyAmount = amount),
          ),
        ),
        Expanded(child: ShopProgressPath(buyAmount: _buyAmount)),
      ],
    );
  }
}
