import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../app/widgets/game_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/theme/app_colors.dart';
import '../../core/services/notification_service.dart';
import '../../l10n/app_localizations.dart';
import '../game/game_cubit.dart';
import '../game/game_settings.dart';
import '../game/game_state.dart';
import 'language_names.dart';
import 'sprite_gallery_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const Key resetKey = Key('settings_reset');
  static const Key languageKey = Key('settings_language');
  static const Key spriteGalleryKey = Key('settings_sprite_gallery');

  Future<void> _confirmReset(BuildContext context, GameCubit cubit) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.card,
        title: Text(l10n.resetConfirmTitle),
        content: Text(l10n.resetConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            key: const Key('settings_reset_confirm'),
            style: FilledButton.styleFrom(backgroundColor: AppColors.copper),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.resetConfirm),
          ),
        ],
      ),
    );
    if (confirmed ?? false) await cubit.resetProgress();
  }

  Future<void> _toggleNotifications(
    BuildContext context,
    GameCubit cubit,
    GameSettings settings,
    bool enabled,
  ) async {
    if (enabled) {
      await context.read<NotificationService?>()?.requestPermission();
    }
    await cubit.updateSettings(settings.copyWith(notifications: enabled));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<GameCubit>();
    final supported = {
      for (final locale in AppLocalizations.supportedLocales)
        locale.languageCode,
    };
    final languageCodes = [
      GameSettings.systemLocale,
      ...languageOrder.where(supported.contains),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: Text(l10n.settingsTitle),
      ),
      body: GameBackground(
        child: BlocSelector<GameCubit, GameState, GameSettings>(
          selector: (state) => state.settings,
          builder: (context, settings) => ListView(
            children: [
              ListTile(
                leading: const Icon(LucideIcons.languages),
                title: Text(l10n.settingsLanguage),
                trailing: DropdownButton<String>(
                  key: languageKey,
                  value: settings.locale,
                  underline: const SizedBox.shrink(),
                  onChanged: (code) {
                    if (code != null) {
                      cubit.updateSettings(settings.copyWith(locale: code));
                    }
                  },
                  items: [
                    for (final code in languageCodes)
                      DropdownMenuItem(
                        value: code,
                        child: Text(
                          code == GameSettings.systemLocale
                              ? l10n.languageSystem
                              : languageNativeName(l10n, code),
                        ),
                      ),
                  ],
                ),
              ),
              SwitchListTile(
                secondary: const Icon(LucideIcons.volume2),
                title: Text(l10n.settingsSound),
                value: settings.sound,
                onChanged: (value) =>
                    cubit.updateSettings(settings.copyWith(sound: value)),
              ),
              SwitchListTile(
                secondary: const Icon(LucideIcons.vibrate),
                title: Text(l10n.settingsHaptics),
                value: settings.haptics,
                onChanged: (value) =>
                    cubit.updateSettings(settings.copyWith(haptics: value)),
              ),
              SwitchListTile(
                secondary: const Icon(LucideIcons.bell),
                title: Text(l10n.settingsNotifications),
                value: settings.notifications,
                onChanged: (value) =>
                    _toggleNotifications(context, cubit, settings, value),
              ),
              SwitchListTile(
                key: const Key('settings_scientific'),
                secondary: const Icon(LucideIcons.sigma),
                title: Text(l10n.settingsScientific),
                value: settings.scientific,
                onChanged: (value) =>
                    cubit.updateSettings(settings.copyWith(scientific: value)),
              ),
              if (kDebugMode)
                ListTile(
                  key: spriteGalleryKey,
                  leading: const Icon(LucideIcons.grid3x3),
                  title: Text(l10n.spriteGalleryTitle),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const SpriteGalleryScreen(),
                    ),
                  ),
                ),
              const Divider(),
              ListTile(
                key: resetKey,
                leading: const Icon(
                  LucideIcons.trash2,
                  color: AppColors.copper,
                ),
                title: Text(
                  l10n.settingsReset,
                  style: const TextStyle(color: AppColors.copper),
                ),
                onTap: () => _confirmReset(context, cubit),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
