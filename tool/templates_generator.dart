// tool/templates_generator.dart
//
// Build-time code generator — never shipped to clients.
// Run with: dart run tool/templates_generator.dart [--local <conf-dir>]
//
// With --local: reads OpenCage YAML from the given local conf/ directory.
//   Example: dart run tool/templates_generator.dart --local tool/address-formatting/conf
//
// Without --local: fetches OpenCage YAML from the upstream repository.
//
// Note: territory_names.g.dart is always fetched from CLDR (network required),
// regardless of --local.
//
// Generated files (in lib/src/generated/):
//   abbreviations.g.dart    — per-language word → abbreviation maps
//   worldwide.g.dart        — mustache templates + per-country format entries
//   territory_names.g.dart  — country display names in 82 languages (CLDR)
//   components.g.dart       — canonical component names and aliases
//   country_codes.g.dart    — ISO 3166-1 alpha-2 code set
//   country2lang.g.dart     — country → official language codes
//   county_codes.g.dart     — county/district codes per country
//   state_codes.g.dart      — state/province codes per country

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:yaml/yaml.dart';

// ---------------------------------------------------------------------------
// Configuration
// ---------------------------------------------------------------------------

const _baseUrl =
    'https://raw.githubusercontent.com/OpenCageData/address-formatting/'
    'master/conf';

const _cldrBaseUrl =
    'https://raw.githubusercontent.com/unicode-org/cldr-json/main/'
    'cldr-json/cldr-localenames-full/main';

const _outputDir = 'lib/src/generated';

// Language codes from kMaterialSupportedLanguages (Flutter localizations).
// Used to generate kTerritoryNames in territory_names.g.dart.
const _materialLanguages = [
  'af', 'am', 'ar', 'as', 'az', 'be', 'bg', 'bn', 'bo', 'bs',
  'ca', 'cs', 'cy', 'da', 'de', 'el', 'en', 'es', 'et', 'eu',
  'fa', 'fi', 'fil', 'fr', 'ga', 'gl', 'gsw', 'gu', 'he', 'hi',
  'hr', 'hu', 'hy', 'id', 'is', 'it', 'ja', 'ka', 'kk', 'km',
  'kn', 'ko', 'ky', 'lo', 'lt', 'lv', 'mk', 'ml', 'mn', 'mr',
  'ms', 'my', 'nb', 'ne', 'nl', 'no', 'or', 'pa', 'pl', 'ps',
  'pt', 'ro', 'ru', 'si', 'sk', 'sl', 'sq', 'sr', 'sv', 'sw',
  'ta', 'te', 'th', 'tl', 'tr', 'ug', 'uk', 'ur', 'uz', 'vi',
  'zh', 'zu',
];

// Language codes for conf/abbreviations/*.yaml, in alphabetical order.
// Used for remote fetching; local mode discovers files dynamically.
const _abbreviationLanguages = [
  'ca', 'cs', 'da', 'de', 'en', 'es', 'et', 'eu', 'fi', 'fr',
  'gl', 'hu', 'it', 'nl', 'no', 'pl', 'pt', 'ro', 'ru', 'sk',
  'sl', 'sv', 'tr', 'uk', 'vi',
];

// Named anchor/alias keys from worldwide.yaml stored in kAddressTemplates.
const _sharedTemplateKeys = {
  'generic1',  'generic2',  'generic3',  'generic4',  'generic5',
  'generic6',  'generic7',  'generic8',  'generic9',  'generic10',
  'generic11', 'generic12', 'generic13', 'generic14', 'generic15',
  'generic16', 'generic17', 'generic18', 'generic19', 'generic20',
  'generic21', 'generic22', 'generic23',
  'fallback1', 'fallback2', 'fallback3', 'fallback4',
};

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------

