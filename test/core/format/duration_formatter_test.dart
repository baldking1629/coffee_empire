import 'package:coffee_empire/core/format/duration_formatter.dart';
import 'package:coffee_empire/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

DurationFormatter formatterFor(String languageCode) {
  final l10n = lookupAppLocalizations(Locale(languageCode));
  return DurationFormatter(
    DurationUnitLabels(
      days: l10n.durationDays,
      hours: l10n.durationHours,
      minutes: l10n.durationMinutes,
      seconds: l10n.durationSeconds,
    ),
  );
}

void main() {
  final en = formatterFor('en');
  final tr = formatterFor('tr');

  test('shows two largest units in English', () {
    expect(en.format(const Duration(days: 1, hours: 4)), '1d 4h');
    expect(en.format(const Duration(minutes: 12, seconds: 30)), '12m 30s');
    expect(en.format(const Duration(seconds: 7)), '7s');
    expect(en.format(const Duration(hours: 2)), '2h');
  });

  test('uses Turkish units', () {
    expect(tr.format(const Duration(days: 1, hours: 4)), '1g 4sa');
    expect(tr.format(const Duration(minutes: 12, seconds: 30)), '12dk 30sn');
  });

  test('negative duration is zero', () {
    expect(en.format(const Duration(seconds: -5)), '0s');
  });
}
