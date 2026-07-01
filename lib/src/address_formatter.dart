import 'package:mustache_template/mustache_template.dart';

import 'generated/abbreviations.g.dart';
import 'generated/worldwide.g.dart';
import 'generated/components.g.dart';
import 'generated/country_codes.g.dart';
import 'generated/country2lang.g.dart';
import 'generated/county_codes.g.dart';
import 'generated/state_codes.g.dart';
import 'generated/territory_names.g.dart';

/// Converts geocoder address components into a localised, human-readable
/// address string following the
/// [OpenCage address-formatting](https://github.com/OpenCageData/address-formatting)
/// specification.
///
/// The class cannot be instantiated or subclassed. It exposes three static
/// methods that share the same parameters:
/// - [format] — returns a `List<String>` of address lines (core method).
/// - [multiLineFormat] — joins the lines with `\n` for display or printing.
/// - [singleLineFormat] — joins the lines with `', '` for compact display.
///
/// Example:
/// ```dart
/// final address = nominatimResult['address'] as Map<String, dynamic>;
///
/// final lines = AddressFormatter.format(address, languageCode: 'fr');
/// final multiLine = AddressFormatter.multiLineFormat(address, languageCode: 'fr');
/// final singleLine = AddressFormatter.singleLineFormat(address, languageCode: 'fr');
/// ```
abstract final class AddressFormatter {
  static final Map<String, Template> _templateCache = {};

  // Post-render cleanup patterns ported from the OpenCage reference
  // implementation. Applied in order before line-level deduplication.
  static final List<(RegExp, String)> _cleanupPatterns = [
    (RegExp(r'[},\s]+$', multiLine: true), ''),
    (RegExp(r'^[,\s]+', multiLine: true), ''),
    (RegExp(r'^- ', multiLine: true), ''),
    (RegExp(r',\s*,'), ', '),
    (RegExp(r'[ \t]+,[ \t]+'), ', '),
    (RegExp(r'[ \t]{2,}'), ' '),
    (RegExp(r'[ \t]\n'), '\n'),
    (RegExp(r'\n,'), '\n'),
    (RegExp(r',+'), ','),
    (RegExp(r',\n'), '\n'),
    (RegExp(r'\n[ \t]+'), '\n'),
    (RegExp(r'\n{2,}'), '\n'),
  ];

