// GENERATED FILE — do not edit by hand.
// Regenerate with: dart run tool/templates_generator.dart
//
// Source: OpenCageData/address-formatting/conf/countries/worldwide.yaml
//   https://github.com/OpenCageData/address-formatting
//
// Why a .dart file and not JSON?
// • Zero runtime cost: const maps are resolved at compile time —
//   no file I/O, no JSON parsing, no heap allocation on cold start.
// • No asset pipeline: a JSON asset in a Dart/Flutter package
//   requires pubspec registration and an async load, which would
//   force AddressFormatter.format to become async.
// • Type safety: the emitted types match exactly what
//   AddressFormatter expects; a JSON file would require dynamic casts.
// ignore_for_file: constant_identifier_names, lines_longer_than_80_chars

/// Named mustache template strings shared across many countries.
/// Keys: generic1…generic23, fallback1…fallback4.
/// Consumed by [AddressFormatter] via [kAddressCountries] entries
/// whose 'address_template' / 'fallback_template' values are
/// one of these keys rather than inline mustache text.
const Map<String, String> kAddressTemplates = {
  'generic1': '''
{{{attention}}}
{{{house}}}
{{#first}} {{{road}}} || {{{place}}} || {{{hamlet}}} {{/first}} {{{house_number}}}
{{{postcode}}} {{#first}} {{{postal_city}}} || {{{town}}} || {{{city}}} || {{{village}}} || {{{municipality}}} || {{{hamlet}}} || {{{county}}} || {{{state}}} {{/first}}
{{{archipelago}}}
{{{country}}}
''',

  'generic2': '''
{{{attention}}}
{{{house}}}, {{{quarter}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{village}}} || {{{town}}} || {{{city}}} || {{{municipality}}} || {{{hamlet}}} || {{{county}}} {{/first}} {{{postcode}}}
{{#first}} {{{country}}} || {{{state}}} {{/first}}
''',

  'generic3': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{{place}}}
{{{postcode}}} {{#first}} {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{city}}} || {{{municipality}}} || {{{state}}} {{/first}}
{{{country}}}
''',

  'generic4': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{village}}} || {{{hamlet}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{state_district}}} || {{{suburb}}} || {{{municipality}}} || {{{county}}} {{/first}}, {{#first}} {{{state_code}}} || {{{state}}} {{/first}} {{{postcode}}}
{{{country}}}
''',

  'generic5': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{#first}} {{{state_district}}} || {{{state}}} {{/first}}
{{{country}}}
''',

  'generic6': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{municipality}}} {{/first}}
{{{county}}}
{{{state}}}
{{{country}}}
''',

  'generic7': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{state}}}{{/first}}, {{{postcode}}}
{{{country}}}
''',

  'generic8': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{{postcode}}} {{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{municipality}}} {{/first}} {{#first}} {{{county_code}}} || {{{county}}} {{/first}}
{{{country}}}
''',

  'generic9': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{state_district}}} {{/first}}
{{{postcode}}} {{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{state}}} {{/first}}
{{{country}}}
''',

  'generic10': '''
{{{attention}}}
{{{house}}}
{{{road}}}, {{{house_number}}}
{{#first}} {{{suburb}}} || {{{city_district}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{{state}}}
{{{country}}}
{{{postcode}}}
''',

  'generic11': '''
{{{country}}}
{{{state}}}
{{{postcode}}} {{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{{suburb}}}
{{{road}}}, {{{house_number}}}
{{{house}}}
{{{attention}}}
''',

  'generic12': '''
{{{attention}}}
{{{house}}}
{{{house_number}}}, {{{road}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{state_district}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}} - {{{postcode}}}
{{{state}}}
{{{country}}}
''',

  'generic13': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{city}}} || {{{town}}} || {{{state_district}}} || {{{village}}} || {{{hamlet}}} || {{{region}}} {{/first}} {{#first}} {{{state_code}}} || {{{state}}} {{/first}} {{{postcode}}}
{{{country}}}
''',

  'generic14': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{{postcode}}} {{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{state_district}}} {{/first}}
{{{state}}}
{{{country}}}
''',

  'generic15': '''
{{{attention}}}
{{{house}}}
{{{road}}}, {{{house_number}}}
{{{postcode}}} {{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{municipality}}} || {{{state}}} || {{{county}}} {{/first}}
{{{country}}}
''',

  'generic16': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{municipality}}} || {{{county}}} || {{{state_district}}} || {{{state}}} {{/first}}
{{{country}}}
''',

  'generic17': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{municipality}}} || {{{county}}} || {{{state_district}}} || {{{state}}} {{/first}}
{{{country}}}
''',

  'generic18': '''
{{{attention}}}
{{{house}}}
{{{house_number}}}, {{{road}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} || {{{state}}} {{/first}}
{{{country}}}
''',

  'generic19': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}} {{{postcode}}}
{{{country}}}
''',

  'generic20': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}} {{{postcode}}}
{{{country}}}
''',

  'generic21': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{state}}} {{/first}}
{{{country}}}
''',

  'generic22': '''
{{{attention}}}
{{{house}}}
{{{house_number}}}, {{{road}}}
{{{postcode}}} {{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{state}}} {{/first}}
{{{country}}}
''',

  'generic23': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{{quarter}}}
{{#first}} {{{village}}} || {{{town}}} || {{{city}}} || {{{municipality}}} || {{{hamlet}}} || {{{county}}} {{/first}}
{{{postcode}}}
{{#first}} {{{country}}} || {{{state}}} {{/first}}
''',

  'fallback1': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{{place}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} || {{{island}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{municipality}}} {{/first}}
{{#first}} {{{county}}} || {{{state_district}}} || {{{state}}} || {{{region}}} || {{{island}}}, {{{archipelago}}} {{/first}}
{{{country}}}
''',

  'fallback2': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{{place}}}
{{#first}} {{{suburb}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{municipality}}} || {{{county}}} || {{{island}}} || {{{state_district}}} {{/first}}, {{#first}} {{{state}}} || {{{state_code}}} {{/first}}
{{{country}}}
''',

  'fallback3': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{{place}}}
{{#first}} {{{suburb}}} || {{{island}}} {{/first}}
{{#first}} {{{village}}} || {{{hamlet}}} || {{{municipality}}} {{/first}}
{{#first}} {{{town}}} || {{{city}}}{{/first}}
{{{county}}}
{{#first}} {{{state}}} || {{{state_code}}} {{/first}}
{{{country}}}
''',

  'fallback4': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{{place}}}
{{{suburb}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{municipality}}} || {{{county}}} {{/first}}
{{#first}} {{{state}}} || {{{county}}} {{/first}}
{{{country}}}
''',

};

/// Per-country (and per-language-variant) address format entries.
///
/// 'address_template'   — key in [kAddressTemplates] or inline mustache
/// 'fallback_template'  — same; used when main template yields empty output
/// 'use_country'        — delegate format rules to another ISO code
/// 'change_country'     — override the country name component
/// 'add_component'      — inject a fixed component e.g. 'state=Foo'
/// 'replace'            — `List<List<String>>` pre-render [pattern, replacement]
/// 'postformat_replace' — `List<List<String>>` post-render [pattern, replacement]
const Map<String, Map<String, Object>> kAddressCountries = {
  'default': {
    'address_template': 'generic1',
    'fallback_template': 'fallback1',
  },

  'AD': {
    'address_template': 'generic3',
  },

  'AE': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{#first}} {{{state_district}}} || {{{state}}} {{/first}}
{{{country}}}
''',
  },

  'AF': {
    'address_template': 'generic21',
  },

  'AG': {
    'address_template': 'generic16',
  },

  'AI': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{{postcode}}} {{{country}}}
''',
  },

  'AL': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{{postcode}}}
{{#first}} {{{city}}} || {{{town}}} || {{{city_district}}} || {{{municipality}}} || {{{state_district}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{{country}}}
''',
  },

  'AM': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{{postcode}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{#first}} {{{state_district}}} || {{{state}}} {{/first}}
{{{country}}}
''',
  },

  'AO': {
    'address_template': 'generic7',
  },

  'AQ': {
    'address_template': '''
{{{house}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{#first}} {{{country}}} || {{{continent}}} {{/first}}
''',
    'fallback_template': '''
{{{house}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{#first}} {{{country}}} || {{{continent}}} {{/first}}
''',
  },

  'AR': {
    'address_template': 'generic9',
    'replace': <List<String>>[
      ['^Autonomous City of ', ''],
    ],
    'postformat_replace': <List<String>>[
      ['\n(\\w\\d{4})(\\w{3}) ', '\n\$1 \$2 '],
    ],
  },

  'AS': {
    'use_country': 'US',
    'change_country': 'United States of America',
    'add_component': 'state=American Samoa',
  },

  'AT': {
    'address_template': 'generic1',
    'replace': <List<String>>[
      ['^Politischer Bezirk ', ''],
    ],
  },

  'AU': {
    'address_template': 'generic13',
  },

  'AW': {
    'address_template': 'generic17',
  },

  'AX': {
    'use_country': 'FI',
    'change_country': 'Åland, Finland',
  },

  'AZ': {
    'address_template': 'generic3',
  },

  'BA': {
    'address_template': 'generic1',
  },

  'BB': {
    'address_template': 'generic16',
  },

  'BD': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{state_district}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}} - {{{postcode}}}
{{{country}}}
''',
  },

  'BE': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{{postcode}}} {{#first}} {{{postal_city}}} || {{{town}}} || {{{city}}} || {{{village}}} || {{{municipality}}} || {{{hamlet}}} || {{{county}}} || {{{state}}} {{/first}}
{{{archipelago}}}
{{{country}}}
''',
  },

  'BF': {
    'address_template': 'generic6',
  },

  'BG': {
    'address_template': 'generic19',
  },

  'BH': {
    'address_template': 'generic2',
  },

  'BI': {
    'address_template': 'generic17',
  },

  'BJ': {
    'address_template': 'generic18',
  },

  'BL': {
    'use_country': 'FR',
    'change_country': 'Saint-Barthélemy, France',
  },

  'BM': {
    'address_template': 'generic2',
  },

  'BN': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}}, {{{road}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{municipality}}} {{/first}}
{{#first}} {{{county}}} || {{{state_district}}} || {{{state}}} {{/first}} {{{postcode}}}
{{{country}}}
''',
  },

  'BO': {
    'address_template': 'generic17',
    'replace': <List<String>>[
      ['^Municipio Nuestra Senora de ', ''],
    ],
  },

  'BQ': {
    'use_country': 'NL',
    'change_country': 'Caribbean Netherlands',
  },

  'BR': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{road}}}, {{{house_number}}}{{#first}}, {{{quarter}}}{{/first}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{village}}} || {{{hamlet}}}{{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{state_district}}} {{/first}} - {{#first}} {{{state_code}}} || {{{state}}} {{/first}}
{{{postcode}}}
{{{country}}}
''',
    'postformat_replace': <List<String>>[
      ['\\b(\\d{5})(\\d{3})\\b', '\$1-\$2'],
    ],
  },

  'BS': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{municipality}}} {{/first}}
{{{county}}}
{{{country}}}
''',
  },

  'BT': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}, {{{house}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{state}}} {{/first}} {{{postcode}}}
{{{country}}}
''',
  },

  'BV': {
    'use_country': 'NO',
    'change_country': 'Bouvet Island, Norway',
  },

  'BW': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{{country}}}
''',
  },

  'BY': {
    'address_template': 'generic11',
  },

  'BZ': {
    'address_template': 'generic16',
  },

  'CA': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{#first}} {{{house_number}}} {{{road}}} || {{{suburb}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{county}}} || {{{state_district}}} {{/first}}, {{#first}} {{{state_code}}} || {{{state}}} {{/first}} {{{postcode}}}
{{{country}}}
''',
    'fallback_template': '''
{{{attention}}}
{{{house}}}
{{#first}} {{{house_number}}} {{{road}}} || {{{suburb}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{county}}} || {{{state_district}}} || {{{region}}}{{/first}}, {{#first}} {{{state}}} || {{{state_code}}} {{/first}} {{{postcode}}}
{{{country}}}
''',
    'postformat_replace': <List<String>>[
      [' ([A-Za-z]{2}) ([A-Za-z]\\d[A-Za-z])(\\d[A-Za-z]\\d)\n', ' \$1 \$2 \$3\n'],
    ],
  },

  'CA_en': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{#first}} {{{house_number}}} {{{road}}} || {{{suburb}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{county}}} || {{{state_district}}} {{/first}}, {{#first}} {{{state_code}}} || {{{state}}} {{/first}} {{{postcode}}}
{{{country}}}
''',
    'fallback_template': '''
{{{attention}}}
{{{house}}}
{{#first}} {{{house_number}}} {{{road}}} || {{{suburb}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{county}}} || {{{state_district}}} {{/first}}, {{#first}} {{{state_code}}} || {{{state}}} {{/first}} {{{postcode}}}
{{{country}}}
''',
    'postformat_replace': <List<String>>[
      [' ([A-Za-z]{2}) ([A-Za-z]\\d[A-Za-z])(\\d[A-Za-z]\\d)\n', ' \$1 \$2 \$3\n'],
    ],
  },

  'CA_fr': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{#first}} {{{house_number}}}, {{{road}}} || {{{suburb}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{county}}} || {{{state_district}}} {{/first}} {{#first}} ({{{state_code}}}) || {{{state}}} {{/first}} {{{postcode}}}
{{{country}}}
''',
    'postformat_replace': <List<String>>[
      [' ([A-Za-z]{2}) ([A-Za-z]\\d[A-Za-z])(\\d[A-Za-z]\\d)\n', ' \$1 \$2 \$3\n'],
    ],
  },

  'CC': {
    'use_country': 'AU',
    'change_country': 'Australia',
  },

  'CD': {
    'address_template': 'generic18',
  },

  'CF': {
    'address_template': 'generic17',
  },

  'CG': {
    'address_template': 'generic18',
  },

  'CH': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{{postcode}}} {{#first}} {{{postal_city}}} || {{{town}}} || {{{city}}} || {{{municipality}}} || {{{village}}} || {{{hamlet}}} || {{{county}}} || {{{state}}} {{/first}}
{{{country}}}
''',
    'replace': <List<String>>[
      ['Verwaltungskreis', ''],
      ['Verwaltungsregion', ''],
      [' administrative district', ''],
      [' administrative region', ''],
    ],
  },

  'CI': {
    'address_template': 'generic16',
  },

  'CK': {
    'address_template': 'generic16',
  },

  'CL': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{{postcode}}} {{#first}} {{{postal_city}}} || {{{town}}} || {{{city}}} || {{{village}}} || {{{municipality}}} || {{{hamlet}}} || {{{county}}} || {{{state}}} {{/first}}
{{{region}}}
{{{country}}}
''',
  },

  'CM': {
    'address_template': 'generic17',
  },

  'CN': {
    'address_template': '''
{{{postcode}}} {{{country}}}
{{#first}} {{{state_code}}} || {{{state}}} || {{{state_district}}} || {{{region}}}{{/first}}
{{{county}}}
{{#first}}{{{city}}} || {{{town}}} || {{{municipality}}}|| {{{village}}}|| {{{hamlet}}}{{/first}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{{road}}} {{{house_number}}}
{{{house}}}
{{{attention}}}
''',
  },

  'CN_en': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{{county}}}
{{#first}}{{{city}}} || {{{town}}} || {{{municipality}}}|| {{{village}}}|| {{{hamlet}}}{{/first}}
{{#first}} {{{state_code}}} || {{{state}}} || {{{state_district}}} || {{{region}}}{{/first}}
{{{country}}} {{{postcode}}}
''',
  },

  'CN_zh': {
    'address_template': '''
{{{postcode}}} {{{country}}}
{{#first}} {{{state_code}}} || {{{state}}} || {{{state_district}}} || {{{region}}}{{/first}}
{{{county}}}
{{#first}}{{{city}}} || {{{town}}} || {{{municipality}}}|| {{{village}}}|| {{{hamlet}}}{{/first}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{{road}}} {{{house_number}}}
{{{house}}}
{{{attention}}}
''',
  },

  'CO': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{{postcode}}} {{#first}} {{{city}}} || {{{town}}} || {{{state_district}}} || {{{village}}} || {{{hamlet}}} {{/first}}, {{#first}} {{{state_code}}} || {{{state}}} {{/first}}
{{{country}}}
''',
    'postformat_replace': <List<String>>[
      ['Localidad ', ' '],
      ['(Bogot[áa]),? (Distrito Capital|Capital District)', '\$1'],
      ['(Bogot[áa]), Bogot[áa]', '\$1'],
    ],
  },

  'CR': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{{state}}}, {{#first}} {{{city}}} || {{{town}}} || {{{state_district}}} || {{{village}}} || {{{hamlet}}} {{/first}}, {{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{{postcode}}} {{{country}}}
''',
  },

  'CU': {
    'address_template': 'generic7',
  },

  'CV': {
    'address_template': 'generic1',
    'postformat_replace': <List<String>>[
      ['\n(\\d{4}) ([^,]*)\n', '\n\$1-\$2\n'],
    ],
  },

  'CW': {
    'address_template': 'generic17',
  },

  'CX': {
    'use_country': 'AU',
    'change_country': 'Australia',
    'add_component': 'state=Christmas Island',
  },

  'CY': {
    'address_template': 'generic1',
  },

  'CZ': {
    'address_template': 'generic1',
    'replace': <List<String>>[
      ['^Capital City of ', ''],
    ],
    'postformat_replace': <List<String>>[
      ['\n(\\d{3})(\\d{2}) ', '\n\$1 \$2 '],
    ],
  },

  'DE': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{#first}} {{{road}}} || {{{place}}} || {{{hamlet}}} {{/first}} {{{house_number}}}
{{{postcode}}} {{#first}} {{{village}}} {{{postal_city}}} || {{{town}}} || {{{city}}} || {{{municipality}}} || {{{hamlet}}} || {{{county}}} || {{{state}}} {{/first}}
{{{archipelago}}}
{{{country}}}
''',
    'fallback_template': '''
{{{attention}}}
{{{house}}}
{{#first}} {{{road}}} || {{{place}}} || {{{hamlet}}} {{/first}} {{{house_number}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{#first}} {{{village}}} || {{{town}}} || {{{city}}} || {{{hamlet}}} || {{{municipality}}} || {{{county}}} {{/first}}
{{#first}} {{{state}}} || {{{state_district}}} {{/first}}
{{{country}}}
''',
    'replace': <List<String>>[
      ['^Stadtteil ', ''],
      ['^Stadtbezirk (\\d+)', ''],
      ['^Ortsbeirat (\\d+) :', ''],
      ['^Gemeinde ', ''],
      ['^Gemeindeverwaltungsverband ', ''],
      ['county=Landkreis ', ''],
      ['county=Kreis ', ''],
      ['^Grenze ', ''],
      ['state=Free State of ', ''],
      ['^Freistaat ', ''],
      ['^Regierungsbezirk ', ''],
      ['^Stadtgebiet ', ''],
      ['^Gemeindefreies Gebiet ', ''],
      ['city=Alt-Berlin', 'Berlin'],
    ],
    'postformat_replace': <List<String>>[
      ['Berlin\nBerlin', 'Berlin'],
      ['Bremen\nBremen', 'Bremen'],
      ['Hamburg\nHamburg', 'Hamburg'],
    ],
  },

  'DJ': {
    'address_template': 'generic16',
    'replace': <List<String>>[
      ['city=Djibouti', 'Djibouti-Ville'],
    ],
  },

  'DK': {
    'address_template': 'generic1',
    'replace': <List<String>>[
      ['state=Capital Region of Denmark', 'Capital Region'],
      ['^Region of ', ''],
    ],
  },

  'DM': {
    'address_template': 'generic16',
  },

  'DO': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}}, {{{state}}}
{{{postcode}}}
{{{country}}}
''',
    'postformat_replace': <List<String>>[
      [', Distrito Nacional', ', DN'],
    ],
  },

  'DZ': {
    'address_template': 'generic3',
  },

  'EC': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{{postcode}}}
{{#first}} {{{city}}} || {{{town}}} || {{{state_district}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{{country}}}
''',
  },

  'EG': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{{postcode}}}
{{{country}}}
''',
  },

  'EE': {
    'address_template': 'generic1',
  },

  'EH': {
    'address_template': 'generic17',
  },

  'ER': {
    'address_template': 'generic17',
  },

  'ES': {
    'address_template': 'generic15',
    'fallback_template': 'fallback4',
    'replace': <List<String>>[
      ['Autonomous Community of the ', ''],
      ['Autonomous Community of ', ''],
      ['^Community of ', ''],
    ],
  },

  'ET': {
    'address_template': 'generic1',
  },

  'FI': {
    'address_template': 'generic1',
  },

  'FJ': {
    'address_template': 'generic16',
  },

  'FK': {
    'use_country': 'GB',
    'change_country': 'Falkland Islands, United Kingdom',
  },

  'FM': {
    'address_template': 'generic4',
    'fallback_template': 'fallback2',
    'postformat_replace': <List<String>>[
      ['PNI 96941', 'FM 96941'],
      ['TRK 96942', 'FM 96942'],
      ['YAP 96943', 'FM 96943'],
      ['KSA 96944', 'FM 96944'],
    ],
  },

  'FO': {
    'address_template': 'generic1',
    'postformat_replace': <List<String>>[
      ['Territorial waters of Faroe Islands', 'Faroe Islands'],
    ],
  },

  'FR': {
    'address_template': 'generic3',
    'replace': <List<String>>[
      ['Polynésie française, Îles du Vent \\(eaux territoriales\\)', 'Polynésie française'],
      ['France, Mayotte \\(eaux territoriales\\)', 'Mayotte, France'],
      ['France, La Réunion \\(eaux territoriales\\)', 'La Réunion, France'],
      ['Grande Terre et récifs d\'Entrecasteaux', ''],
      ['France, Nouvelle-Calédonie', 'Nouvelle-Calédonie, France'],
      ['\\(eaux territoriales\\)', ''],
      ['state= \\(France\\)\$', ''],
      ['Paris (\\d+)(\\w+) Arrondissement\$', 'Paris'],
    ],
  },

  'GA': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{municipality}}} || {{{county}}} || {{{state_district}}} || {{{state}}} {{/first}}
{{{country}}}
''',
  },

  'GB': {
    'address_template': 'generic23',
    'fallback_template': 'fallback3',
    'replace': <List<String>>[
      ['village= CP\$', ''],
      ['^Borough of ', ''],
      ['^County( of)? ', ''],
      ['^Parish of ', ''],
      ['^Greater London', 'London'],
      ['^London Borough of ', ''],
      ['Royal Borough of ', ''],
      ['County Borough of ', ''],
    ],
    'postformat_replace': <List<String>>[
      ['London, London', 'London'],
      ['London, Greater London', 'London'],
      ['City of Westminster', 'London'],
      ['City of Nottingham', 'Nottingham'],
      [', United Kingdom\$', '\nUnited Kingdom'],
      ['London\nEngland\nUnited Kingdom', 'London\nUnited Kingdom'],
    ],
  },

  'GD': {
    'address_template': 'generic17',
  },

  'GE': {
    'address_template': 'generic1',
  },

  'GF': {
    'use_country': 'FR',
    'change_country': 'France',
  },

  'GG': {
    'use_country': 'GB',
    'change_country': 'Guernsey, Channel Islands',
  },

  'GH': {
    'address_template': 'generic16',
  },

  'GI': {
    'address_template': 'generic16',
  },

  'GL': {
    'address_template': 'generic1',
  },

  'GM': {
    'address_template': 'generic16',
  },

  'GN': {
    'address_template': 'generic14',
  },

  'GP': {
    'use_country': 'FR',
    'change_country': 'Guadeloupe, France',
  },

  'GQ': {
    'address_template': 'generic17',
  },

  'GR': {
    'address_template': 'generic1',
    'replace': <List<String>>[
      ['Municipal Unit of ', ''],
      ['Regional Unit of ', ''],
    ],
    'postformat_replace': <List<String>>[
      ['\n(\\d{3})(\\d{2}) ', '\n\$1 \$2 '],
    ],
  },

  'GS': {
    'use_country': 'GB',
    'change_country': 'United Kingdom',
    'add_component': 'county=South Georgia',
  },

  'GT': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{{postcode}}}-{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{municipality}}} || {{{state}}} {{/first}}
{{{country}}}
''',
    'postformat_replace': <List<String>>[
      ['\n(\\d{5})- ', '\n\$1-'],
      ['\n -', '\n'],
    ],
  },

  'GU': {
    'use_country': 'US',
    'change_country': 'United States of America',
    'add_component': 'state=Guam',
  },

  'GW': {
    'address_template': 'generic1',
  },

  'GY': {
    'address_template': 'generic16',
  },

  'HK': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{{state_district}}}
{{#first}} {{{state}}} || {{{country}}} {{/first}}
''',
  },

  'HK_en': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{{state_district}}}
{{{state}}}
{{{country}}}
''',
  },

  'HK_zh': {
    'address_template': '''
{{{country}}}
{{{state}}}
{{{state_district}}}
{{{road}}}
{{{house_number}}}
{{{house}}}
{{{attention}}}
''',
  },

  'HM': {
    'use_country': 'AU',
    'change_country': 'Australia',
    'add_component': 'state=Heard Island and McDonald Islands',
  },

  'HN': {
    'address_template': 'generic1',
  },

  'HR': {
    'address_template': 'generic1',
  },

  'HT': {
    'address_template': 'generic1',
    'postformat_replace': <List<String>>[
      [' Commune de ', ' '],
    ],
  },

  'HU': {
    'address_template': '''
{{{attention}}}
{{{postcode}}} {{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{{road}}} {{{house_number}}}.
{{{country}}}
''',
    'postformat_replace': <List<String>>[
      ['\n.\n', '\n'],
    ],
  },

  'ID': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}} {{{postcode}}}
{{{state}}}
{{{country}}}
''',
  },

  'IE': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{municipality}}} {{/first}}
{{{county}}}
{{{postcode}}}
{{{country}}}
''',
    'replace': <List<String>>[
      [' City\$', ''],
      ['The Municipal District of ', ''],
      ['The Metropolitan District of ', ''],
      ['Municipal District', ''],
      ['Electoral Division', ''],
    ],
    'postformat_replace': <List<String>>[
      ['Dublin\nCounty Dublin', 'Dublin'],
      ['Dublin\nLeinster', 'Dublin'],
      ['Galway\nCounty Galway', 'Galway'],
      ['Kilkenny\nCounty Kilkenny', 'Kilkenny'],
      ['Limerick\nCounty Limerick', 'Limerick'],
      ['Tipperary\nCounty Tipperary', 'Tipperary'],
      ['\n(([AC-FHKNPRTV-Y][0-9]{2}|D6W))[ -]?([0-9AC-FHKNPRTV-Y]{4})', '\n\$1 \$3'],
    ],
  },

  'IL': {
    'address_template': 'generic1',
  },

  'IM': {
    'use_country': 'GB',
  },

  'IN': {
    'address_template': 'generic12',
    'postformat_replace': <List<String>>[
      [' -\n', '\n'],
    ],
  },

  'IO': {
    'use_country': 'GB',
    'change_country': 'British Indian Ocean Territory, United Kingdom',
  },

  'IQ': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{#first}} {{{city_district}}} || {{{neighbourhood}}} || {{{suburb}}} {{/first}}
{{{road}}}
{{#first}} {{{city}}} || {{{town}}} || {{{state}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{{postcode}}}
{{{country}}}
''',
  },

  'IR': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{{road}}}
{{{house_number}}}
{{#first}}{{{province}}} || {{{state}}} || {{{state_district}}}{{/first}}
{{{postcode}}}
{{{country}}}
''',
  },

  'IR_en': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{{road}}}
{{{house_number}}}
{{#first}}{{{state}}} || {{{state_district}}}{{/first}}
{{{postcode}}}
{{{country}}}
''',
  },

  'IR_fa': {
    'address_template': '''
{{{country}}}
{{{state}}}
{{{state_district}}}
{{#first}} {{{state}}} || {{{province}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{{road}}}
{{{house_number}}}
{{{house}}}
{{{attention}}}
{{{postcode}}}
''',
  },

  'IS': {
    'address_template': 'generic1',
  },

  'IT': {
    'address_template': 'generic8',
    'replace': <List<String>>[
      ['county=Provincia di ', ''],
      ['county=Province of ', ''],
      ['county=Città Metropolitana di ', ''],
      ['county=Metropolitan City of ', ''],
    ],
    'postformat_replace': <List<String>>[
      ['Vatican City\nVatican City\$', '\nVatican City'],
      ['Città del Vaticano\nCittà del Vaticano\$', 'Città del Vaticano\n'],
    ],
  },

  'JE': {
    'use_country': 'GB',
    'change_country': 'Jersey, Channel Islands',
  },

  'JM': {
    'address_template': 'generic20',
  },

  'JO': {
    'address_template': 'generic1',
  },

  'JP': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}}, {{#first}} {{{state}}} || {{{state_district}}} {{/first}} {{{postcode}}}
{{{country}}}
''',
    'postformat_replace': <List<String>>[
      [' (\\d{3})(\\d{4})\n', ' \$1-\$2\n'],
    ],
  },

  'JP_en': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}}, {{#first}} {{{state}}} || {{{state_district}}} {{/first}} {{{postcode}}}
{{{country}}}
''',
    'postformat_replace': <List<String>>[
      [' (\\d{3})(\\d{4})\n', ' \$1-\$2\n'],
    ],
  },

  'JP_ja': {
    'address_template': '''
{{{country}}}
{{{postcode}}}
{{#first}} {{{state}}} || {{{state_district}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{{road}}}
{{{house_number}}}
{{{house}}}
{{{attention}}}
''',
    'postformat_replace': <List<String>>[
      [' (\\d{3})(\\d{4})\n', ' \$1-\$2\n'],
    ],
  },

  'KE': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{city}}} || {{{town}}} || {{{state}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{{postcode}}}
{{{country}}}
''',
  },

  'KG': {
    'address_template': 'generic11',
  },

  'KH': {
    'address_template': 'generic20',
  },

  'KI': {
    'address_template': 'generic17',
  },

  'KM': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{{country}}}
''',
  },

  'KN': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}}, {{#first}} {{{state}}} || {{{island}}} {{/first}}
{{{country}}}
''',
  },

  'KP': {
    'address_template': 'generic21',
  },

  'KR': {
    'address_template': '''
{{{country}}}
{{{state}}} {{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}} {{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}} {{{road}}} {{{house_number}}}
{{{attention}}}
{{{postcode}}}
''',
    'fallback_template': '''
{{{country}}}
{{{state}}} {{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}} {{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{{attention}}}
''',
  },

  'KR_en': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}, {{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}} {{{postcode}}}
{{{state}}}
{{{country}}}
''',
  },

  'KR_ko': {
    'address_template': '''
{{{country}}}
{{{state}}} {{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}} {{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}} {{{road}}} {{{house_number}}}
{{{attention}}}
{{{postcode}}}
''',
    'fallback_template': '''
{{{country}}}
{{{state}}} {{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}} {{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{{attention}}}
''',
  },

  'KW': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{#first}} {{{area}}} {{{city_block}}} || {{{neighbourhood}}} || {{{city_district}}} || {{{suburb}}} {{/first}}
{{{road}}}
{{{house_number}}} {{{house}}}
{{{postcode}}} {{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{{country}}}
''',
  },

  'KY': {
    'address_template': 'generic2',
  },

  'KZ': {
    'address_template': 'generic11',
  },

  'LA': {
    'address_template': 'generic22',
  },

  'LB': {
    'address_template': 'generic2',
    'postformat_replace': <List<String>>[
      [' (\\d{4}) (\\d{4})\n', ' \$1 \$2\n'],
    ],
  },

  'LC': {
    'address_template': 'generic17',
  },

  'LI': {
    'use_country': 'CH',
  },

  'LK': {
    'address_template': 'generic20',
  },

  'LR': {
    'address_template': 'generic1',
  },

  'LS': {
    'address_template': 'generic2',
  },

  'LT': {
    'address_template': 'generic1',
  },

  'LU': {
    'address_template': 'generic3',
  },

  'LV': {
    'address_template': 'generic7',
  },

  'LY': {
    'address_template': 'generic17',
  },

  'MA': {
    'address_template': 'generic3',
  },

  'MC': {
    'address_template': 'generic3',
    'fallback_template': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{{place}}}
{{#first}} {{{neighbourhood}}} || {{{city_district}}} || {{{municipality}}} || {{{suburb}}}{{/first}}
{{{city}}}
{{{country}}}
''',
    'postformat_replace': <List<String>>[
      ['Monaco\nMonaco', 'Monaco'],
    ],
  },

  'MD': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{road}}}, {{{house_number}}}
{{{postcode}}} {{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{state}}} {{/first}}
{{{country}}}
''',
  },

  'ME': {
    'address_template': 'generic1',
  },

  'MF': {
    'use_country': 'FR',
    'change_country': 'France',
  },

  'MH': {
    'address_template': 'generic4',
    'fallback_template': 'fallback2',
    'postformat_replace': <List<String>>[
      [', 96060', ', MH 96060'],
      [', 96070', ', MH 96070'],
    ],
  },

  'MG': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{{postcode}}} {{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{{country}}}
''',
  },

  'MK': {
    'address_template': 'generic1',
  },

  'ML': {
    'address_template': 'generic17',
  },

  'MM': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{state}}} {{/first}}, {{{postcode}}}
{{{country}}}
''',
  },

  'MN': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{city_district}}}
{{#first}} {{{suburb}}} || {{{neighbourhood}}} {{/first}}
{{{road}}}
{{{house_number}}}
{{{postcode}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{{country}}}
''',
  },

  'MO': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{#first}} {{{suburb}}} || {{{village}}} || {{{hamlet}}} || {{{state_district}}} {{/first}}
{{{country}}}
''',
  },

  'MO_pt': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{#first}} {{{suburb}}} || {{{village}}} || {{{hamlet}}} || {{{state_district}}} {{/first}}
{{{country}}}
''',
  },

  'MO_zh': {
    'address_template': '''
{{{country}}}
{{#first}} {{{suburb}}} || {{{village}}} || {{{hamlet}}} || {{{state_district}}} {{/first}}
{{{road}}}
{{{house_number}}}
{{{house}}}
{{{attention}}}
''',
  },

  'MP': {
    'use_country': 'US',
    'change_country': 'United States of America',
    'add_component': 'state=Northern Mariana Islands',
  },

  'MS': {
    'address_template': 'generic16',
  },

  'MT': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{city}}} || {{{town}}} || {{{suburb}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{{postcode}}}
{{{country}}}
''',
  },

  'MQ': {
    'use_country': 'FR',
    'change_country': 'Martinique, France',
  },

  'MR': {
    'address_template': 'generic18',
  },

  'MU': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}}, {{{road}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{state}}} {{/first}} {{{postcode}}}
{{{country}}}
''',
  },

  'MV': {
    'address_template': 'generic2',
  },

  'MW': {
    'address_template': 'generic16',
  },

  'MX': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{{postcode}}} {{#first}} {{{city}}} || {{{town}}} || {{{state_district}}} || {{{village}}} || {{{hamlet}}} {{/first}}, {{#first}} {{{state_code}}} || {{{state}}} {{/first}}
{{{country}}}
''',
  },

  'MY': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{{postcode}}} {{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{{state}}}
{{{country}}}
''',
  },

  'MZ': {
    'address_template': 'generic15',
    'fallback_template': 'fallback4',
  },

  'NA': {
    'address_template': 'generic2',
  },

  'NC': {
    'use_country': 'FR',
    'change_country': 'Nouvelle-Calédonie, France',
  },

  'NE': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}}
{{{road}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{{country}}}
''',
  },

  'NF': {
    'use_country': 'AU',
    'change_country': 'Australia',
    'add_component': 'state=Norfolk Island',
  },

  'NG': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}} {{{postcode}}}
{{{state}}}
{{{country}}}
''',
  },

  'NI': {
    'address_template': 'generic21',
  },

  'NL': {
    'address_template': 'generic1',
    'postformat_replace': <List<String>>[
      ['\n(\\d{4})(\\w{2}) ', '\n\$1 \$2 '],
      ['\nKoninkrijk der Nederlanden\$', '\nNederland'],
    ],
  },

  'NO': {
    'address_template': 'generic1',
  },

  'NP': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{#first}} {{{suburb}}} || {{{neighbourhood}}} || {{{city}}} {{/first}}
{{#first}} {{{municipality}}} || {{{county}}} || {{{state_district}}} || {{{state}}} {{/first}} {{{postcode}}}
{{{country}}}
''',
  },

  'NR': {
    'address_template': 'generic16',
  },

  'NU': {
    'address_template': 'generic16',
  },

  'NZ': {
    'address_template': 'generic20',
    'postformat_replace': <List<String>>[
      ['Wellington\nWellington City', 'Wellington'],
    ],
  },

  'OM': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{{postcode}}}
{{#first}} {{{city}}} || {{{town}}} || {{{state_district}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{{state}}}
{{{country}}}
''',
  },

  'PA': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{{postcode}}}
{{#first}} {{{city}}} || {{{town}}} || {{{state_district}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{{state}}}
{{{country}}}
''',
    'replace': <List<String>>[
      ['city=Panama\$', 'Panama City'],
      ['city=Panamá\$', 'Ciudad de Panamá'],
    ],
  },

  'PE': {
    'address_template': 'generic19',
  },

  'PF': {
    'use_country': 'FR',
    'change_country': 'Polynésie française, France',
    'replace': <List<String>>[
      ['Polynésie française, Îles du Vent \\(eaux territoriales\\)', 'Polynésie française'],
    ],
  },

  'PG': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}} {{{postcode}}} {{{state}}}
{{{country}}}
''',
  },

  'PH': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}, {{#first}}{{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}}{{/first}}, {{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{suburb}}} || {{{state_district}}} {{/first}}
{{{postcode}}} {{#first}} {{{municipality}}} || {{{region}}} || {{{state}}} {{/first}}
{{{country}}}
''',
  },

  'PK': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{state}}} {{/first}} {{{postcode}}}
{{{country}}}
''',
  },

  'PL': {
    'address_template': 'generic1',
    'postformat_replace': <List<String>>[
      ['\n(\\d{2})(\\w{3}) ', '\n\$1-\$2 '],
    ],
  },

  'PM': {
    'use_country': 'FR',
    'change_country': 'Saint-Pierre-et-Miquelon, France',
  },

  'PN': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{#first}} {{{city}}} || {{{town}}} || {{{island}}} {{/first}}
{{{country}}}
''',
  },

  'PR': {
    'use_country': 'US',
    'change_country': 'United States of America',
    'add_component': 'state=Puerto Rico',
  },

  'PS': {
    'use_country': 'IL',
  },

  'PT': {
    'address_template': 'generic1',
    'postformat_replace': <List<String>>[
      ['\n(\\d{4})(\\d{3}) ', '\n\$1-\$2 '],
    ],
  },

  'PW': {
    'address_template': 'generic1',
  },

  'PY': {
    'address_template': 'generic1',
  },

  'QA': {
    'address_template': 'generic17',
  },

  'RE': {
    'use_country': 'FR',
    'change_country': 'La Réunion, France',
  },

  'RO': {
    'address_template': 'generic1',
  },

  'RS': {
    'address_template': 'generic1',
  },

  'RU': {
    'address_template': 'generic10',
    'fallback_template': '''
{{{attention}}}
{{{house}}}
{{{road}}}, {{{house_number}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} || {{{island}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{municipality}}} {{/first}}
{{#first}} {{{county}}} || {{{state_district}}} || {{{state}}} {{/first}}
{{{country}}}
''',
  },

  'RW': {
    'address_template': 'generic16',
  },

  'SA': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}, {{#first}} {{{village}}} || {{{hamlet}}} || {{{city_district}}} || {{{suburb}}} || {{{neighbourhood}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{state_district}}} {{/first}} {{{postcode}}}
{{{country}}}
''',
  },

  'SB': {
    'address_template': 'generic17',
  },

  'SC': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{island}}} {{/first}}
{{{island}}}
{{{country}}}
''',
  },

  'SD': {
    'address_template': 'generic1',
  },

  'SE': {
    'address_template': 'generic1',
    'postformat_replace': <List<String>>[
      ['\n(\\d{3})(\\d{2}) ', '\n\$1 \$2 '],
    ],
  },

  'SG': {
    'address_template': '''
{{{attention}}}
{{{house}}}, {{{quarter}}}
{{{house_number}}} {{{road}}}, {{{residential}}}
{{#first}} {{{country}}} || {{{town}}} || {{{city}}} || {{{municipality}}} || {{{hamlet}}} || {{{village}}} || {{{county}}} {{/first}} {{{postcode}}}
''',
  },

  'SH': {
    'use_country': 'GB',
    'change_country': '\$state, United Kingdom',
  },

  'SI': {
    'address_template': 'generic1',
  },

  'SJ': {
    'use_country': 'NO',
    'change_country': 'Norway',
  },

  'SK': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{{postcode}}} {{#first}} {{{postal_city}}} || {{{city}}} || {{{town}}} || {{{village}}} || {{{municipality}}} || {{{city_district}}} || {{{hamlet}}} || {{{county}}} || {{{state}}} {{/first}}
{{{country}}}
''',
    'replace': <List<String>>[
      ['^District of ', ''],
      ['^Region of ', ''],
    ],
    'postformat_replace': <List<String>>[
      ['\n(\\d{3})(\\d{2}) ', '\n\$1 \$2 '],
    ],
  },

  'SL': {
    'address_template': 'generic16',
  },

  'SM': {
    'use_country': 'IT',
  },

  'SN': {
    'address_template': 'generic3',
    'replace': <List<String>>[
      ['^Commune de ', ''],
      ['^Arrondissement de ', ''],
      ['^Département de ', ''],
    ],
  },

  'SO': {
    'address_template': 'generic21',
  },

  'SR': {
    'address_template': 'generic21',
  },

  'SS': {
    'address_template': 'generic17',
  },

  'ST': {
    'address_template': 'generic17',
  },

  'SV': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{{postcode}}} - {{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{{state}}}
{{{country}}}
''',
    'postformat_replace': <List<String>>[
      ['\n- ', '\n '],
    ],
  },

  'SX': {
    'address_template': 'generic17',
  },

  'SY': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{road}}}, {{{house_number}}}
{{#first}} {{{village}}} || {{{hamlet}}} || {{{city_district}}} || {{{neighbourhood}}} || {{{suburb}}} {{/first}}
{{{postcode}}} {{#first}} {{{city}}} || {{{town}}} || {{{state_district}}} || {{{state}}} {{/first}}

{{{country}}}
''',
  },

  'SZ': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{state}}} {{/first}}
{{{postcode}}}
{{{country}}}
''',
  },

  'TC': {
    'address_template': 'generic23',
    'fallback_template': '''
{{{attention}}}
{{{house_number}}} {{{road}}}
{{{quarter}}}
{{#first}} {{{village}}} || {{{town}}} || {{{city}}} || {{{municipality}}} || {{{hamlet}}} || {{{county}}} {{/first}}
{{{island}}}
{{{country}}}
''',
  },

  'TD': {
    'address_template': 'generic21',
  },

  'TF': {
    'use_country': 'FR',
    'change_country': 'Terres australes et antarctiques françaises, France',
  },

  'TG': {
    'address_template': 'generic18',
  },

  'TH': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{#first}} {{{village}}} || {{{hamlet}}} {{/first}}
{{{road}}}
{{#first}} {{{neighbourhood}}} || {{{city}}} || {{{town}}} {{/first}}, {{#first}} {{{suburb}}} || {{{city_district}}} || {{{state_district}}} {{/first}}
{{{state}}} {{{postcode}}}
{{{country}}}
''',
  },

  'TJ': {
    'address_template': 'generic1',
  },

  'TK': {
    'use_country': 'NZ',
    'change_country': 'Tokelau, New Zealand',
  },

  'TL': {
    'address_template': 'generic17',
  },

  'TM': {
    'address_template': 'generic22',
  },

  'TN': {
    'address_template': 'generic3',
  },

  'TO': {
    'address_template': 'generic16',
  },

  'TR': {
    'address_template': 'generic1',
  },

  'TT': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{state_district}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{state_district}}} || {{{village}}} || {{{hamlet}}} {{/first}}, {{{postcode}}}
{{{country}}}
''',
  },

  'TV': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{municipality}}} {{/first}}
{{#first}} {{{county}}} || {{{state_district}}} || {{{state}}} || {{{island}}} {{/first}}
{{{country}}}
''',
  },

  'TW': {
    'address_template': '''
{{{country}}}
{{{postcode}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{municipality}}} {{/first}} {{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}} {{{road}}} {{{house_number}}}
{{{house}}}
{{{attention}}}
''',
  },

  'TW_en': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}}, {{{road}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}, {{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}} {{{postcode}}}
{{{country}}}
''',
  },

  'TW_zh': {
    'address_template': '''
{{{country}}}
{{{postcode}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{municipality}}} {{/first}} {{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}} {{{road}}} {{{house_number}}}
{{{house}}}
{{{attention}}}
''',
  },

  'TZ': {
    'address_template': 'generic14',
    'fallback_template': 'generic14',
    'postformat_replace': <List<String>>[
      ['Dar es Salaam\nDar es Salaam', 'Dar es Salaam'],
    ],
  },

  'UA': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{road}}}, {{{house_number}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{state_district}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{municipality}}} {{/first}}
{{#first}} {{{region}}} || {{{state}}} {{/first}}
{{{postcode}}}
{{{country}}}
''',
  },

  'UG': {
    'address_template': 'generic16',
  },

  'UM': {
    'fallback_template': 'fallback2',
    'use_country': 'US',
    'change_country': 'United States of America',
    'add_component': 'state=US Minor Outlying Islands',
  },

  'US': {
    'address_template': 'generic4',
    'fallback_template': 'fallback2',
    'replace': <List<String>>[
      ['state=United States Virgin Islands', 'US Virgin Islands'],
      ['state=USVI', 'US Virgin Islands'],
    ],
    'postformat_replace': <List<String>>[
      ['\nUS\$', '\nUnited States of America'],
      ['\nUSA\$', '\nUnited States of America'],
      ['\nUnited States\$', '\nUnited States of America'],
      ['Town of ', ''],
      ['Township of ', ''],
    ],
  },

  'UZ': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}}
{{#first}} {{{state}}} || {{{state_district}}} {{/first}}
{{{country}}}
{{{postcode}}}
''',
  },

  'UY': {
    'address_template': 'generic1',
  },

  'VA': {
    'use_country': 'IT',
  },

  'VC': {
    'address_template': 'generic17',
  },

  'VE': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{road}}} {{{house_number}}}
{{#first}} {{{city}}} || {{{town}}} || {{{state_district}}} || {{{village}}} || {{{hamlet}}} {{/first}} {{{postcode}}}, {{#first}} {{{state_code}}} || {{{state}}} {{/first}}
{{{country}}}
''',
  },

  'VG': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} {{/first}}, {{{island}}}
{{{country}}}, {{{postcode}}}
''',
  },

  'VI': {
    'use_country': 'US',
    'change_country': 'United States of America',
    'add_component': 'state=US Virgin Islands',
  },

  'VN': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{neighbourhood}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{state_district}}} {{/first}}
{{{state}}} {{{postcode}}}
{{{country}}}
''',
  },

  'VU': {
    'address_template': 'generic17',
  },

  'WF': {
    'use_country': 'FR',
    'change_country': 'Wallis-et-Futuna, France',
  },

  'WS': {
    'address_template': 'generic17',
  },

  'XC': {
    'address_template': 'generic6',
  },

  'XK': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}}, {{{road}}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{state}}} {{/first}} {{{postcode}}}
{{{country}}}
''',
  },

  'YE': {
    'address_template': 'generic18',
  },

  'YT': {
    'use_country': 'FR',
    'change_country': 'Mayotte, France',
  },

  'ZA': {
    'address_template': '''
{{{attention}}}
{{{house}}}
{{{house_number}}} {{{road}}}
{{#first}} {{{suburb}}} || {{{city_district}}} || {{{state_district}}} {{/first}}
{{#first}} {{{city}}} || {{{town}}} || {{{village}}} || {{{hamlet}}} || {{{state}}} {{/first}}
{{{postcode}}}
{{{country}}}
''',
  },

  'ZM': {
    'address_template': 'generic3',
  },

  'ZW': {
    'address_template': 'generic16',
  },

};
