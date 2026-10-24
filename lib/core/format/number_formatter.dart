import 'dart:math' as math;

import '../bignumber/big_number.dart';
import 'decimal_separators.dart';

class NumberFormatter {
  NumberFormatter({
    required String languageCode,
    this.scientific = false,
    this.isolateLeftToRight = false,
  }) : decimalSeparator = decimalSeparatorFor(languageCode);

  static const String currencySymbol = r'$';
  static const List<String> namedSuffixes = [
    '',
    'K',
    'M',
    'B',
    'T',
    'Qa',
    'Qi',
    'Sx',
    'Sp',
    'Oc',
    'No',
    'Dc',
  ];
  static const int _alphabetLength = 26;
  static const int _letterCodeA = 97;
  static const String _leftToRightIsolate = '\u2066';
  static const String _popDirectionalIsolate = '\u2069';

  final String decimalSeparator;
  final bool scientific;
  final bool isolateLeftToRight;

  String formatMoney(BigNumber value) {
    final sign = value.isNegative ? '-' : '';
    return _isolate('$sign$currencySymbol${_formatPlain(value.abs())}');
  }

  String format(BigNumber value) => _isolate(_formatPlain(value));

  String _isolate(String text) => isolateLeftToRight
      ? '$_leftToRightIsolate$text$_popDirectionalIsolate'
      : text;

  String _formatPlain(BigNumber value) {
    if (value.isNegative) return '-${_formatPlain(value.abs())}';
    if (value.isZero) return '0';
    if (value.exponent < 3) {
      final small = _formatSmall(value.toDouble());
      if (small != null) return small;
    }
    final rounded = _roundToThreeSignificant(value);
    if (scientific) {
      return _withSeparator(
        '${rounded.mantissa.toStringAsFixed(2)}e'
        '${rounded.exponent}',
      );
    }
    final tier = rounded.exponent ~/ 3;
    final suffix = suffixForTier(tier);
    if (suffix == null) {
      return _withSeparator(
        '${rounded.mantissa.toStringAsFixed(2)}e'
        '${rounded.exponent}',
      );
    }
    final integerDigits = rounded.exponent % 3;
    final scaled = rounded.mantissa * math.pow(10, integerDigits);
    return _withSeparator(
      '${scaled.toStringAsFixed(2 - integerDigits)}$suffix',
    );
  }

  static String? suffixForTier(int tier) {
    if (tier < namedSuffixes.length) return namedSuffixes[tier];
    final letterIndex = tier - namedSuffixes.length;
    if (letterIndex >= _alphabetLength * _alphabetLength) return null;
    final first = String.fromCharCode(
      _letterCodeA + letterIndex ~/ _alphabetLength,
    );
    final second = String.fromCharCode(
      _letterCodeA + letterIndex % _alphabetLength,
    );
    return '$first$second';
  }

  String? _formatSmall(double value) {
    final fixed = value.toStringAsFixed(2);
    if (double.parse(fixed) >= 1000) return null;
    var trimmed = fixed;
    if (trimmed.contains('.')) {
      trimmed = trimmed.replaceFirst(RegExp(r'0+$'), '');
      trimmed = trimmed.replaceFirst(RegExp(r'\.$'), '');
    }
    return _withSeparator(trimmed);
  }

  BigNumber _roundToThreeSignificant(BigNumber value) {
    final roundedMantissa = (value.mantissa * 100).round() / 100;
    if (roundedMantissa >= 10) {
      return BigNumber.parse('1e${value.exponent + 1}');
    }
    return BigNumber.parse('${roundedMantissa}e${value.exponent}');
  }

  String _withSeparator(String text) =>
      decimalSeparator == '.' ? text : text.replaceFirst('.', decimalSeparator);
}
