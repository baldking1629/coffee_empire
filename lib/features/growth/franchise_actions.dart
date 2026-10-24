import '../../config/economy_config.dart';
import '../../core/bignumber/big_number.dart';
import '../../engine/economy_engine.dart';
import '../../engine/franchise_math.dart';
import '../game/game_state.dart';

class FranchiseActions {
  const FranchiseActions(this.engine);

  final EconomyEngine engine;

  FranchiseMath get math => engine.franchiseMath;

  List<CityConfig> get citiesByHype =>
      [...engine.config.franchise.cities]
        ..sort((a, b) => a.requiredHype.compareTo(b.requiredHype));

  CityConfig? cityById(String cityId) {
    for (final city in engine.config.franchise.cities) {
      if (city.id == cityId) return city;
    }
    return null;
  }

  int ownedIn(GameState state, String cityId) => state.franchises[cityId] ?? 0;

  BigNumber nextSlotCost(GameState state, CityConfig city) =>
      math.costOfSlot(city, ownedIn(state, city.id));

  GameState? openFranchise(GameState state, String cityId) {
    final city = cityById(cityId);
    if (city == null) return null;
    final owned = ownedIn(state, cityId);
    final hype = engine.brandHype(state.lifetimeEarnings);
    if (!math.canOpen(city, owned, hype)) return null;
    final cost = math.costOfSlot(city, owned);
    if (state.cash < cost) return null;
    return state
        .spend(cost)
        .copyWith(franchises: {...state.franchises, cityId: owned + 1});
  }
}
