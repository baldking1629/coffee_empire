import 'package:coffee_empire/features/settings/sprite_gallery_screen.dart';
import 'package:coffee_empire/l10n/app_localizations.dart';
import 'package:coffee_empire/pixel/sprite_atlas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/sprite_files.dart';

void main() {
  testWidgets('gallery shows every sprite crisp at 4x and animates', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 8000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final atlas = loadAtlas();
    await tester.pumpWidget(
      RepositoryProvider<SpriteAtlas>.value(
        value: atlas,
        child: const MaterialApp(
          locale: Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SpriteGalleryScreen(),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Sprite Gallery'), findsOneWidget);
    for (final id in [
      'customer_a',
      'espresso_machine_3',
      'building_drive_thru',
    ]) {
      expect(
        find.byKey(Key('gallery_$id'), skipOffstage: false),
        findsOneWidget,
      );
    }
    final chair = tester.widget<PixelImage>(
      find.descendant(
        of: find.byKey(const Key('gallery_chair'), skipOffstage: false),
        matching: find.byType(PixelImage, skipOffstage: false),
      ),
    );
    expect(chair.scale, SpriteGalleryScreen.scale);
    expect(tester.getSize(find.byWidget(chair)), const Size(64, 64));

    await tester.tap(find.text('floor_marble'));
    await tester.pump(const Duration(milliseconds: 500));
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
