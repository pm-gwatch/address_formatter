# Changelog

## 0.3.0

- Removed the `formatLanguageCode` parameter. Language-specific format templates (e.g. selecting a Chinese vs. English layout for Taiwan) are no longer supported; the country default is always used, consistent with other implementations of the OpenCage spec.
- Removed the `countryNameLanguageCode` parameter and the CLDR-backed `kTerritoryNames` constant. Country names are now sourced from the inline comments in OpenCage's `country_codes.yaml` and stored in the new `kCountryNames` constant (English only). When the geocoder response includes a `country_code` but no `country`, the formatter injects the English country name automatically.
- Added `example/example.dart` demonstrating how to query the Nominatim API and format the returned address components.

## 0.2.0

- Added `countryNameLanguageCode` parameter to `format()`, `multiLineFormat()`, and `singleLineFormat()`. Accepts any ISO 639-1 code from Flutter's `kMaterialSupportedLanguages` (81 languages); unsupported codes fall back to `'en'`. Defaults to `'en'`.
- Country display names are sourced from CLDR (`cldr-localenames-full`) and stored in the new generated constant `kTerritoryNames`. Short forms are preferred over verbose ones where CLDR provides them (e.g. `HK` → `'Hong Kong'` rather than `'Hong Kong SAR China'`).

## 0.1.0

Converts address components into correctly formatted postal addresses for countries worldwide, following the OpenCage address-formatting specification.
