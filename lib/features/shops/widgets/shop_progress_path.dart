import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/economy_config.dart';
import '../../../engine/shop_math.dart';
import 'shop_station.dart';

class ShopProgressPath extends StatelessWidget {
  const ShopProgressPath({super.key, required this.buyAmount});

  final BuyAmount buyAmount;

  @override
  Widget build(BuildContext context) {
    final shops = context.read<EconomyConfig>().shops;
    return ListView.builder(
      padding: const EdgeInsetsDirectional.only(bottom: 16),
      itemCount: shops.length,
      itemBuilder: (context, index) => ShopStation(
        key: ValueKey(shops[index].id),
        shops: shops,
        index: index,
        buyAmount: buyAmount,
      ),
    );
  }
}
