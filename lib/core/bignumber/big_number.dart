import 'dart:math' as math;

import 'package:equatable/equatable.dart';

class BigNumber extends Equatable implements Comparable<BigNumber> {
  const BigNumber._(this.mantissa, this.exponent);

  factory BigNumber.fromDouble(double value) => _normalize(value, 0);

  factory BigNumber.fromInt(int value) => _normalize(value.toDouble(), 0);

  factory BigNumber.parse(String source) {
    final text = source.trim().toLowerCase();
    final separatorIndex = text.indexOf('e');
    if (separatorIndex < 0) {
      return BigNumber.fromDouble(double.parse(text));
    }
    final mantissaPart = double.parse(text.substring(0, separatorIndex));
    final exponentPart = int.parse(text.substring(separatorIndex + 1));
    return _normalize(mantissaPart, exponentPart);
  }

  factory BigNumber.fromJson(Object? json) => switch (json) {
    final String text => BigNumber.parse(text),
    final num value => BigNumber.fromDouble(value.toDouble()),
    _ => throw FormatException('Invalid BigNumber: $json'),
  };

  static const BigNumber zero = BigNumber._(0, 0);
  static const BigNumber one = BigNumber._(1, 0);

  static const int _maxSignificantGap = 17;

  final double mantissa;
  final int exponent;

  bool get isZero => mantissa == 0;
  bool get isNegative => mantissa < 0;

  static BigNumber _normalize(double mantissa, int exponent) {
    if (mantissa == 0 || mantissa.isNaN) {
      return zero;
    }
    if (mantissa.isInfinite) {
      throw ArgumentError.value(mantissa, 'mantissa', 'must be finite');
    }
    final magnitude = mantissa.abs();
    var shift = (math.log(magnitude) / math.ln10).floor();
    var normalized = magnitude / math.pow(10, shift);
    while (normalized >= 10) {
      normalized /= 10;
      shift++;
    }
    while (normalized < 1) {
      normalized *= 10;
      shift--;
    }
    final signed = mantissa < 0 ? -normalized : normalized;
    return BigNumber._(signed, exponent + shift);
  }

  BigNumber operator -() => BigNumber._(-mantissa, exponent);

  BigNumber abs() => isNegative ? -this : this;

  BigNumber operator +(BigNumber other) {
    if (isZero) return other;
    if (other.isZero) return this;
    final larger = exponent >= other.exponent ? this : other;
    final smaller = identical(larger, this) ? other : this;
    final gap = larger.exponent - smaller.exponent;
    if (gap > _maxSignificantGap) return larger;
    final sum =
        larger.mantissa + smaller.mantissa / math.pow(10, gap).toDouble();
    return _normalize(sum, larger.exponent);
  }

  BigNumber operator -(BigNumber other) => this + (-other);

  BigNumber operator *(BigNumber other) {
    if (isZero || other.isZero) return zero;
    return _normalize(mantissa * other.mantissa, exponent + other.exponent);
  }

  BigNumber operator /(BigNumber other) {
    if (other.isZero) {
      throw ArgumentError.value(other, 'other', 'division by zero');
    }
    if (isZero) return zero;
    return _normalize(mantissa / other.mantissa, exponent - other.exponent);
  }

  BigNumber pow(double power) {
    if (power == 0) return one;
    if (isZero) return zero;
    final resultLog = log10() * power;
    final resultExponent = resultLog.floor();
    final resultMantissa = math.pow(10, resultLog - resultExponent).toDouble();
    final isOddInteger = power == power.roundToDouble() && power.toInt().isOdd;
    final sign = isNegative && isOddInteger ? -1.0 : 1.0;
    return _normalize(sign * resultMantissa, resultExponent);
  }

  BigNumber sqrt() => pow(0.5);

  double log10() {
    if (isZero) return double.negativeInfinity;
    return math.log(mantissa.abs()) / math.ln10 + exponent;
  }

  BigNumber floor() {
    if (isZero || exponent >= 16) return this;
    if (exponent < 0) return isNegative ? -one : zero;
    return BigNumber.fromDouble(toDouble().floorToDouble());
  }

  double toDouble() {
    if (isZero) return 0;
    if (exponent > 308) {
      return isNegative ? double.negativeInfinity : double.infinity;
    }
    if (exponent < -323) return 0;
    return mantissa * math.pow(10, exponent);
  }

  BigNumber min(BigNumber other) => this <= other ? this : other;

  BigNumber max(BigNumber other) => this >= other ? this : other;

  BigNumber clampMin(BigNumber lowerBound) => max(lowerBound);

  @override
  int compareTo(BigNumber other) {
    if (isNegative != other.isNegative) {
      return isNegative ? -1 : 1;
    }
    if (isZero || other.isZero) {
      return mantissa.compareTo(other.mantissa);
    }
    final magnitudeOrder = exponent != other.exponent
        ? exponent.compareTo(other.exponent)
        : mantissa.abs().compareTo(other.mantissa.abs());
    return isNegative ? -magnitudeOrder : magnitudeOrder;
  }

  bool operator <(BigNumber other) => compareTo(other) < 0;
  bool operator >(BigNumber other) => compareTo(other) > 0;
  bool operator <=(BigNumber other) => compareTo(other) <= 0;
  bool operator >=(BigNumber other) => compareTo(other) >= 0;

  String toJson() => '${mantissa}e$exponent';

  @override
  List<Object?> get props => [mantissa, exponent];

  @override
  String toString() => toJson();
}
