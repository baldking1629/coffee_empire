import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/formatters.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/services/monetization_service.dart';
import '../../../engine/offline_math.dart';
import '../../../l10n/app_localizations.dart';
import '../../game/game_cubit.dart';
import '../../game/game_state.dart';
import 'rewarded_ad_runner.dart';

class OfflineEarningsListener extends StatefulWidget {
  const OfflineEarningsListener({super.key, required this.child});

  final Widget child;

  @override
  State<OfflineEarningsListener> createState() =>
      _OfflineEarningsListenerState();
}

class _OfflineEarningsListenerState extends State<OfflineEarningsListener> {
  bool _showing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pending = context.read<GameCubit>().state.pendingOffline;
      if (pending != null) _show(pending);
    });
  }

  Future<void> _show(OfflineEarnings earnings) async {
    if (_showing || !mounted) return;
    _showing = true;
    final cubit = context.read<GameCubit>();
    final doubled = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => _OfflineDialog(
        earnings: earnings,
        scientific: cubit.state.settings.scientific,
      ),
    );
    _showing = false;
    await cubit.claimOfflineEarnings(doubled: doubled ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameCubit, GameState>(
      listenWhen: (previous, current) =>
          previous.pendingOffline == null && current.pendingOffline != null,
      listener: (context, state) {
        final pending = state.pendingOffline;
        if (pending != null) _show(pending);
      },
      child: widget.child,
    );
  }
}

class _OfflineDialog extends StatelessWidget {
  const _OfflineDialog({required this.earnings, required this.scientific});

  final OfflineEarnings earnings;
  final bool scientific;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final duration = Duration(seconds: earnings.awaySeconds.round());
    return AlertDialog(
      backgroundColor: AppColors.card,
      title: Text(l10n.offlineTitle),
      content: Text(
        l10n.offlineBody(
          durationFormatterOf(context).format(duration),
          numberFormatterOf(
            context,
            scientific: scientific,
          ).formatMoney(earnings.amount),
        ),
      ),
      actions: [
        TextButton(
          key: const Key('offline_collect'),
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.offlineCollect),
        ),
        FilledButton(
          key: const Key('offline_collect_double'),
          style: FilledButton.styleFrom(backgroundColor: AppColors.copper),
          onPressed: () async {
            final watched = await runRewardedAd(
              context,
              RewardedAdType.offlineDouble,
            );
            if (context.mounted) Navigator.of(context).pop(watched);
          },
          child: Text(
            l10n.offlineCollectDouble,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