  /// Formats [components] into a list of address lines.
  ///
  /// This is the core formatting method. [multiLineFormat] and
  /// [singleLineFormat] are thin wrappers that join the returned list.
  ///
  /// [components] is the flat address map returned by a geocoder such as
  /// Nominatim or Photon. Keys follow Nominatim field names; aliases such as
  /// `street` and `housenumber` are resolved automatically to the canonical
  /// OpenCage names `road` and `house_number`.
  ///
  /// Processing pipeline (in order):
  /// 1. Alias resolution (`street` → `road`, `suburb` → `neighbourhood`, …).
  /// 2. Country code normalisation: `UK` → `GB`; Netherlands overseas
  ///    territories redirect to their own codes (e.g. Curaçao → `CW`).
  /// 3. Format entry lookup: `CC_ll` → `CC` → `default`.
  /// 4. `use_country` — delegate format rules to another country's entry.
  /// 5. CLDR lookup — set `country` from `kTerritoryNames` using
  ///    [countryNameLanguageCode] and the original country code.
  /// 6. `change_country` / `add_component` — may override the CLDR name.
  /// 7. Pre-render component substitutions (`replace`).
  /// 8. Component enrichment: `state_code` and `county_code` injected from
  ///    generated lookup tables; URL-valued components and malformed postcodes
  ///    stripped; abbreviations applied when [abbreviate] is `true`.
  /// 9. Mustache template rendering (`{{#first}} A || B {{/first}}` supported).
  /// 10. Post-render substitutions (`postformat_replace`), with `$N` groups.
  /// 11. Cleanup: punctuation normalisation, blank-line removal, duplicate-token
  ///    and duplicate-line deduplication.
  ///
  /// [fallbackCountryCode] is the ISO 3166-1 alpha-2 code used when
  /// `country_code` is absent or unrecognised. Defaults to `null`.
  ///
  /// [languageCode] selects a `CC_ll` template variant for countries with
  /// multiple format layouts (CA, CN, HK, IR, JP, KR, MO, TW).
  /// Defaults to `null` (country default layout).
  ///
  /// [countryNameLanguageCode] is the ISO 639-1 code for the language in
  /// which the country name is displayed. Supported codes mirror
  /// [kMaterialSupportedLanguages](https://api.flutter.dev/flutter/flutter_localizations/kMaterialSupportedLanguages.html);
  /// unsupported codes fall back to `'en'`. Defaults to `'en'`.
  ///
  /// [appendCountry] controls whether the country name appears in the output.
  /// Defaults to `true`.
  ///
  /// [abbreviate] applies per-language road and place-name abbreviations
  /// (e.g. `Avenue` → `Ave` in English, `Boulevard` → `Boul` in French).
  /// Defaults to `false`.
  static List<String> format(
    Map<String, dynamic> components, {
    String? fallbackCountryCode,
    String? languageCode,
    String countryNameLanguageCode = 'en',
    bool appendCountry = true,
    bool abbreviate = false,
  }) {
    final comps = Map<String, String>.fromEntries(
      components.entries
          .where((e) => e.value != null)
          .map((e) => MapEntry(e.key, e.value.toString())),
    );

    // Resolve Nominatim field aliases to canonical OpenCage names.
    _applyAliases(comps);

    // Validate/normalise the country code (UK→GB, NL territories, etc.).
    final cc = _resolveCountryCode(comps, fallbackCountryCode?.toUpperCase());

    final key = _resolveKey(cc, languageCode);
    final entry = kAddressCountries[key] ?? kAddressCountries['default']!;

    final Map<String, Object> formatEntry;
    final String effectiveCc;
    if (entry.containsKey('use_country')) {
      effectiveCc = (entry['use_country'] as String).toUpperCase();
      formatEntry =
          kAddressCountries[effectiveCc] ?? kAddressCountries['default']!;
    } else {
      effectiveCc = cc;
      formatEntry = entry;
    }

    // Set country name from CLDR, using cc (original territory, not effectiveCc)
    // so that e.g. Puerto Rico shows the name for PR, not US.
    // change_country below may still override this for entries like GG and PR.
    if (cc != 'default') {
      final normalised = countryNameLanguageCode.toLowerCase();
      final lang = kTerritoryNames.containsKey(normalised) ? normalised : 'en';
      final cldrName = kTerritoryNames[lang]?[cc];
      if (cldrName != null) comps['country'] = cldrName;
    }

    if (entry.containsKey('change_country')) {
      comps['country'] = entry['change_country'] as String;
    }
    if (entry.containsKey('add_component')) {
      final raw = entry['add_component'] as String;
      final idx = raw.indexOf('=');
      if (idx != -1) {
        comps[raw.substring(0, idx).trim()] = raw.substring(idx + 1).trim();
      }
    }

    if (formatEntry.containsKey('replace')) {
      _applyReplace(comps, formatEntry['replace'] as List<List<String>>);
    }

    // Enrich with state_code / county_code and optionally abbreviate.
    // Use effectiveCc (post use_country) so that e.g. PR looks up state codes
    // in the US table rather than a non-existent PR table.
    _cleanupComponents(comps, effectiveCc, abbreviate);

    if (!appendCountry) comps.remove('country');

    final templateSource = _resolveTemplate(formatEntry, 'address_template');
    if (templateSource == null) {
      return _clean(_renderFallback(formatEntry, comps)).split('\n');
    }

    final rendered = _render(templateSource, comps, key);
    var output = rendered.trim().isEmpty
        ? _renderFallback(formatEntry, comps)
        : rendered;

    if (formatEntry.containsKey('postformat_replace')) {
      output = _applyPostformat(
        output,
        formatEntry['postformat_replace'] as List<List<String>>,
      );
    }

    return _clean(output).split('\n');
  }

  /// Formats [components] into a localised, newline-separated address string.
  ///
  /// Convenience wrapper: calls [format] and joins the result with `\n`.
  static String multiLineFormat(
    Map<String, dynamic> components, {
    String? fallbackCountryCode,
    String? languageCode,
    String countryNameLanguageCode = 'en',
    bool appendCountry = true,
    bool abbreviate = false,
  }) => format(
    components,
    fallbackCountryCode: fallbackCountryCode,
    languageCode: languageCode,
    countryNameLanguageCode: countryNameLanguageCode,
    appendCountry: appendCountry,
    abbreviate: abbreviate,
  ).join('\n');

  /// Formats [components] into a localised, comma-separated address string.
  ///
  /// Convenience wrapper: calls [format] and joins the result with `', '`.
  static String singleLineFormat(
    Map<String, dynamic> components, {
    String? fallbackCountryCode,
    String? languageCode,
    String countryNameLanguageCode = 'en',
    bool appendCountry = true,
    bool abbreviate = false,
  }) => format(
    components,
    fallbackCountryCode: fallbackCountryCode,
    languageCode: languageCode,
    countryNameLanguageCode: countryNameLanguageCode,
    appendCountry: appendCountry,
    abbreviate: abbreviate,
  ).join(', ');

