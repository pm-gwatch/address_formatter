# Address Formatter

### Overview

A Dart package for formatting address components into human-readable address
strings. It uses the address templates from
[OpenCage](https://github.com/OpenCageData/address-formatting/) to produce
correctly formatted addresses for countries worldwide.

Pass a components map — for example Nominatim's `address` object (with
`addressdetails=1`) or Photon's `properties`.

### Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  address_formatter: ^0.4.0
```

### API

```dart
formatAddress(Map<String, dynamic> components, {
  String? fallbackCountryCode,
  bool appendCountry = true,
  bool abbreviate = false,
})

formatAddressSingleLine(Map<String, dynamic> components, {
  String? fallbackCountryCode,
  bool appendCountry = true,
  bool abbreviate = false,
})
```

`formatAddress` returns a newline-separated string.
`formatAddressSingleLine` joins those lines with `', '`.

- `abbreviate`: shorten road and place names (`Avenue` → `Ave`).
- `appendCountry`: include the country name (default `true`).
- `fallbackCountryCode`: ISO 3166-1 alpha-2 code when `country_code` is missing.

### Use

```dart
print(formatAddress({
  'country_code': 'US',
  'house_number': '301',
  'road': 'Hamilton Avenue',
  'neighbourhood': 'Crescent Park',
  'city': 'Palo Alto',
  'postcode': '94303',
  'county': 'Santa Clara County',
  'state': 'California',
  'country': 'United States',
}));
/*
301 Hamilton Avenue
Palo Alto, CA 94303
United States of America
*/

print(formatAddressSingleLine({
  'house_number': '17',
  'road': 'Rue du Médecin-Colonel Calbairac',
  'postcode': '31000',
  'city': 'Toulouse',
  'country': 'France',
  'country_code': 'FR',
}));
// 17 Rue du Médecin-Colonel Calbairac, 31000 Toulouse, France
```

### License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) for details. The OpenCage address templates are also MIT; see [THIRD_PARTY_LICENSES](THIRD_PARTY_LICENSES).

### Contributions

Contributions welcome.

### Acknowledgements

- [OpenCage address-formatting](https://github.com/OpenCageData/address-formatting/)
