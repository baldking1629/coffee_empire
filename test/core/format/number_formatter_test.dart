import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:coffee_empire/core/format/number_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final en = NumberFormatter(languageCode: 'en');
  final tr = NumberFormatter(languageCode: 'tr');

  String fmt(String value, [NumberFormatter? formatter]) =>
      (formatter ?? en).format(BigNumber.parse(value));

  test('small values drop trailing zeros', () {
    expect(fmt('12.5'), '12.5');
    expect(fmt('999'), '999');
    expect(fmt('3.14159'), '3.14');
    expect(fmt('0'), '0');
    expect(fmt('5'), '5');
  });

  test('suffixes with three significant digits', () {
    expect(en.formatMoney(BigNumber.parse('1250')), r'$1.25K');
    expect(en.formatMoney(BigNumber.parse('4.5e6')), r'$4.50M');
    expect(en.formatMoney(BigNumber.parse('1.24e10')), r'$12.4B');
    expect(fmt('9.99e14'), '999T');
    expect(fmt('1e33'), '1.00Dc');
  });

  test('rounding carries into next tier', () {
    expect(fmt('999.999'), '1.00K');
    expect(fmt('999999'), '1.00M');
  });

  test('letter suffixes after Dc', () {
    expect(fmt('1e36'), '1.00aa');
    expect(fmt('1e39'), '1.00ab');
    expect(fmt('1e114'), '1.00ba');
    expect(NumberFormatter.suffixForTier(12), 'aa');
    expect(NumberFormatter.suffixForTier(38), 'ba');
  });

  test('language decides decimal separator', () {
    expect(tr.formatMoney(BigNumber.parse('1250')), r'$1,25K');
    expect(fmt('12.5', tr), '12,5');
    expect(fmt('12.5', NumberFormatter(languageCode: 'ja')), '12.5');
    expect(fmt('12.5', NumberFormatter(languageCode: 'xx')), '12.5');
  });

  test('scientific option', () {
    final scientific = NumberFormatter(languageCode: 'en', scientific: true);
    expect(fmt('1.25e15', scientific), '1.25e15');
    expect(fmt('12.5', scientific), '12.5');
  });

  test('negative values keep sign before currency', () {
    expect(en.formatMoney(BigNumber.parse('-1500')), r'-$1.50K');
  });

  test('right-to-left isolation keeps money left-to-right', () {
    final arabic = NumberFormatter(
      languageCode: 'ar',
      isolateLeftToRight: true,
    );
    expect(arabic.formatMoney(BigNumber.parse('1250')), '\u2066\$1.25K\u2069');
    expect(en.formatMoney(BigNumber.parse('1250')), r'$1.25K');
  });
}