void main(List<String> args) async {
  final localIdx = args.indexOf('--local');
  final confDir = localIdx != -1 && localIdx + 1 < args.length
      ? args[localIdx + 1]
      : null;

  if (confDir != null) {
    stdout.writeln('Using local conf dir: $confDir');
  } else {
    stdout.writeln('Fetching from OpenCage address-formatting repository...');
  }

  Directory(_outputDir).createSync(recursive: true);

  await Future.wait([
    _generateAbbreviations(confDir),
    _generateWorldwideAddressTemplates(confDir),
    _generateTerritoryNames(),
    _generateComponents(confDir),
    _generateCountryCodes(confDir),
    _generateCountry2Lang(confDir),
    _generateCodeMap(
      confDir: confDir,
      yamlPath: 'state_codes.yaml',
      outputFile: 'state_codes.g.dart',
      constName: 'kStateCodes',
      docComment:
          '/// State and province codes, keyed by ISO 3166-1 alpha-2 country code.\n'
          '///\n'
          "/// Structure: `CC → code → {'default': name, 'alt_en': englishName}`.\n"
          '/// Used by [AddressFormatter] to resolve a `state` name to its\n'
          '/// abbreviated `state_code` for use in templates such as `generic4`.',
    ),
    _generateCodeMap(
      confDir: confDir,
      yamlPath: 'county_codes.yaml',
      outputFile: 'county_codes.g.dart',
      constName: 'kCountyCodes',
      docComment:
          '/// County and district codes, keyed by ISO 3166-1 alpha-2 country code.\n'
          '///\n'
          "/// Structure: `CC → code → {'default': name, 'alt_en': englishName}`.\n"
          '/// Used by [AddressFormatter] to resolve a `county` name to its\n'
          '/// abbreviated `county_code` for use in templates such as `generic8`.',
    ),
  ]);

  stdout.writeln('Done.');
}

// ---------------------------------------------------------------------------
// YAML reading
// ---------------------------------------------------------------------------

// Reads a YAML file from confDir/relativePath in local mode, or fetches it
// from the OpenCage repository when confDir is null.
Future<String> _readConf(String? confDir, String relativePath) async {
  if (confDir != null) {
    final path = '$confDir/$relativePath';
    stdout.writeln('Reading $path ...');
    return File(path).readAsStringSync();
  }
  final url = '$_baseUrl/$relativePath';
  stdout.writeln('Fetching $url ...');
  final response = await http.get(Uri.parse(url));
  if (response.statusCode != 200) {
    throw Exception('HTTP ${response.statusCode} fetching $url');
  }
  return response.body;
}

// ---------------------------------------------------------------------------
// Generator: abbreviations.g.dart
// ---------------------------------------------------------------------------

// Generates abbreviations.g.dart from the per-language YAML files under
// conf/abbreviations/. In local mode, files are discovered dynamically so
// new languages added to the submodule are picked up automatically.
Future<void> _generateAbbreviations(String? confDir) async {
  // Collect {lang → YamlMap} for all abbreviation files.
  final langDocs = <String, YamlMap>{};

  if (confDir != null) {
    // Local: discover files dynamically so new languages are picked up
    // automatically when the submodule is updated.
    final dir = Directory('$confDir/abbreviations');
    final files = dir.listSync().whereType<File>()
        .where((f) => f.path.endsWith('.yaml'))
        .toList()
        ..sort((a, b) => a.path.compareTo(b.path));
    for (final file in files) {
      final lang = file.uri.pathSegments.last.replaceAll('.yaml', '');
      stdout.writeln('Reading ${file.path} ...');
      langDocs[lang] = loadYaml(file.readAsStringSync()) as YamlMap;
    }
  } else {
    // Remote: fetch each known language file in parallel.
    await Future.wait(
      _abbreviationLanguages.map((lang) async {
        final raw = await _readConf(null, 'abbreviations/$lang.yaml');
        langDocs[lang] = loadYaml(raw) as YamlMap;
      }),
    );
  }

  final buf = StringBuffer();
  buf.writeln('// GENERATED FILE — do not edit by hand.');
  buf.writeln('// Regenerate with: dart run tool/templates_generator.dart');
  buf.writeln('//');
  buf.writeln('// Source: OpenCageData/address-formatting/conf/abbreviations/');
  buf.writeln('// ignore_for_file: constant_identifier_names, lines_longer_than_80_chars');
  buf.writeln();
  buf.writeln('/// Per-language abbreviation maps, keyed by ISO 639-1 language code.');
  buf.writeln('///');
  buf.writeln('/// Structure: language → component → full word → abbreviation.');
  buf.writeln("/// Example: kAbbreviations['en']['road']['Avenue'] == 'Ave'");
  buf.writeln('const Map<String, Map<String, Map<String, String>>> kAbbreviations = {');

  for (final lang in langDocs.keys.toList()..sort()) {
    final doc = langDocs[lang]!;
    buf.writeln("  ${_dartSingleString(lang)}: {");
    for (final compKey in doc.keys) {
      final component = compKey as String;
      final entries = doc[component];
      if (entries is! YamlMap) continue;
      buf.writeln("    ${_dartSingleString(component)}: {");
      for (final wordKey in entries.keys) {
        final word = wordKey as String;
        final abbrev = entries[word];
        if (abbrev is! String) continue;
        buf.writeln("      ${_dartSingleString(word)}: ${_dartSingleString(abbrev)},");
      }
      buf.writeln('    },');
    }
    buf.writeln('  },');
  }

  buf.writeln('};');

  File('$_outputDir/abbreviations.g.dart').writeAsStringSync(buf.toString());
  stdout.writeln('Written → $_outputDir/abbreviations.g.dart');
}