  // ── Country code resolution ───────────────────────────────────────────────

  static String _resolveCountryCode(
    Map<String, String> comps,
    String? fallbackCC,
  ) {
    var cc = (comps['country_code'] ?? '').toUpperCase();

    if (cc == 'UK') cc = 'GB';

    // NL overseas territories: map based on the state name.
    if (cc == 'NL') {
      switch (comps['state']) {
        case 'Curaçao':
          cc = 'CW';
        case 'Sint Maarten':
          cc = 'SX';
        case 'Aruba':
          cc = 'AW';
      }
    }

    if (kCountryCodes.contains(cc)) return cc;

    // Country code is a numeric or otherwise unknown string — use state name
    // as the country if a proper name is absent.
    if (cc.isNotEmpty && RegExp(r'^\d+$').hasMatch(cc)) {
      if (comps['state'] != null) {
        comps['country'] = comps['state']!;
      }
      cc = '';
    }

    // Try the fallback CC.
    if (cc.isEmpty && fallbackCC != null) {
      final fb = fallbackCC == 'UK' ? 'GB' : fallbackCC;
      if (kCountryCodes.contains(fb)) return fb;
    }

    return cc.isEmpty ? 'default' : cc;
  }

  // ── Key resolution ────────────────────────────────────────────────────────

  static String _resolveKey(String cc, String? lang) {
    if (cc == 'default' || !kAddressCountries.containsKey(cc)) {
      return 'default';
    }
    if (lang != null) {
      final langKey = '${cc}_${lang.toLowerCase()}';
      if (kAddressCountries.containsKey(langKey)) return langKey;
    }
    return cc;
  }

  // ── Alias resolution ─────────────────────────────────────────────────────

  static void _applyAliases(Map<String, String> comps) {
    for (final alias in kComponentAliases.keys.toList()) {
      if (comps.containsKey(alias) &&
          !comps.containsKey(kComponentAliases[alias]!)) {
        comps[kComponentAliases[alias]!] = comps.remove(alias)!;
      }
    }
  }

  // ── Component cleanup ─────────────────────────────────────────────────────

  static void _cleanupComponents(
    Map<String, String> comps,
    String cc,
    bool abbreviate,
  ) {
    // Strip components that contain URLs — they're data artifacts, not address parts.
    comps.removeWhere(
      (_, v) => v.contains('http://') || v.contains('https://'),
    );

    // Normalise postcodes.
    final postcode = comps['postcode'];
    if (postcode != null) {
      // Two-postcode form like "12345,67890" → take first.
      final twoCode = RegExp(r'^(\d{5}),\d{5}$').firstMatch(postcode);
      if (twoCode != null) {
        comps['postcode'] = twoCode.group(1)!;
      } else if (postcode.length > 20 ||
          RegExp(r'^\d+;\d+$').hasMatch(postcode)) {
        comps.remove('postcode');
      }
    }

    // Look up and inject state_code if we have a state but no state_code yet.
    if (!comps.containsKey('state_code')) {
      final state = comps['state'];
      if (state != null && cc != 'default') {
        final code = _lookupStateCode(state, cc);
        if (code != null) comps['state_code'] = code;
      }
    }

    // Look up and inject county_code if we have a county but no county_code yet.
    if (!comps.containsKey('county_code')) {
      final county = comps['county'];
      if (county != null && cc != 'default') {
        final code = _lookupCountyCode(county, cc);
        if (code != null) comps['county_code'] = code;
      }
    }

    if (abbreviate && cc != 'default') {
      _applyAbbreviations(comps, cc);
    }
  }

  static String? _lookupStateCode(String state, String cc) {
    final states = kStateCodes[cc];
    if (states == null) return null;
    final upper = state.toUpperCase();
    for (final entry in states.entries) {
      if ((entry.value['default'] ?? '').toUpperCase() == upper) return entry.key;
      if ((entry.value['alt_en'] ?? '').toUpperCase() == upper) return entry.key;
    }
    return null;
  }

  static String? _lookupCountyCode(String county, String cc) {
    final counties = kCountyCodes[cc];
    if (counties == null) return null;
    final upper = county.toUpperCase();
    for (final entry in counties.entries) {
      if ((entry.value['default'] ?? '').toUpperCase() == upper) return entry.key;
      if ((entry.value['alt_en'] ?? '').toUpperCase() == upper) return entry.key;
    }
    return null;
  }

