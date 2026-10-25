import 'package:coffee_empire/cafe/edit/placement_ghost.dart';
import 'package:coffee_empire/features/customize/edit_toolbar.dart';
import 'package:coffee_empire/features/customize/furniture_catalog_sheet.dart';
import 'package:coffee_empire/features/home/widgets/cafe_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/cafe_driver.dart';
import '../../helpers/cubit_harness.dart';
import '../../helpers/pump_app.dart';

void main() {
  testWidgets('edit mode buys, previews and places furniture', (tester) async {
    tester.view.physicalSize = const Size(1179, 2556);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    final harness = CubitHarness();
    final cubit = harness.build(harness.stateWithCash('1e3'));
    await pumpWithGame(
      tester,
      config: harness.config,
      cubit: cubit,
      child: const CafeView(active: true),
    );
    await tester.pump(const Duration(seconds: 8));
    final game = cafeViewState(tester).game;

    await tester.tap(find.byKey(CafeView.editButtonKey));
    await tester.pump(const Duration(milliseconds: 100));
    expect(game.isEditing, isTrue);
    expect(game.flow.customers, isEmpty);
    expect(find.byType(EditToolbar), findsOneWidget);

    await tester.tap(find.byKey(EditToolbar.catalogKey));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.scrollUntilVisible(
      find.byKey(FurnitureCatalogSheet.buyKey('plant')),
      200,
      scrollable: find.descendant(
        of: find.byType(FurnitureCatalogSheet),
        matching: find.byType(Scrollable),
      ),
    );
    await tester.tap(find.byKey(FurnitureCatalogSheet.buyKey('plant')));
    await tester.pump(const Duration(milliseconds: 300));
    expect(cubit.state.inventory['plant'], 1);
    await tester.tap(find.byKey(FurnitureCatalogSheet.placeKey('plant')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    final editor = cafeViewState(tester).bridge.editor;
    expect(editor.session.value?.isValid, isTrue);
    await tester.pump(const Duration(milliseconds: 50));
    expect(game.world.descendants().whereType<PlacementGhost>(), hasLength(1));

    editor.moveTo((x: 3, y: 5));
    await tester.pump(const Duration(milliseconds: 50));
    expect(editor.session.value?.isValid, isFalse);
    expect(find.text("Can't place here"), findsOneWidget);
    await tester.tap(find.byKey(EditToolbar.placeKey));
    await tester.pump(const Duration(milliseconds: 300));
    expect(cubit.state.inventory['plant'], 1);

    editor.moveTo((x: 5, y: 8));
    await tester.pump(const Duration(milliseconds: 50));
    expect(editor.session.value?.isValid, isTrue);
    await tester.tap(find.byKey(EditToolbar.placeKey));
    await tester.pump(const Duration(milliseconds: 300));
    expect(cubit.state.inventory, isEmpty);
    expect(editor.session.value, isNull);

    await tester.tap(find.byKey(EditToolbar.doneKey));
    await tester.pump(const Duration(milliseconds: 100));
    expect(game.isEditing, isFalse);
    expect(game.flow.plan.blocked, contains((x: 5, y: 8)));
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