// ---------------------------------------------------------------------------
// Generator: worldwide.g.dart
// ---------------------------------------------------------------------------

// Generates worldwide.g.dart from conf/countries/worldwide.yaml.
// Emits kAddressTemplates (shared mustache templates) and kAddressCountries
// (per-country format entries).
Future<void> _generateWorldwideAddressTemplates(String? confDir) async {
  final raw = await _readConf(confDir, 'countries/worldwide.yaml');
  stdout.writeln('Parsing worldwide.yaml ...');
  final doc = loadYaml(raw) as YamlMap;
  stdout.writeln('Converting ...');
  final result = _convertAddressFormats(doc);
  File('$_outputDir/worldwide.g.dart').writeAsStringSync(result);
  stdout.writeln('Written → $_outputDir/worldwide.g.dart');
}

// Converts the parsed worldwide.yaml doc into the Dart source for
// worldwide.g.dart.
String _convertAddressFormats(YamlMap doc) {
  // 1. Shared templates
  final sharedTemplates = <String, String>{};
  for (final key in _sharedTemplateKeys) {
    final value = doc[key];
    if (value is String) sharedTemplates[key] = value;
  }

  // Reverse index: template text → anchor name, to compact per-country entries.
  final reverseIndex = <String, String>{
    for (final e in sharedTemplates.entries) e.value: e.key,
  };

  // 2. Country / language-variant entries
  final countries = <String, Map<String, Object>>{};
  for (final rawKey in doc.keys) {
    final key = rawKey as String;
    if (_sharedTemplateKeys.contains(key)) continue;
    final entry = doc[key];
    if (entry is! YamlMap) continue;

    final country = <String, Object>{};

    final addrTmpl = entry['address_template'];
    if (addrTmpl is String) {
      country['address_template'] = reverseIndex[addrTmpl] ?? addrTmpl;
    }

    final fallbackTmpl = entry['fallback_template'];
    if (fallbackTmpl is String) {
      country['fallback_template'] = reverseIndex[fallbackTmpl] ?? fallbackTmpl;
    }

    final useCountry = entry['use_country'];
    if (useCountry is String) country['use_country'] = useCountry;

    final changeCountry = entry['change_country'];
    if (changeCountry is String) country['change_country'] = changeCountry;

    final addComponent = entry['add_component'];
    if (addComponent is String) country['add_component'] = addComponent;

    final replace = _parseReplacePairs(entry['replace']);
    if (replace.isNotEmpty) country['replace'] = replace;

    final postformat = _parseReplacePairs(entry['postformat_replace']);
    if (postformat.isNotEmpty) country['postformat_replace'] = postformat;

    if (country.isNotEmpty) countries[key] = country;
  }

  // 3. Emit Dart source
  final buf = StringBuffer();
  buf.writeln('// GENERATED FILE — do not edit by hand.');
  buf.writeln('// Regenerate with: dart run tool/templates_generator.dart');
  buf.writeln('//');
  buf.writeln('// Source: OpenCageData/address-formatting/conf/countries/worldwide.yaml');
  buf.writeln('//   https://github.com/OpenCageData/address-formatting');
  buf.writeln('//');
  buf.writeln('// Why a .dart file and not JSON?');
  buf.writeln('// • Zero runtime cost: const maps are resolved at compile time —');
  buf.writeln('//   no file I/O, no JSON parsing, no heap allocation on cold start.');
  buf.writeln('// • No asset pipeline: a JSON asset in a Dart/Flutter package');
  buf.writeln('//   requires pubspec registration and an async load, which would');
  buf.writeln('//   force AddressFormatter.format to become async.');
  buf.writeln('// • Type safety: the emitted types match exactly what');
  buf.writeln('//   AddressFormatter expects; a JSON file would require dynamic casts.');
  buf.writeln('// ignore_for_file: constant_identifier_names, lines_longer_than_80_chars');
  buf.writeln();

  buf.writeln('/// Named mustache template strings shared across many countries.');
  buf.writeln('/// Keys: generic1…generic23, fallback1…fallback4.');
  buf.writeln('/// Consumed by [AddressFormatter] via [kAddressCountries] entries');
  buf.writeln("/// whose 'address_template' / 'fallback_template' values are");
  buf.writeln('/// one of these keys rather than inline mustache text.');
  buf.writeln('const Map<String, String> kAddressTemplates = {');
  for (final e in sharedTemplates.entries) {
    buf.writeln("  '${e.key}': ${_dartMultilineString(e.value)},");
    buf.writeln();
  }
  buf.writeln('};');
  buf.writeln();

  buf.writeln('/// Per-country (and per-language-variant) address format entries.');
  buf.writeln('///');
  buf.writeln("/// 'address_template'   — key in [kAddressTemplates] or inline mustache");
  buf.writeln("/// 'fallback_template'  — same; used when main template yields empty output");
  buf.writeln("/// 'use_country'        — delegate format rules to another ISO code");
  buf.writeln("/// 'change_country'     — override the country name component");
  buf.writeln("/// 'add_component'      — inject a fixed component e.g. 'state=Foo'");
  buf.writeln("/// 'replace'            — `List<List<String>>` pre-render [pattern, replacement]");
  buf.writeln("/// 'postformat_replace' — `List<List<String>>` post-render [pattern, replacement]");
  buf.writeln('const Map<String, Map<String, Object>> kAddressCountries = {');
  for (final e in countries.entries) {
    buf.writeln("  '${e.key}': {");
    _writeCountryEntry(buf, e.value);
    buf.writeln('  },');
    buf.writeln();
  }
  buf.writeln('};');

  return buf.toString();
}

