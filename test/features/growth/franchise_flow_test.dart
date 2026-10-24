import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/cubit_harness.dart';

void main() {
  late CubitHarness harness;

  setUp(() => harness = CubitHarness());

  test('city needs brand hype before opening', () async {
    final cubit = harness.build(harness.stateWithCash('1e30'));
    expect(await cubit.openFranchise('vienna'), isFalse);
  });

  test('opening slots charges growing costs and stops at the limit', () async {
    final cubit = harness.build(
      harness
          .stateWithCash('1e30')
          .copyWith(
            lifetimeEarnings: BigNumber.parse('1e20'),
            shopLevels: {'street_cart': 50},
          ),
    );
    final before = cubit.state.incomePerSec;
    expect(await cubit.openFranchise('vienna'), isTrue);
    expect(cubit.state.franchises['vienna'], 1);
    expect(cubit.state.incomePerSec > before, isTrue);
    expect(await cubit.openFranchise('vienna'), isFalse);

    for (var slot = 0; slot < 5; slot++) {
      expect(await cubit.openFranchise('istanbul'), isTrue);
    }
    expect(await cubit.openFranchise('istanbul'), isFalse);
    expect(cubit.state.franchises['istanbul'], 5);
  });
}
