import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

Map<String, dynamic> readArb(String code) =>
    jsonDecode(File('lib/l10n/app_$code.arb').readAsStringSync())
        as Map<String, dynamic>;

Set<String> messageKeys(Map<String, dynamic> arb) =>
    arb.keys.where((key) => !key.startsWith('@')).toSet();

Set<String> placeholdersIn(String message) => RegExp(
  r'\{([A-Za-z_]\w*)\s*[,}]',
).allMatches(message).map((match) => match.group(1) ?? '').toSet();

void main() {
  final english = readArb('en');
  final turkish = readArb('tr');

  test('en and tr define exactly the same keys', () {
    expect(messageKeys(turkish), messageKeys(english));
  });

  test('no message is blank', () {
    for (final arb in [english, turkish]) {
      for (final key in messageKeys(arb)) {
        expect((arb[key] as String).trim(), isNotEmpty, reason: key);
      }
    }
  });

  test('placeholders match the English source', () {
    for (final key in messageKeys(english)) {
      expect(
        placeholdersIn(turkish[key] as String),
        placeholdersIn(english[key] as String),
        reason: key,
      );
    }
  });
}
