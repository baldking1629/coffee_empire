import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_theme.dart';
import '../../app/widgets/bouncy_button.dart';
import '../../cafe/edit/edit_mode_controller.dart';
import '../../l10n/app_localizations.dart';
import 'furniture_catalog_sheet.dart';

class EditToolbar extends StatelessWidget {
  const EditToolbar({super.key, required this.editor, required this.onDone});

  static const Key placeKey = Key('edit_place');
  static const Key rotateKey = Key('edit_rotate');
  static const Key storeKey = Key('edit_store');
  static const Key cancelKey = Key('edit_cancel');
  static const Key catalogKey = Key('edit_catalog');
  static const Key doneKey = Key('edit_done');

  final EditModeController editor;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsetsDirectional.all(12),
      padding: const EdgeInsetsDirectional.all(12),
      decoration: AppTheme.cardDecoration(),
      child: ValueListenableBuilder<EditSession?>(
        valueListenable: editor.session,
        builder: (context, session, _) {
          if (session == null) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.editHint,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _action(
                        key: catalogKey,
                        icon: LucideIcons.sofa,
                        label: l10n.furnitureCatalog,
                        onPressed: () => showFurnitureCatalog(context, editor),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _action(
                        key: doneKey,
                        icon: LucideIcons.check,
                        label: l10n.editDone,
                        onPressed: onDone,
                        primary: true,
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!session.isValid)
                Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: 8),
                  child: Text(
                    l10n.editInvalid,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.danger,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Row(
                children: [
                  if (editor.canRotate) ...[
                    Expanded(
                      child: _action(
                        key: rotateKey,
                        icon: LucideIcons.rotateCw,
                        label: l10n.editRotate,
                        onPressed: editor.rotate,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  if (!session.fromInventory) ...[
                    Expanded(
                      child: _action(
                        key: storeKey,
                        icon: LucideIcons.archive,
                        label: l10n.editStore,
                        onPressed: editor.store,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: _action(
                      key: cancelKey,
                      icon: LucideIcons.x,
                      label: l10n.editCancel,
                      onPressed: editor.cancel,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: BouncyButton(
                      key: placeKey,
                      compact: true,
                      canAfford: session.isValid,
                      onPressed: editor.confirm,
                      onDenied: editor.confirm,
                      child: _label(LucideIcons.check, l10n.editPlace),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _action({
    required Key key,
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    bool primary = false,
  }) => BouncyButton(
    key: key,
    compact: true,
    style: primary ? BouncyButtonStyle.primary : BouncyButtonStyle.secondary,
    onPressed: onPressed,
    child: _label(icon, label),
  );

  Widget _label(IconData icon, String label) => FittedBox(
    fit: BoxFit.scaleDown,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16),
        const SizedBox(width: 4),
        Text(label, maxLines: 1),
      ],
    ),
  );
}
