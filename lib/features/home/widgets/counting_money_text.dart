import 'package:flutter/material.dart';

import '../../../core/bignumber/big_number.dart';
import '../../../core/format/number_formatter.dart';

class CountingMoneyText extends StatefulWidget {
  const CountingMoneyText({
    super.key,
    required this.value,
    required this.formatter,
    this.style,
    this.textKey,
  });

  static const Duration duration = Duration(milliseconds: 400);

  final BigNumber value;
  final NumberFormatter formatter;
  final TextStyle? style;
  final Key? textKey;

  @override
  State<CountingMoneyText> createState() => _CountingMoneyTextState();
}

class _CountingMoneyTextState extends State<CountingMoneyText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _count = AnimationController(
    vsync: this,
    duration: CountingMoneyText.duration,
    value: 1,
  );
  late BigNumber _from = widget.value;

  BigNumber get _displayed {
    final progress = Curves.easeOut.transform(_count.value);
    if (progress >= 1) return widget.value;
    return _from + (widget.value - _from) * BigNumber.fromDouble(progress);
  }

  @override
  void didUpdateWidget(CountingMoneyText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value == widget.value) return;
    if (MediaQuery.disableAnimationsOf(context)) {
      _count.value = 1;
      return;
    }
    _from = _displayedFor(oldWidget.value);
    _count.forward(from: 0);
  }

  BigNumber _displayedFor(BigNumber previousTarget) {
    final progress = Curves.easeOut.transform(_count.value);
    if (progress >= 1) return previousTarget;
    return _from + (previousTarget - _from) * BigNumber.fromDouble(progress);
  }

  @override
  void dispose() {
    _count.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _count,
      builder: (context, _) => Text(
        key: widget.textKey,
        widget.formatter.formatMoney(_displayed.clampMin(BigNumber.zero)),
        textDirection: TextDirection.ltr,
        style: widget.style,
      ),
    );
  }
}
