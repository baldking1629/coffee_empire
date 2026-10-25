import 'dart:io';

import 'package:coffee_empire/config/achievement_config.dart';
import 'package:coffee_empire/core/services/haptic_service.dart';
import 'package:coffee_empire/engine/shop_math.dart';
import 'package:coffee_empire/features/game/game_cubit.dart';
import 'package:coffee_empire/features/game/game_feedback.dart';
import 'package:coffee_empire/features/game/game_settings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/cubit_harness.dart';

class MockHaptics extends Mock implements HapticService {}

void main() {
  final catalog = AchievementCatalog.fromJsonString(
    File('assets/config/achievements.json').readAsStringSync(),
  );

  test('catalog has 20 unique achievements', () {
    expect(catalog.achievements, hasLength(20));
    expect(catalog.achievements.map((a) => a.id).toSet(), hasLength(20));
  });

  test('tapping 100 times unlocks a tap achievement that boosts income', () {
    final harness = CubitHarness();
    final cubit = GameCubit(
      config: harness.config,
      repository: harness.repository,
      clock: harness.clock,
      achievements: catalog,
      restored: harness
          .stateWithCash('0')
          .copyWith(shopLevels: {'street_cart': 10}),
    );
    final before = cubit.state.incomePerSec.toDouble();
    for (var i = 0; i < 100; i++) {
      cubit.brewTap();
    }
    expect(cubit.state.achievements, contains('eager_barista'));
    cubit.tick(0);
    final expected =
        before *
        (1 + cubit.state.achievements.length * harness.config.achievementBonus);
    expect(cubit.state.incomePerSec.toDouble(), closeTo(expected, 1e-9));
  });

  test('haptics follow the settings toggle', () async {
    final harness = CubitHarness();
    final haptics = MockHaptics();
    when(haptics.selection).thenAnswer((_) async {});
    when(haptics.medium).thenAnswer((_) async {});
    final cubit = GameCubit(
      config: harness.config,
      repository: harness.repository,
      clock: harness.clock,
      feedback: GameFeedback(haptics: haptics),
      restored: harness.stateWithCash('100'),
    );
    cubit.brewTap();
    verify(haptics.selection).called(1);
    await cubit.buyShopLevels('street_cart', BuyAmount.one);
    verify(haptics.medium).called(1);

    await cubit.updateSettings(const GameSettings(haptics: false));
    cubit.brewTap();
    verifyNever(haptics.selection);
  });
}
