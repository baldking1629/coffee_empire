import 'package:flutter/widgets.dart';

import '../core/format/duration_formatter.dart';
import '../core/format/number_formatter.dart';
import '../l10n/app_localizations.dart';

NumberFormatter numberFormatterOf(
  BuildContext context, {
  required bool scientific,
}) => NumberFormatter(
  languageCode: Localizations.localeOf(context).languageCode,
  scientific: scientific,
);

DurationFormatter durationFormatterOf(BuildContext context) {
  final l10n = AppLocalizations.of(context);
  return DurationFormatter(
    DurationUnitLabels(
      days: l10n.durationDays,
      hours: l10n.durationHours,
      minutes: l10n.durationMinutes,
      seconds: l10n.durationSeconds,
    ),
  );
}