// ---------------------------------------------------------------------------
// Generator: territory_names.g.dart
// ---------------------------------------------------------------------------

// Generates territory_names.g.dart by fetching CLDR territory display names
// for every language in _materialLanguages. Locales that return a non-200
// status are skipped silently (e.g. 'no', 'tl' may not exist as top-level
// CLDR locales). Always fetches from the network; not affected by --local.
Future<void> _generateTerritoryNames() async {
  final langData = <String, Map<String, String>>{};
  var resolved = 0;
  final ccPattern = RegExp(r'^[A-Z]{2}$');

  await Future.wait(
    _materialLanguages.map((lang) async {
      final url = '$_cldrBaseUrl/$lang/territories.json';
      stdout.writeln('Fetching $url ...');
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        stdout.writeln('  [skip] $lang: HTTP ${response.statusCode}');
        return;
      }
      try {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final main = json['main'] as Map<String, dynamic>;
        final localeData = main.values.first as Map<String, dynamic>;
        final territories = (localeData['localeDisplayNames']
            as Map<String, dynamic>)['territories'] as Map<String, dynamic>;

        // Keep only 2-letter uppercase country codes, discarding M49 numeric
        // region codes and hyphenated keys (alt-short, alt-variant, etc.).
        // Where a preferred short form exists (CC-alt-short with length > 2),
        // use it in place of the verbose standard form, so that each territory
        // code maps to exactly one display name.
        langData[lang] = Map<String, String>.fromEntries(
          territories.keys
              .where(ccPattern.hasMatch)
              .map((cc) {
                final altShort = territories['$cc-alt-short'];
                final name = (altShort is String && altShort.length > 2)
                    ? altShort
                    : (territories[cc] as String);
                return MapEntry(cc, name);
              }),
        );
        resolved++;
      } catch (e) {
        stdout.writeln('  [skip] $lang: parse error ($e)');
      }
    }),
  );

  stdout.writeln(
    'Territory names: resolved $resolved/${_materialLanguages.length} languages.',
  );

  final buf = StringBuffer();
  buf.writeln('// GENERATED FILE — do not edit by hand.');
  buf.writeln('// Regenerate with: dart run tool/templates_generator.dart');
  buf.writeln('//');
  buf.writeln('// Source: unicode-org/cldr-json (cldr-localenames-full)');
  buf.writeln('//   https://github.com/unicode-org/cldr-json');
  buf.writeln('// ignore_for_file: constant_identifier_names, lines_longer_than_80_chars');
  buf.writeln();
  buf.writeln('/// Country display names keyed first by ISO 639-1 language code,');
  buf.writeln('/// then by ISO 3166-1 alpha-2 territory code.');
  buf.writeln('///');
  buf.writeln('/// Each territory code maps to exactly one display name: the CLDR');
  buf.writeln('/// short form (alt-short) when one exists, otherwise the standard form.');
  buf.writeln('/// M49 numeric region codes and hyphenated alt-* keys are excluded;');
  buf.writeln('/// two-letter non-country codes (EU, EZ, …) are retained but never');
  buf.writeln('/// looked up at runtime since they do not appear in [kCountryCodes].');
  buf.writeln('///');
  buf.writeln('/// The set of supported language codes mirrors');
  // ignore_for_file line keeps the long URL from triggering a lint warning.
  buf.writeln(
    '/// [kMaterialSupportedLanguages](https://api.flutter.dev/flutter/flutter_localizations/kMaterialSupportedLanguages.html).',
  );
  buf.writeln('/// Pass a language code as the `countryNameLanguageCode` parameter of');
  buf.writeln('/// [AddressFormatter.format]; unsupported codes fall back to `\'en\'`.');
  buf.writeln('const Map<String, Map<String, String>> kTerritoryNames = {');

  for (final lang in _materialLanguages) {
    final territories = langData[lang];
    if (territories == null) continue;
    buf.writeln("  ${_dartSingleString(lang)}: {");
    final sorted = territories.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    for (final e in sorted) {
      buf.writeln("    ${_dartSingleString(e.key)}: ${_dartSingleString(e.value)},");
    }
    buf.writeln('  },');
  }

  buf.writeln('};');

  File('$_outputDir/territory_names.g.dart').writeAsStringSync(buf.toString());
  stdout.writeln('Written → $_outputDir/territory_names.g.dart');
}

