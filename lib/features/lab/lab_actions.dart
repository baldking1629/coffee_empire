import '../../config/economy_config.dart';
import '../../core/bignumber/big_number.dart';
import '../../engine/economy_engine.dart';
import '../../engine/lab_math.dart';
import '../../engine/shop_math.dart';
import '../game/game_state.dart';
import 'lab_state.dart';

typedef BrewCompletion = ({GameState state, BrewResult? result});

class LabActions {
  const LabActions(this.engine);

  final EconomyEngine engine;

  LabMath get math => engine.labMath;

  RecipeConfig? recipeById(String recipeId) {
    for (final recipe in engine.config.lab.recipes) {
      if (recipe.id == recipeId) return recipe;
    }
    return null;
  }

  int brandHype(GameState state) => engine.brandHype(state.lifetimeEarnings);

  bool isCapsuleUnlocked(GameState state) =>
      math.isCapsuleUnlocked(state.lab.bestScores, brandHype(state));

  BigNumber testCost(RecipeConfig recipe, GameState state) =>
      math.testCost(recipe, state.incomePerSec);

  GameState? unlockRecipe(GameState state, String recipeId) {
    final recipe = recipeById(recipeId);
    if (recipe == null || state.lab.isUnlocked(recipe)) return null;
    if (state.cash < recipe.unlockCost) return null;
    final progress = state.lab.progressOf(recipeId).copyWith(unlocked: true);
    return state
        .spend(recipe.unlockCost)
        .copyWith(lab: state.lab.withRecipe(recipeId, progress));
  }

  GameState? startBrew(
    GameState state,
    String recipeId,
    FlavorProfile sliders,
    DateTime now,
  ) {
    final recipe = recipeById(recipeId);
    if (recipe == null ||
        !state.lab.isUnlocked(recipe) ||
        state.lab.activeBrew != null) {
      return null;
    }
    final cost = testCost(recipe, state);
    if (state.cash < cost) return null;
    final brew = ActiveBrew(
      recipeId: recipeId,
      endsAt: now.add(Duration(seconds: recipe.testDurationSeconds)),
      sliders: sliders,
    );
    return state
        .spend(cost)
        .copyWith(lab: state.lab.copyWith(activeBrew: () => brew));
  }

  BrewCompletion completeDueBrew(GameState state, DateTime now) {
    final brew = state.lab.activeBrew;
    if (brew == null || !brew.isDone(now)) return (state: state, result: null);
    final recipe = recipeById(brew.recipeId);
    final cleared = state.lab.copyWith(activeBrew: () => null);
    if (recipe == null) {
      return (state: state.copyWith(lab: cleared), result: null);
    }
    final result = math.evaluate(recipe, brew.sliders);
    final previous = state.lab.progressOf(recipe.id);
    final progress = previous.copyWith(
      bestScore: result.score > previous.bestScore
          ? result.score
          : previous.bestScore,
      lastScore: result.score,
      lastHint: result.hint,
    );
    return (
      state: state.copyWith(lab: cleared.withRecipe(recipe.id, progress)),
      result: result,
    );
  }

  GameState? expireBrewNow(GameState state, DateTime now) {
    final brew = state.lab.activeBrew;
    if (brew == null) return null;
    return state.copyWith(
      lab: state.lab.copyWith(activeBrew: () => brew.copyWith(endsAt: now)),
    );
  }

  PurchasePlan capsulePlan(GameState state, BuyAmount amount) =>
      math.machineCost.plan(state.lab.capsuleMachines, state.cash, amount);

  GameState? buyCapsuleMachines(GameState state, BuyAmount amount) {
    if (!isCapsuleUnlocked(state)) return null;
    final plan = capsulePlan(state, amount);
    if (!plan.affordable) return null;
    return state
        .spend(plan.cost)
        .copyWith(
          lab: state.lab.copyWith(
            capsuleMachines: state.lab.capsuleMachines + plan.count,
          ),
        );
  }
}
