import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../game/game_cubit.dart';
import '../game/game_state.dart';
import 'achievement_labels.dart';

class AchievementListener extends StatefulWidget {
  const AchievementListener({super.key, required this.child});

  final Widget child;

  @override
  State<AchievementListener> createState() => _AchievementListenerState();
}

class _AchievementListenerState extends State<AchievementListener> {
  late Set<String> _known = context.read<GameCubit>().state.achievements;

  void _announce(Set<String> current) {
    final fresh = current.difference(_known);
    _known = current;
    if (fresh.isEmpty) return;
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    for (final id in fresh) {
      messenger.showSnackBar(
        SnackBar(
          backgroundColor: AppColors.card,
          content: Text(
            l10n.achievementUnlocked(achievementName(l10n, id)),
            style: const TextStyle(color: AppColors.gold),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameCubit, GameState>(
      listenWhen: (previous, current) =>
          previous.achievements != current.achievements,
      listener: (context, state) => _announce(state.achievements),
      child: widget.child,
    );
  }
}
