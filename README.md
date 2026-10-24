# Coffee Empire

Idle coffee simulator for iOS and Android, built with Flutter. Start with a street cart and grow into a global franchise empire.

## Development

```bash
flutter pub get
flutter gen-l10n
dart format .
flutter analyze
flutter test
dart run tool/simulate.dart
flutter run
```

- Game rules and numbers live in `assets/config/economy.json` and `assets/config/achievements.json`.
- All game math is pure Dart under `lib/engine/` and is unit tested.
- `tool/simulate.dart` runs a passive greedy bot and prints when each shop is first bought.

## Languages

15 languages: English (source), Türkçe, Español, Português (Brasil), Français, Deutsch, Italiano, Русский, العربية (RTL), हिन्दी, Bahasa Indonesia, 日本語, 한국어, 简体中文, Tiếng Việt. The player can pick one in Settings or follow the system language.

> **Çeviriler makine çevirisidir, yayından önce anadil kontrolü gerekir.** (Translations are machine-generated and need a native-speaker review before release.)

## Release checklist

- [ ] **App name:** "Coffee Empire" (Android `android:label`, iOS `CFBundleDisplayName`). Confirm the final store name.
- [ ] **App icon:** the default Flutter icon is a placeholder. Replace `android/app/src/main/res/mipmap-*` and `ios/Runner/Assets.xcassets/AppIcon.appiconset`.
- [ ] **Privacy policy URL:** `PRIVACY_POLICY_URL = <to be filled>`. Required by both stores, and linked from the store listing and the in-app consent flow.
- [ ] **Age rating:** the game has no violence, gambling with real money or user-generated content. Rewarded ads and in-app purchases are present, so answer the IARC / App Store questionnaire with "contains ads" and "in-app purchases"; the expected rating is PEGI 3 / ESRB Everyone / App Store 4+.
- [ ] **Monetization:** `MockMonetizationService` and `MockConsentService` must be replaced by real AdMob / IAP / UMP / ATT implementations before release.
- [ ] **Analytics:** `DebugAnalyticsService` only prints to the debug console.
- [ ] **Signing:** set up release signing for Android (`android/app/build.gradle.kts`) and iOS (Xcode team and provisioning).
