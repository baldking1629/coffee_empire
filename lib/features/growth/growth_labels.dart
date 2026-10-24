import '../../l10n/app_localizations.dart';

String cityName(AppLocalizations l10n, String cityId) => switch (cityId) {
  'vienna' => l10n.city_vienna,
  'lisbon' => l10n.city_lisbon,
  'reykjavik' => l10n.city_reykjavik,
  'addis_ababa' => l10n.city_addis_ababa,
  'nairobi' => l10n.city_nairobi,
  'hanoi' => l10n.city_hanoi,
  'amsterdam' => l10n.city_amsterdam,
  'singapore' => l10n.city_singapore,
  'bangkok' => l10n.city_bangkok,
  'buenos_aires' => l10n.city_buenos_aires,
  'bogota' => l10n.city_bogota,
  'lagos' => l10n.city_lagos,
  'berlin' => l10n.city_berlin,
  'madrid' => l10n.city_madrid,
  'rome' => l10n.city_rome,
  'toronto' => l10n.city_toronto,
  'sydney' => l10n.city_sydney,
  'mumbai' => l10n.city_mumbai,
  'cairo' => l10n.city_cairo,
  'jakarta' => l10n.city_jakarta,
  'paris' => l10n.city_paris,
  'dubai' => l10n.city_dubai,
  'shanghai' => l10n.city_shanghai,
  'mexico_city' => l10n.city_mexico_city,
  'seoul' => l10n.city_seoul,
  'new_york' => l10n.city_new_york,
  'tokyo' => l10n.city_tokyo,
  'london' => l10n.city_london,
  'istanbul' => l10n.city_istanbul,
  'sao_paulo' => l10n.city_sao_paulo,
  _ => cityId,
};

String countryName(AppLocalizations l10n, String countryCode) =>
    switch (countryCode) {
      'AT' => l10n.country_AT,
      'PT' => l10n.country_PT,
      'IS' => l10n.country_IS,
      'ET' => l10n.country_ET,
      'KE' => l10n.country_KE,
      'VN' => l10n.country_VN,
      'NL' => l10n.country_NL,
      'SG' => l10n.country_SG,
      'TH' => l10n.country_TH,
      'AR' => l10n.country_AR,
      'CO' => l10n.country_CO,
      'NG' => l10n.country_NG,
      'DE' => l10n.country_DE,
      'ES' => l10n.country_ES,
      'IT' => l10n.country_IT,
      'CA' => l10n.country_CA,
      'AU' => l10n.country_AU,
      'IN' => l10n.country_IN,
      'EG' => l10n.country_EG,
      'ID' => l10n.country_ID,
      'FR' => l10n.country_FR,
      'AE' => l10n.country_AE,
      'CN' => l10n.country_CN,
      'MX' => l10n.country_MX,
      'KR' => l10n.country_KR,
      'US' => l10n.country_US,
      'JP' => l10n.country_JP,
      'GB' => l10n.country_GB,
      'TR' => l10n.country_TR,
      'BR' => l10n.country_BR,
      _ => countryCode,
    };

String regionName(AppLocalizations l10n, String region) => switch (region) {
  'europe' => l10n.region_europe,
  'asia_pacific' => l10n.region_asia_pacific,
  'americas' => l10n.region_americas,
  'mea' => l10n.region_mea,
  _ => region,
};

const List<String> regionOrder = ['europe', 'asia_pacific', 'americas', 'mea'];

const int _regionalIndicatorA = 0x1F1E6;
const int _letterA = 65;

String flagEmoji(String countryCode) => String.fromCharCodes(
  countryCode.toUpperCase().codeUnits.map(
    (unit) => _regionalIndicatorA + unit - _letterA,
  ),
);
