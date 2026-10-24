import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

const supportedLanguages = [
  'en',
  'tr',
  'es',
  'pt',
  'fr',
  'de',
  'it',
  'ru',
  'ar',
  'hi',
  'id',
  'ja',
  'ko',
  'zh',
  'vi',
];
const reviewLanguages = ['ar', 'ru', 'ja', 'ko', 'zh', 'hi'];
const sameEverywhere = {'appTitle', 'buyAmountOne', 'buyAmountTen'};

Map<String, dynamic> readArb(String code) =>
    jsonDecode(File('lib/l10n/app_$code.arb').readAsStringSync())
        as Map<String, dynamic>;

Set<String> messageKeys(Map<String, dynamic> arb) =>
    arb.keys.where((key) => !key.startsWith('@')).toSet();

Set<String> placeholdersIn(String message) => RegExp(
  r'\{([A-Za-z_]\w*)\s*[,}]',
).allMatches(message).map((match) => match.group(1) ?? '').toSet();

bool isPlural(String message) => message.contains(', plural,');

void main() {
  final english = readArb('en');
  final arbs = {for (final code in supportedLanguages) code: readArb(code)};

  test('every language has an ARB file', () {
    final files = Directory('lib/l10n')
        .listSync()
        .map((file) => file.uri.pathSegments.last)
        .where((name) => name.endsWith('.arb'))
        .toSet();
    expect(files, {for (final code in supportedLanguages) 'app_$code.arb'});
  });

  for (final code in supportedLanguages) {
    group(code, () {
      final arb = arbs[code] ?? const {};

      test('defines exactly the English keys', () {
        expect(messageKeys(arb), messageKeys(english));
      });

      test('has no blank messages', () {
        for (final key in messageKeys(arb)) {
          expect((arb[key] as String).trim(), isNotEmpty, reason: key);
        }
      });

      test('keeps placeholders and plural structure', () {
        for (final key in messageKeys(english)) {
          final source = english[key] as String;
          final translated = arb[key] as String;
          expect(
            placeholdersIn(translated),
            placeholdersIn(source),
            reason: key,
          );
          expect(isPlural(translated), isPlural(source), reason: key);
        }
      });
    });
  }

  test('report messages still identical to English', () {
    for (final code in reviewLanguages) {
      final arb = arbs[code] ?? const {};
      final untranslated = messageKeys(english)
          .where((key) => !sameEverywhere.contains(key))
          .where((key) => !key.startsWith('languageNative_'))
          .where((key) => arb[key] == english[key])
          .toList();
      if (untranslated.isNotEmpty) {
        debugPrint('[l10n] $code identical to en: ${untranslated.join(', ')}');
      }
    }
  });
}
