# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Run all tests (hits the live Photon Komoot API)
dart test

# Run a single test file
dart test test/address_formatter_test.dart

# Run a single test by name
dart test --name "formats Four Seasons"

# Static analysis
dart analyze

# Regenerate all lib/src/generated/*.g.dart files from upstream OpenCage YAML
dart run tool/templates_generator.dart

# Regenerate offline from the local submodule
dart run tool/templates_generator.dart --local tool/address-formatting/conf
```

## Architecture

This is a Dart package that converts geocoding API address JSON into localised address strings using the [OpenCage address-formatting](https://github.com/OpenCageData/address-formatting) spec.

**Data pipeline (build time):**
`tool/templates_generator.dart` reads YAML from the OpenCage repo (or the local `tool/address-formatting` submodule) and emits seven `const`-map files under `lib/src/generated/`:

| Generated file | Source | Dart constant |
|---|---|---|
| `abbreviations.g.dart` | OpenCage `abbreviations/*.yaml` | `kAbbreviations` |
| `worldwide.g.dart` | OpenCage `countries/worldwide.yaml` | `kAddressTemplates`, `kAddressCountries` |
| `territory_names.g.dart` | CLDR `cldr-localenames-full` (network) | `kTerritoryNames` |
| `components.g.dart` | OpenCage `components.yaml` | `kComponentNames`, `kComponentAliases` |
| `country_codes.g.dart` | OpenCage `country_codes.yaml` | `kCountryCodes` |
| `country2lang.g.dart` | OpenCage `country2lang.yaml` | `kCountry2Lang` |
| `state_codes.g.dart` | OpenCage `state_codes.yaml` | `kStateCodes` |
| `county_codes.g.dart` | OpenCage `county_codes.yaml` | `kCountyCodes` |

- `kAddressTemplates` — shared named mustache templates (`generic1`…`generic23`, `fallback1`…`fallback4`)
- `kAddressCountries` — per-country (and per-language-variant) format entries, keyed by ISO 3166-1 alpha-2 code (e.g. `CH`, `US`) or language variant (e.g. `CH_fr`, `CA_en`)
- `kTerritoryNames` — country display names for 81 languages (mirrors `kMaterialSupportedLanguages`); one entry per 2-letter country code, using the CLDR short form where available

The generated files are committed; they only need regenerating when pulling in updated OpenCage or CLDR data. Note: `territory_names.g.dart` always requires a network fetch from CLDR regardless of `--local`.

**Runtime (`lib/src/address_formatter.dart`):**
`AddressFormatter.format(components, {fallbackCountryCode, languageCode, countryNameLanguageCode, appendCountry, abbreviate})` is the sole public API — a static method on an `abstract final` class. The country code is read from `components['country_code']`. The lookup chain is: `CC_lang` → `CC` → `default`. The method applies, in order:
1. `use_country` — delegate to another country's format rules
2. CLDR lookup — set `country` from `kTerritoryNames[countryNameLanguageCode][cc]`
3. `change_country` / `add_component` — mutate the components map (may override CLDR name)
4. `replace` — pre-render regex substitutions on component values
5. mustache template render (with a `{{#first}} A || B {{/first}}` lambda for fallback fields)
6. `postformat_replace` — post-render regex substitutions on the output string
7. `_clean` — strip blank lines and trim

Templates are cached after first parse (`_templateCache`) so repeated calls for the same country are cheap.

**Tests** are entirely static — no live HTTP calls. All test fixtures are inline `Map<String, dynamic>` constants covering CH, FR, DE, GB, US, NL, GG, PR, HK, MO, TW and various edge cases (aliases, abbreviations, postcode normalisation, URL filtering).
