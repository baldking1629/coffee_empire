import 'package:coffee_empire/engine/shop_math.dart';
import 'package:coffee_empire/features/game/game_state.dart';
import 'package:coffee_empire/features/tutorial/tutorial_overlay.dart';
import 'package:coffee_empire/features/tutorial/tutorial_rules.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/cubit_harness.dart';
import '../../helpers/pump_app.dart';

void main() {
  test('tutorial follows the six steps in order', () async {
    final harness = CubitHarness();
    final cubit = harness.build(harness.stateWithCash('1e4'));
    expect(cubit.state.tutorialStep, TutorialSteps.serveCustomer);

    cubit.serveOrder(drinkId: 'espresso', patienceRatio: 1, byBarista: false);
    expect(cubit.state.tutorialStep, TutorialSteps.buyFirstShop);

    cubit.notifyTabOpened(TutorialSteps.labTabIndex);
    expect(cubit.state.tutorialStep, TutorialSteps.buyFirstShop);

    await cubit.buyShopLevels('street_cart', BuyAmount.one);
    expect(cubit.state.tutorialStep, TutorialSteps.buySecondShop);
    await cubit.buyShopLevels('corner_booth', BuyAmount.one);
    expect(cubit.state.tutorialStep, TutorialSteps.hireManager);
    await cubit.hireManager('street_cart');
    expect(cubit.state.tutorialStep, TutorialSteps.openLab);
    cubit.notifyTabOpened(TutorialSteps.labTabIndex);
    expect(cubit.state.tutorialStep, TutorialSteps.finish);

    await cubit.completeTutorial();
    expect(cubit.state.tutorialStep, TutorialSteps.done);
    expect(
      GameState.fromJson(cubit.state.toJson()).tutorialStep,
      TutorialSteps.done,
    );
  });

  testWidgets('banner can be skipped and stays hidden', (tester) async {
    final harness = CubitHarness();
    final cubit = harness.build(harness.stateWithCash('5'));
    await pumpWithGame(
      tester,
      config: harness.config,
      cubit: cubit,
      child: const TutorialBanner(),
    );
    expect(find.textContaining('Barista training 1/6'), findsOneWidget);
    await tester.tap(find.byKey(TutorialBanner.skipKey));
    await tester.pumpAndSettle();
    expect(cubit.state.tutorialStep, TutorialSteps.done);
    expect(find.textContaining('Barista training'), findsNothing);

    final relaunched = harness.build(cubit.state);
    await pumpWithGame(
      tester,
      config: harness.config,
      cubit: relaunched,
      child: const TutorialBanner(),
    );
    expect(find.textContaining('Barista training'), findsNothing);
  });

  testWidgets('finish step asks for notification permission', (tester) async {
    final harness = CubitHarness();
    final cubit = harness.build(
      harness.stateWithCash('5').copyWith(tutorialStep: TutorialSteps.finish),
    );
    await pumpWithGame(
      tester,
      config: harness.config,
      cubit: cubit,
      child: const TutorialBanner(),
    );
    await tester.tap(find.byKey(TutorialBanner.finishKey));
    await tester.pumpAndSettle();
    expect(cubit.state.tutorialStep, TutorialSteps.done);
  });
}
