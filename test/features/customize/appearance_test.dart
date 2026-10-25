import 'package:coffee_empire/cafe/actors/barista_component.dart';
import 'package:coffee_empire/cafe/world/floor_layer.dart';
import 'package:coffee_empire/cafe/world/furniture_component.dart';
import 'package:coffee_empire/cafe/world/light_overlay.dart';
import 'package:coffee_empire/cafe/world/machine_component.dart';
import 'package:coffee_empire/cafe/world/pixel_sprite_component.dart';
import 'package:coffee_empire/config/economy_config.dart';
import 'package:coffee_empire/features/customize/cosmetic_tile.dart';
import 'package:coffee_empire/features/customize/theme_picker.dart';
import 'package:coffee_empire/features/home/widgets/cafe_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/cafe_driver.dart';
import '../../helpers/cafe_files.dart';
import '../../helpers/cubit_harness.dart';
import '../../helpers/pump_app.dart';

void main() {
  Future<void> pumpCafe(
    WidgetTester tester,
    CubitHarness harness,
    cubit,
  ) async {
    tester.view.physicalSize = const Size(1179, 2556);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await pumpWithGame(
      tester,
      config: harness.config,
      cubit: cubit,
      child: const CafeView(active: true),
    );
    await tester.pump(const Duration(milliseconds: 100));
  }

  testWidgets('themes repaint the scene by palette swap only', (tester) async {
    final harness = CubitHarness();
    final cubit = harness.build(
      harness
          .stateWithCash('1e9')
          .copyWith(
            goldenBeans: 20,
            shopLevels: const {'street_cart': 1, 'corner_booth': 1},
          ),
    );
    await pumpCafe(tester, harness, cubit);
    final game = cafeViewState(tester).game;
    final spriteCount = testAtlas.sprites.length;
    FloorLayer floor() =>
        game.world.descendants().whereType<FloorLayer>().single;
    expect(floor().paletteKey, 'base');

    await cubit.unlockCosmetic('floor_terracotta');
    await cubit.equipCosmetic('floor_terracotta');
    await cubit.unlockCosmetic('sign_neon');
    await cubit.equipCosmetic('sign_neon');
    await cubit.equipCosmetic('light_warm');
    await cubit.equipCosmetic('outfit_red', slot: 'player');
    await tester.pump(const Duration(milliseconds: 50));

    expect(floor().paletteKey, 'base+floor_terracotta');
    final sign = game.world
        .descendants()
        .whereType<FurnitureComponent>()
        .singleWhere((component) => component.item.itemId == 'sign');
    expect(sign.spriteId, 'sign_neon');
    final light = game.world.descendants().whereType<LightOverlay>().single;
    expect(light.intensity, greaterThan(0));
    final player = game.world.descendants().whereType<BaristaComponent>().first;
    expect(player.paletteKey, 'base+outfit_red');
    expect(testAtlas.sprites.length, spriteCount);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('buying equipment swaps the machine and sparkles', (
    tester,
  ) async {
    final harness = CubitHarness();
    final cubit = harness.build(
      harness
          .stateWithCash('1e9')
          .copyWith(shopLevels: const {'street_cart': 1}),
    );
    await pumpCafe(tester, harness, cubit);
    final game = cafeViewState(tester).game;
    final machine = game.world
        .descendants()
        .whereType<MachineComponent>()
        .single;
    expect(machine.spriteId, 'espresso_machine_0');

    await cubit.buyEquipment('street_cart');
    await tester.pump(const Duration(milliseconds: 50));
    expect(machine.spriteId, 'espresso_machine_1');
    expect(
      machine.children.whereType<PixelSpriteComponent>().where(
        (child) => child.spriteId == 'star',
      ),
      isNotEmpty,
    );
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(milliseconds: 100));
    expect(
      machine.children.whereType<PixelSpriteComponent>().where(
        (child) => child.spriteId == 'star',
      ),
      isEmpty,
    );
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('appearance panel locks, unlocks with beans and equips', (
    tester,
  ) async {
    final harness = CubitHarness();
    final cubit = harness.build(
      harness.stateWithCash('5').copyWith(goldenBeans: 10),
    );
    await pumpCafe(tester, harness, cubit);
    await tester.tap(find.byKey(CafeView.appearanceButtonKey));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.tap(find.byKey(AppearanceSheet.tabKey(CosmeticType.sign)));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    await tester.tap(find.byKey(CosmeticTile.tileKey('sign_round')));
    await tester.pump();
    expect(cubit.equippedCosmetic(CosmeticType.sign)?.id, 'sign_classic');
    expect(find.text('Unlocks with Boutique Café'), findsOneWidget);

    await tester.tap(find.byKey(CosmeticTile.unlockKey('sign_neon')));
    await tester.pump(const Duration(milliseconds: 300));
    expect(cubit.state.goldenBeans, 0);
    await tester.tap(find.byKey(CosmeticTile.tileKey('sign_neon')));
    await tester.pump(const Duration(milliseconds: 300));
    expect(cubit.equippedCosmetic(CosmeticType.sign)?.id, 'sign_neon');
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
