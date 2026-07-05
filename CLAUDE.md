# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Run all tests (entirely static — no live HTTP calls)
dart test

# Run a single test file
dart test test/address_formatter_test.dart

# Run a single test by name
dart test --name "CH: road"

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
`tool/templates_generator.dart` reads YAML from the OpenCage repo (or the local `tool/address-formatting` submodule) and emits six `const`-map files under `lib/src/generated/`:

| Generated file | Source | Dart constant |
|---|---|---|
| `abbreviations.g.dart` | OpenCage `abbreviations/*.yaml` | `kAbbreviations` |
| `worldwide.g.dart` | OpenCage `countries/worldwide.yaml` | `kAddressTemplates`, `kAddressCountries` |
| `components.g.dart` | OpenCage `components.yaml` | `kComponentNames`, `kComponentAliases` |
| `country_names.g.dart` | OpenCage `country_codes.yaml` | `kCountryNames` |
| `country2lang.g.dart` | OpenCage `country2lang.yaml` | `kCountry2Lang` |
| `state_codes.g.dart` | OpenCage `state_codes.yaml` | `kStateCodes` |
| `county_codes.g.dart` | OpenCage `county_codes.yaml` | `kCountyCodes` |

- `kAddressTemplates` — shared named mustache templates (`generic1`…`generic23`, `fallback1`…`fallback4`)
- `kAddressCountries` — per-country (and per-language-variant) format entries, keyed by ISO 3166-1 alpha-2 code (e.g. `CH`, `US`) or language variant (e.g. `CH_fr`, `CA_en`)
- `kCountryNames` — English country names keyed by ISO 3166-1 alpha-2 code, parsed from the inline comments in `country_codes.yaml`

The generated files are committed; they only need regenerating when pulling in updated OpenCage data.

**Runtime (`lib/src/address_formatter.dart`):**
`AddressFormatter.format(components, {fallbackCountryCode, appendCountry, abbreviate})` is the sole public API — a static method on an `abstract final` class. The country code is read from `components['country_code']`. The lookup chain is: `CC` → `default`. The method applies, in order:
1. Alias resolution — `kComponentAliases` maps geocoder-specific keys to canonical OpenCage names (e.g. `street` → `road`, `housenumber` → `house_number`)
2. Country code normalisation — `UK` → `GB`; Netherlands overseas territories redirect to their own codes (e.g. Curaçao → `CW`)
3. `use_country` — delegate to another country's format rules
4. Country name injection — if `country` is absent and `appendCountry` is true, fill from `kCountryNames`
5. `change_country` / `add_component` — mutate the components map (may override injected name)
6. `replace` — pre-render regex substitutions on component values
7. mustache template render (with a `{{#first}} A || B {{/first}}` lambda for fallback fields)
8. `postformat_replace` — post-render regex substitutions on the output string
9. `_clean` — strip blank lines and trim

Templates are cached after first parse (`_templateCache`) so repeated calls for the same country are cheap.

**Tests** are entirely static — no live HTTP calls. All test fixtures are inline `Map<String, dynamic>` constants covering CH, FR, DE, GB, US, NL, GG, PR, HK, MO, TW and various edge cases (aliases, abbreviations, postcode normalisation, URL filtering).
