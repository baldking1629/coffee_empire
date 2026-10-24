import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app/formatters.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/time/clock.dart';
import '../../../l10n/app_localizations.dart';

class BrewCountdown extends StatefulWidget {
  const BrewCountdown({super.key, required this.endsAt, required this.clock});

  final DateTime endsAt;
  final Clock clock;

  @override
  State<BrewCountdown> createState() => _BrewCountdownState();
}

class _BrewCountdownState extends State<BrewCountdown> {
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => setState(() {}));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final remaining = widget.endsAt.difference(widget.clock.now());
    final safeRemaining = remaining.isNegative ? Duration.zero : remaining;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox.square(
          dimension: 14,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.copper,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            AppLocalizations.of(context).brewingRemaining(
              durationFormatterOf(context).format(safeRemaining),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: AppColors.copper),
          ),
        ),
      ],
    );
  }
}