  // ── Abbreviations ─────────────────────────────────────────────────────────

  static void _applyAbbreviations(Map<String, String> comps, String cc) {
    final languages = kCountry2Lang[cc];
    if (languages == null) return;

    for (final lang in languages) {
      final langMap = kAbbreviations[lang];
      if (langMap == null) continue;

      for (final MapEntry(key: component, value: replacements)
          in langMap.entries) {
        final value = comps[component];
        if (value == null) continue;

        var updated = value;
        for (final MapEntry(key: word, value: abbrev) in replacements.entries) {
          // Word-boundary match is ASCII-safe for Latin scripts; Cyrillic
          // scripts silently no-op since \b is ASCII-only in Dart.
          updated = updated.replaceAll(
            RegExp('\\b${RegExp.escape(word)}\\b'),
            abbrev,
          );
        }
        if (updated != value) comps[component] = updated;
      }
    }
  }

  // ── Template rendering ────────────────────────────────────────────────────

  static String? _resolveTemplate(
    Map<String, Object> entry,
    String templateKey,
  ) {
    final value = entry[templateKey];
    if (value == null) return null;
    final str = value as String;
    return kAddressTemplates[str] ?? str;
  }

  static String _render(
    String templateSource,
    Map<String, String> comps,
    String cacheKey,
  ) {
    final template = _templateCache.putIfAbsent(
      cacheKey,
      () => Template(
        templateSource,
        name: cacheKey,
        lenient: true,
        htmlEscapeValues: false,
      ),
    );

    String firstLambda(LambdaContext ctx) {
      final alternatives = ctx.source.split('||');
      for (final alt in alternatives) {
        final rendered = ctx.renderSource(alt.trim());
        final cleaned = rendered.trim();
        if (cleaned.isNotEmpty) return cleaned;
      }
      return '';
    }

    return template.renderString({...comps, 'first': firstLambda});
  }

  static String _renderFallback(
    Map<String, Object> entry,
    Map<String, String> comps,
  ) {
    final src = _resolveTemplate(entry, 'fallback_template');
    if (src == null) return '';
    return _render(src, comps, '__fallback__${entry.hashCode}');
  }

  // ── Substitution helpers ─────────────────────────────────────────────────

  static void _applyReplace(
    Map<String, String> comps,
    List<List<String>> pairs,
  ) {
    for (final [pattern, replacement] in pairs) {
      final eqIdx = pattern.indexOf('=');
      if (eqIdx != -1) {
        final targetKey = pattern.substring(0, eqIdx);
        final regex = pattern.substring(eqIdx + 1);
        if (comps.containsKey(targetKey)) {
          comps[targetKey] = comps[targetKey]!.replaceAll(
            RegExp(regex),
            replacement,
          );
        }
      } else {
        for (final key in comps.keys.toList()) {
          comps[key] = comps[key]!.replaceAll(RegExp(pattern), replacement);
        }
      }
    }
  }

  static String _applyPostformat(String rendered, List<List<String>> pairs) {
    var output = rendered;
    for (final [pattern, replacement] in pairs) {
      output = output.replaceAllMapped(RegExp(pattern, multiLine: true), (
        match,
      ) {
        // Expand $0…$N backreferences in the replacement string, iterating
        // from highest group to lowest to avoid "$1" clobbering "$10".
        var result = replacement;
        for (var i = match.groupCount; i >= 0; i--) {
          result = result.replaceAll('\$$i', match.group(i) ?? '');
        }
        return result;
      });
    }
    return output;
  }

  // ── Output cleanup ────────────────────────────────────────────────────────

  static String _clean(String raw) {
    var output = raw;
    for (final (pattern, replacement) in _cleanupPatterns) {
      output = output.replaceAll(pattern, replacement);
    }

    // Deduplicate consecutive identical tokens within a line, then
    // deduplicate consecutive identical lines.
    final lines = output.split('\n').map((line) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) return '';
      // Collapse repeated comma-separated tokens on the same line.
      final tokens = trimmed.split(RegExp(r',\s*'));
      final seen = <String>{};
      return tokens.where((t) => t.isEmpty || seen.add(t.trim())).join(', ');
    }).toList();

    // Remove duplicate adjacent lines.
    final deduped = <String>[];
    for (final line in lines) {
      if (line.isEmpty) continue;
      if (deduped.isEmpty || deduped.last != line) deduped.add(line);
    }

    return deduped.join('\n');
  }
}
