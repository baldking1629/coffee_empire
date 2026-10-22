const Map<String, String> decimalSeparatorsByLanguage = {
  'tr': ',',
  'es': ',',
  'pt': ',',
  'fr': ',',
  'de': ',',
  'it': ',',
  'ru': ',',
  'id': ',',
  'vi': ',',
  'en': '.',
  'hi': '.',
  'ja': '.',
  'ko': '.',
  'zh': '.',
  'ar': '.',
};

String decimalSeparatorFor(String languageCode) =>
    decimalSeparatorsByLanguage[languageCode] ?? '.';