// ---------------------------------------------------------------------------
// Generator: components.g.dart
// ---------------------------------------------------------------------------

// Generates components.g.dart from conf/components.yaml.
// Emits kComponentNames (ordered canonical names) and kComponentAliases
// (Nominatim/OSM alias → canonical name).
Future<void> _generateComponents(String? confDir) async {
  final raw = await _readConf(confDir, 'components.yaml');
  final names = <String>[];
  final aliases = <String, String>{};

  // loadYamlStream returns a YamlList of each document's contents node.
  for (final node in loadYamlStream(raw)) {
    if (node is! YamlMap) continue;
    final name = node['name'] as String;
    names.add(name);
    final aliasList = node['aliases'];
    if (aliasList is YamlList) {
      for (final alias in aliasList) {
        if (alias is String) aliases[alias] = name;
      }
    }
  }

  final buf = StringBuffer();
  buf.writeln('// GENERATED FILE — do not edit by hand.');
  buf.writeln('// Regenerate with: dart run tool/templates_generator.dart');
  buf.writeln('//');
  buf.writeln('// Source: OpenCageData/address-formatting/conf/components.yaml');
  buf.writeln('// ignore_for_file: constant_identifier_names, lines_longer_than_80_chars');
  buf.writeln();
  buf.writeln('/// Canonical component names, ordered from smallest to largest geographic unit.');
  buf.writeln('const List<String> kComponentNames = [');
  for (final name in names) {
    buf.writeln("  ${_dartSingleString(name)},");
  }
  buf.writeln('];');
  buf.writeln();
  buf.writeln('/// Maps alias names to their canonical component name.');
  buf.writeln("/// Example: 'street' → 'road', 'suburb' → 'neighbourhood'.");
  buf.writeln('const Map<String, String> kComponentAliases = {');
  for (final e in aliases.entries) {
    buf.writeln("  ${_dartSingleString(e.key)}: ${_dartSingleString(e.value)},");
  }
  buf.writeln('};');

  File('$_outputDir/components.g.dart').writeAsStringSync(buf.toString());
  stdout.writeln('Written → $_outputDir/components.g.dart');
}

