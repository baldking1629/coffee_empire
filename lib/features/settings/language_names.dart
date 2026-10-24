import '../../l10n/app_localizations.dart';

const List<String> languageOrder = [
  'en',
  'tr',
  'es',
  'pt',
  'fr',
  'de',
  'it',
  'ru',
  'ar',
  'hi',
  'id',
  'ja',
  'ko',
  'zh',
  'vi',
];

String languageNativeName(AppLocalizations l10n, String code) => switch (code) {
  'en' => l10n.languageNative_en,
  'tr' => l10n.languageNative_tr,
  'es' => l10n.languageNative_es,
  'pt' => l10n.languageNative_pt,
  'fr' => l10n.languageNative_fr,
  'de' => l10n.languageNative_de,
  'it' => l10n.languageNative_it,
  'ru' => l10n.languageNative_ru,
  'ar' => l10n.languageNative_ar,
  'hi' => l10n.languageNative_hi,
  'id' => l10n.languageNative_id,
  'ja' => l10n.languageNative_ja,
  'ko' => l10n.languageNative_ko,
  'zh' => l10n.languageNative_zh,
  'vi' => l10n.languageNative_vi,
  _ => code,
};
