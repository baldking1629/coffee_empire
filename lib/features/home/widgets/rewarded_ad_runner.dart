import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/services/monetization_service.dart';
import '../../../l10n/app_localizations.dart';

Future<bool> runRewardedAd(BuildContext context, RewardedAdType type) async {
  final service = context.read<MonetizationService>();
  final navigator = Navigator.of(context);
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) => AlertDialog(
      backgroundColor: AppColors.card,
      content: Row(
        children: [
          const CircularProgressIndicator(color: AppColors.copper),
          const SizedBox(width: 16),
          Expanded(child: Text(AppLocalizations.of(dialogContext).adPlaying)),
        ],
      ),
    ),
  );
  final watched = await service.showRewardedAd(type);
  navigator.pop();
  return watched;
}
