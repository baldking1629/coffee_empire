import 'package:coffee_empire/config/economy_config.dart';
import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:coffee_empire/engine/prestige_math.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const math = PrestigeMath(
    PrestigeConfig(threshold: BigNumber.one, scale: 5, beanBonus: 0.02),
  );
  final scaled = PrestigeMath(
    PrestigeConfig(
      threshold: BigNumber.parse('1e10'),
      scale: 5,
      beanBonus: 0.02,
    ),
  );

  test('below threshold gives nothing and is disabled', () {
    expect(scaled.canPrestige(BigNumber.parse('9.9e9')), isFalse);
    expect(scaled.goldenBeansFor(BigNumber.parse('9.9e9')), 0);
  });

  test('gain is floor(scale * sqrt(run / threshold))', () {
    expect(scaled.goldenBeansFor(BigNumber.parse('1e10')), 5);
    expect(scaled.goldenBeansFor(BigNumber.parse('4e10')), 10);
    expect(scaled.goldenBeansFor(BigNumber.parse('1e12')), 50);
    expect(math.goldenBeansFor(BigNumber.fromInt(3)), 8);
  });

  test('bean multiplier is 1 + beans * bonus', () {
    expect(math.beanMultiplier(0), BigNumber.one);
    expect(math.beanMultiplier(50).toDouble(), closeTo(2, 1e-12));
  });
}
