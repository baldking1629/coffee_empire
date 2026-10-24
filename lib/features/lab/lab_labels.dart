import '../../engine/lab_math.dart';
import '../../l10n/app_localizations.dart';

String recipeName(AppLocalizations l10n, String recipeId) => switch (recipeId) {
  'espresso_classic' => l10n.recipe_espresso_classic,
  'cappuccino' => l10n.recipe_cappuccino,
  'cold_brew' => l10n.recipe_cold_brew,
  'flat_white' => l10n.recipe_flat_white,
  'capsule_house_blend' => l10n.recipe_capsule_house_blend,
  'ethiopian_pour_over' => l10n.recipe_ethiopian_pour_over,
  'nitro_mocha' => l10n.recipe_nitro_mocha,
  'capsule_signature_reserve' => l10n.recipe_capsule_signature_reserve,
  _ => recipeId,
};

String flavorName(AppLocalizations l10n, FlavorAttribute attribute) =>
    switch (attribute) {
      FlavorAttribute.acidity => l10n.flavorAcidity,
      FlavorAttribute.body => l10n.flavorBody,
      FlavorAttribute.aroma => l10n.flavorAroma,
      FlavorAttribute.caffeine => l10n.flavorCaffeine,
    };

String hintText(AppLocalizations l10n, BrewHint hint) {
  final attribute = hint.attribute;
  if (attribute == null || hint.direction == HintDirection.onTrack) {
    return l10n.hintOnTrack;
  }
  final name = flavorName(l10n, attribute);
  return hint.direction == HintDirection.tooLow
      ? l10n.hintTooLow(name)
      : l10n.hintTooHigh(name);
}
