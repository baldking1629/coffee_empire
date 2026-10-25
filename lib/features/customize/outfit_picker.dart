import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/theme/app_colors.dart';
import '../../config/economy_config.dart';
import '../../l10n/app_localizations.dart';
import '../game/game_cubit.dart';
import '../game/game_state.dart';
import 'cosmetic_labels.dart';
import 'cosmetic_tile.dart';
import 'theme_picker.dart';

class OutfitPicker extends StatefulWidget {
  const OutfitPicker({super.key});

  static Key slotKey(String slot) => Key('outfit_slot_$slot');

  @override
  State<OutfitPicker> createState() => _OutfitPickerState();
}

class _OutfitPickerState extends State<OutfitPicker> {
  int _slotIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<GameCubit>();
    final catalog = cubit.engine.config.cosmetics;
    final slots = catalog.outfitSlots;
    if (slots.isEmpty) return const SizedBox.shrink();
    final slot = slots[_slotIndex.clamp(0, slots.length - 1)];
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
          child: Row(
            children: [
              for (var i = 0; i < slots.length; i++)
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8),
                  child: ChoiceChip(
                    key: OutfitPicker.slotKey(slots[i]),
                    label: Text(outfitSlotName(l10n, i)),
                    selected: i == _slotIndex,
                    selectedColor: AppColors.gold,
                    onSelected: (_) => setState(() => _slotIndex = i),
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<GameCubit, GameState>(
            buildWhen: (previous, current) =>
                previous.cosmetics != current.cosmetics ||
                previous.goldenBeans != current.goldenBeans ||
                previous.shopLevels != current.shopLevels ||
                previous.achievements != current.achievements ||
                previous.store != current.store,
            builder: (context, state) {
              final equipped = cubit.outfitFor(slot)?.id;
              return CosmeticGrid(
                children: [
                  for (final cosmetic in catalog.ofType(CosmeticType.outfit))
                    CosmeticTile(
                      cosmetic: cosmetic,
                      equipped: cosmetic.id == equipped,
                      onEquip: () =>
                          cubit.equipCosmetic(cosmetic.id, slot: slot),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
