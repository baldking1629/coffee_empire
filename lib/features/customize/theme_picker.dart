import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/theme/app_colors.dart';
import '../../config/economy_config.dart';
import '../../l10n/app_localizations.dart';
import '../game/game_cubit.dart';
import '../game/game_state.dart';
import 'cosmetic_labels.dart';
import 'cosmetic_tile.dart';
import 'outfit_picker.dart';

Future<void> showAppearanceSheet(BuildContext context) =>
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => const FractionallySizedBox(
        heightFactor: 0.75,
        child: AppearanceSheet(),
      ),
    );

class AppearanceSheet extends StatelessWidget {
  const AppearanceSheet({super.key});

  static Key tabKey(CosmeticType type) => Key('appearance_tab_${type.name}');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DefaultTabController(
      length: CosmeticType.values.length,
      child: Column(
        children: [
          Text(
            l10n.appearanceTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelColor: AppColors.gold,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.gold,
            tabs: [
              for (final type in CosmeticType.values)
                Tab(key: tabKey(type), text: cosmeticTypeName(l10n, type)),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                for (final type in CosmeticType.values)
                  type == CosmeticType.outfit
                      ? const OutfitPicker()
                      : ThemePicker(type: type),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ThemePicker extends StatelessWidget {
  const ThemePicker({super.key, required this.type});

  final CosmeticType type;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameCubit>();
    final options = cubit.engine.config.cosmetics.ofType(type);
    return BlocBuilder<GameCubit, GameState>(
      buildWhen: (previous, current) =>
          previous.cosmetics != current.cosmetics ||
          previous.goldenBeans != current.goldenBeans ||
          previous.shopLevels != current.shopLevels ||
          previous.achievements != current.achievements ||
          previous.store != current.store,
      builder: (context, state) {
        final equipped = cubit.equippedCosmetic(type)?.id;
        return CosmeticGrid(
          children: [
            for (final cosmetic in options)
              CosmeticTile(
                cosmetic: cosmetic,
                equipped: cosmetic.id == equipped,
                onEquip: () => cubit.equipCosmetic(cosmetic.id),
              ),
          ],
        );
      },
    );
  }
}

class CosmeticGrid extends StatelessWidget {
  const CosmeticGrid({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsetsDirectional.all(16),
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 0.62,
      children: children,
    );
  }
}