// ---------------------------------------------------------------------------
// Generator: country_codes.g.dart
// ---------------------------------------------------------------------------

// Generates country_codes.g.dart from conf/country_codes.yaml.
// Emits kCountryCodes, the set of ISO 3166-1 alpha-2 codes recognised by
// the address-formatting spec.
Future<void> _generateCountryCodes(String? confDir) async {
  final raw = await _readConf(confDir, 'country_codes.yaml');
  final doc = loadYaml(raw) as YamlMap;
  final codes = doc.keys.cast<String>().toList()..sort();

  final buf = StringBuffer();
  buf.writeln('// GENERATED FILE — do not edit by hand.');
  buf.writeln('// Regenerate with: dart run tool/templates_generator.dart');
  buf.writeln('//');
  buf.writeln('// Source: OpenCageData/address-formatting/conf/country_codes.yaml');
  buf.writeln('// ignore_for_file: constant_identifier_names, lines_longer_than_80_chars');
  buf.writeln();
  buf.writeln('/// ISO 3166-1 alpha-2 country codes recognised by the address-formatting spec.');
  buf.writeln('const Set<String> kCountryCodes = {');
  for (final code in codes) {
    buf.writeln("  ${_dartSingleString(code)},");
  }
  buf.writeln('};');

  File('$_outputDir/country_codes.g.dart').writeAsStringSync(buf.toString());
  stdout.writeln('Written → $_outputDir/country_codes.g.dart');
}

// ---------------------------------------------------------------------------
// Generator: country2lang.g.dart
// ---------------------------------------------------------------------------

// Generates country2lang.g.dart from conf/country2lang.yaml.
// Emits kCountry2Lang, mapping each country code to its official ISO 639-1
// language codes (used to select abbreviation tables).
Future<void> _generateCountry2Lang(String? confDir) async {
  final raw = await _readConf(confDir, 'country2lang.yaml');
  final doc = loadYaml(raw) as YamlMap;

  final buf = StringBuffer();
  buf.writeln('// GENERATED FILE — do not edit by hand.');
  buf.writeln('// Regenerate with: dart run tool/templates_generator.dart');
  buf.writeln('//');
  buf.writeln('// Source: OpenCageData/address-formatting/conf/country2lang.yaml');
  buf.writeln('// ignore_for_file: constant_identifier_names, lines_longer_than_80_chars');
  buf.writeln();
  buf.writeln('/// Maps ISO 3166-1 alpha-2 country codes to their official ISO 639-1 language codes.');
  buf.writeln('/// Countries with multiple official languages list all codes.');
  buf.writeln('const Map<String, List<String>> kCountry2Lang = {');
  for (final rawKey in doc.keys) {
    final cc = rawKey as String;
    final value = doc[cc];
    if (value is! String) continue;
    final langs = value
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
    final langsLiteral = langs.map(_dartSingleString).join(', ');
    buf.writeln("  ${_dartSingleString(cc)}: [$langsLiteral],");
  }
  buf.writeln('};');

  File('$_outputDir/country2lang.g.dart').writeAsStringSync(buf.toString());
  stdout.writeln('Written → $_outputDir/country2lang.g.dart');
}

// ---------------------------------------------------------------------------
// Generator: state_codes.g.dart and county_codes.g.dart (shared logic)
// ---------------------------------------------------------------------------

