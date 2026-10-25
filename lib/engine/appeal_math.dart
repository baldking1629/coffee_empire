import 'dart:math';

import '../config/economy_config.dart';

class AppealMath {
  const AppealMath({required this.rules, required this.catalog});

  final CafeRulesConfig rules;
  final CafeCatalog catalog;

  int appealOf(Iterable<LayoutItem> placed) => placed.fold(
    0,
    (total, item) => total + (catalog.furniture[item.itemId]?.appeal ?? 0),
  );

  double multiplier(int appeal) =>
      1 + min(rules.appealCap, max(0, appeal) * rules.appealBonus);
}
