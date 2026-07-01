# Changelog

## 0.2.0

- Added `countryNameLanguageCode` parameter to `format()`, `multiLineFormat()`, and `singleLineFormat()`. Accepts any ISO 639-1 code from Flutter's `kMaterialSupportedLanguages` (81 languages); unsupported codes fall back to `'en'`. Defaults to `'en'`.
- Country display names are sourced from CLDR (`cldr-localenames-full`) and stored in the new generated constant `kTerritoryNames`. Short forms are preferred over verbose ones where CLDR provides them (e.g. `HK` → `'Hong Kong'` rather than `'Hong Kong SAR China'`).

## 0.1.0

Converts address components into correctly formatted postal addresses for countries worldwide, following the OpenCage address-formatting specification.