/// Generates a `Map<String, Map<String, Map<String, String>>>` from a YAML
/// file whose structure is: `CC → code → value` where value is either a plain
/// string (normalised to `{'default': value}`) or a map of named variants
/// (e.g. `{default: ..., alt_en: ...}`).
Future<void> _generateCodeMap({
  required String? confDir,
  required String yamlPath,
  required String outputFile,
  required String constName,
  required String docComment,
}) async {
  final raw = await _readConf(confDir, yamlPath);
  final doc = loadYaml(raw) as YamlMap;

  final buf = StringBuffer();
  buf.writeln('// GENERATED FILE — do not edit by hand.');
  buf.writeln('// Regenerate with: dart run tool/templates_generator.dart');
  buf.writeln('//');
  buf.writeln('// Source: OpenCageData/address-formatting/conf/$yamlPath');
  buf.writeln('//');
  buf.writeln("// String values are normalised to {'default': name}.");
  buf.writeln('// ignore_for_file: constant_identifier_names, lines_longer_than_80_chars');
  buf.writeln();
  buf.writeln(docComment);
  buf.writeln('const Map<String, Map<String, Map<String, String>>> $constName = {');

  for (final countryKey in doc.keys) {
    final cc = countryKey as String;
    final codes = doc[cc];
    if (codes is! YamlMap) continue;
    buf.writeln("  ${_dartSingleString(cc)}: {");
    for (final codeKey in codes.keys) {
      final code = codeKey as String;
      final value = codes[code];
      buf.write("    ${_dartSingleString(code)}: {");
      if (value is String) {
        buf.write("'default': ${_dartSingleString(value)}");
      } else if (value is YamlMap) {
        final parts = <String>[];
        for (final e in value.entries) {
          parts.add(
            "${_dartSingleString(e.key as String)}: ${_dartSingleString(e.value as String)}",
          );
        }
        buf.write(parts.join(', '));
      }
      buf.writeln('},');
    }
    buf.writeln('  },');
  }

  buf.writeln('};');

  File('$_outputDir/$outputFile').writeAsStringSync(buf.toString());
  stdout.writeln('Written → $_outputDir/$outputFile');
}

// ---------------------------------------------------------------------------
// Address format helpers
// ---------------------------------------------------------------------------

// Parses a replace or postformat_replace YAML list into [pattern, replacement]
// pairs. Elements that are not two-item lists are silently skipped.
List<List<String>> _parseReplacePairs(dynamic raw) {
  if (raw is! YamlList) return const [];
  final result = <List<String>>[];
  for (final item in raw) {
    if (item is YamlList && item.length == 2) {
      final p = item[0];
      final r = item[1];
      if (p is String && r is String) result.add([p, r]);
    }
  }
  return result;
}

// Emits the key-value pairs of a single country format entry into buf,
// choosing the appropriate Dart literal form for each directive key.
void _writeCountryEntry(StringBuffer buf, Map<String, Object> entry) {
  for (final kv in entry.entries) {
    switch (kv.key) {
      case 'address_template':
      case 'fallback_template':
        final str = kv.value as String;
        final isNamed = _sharedTemplateKeys.contains(str);
        buf.writeln(
          "    '${kv.key}': ${isNamed ? _dartSingleString(str) : _dartMultilineString(str)},",
        );
      case 'use_country':
      case 'change_country':
      case 'add_component':
        buf.writeln("    '${kv.key}': ${_dartSingleString(kv.value as String)},");
      case 'replace':
      case 'postformat_replace':
        final pairs = kv.value as List<List<String>>;
        buf.writeln("    '${kv.key}': <List<String>>[");
        for (final pair in pairs) {
          buf.writeln(
            '      [${_dartSingleString(pair[0])}, ${_dartSingleString(pair[1])}],',
          );
        }
        buf.writeln('    ],');
    }
  }
}

// ---------------------------------------------------------------------------
// String helpers
// ---------------------------------------------------------------------------

/// Emits a triple-single-quoted Dart string for multi-line mustache templates.
String _dartMultilineString(String value) => "'''\n$value'''";

/// Emits a single-quoted Dart string, escaping `\`, `'`, `$`, `\n`, and `\r`.
String _dartSingleString(String value) {
  final escaped = value
      .replaceAll(r'\', r'\\')
      .replaceAll("'", r"\'")
      .replaceAll(r'$', r'\$')
      .replaceAll('\n', r'\n')
      .replaceAll('\r', r'\r');
  return "'$escaped'";
}
