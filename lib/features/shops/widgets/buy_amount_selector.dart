import 'package:flutter/material.dart';

import '../../../engine/shop_math.dart';
import '../../../l10n/app_localizations.dart';

class BuyAmountSelector extends StatelessWidget {
  const BuyAmountSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final BuyAmount selected;
  final ValueChanged<BuyAmount> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SegmentedButton<BuyAmount>(
      showSelectedIcon: false,
      style: const ButtonStyle(visualDensity: VisualDensity.compact),
      segments: [
        ButtonSegment(value: BuyAmount.one, label: Text(l10n.buyAmountOne)),
        ButtonSegment(value: BuyAmount.ten, label: Text(l10n.buyAmountTen)),
        ButtonSegment(value: BuyAmount.max, label: Text(l10n.buyAmountMax)),
      ],
      selected: {selected},
      onSelectionChanged: (selection) => onChanged(selection.first),
    );
  }
}
