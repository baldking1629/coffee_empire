import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:flutter_test/flutter_test.dart';

BigNumber big(String source) => BigNumber.parse(source);

void expectClose(BigNumber actual, BigNumber expected) {
  expect(actual.exponent, expected.exponent, reason: '$actual vs $expected');
  expect(actual.mantissa, closeTo(expected.mantissa, 1e-9));
}

void main() {
  group('construction', () {
    test('normalizes mantissa into [1, 10)', () {
      final value = BigNumber.fromDouble(12345);
      expect(value.mantissa, closeTo(1.2345, 1e-12));
      expect(value.exponent, 4);
    });

    test('exact powers of ten normalize cleanly', () {
      expect(BigNumber.fromInt(1000), big('1e3'));
      expect(BigNumber.fromDouble(0.001), big('1e-3'));
    });

    test('zero is canonical', () {
      expect(BigNumber.fromInt(0), BigNumber.zero);
      expect(BigNumber.zero.isZero, isTrue);
      expect(big('0e50'), BigNumber.zero);
    });

    test('parse accepts plain and scientific forms', () {
      expect(big('1.5e12').mantissa, 1.5);
      expect(big('1.5e12').exponent, 12);
      expect(big('250'), BigNumber.fromInt(250));
      expect(big('15e11'), big('1.5e12'));
    });
  });

  group('arithmetic', () {
    test('adds values with different exponents', () {
      expectClose(big('1e3') + big('5e1'), big('1.05e3'));
      expectClose(big('9e2') + big('2e2'), big('1.1e3'));
    });

    test('adding a negligible value keeps the larger one', () {
      expect(big('1e100') + big('1e10'), big('1e100'));
      expect(big('1e10') + big('1e100'), big('1e100'));
    });

    test('adding zero returns the other operand', () {
      expect(BigNumber.zero + big('3e5'), big('3e5'));
      expect(big('3e5') + BigNumber.zero, big('3e5'));
    });

    test('subtracts', () {
      expectClose(big('1e3') - big('1e2'), big('9e2'));
      expect(big('5e7') - big('5e7'), BigNumber.zero);
      expect((big('1e2') - big('3e2')).isNegative, isTrue);
    });

    test('multiplies and divides', () {
      expectClose(big('2e3') * big('3e4'), big('6e7'));
      expectClose(big('5e5') * big('4e5'), big('2e11'));
      expectClose(big('6e7') / big('3e4'), big('2e3'));
      expectClose(big('1e0') / big('4e0'), big('2.5e-1'));
      expect(big('5e5') * BigNumber.zero, BigNumber.zero);
    });

    test('division by zero throws', () {
      expect(() => BigNumber.one / BigNumber.zero, throwsArgumentError);
    });

    test('pow, sqrt and log10', () {
      expectClose(big('2e0').pow(10), big('1.024e3'));
      expectClose(big('1e10').pow(0.5), big('1e5'));
      expectClose(big('1.6e1').sqrt(), big('4e0'));
      expect(big('1e300').log10(), closeTo(300, 1e-9));
      expect(BigNumber.zero.log10(), double.negativeInfinity);
      expect(big('7e3').pow(0), BigNumber.one);
      expect(BigNumber.zero.pow(3), BigNumber.zero);
    });

    test('floor', () {
      expect(big('1.2345e2').floor(), BigNumber.fromInt(123));
      expect(big('5e-1').floor(), BigNumber.zero);
      expect(big('1.5e40').floor(), big('1.5e40'));
    });

    test('min, max and clampMin', () {
      expect(big('1e3').min(big('1e4')), big('1e3'));
      expect(big('1e3').max(big('1e4')), big('1e4'));
      expect(big('-5e0').clampMin(BigNumber.zero), BigNumber.zero);
    });
  });

  group('huge values', () {
    test('operate beyond 1e300 without overflow', () {
      final product = big('5e300') * big('4e300');
      expectClose(product, big('2e601'));
      expectClose(product / big('2e600'), big('1e1'));
      expectClose(product + big('2e601'), big('4e601'));
      expect(product > big('9.99e600'), isTrue);
    });

    test('toDouble overflows to infinity', () {
      expect(big('1e400').toDouble(), double.infinity);
      expect(big('1.5e3').toDouble(), 1500);
      expect(big('1e-400').toDouble(), 0);
    });
  });

  group('comparison', () {
    test('orders by sign, exponent and mantissa', () {
      expect(big('1e5') > big('9e4'), isTrue);
      expect(big('2e5') > big('1e5'), isTrue);
      expect(big('-1e5') < big('1e0'), isTrue);
      expect(big('-1e5') < big('-1e4'), isTrue);
      expect(BigNumber.zero < big('1e-5'), isTrue);
      expect(BigNumber.zero > big('-1e-5'), isTrue);
      expect(big('3e3') <= big('3e3'), isTrue);
      expect(big('3e3') >= big('3e3'), isTrue);
      expect(big('3e3').compareTo(big('3e3')), 0);
    });
  });

  group('serialization', () {
    test('round-trips through json', () {
      for (final source in ['1.5e12', '0', '7.77e-3', '9.87654321e450']) {
        final value = big(source);
        expect(BigNumber.fromJson(value.toJson()), value);
      }
      expect(big('1.5e12').toJson(), '1.5e12');
    });

    test('fromJson accepts numbers and rejects garbage', () {
      expect(BigNumber.fromJson(42), BigNumber.fromInt(42));
      expect(() => BigNumber.fromJson(true), throwsFormatException);
    });
  });
}
