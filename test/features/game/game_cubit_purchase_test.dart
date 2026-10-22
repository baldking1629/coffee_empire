import 'package:coffee_empire/core/bignumber/big_number.dart';
import 'package:coffee_empire/engine/shop_math.dart';
import 'package:coffee_empire/features/game/game_cubit.dart';
import 'package:coffee_empire/features/game/game_state.dart';
import 'package:coffee_empire/features/game/save_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/fake_clock.dart';
import '../../helpers/test_economy.dart';

class MockSaveRepository extends Mock implements SaveRepository {}

void main() {
  final config = loadTestEconomy();
  final cart = config.shops[0];
  final booth = config.shops[1];
  final shopMath = ShopMath(config.shopRules);
  late MockSaveRepository repository;

  setUpAll(
    () =>
        registerFallbackValue(GameState.initial(startingCash: BigNumber.zero)),
  );

  setUp(() {
    repository = MockSaveRepository();
    when(() => repository.save(any())).thenAnswer(
      (invocation) async => invocation.positionalArguments.first as GameState,
    );
  });

  GameCubit withCash(String cash, {Map<String, int> levels = const {}}) =>
      GameCubit(
        config: config,
        repository: repository,
        clock: FakeClock(DateTime.utc(2026, 1, 1)),
        restored: GameState.initial(
          startingCash: BigNumber.parse(cash),
        ).copyWith(shopLevels: levels),
      );

  test('buying one level deducts cost, raises income and saves', () async {
    final cubit = withCash('5');
    expect(await cubit.buyShopLevels(cart.id, BuyAmount.one), isTrue);
    expect(cubit.state.shopLevels[cart.id], 1);
    expect(cubit.state.cash.toDouble(), closeTo(5 - 4, 1e-9));
    expect(cubit.state.incomePerSec.toDouble(), closeTo(0.5, 1e-9));
    verify(() => repository.save(any())).called(1);
  });

  test('x10 buys exactly ten levels at the series cost', () async {
    final cost = shopMath.costOfN(cart, 0, 10);
    final cubit = withCash(cost.toJson());
    expect(await cubit.buyShopLevels(cart.id, BuyAmount.ten), isTrue);
    expect(cubit.state.shopLevels[cart.id], 10);
    expect(cubit.state.cash.toDouble(), closeTo(0, 1e-6));
  });

  test('MAX buys every affordable level', () async {
    final cubit = withCash('1000');
    final expected = shopMath.maxAffordable(cart, 0, BigNumber.fromInt(1000));
    expect(await cubit.buyShopLevels(cart.id, BuyAmount.max), isTrue);
    expect(cubit.state.shopLevels[cart.id], expected);
    expect(cubit.state.cash < shopMath.costOfNext(cart, expected), isTrue);
  });

  test('insufficient cash or locked shop rejects the purchase', () async {
    final poor = withCash('3');
    expect(await poor.buyShopLevels(cart.id, BuyAmount.one), isFalse);
    expect(await poor.buyShopLevels(cart.id, BuyAmount.max), isFalse);
    final rich = withCash('1e9');
    expect(await rich.buyShopLevels(booth.id, BuyAmount.one), isFalse);
    expect(rich.state.shopLevels[booth.id], isNull);
    verifyNever(() => repository.save(any()));
  });

  test('manager triples shop income and can be hired once', () async {
    final cubit = withCash('1e6', levels: {cart.id: 10});
    final before = cubit.state.incomePerSec.toDouble();
    expect(await cubit.hireManager(cart.id), isTrue);
    expect(cubit.state.incomePerSec.toDouble(), closeTo(before * 3, 1e-9));
    expect(await cubit.hireManager(cart.id), isFalse);
  });

  test('manager requires an owned shop', () async {
    final cubit = withCash('1e9');
    expect(await cubit.hireManager(cart.id), isFalse);
  });

  test('three equipment tiers each double income, no fourth', () async {
    final cubit = withCash('1e9', levels: {cart.id: 5});
    final base = cubit.state.incomePerSec.toDouble();
    for (var tier = 1; tier <= 3; tier++) {
      expect(await cubit.buyEquipment(cart.id), isTrue);
      expect(
        cubit.state.incomePerSec.toDouble(),
        closeTo(base * (1 << tier), 1e-9),
      );
    }
    expect(await cubit.buyEquipment(cart.id), isFalse);
    expect(cubit.state.equipment[cart.id], 3);
  });

  test('reaching level 25 doubles income', () async {
    final cost = shopMath.costOfNext(cart, 24);
    final cubit = withCash(cost.toJson(), levels: {cart.id: 24});
    final at24 = cubit.state.incomePerSec.toDouble();
    expect(await cubit.buyShopLevels(cart.id, BuyAmount.one), isTrue);
    expect(
      cubit.state.incomePerSec.toDouble(),
      closeTo(at24 / 24 * 25 * 2, 1e-9),
    );
  });

  test('second shop opens after the first is owned', () async {
    final cubit = withCash('1e4', levels: {cart.id: 1});
    expect(await cubit.buyShopLevels(booth.id, BuyAmount.one), isTrue);
    expect(cubit.state.shopLevels[booth.id], 1);
  });
}
