
`AddressFormatter` converts address components into correctly formatted postal addresses for countries worldwide thanks to a set of templates based on [OpenCage Data](https://github.com/OpenCageData/address-formatting/). It can format output from the [OpenCage Geocoding API](https://opencagedata.com/api) and Open Street Maps' [Nominatim API](https://wiki.openstreetmap.org/wiki/Nominatim).

## Getting started

Add the `address_formatter` package as a dependency in your `pubspec.yaml` file.

## Usage

`AddressFormatter` exposes three static methods that accept the same parameters: a `Map<String, dynamic>` of address components and a set of named options described in the [Options](#options) section.

### Static methods

#### `format` — list of address lines

Returns a `List<String>` where each element is one line of the formatted address. This is the core method; `multiLineFormat` and `singleLineFormat` are convenience wrappers around it.

```dart
final lines = AddressFormatter.format({
  'road': 'Baker Street',
  'house_number': '221B',
  'city': 'London',
  'postcode': 'NW1 6XE',
  'country': 'United Kingdom',
  'country_code': 'gb',
});

// ['221B Baker Street', 'London', 'NW1 6XE', 'United Kingdom']
```

#### `multiLineFormat` — newline-separated string

Joins the address lines with `\n`. Suitable for printing on a postal envelope or displaying in a multi-line UI widget.

```dart
print(AddressFormatter.multiLineFormat({
  'road': 'Baker Street',
  'house_number': '221B',
  'city': 'London',
  'postcode': 'NW1 6XE',
  'country': 'United Kingdom',
  'country_code': 'gb',
}));
// 221B Baker Street
// London
// NW1 6XE
// United Kingdom
```

#### `singleLineFormat` — comma-separated string

Joins the address lines with `', '`. Suitable for compact display such as map markers or search result subtitles.

```dart
print(AddressFormatter.singleLineFormat({
  'road': 'Baker Street',
  'house_number': '221B',
  'city': 'London',
  'postcode': 'NW1 6XE',
  'country': 'United Kingdom',
  'country_code': 'gb',
}));
// 221B Baker Street, London, NW1 6XE, United Kingdom
```

### Options

All three methods accept the following named parameters.

#### `abbreviate` — apply road name abbreviations

Setting `abbreviate: true` replaces common road and place-name words with their standard abbreviations using the [OpenCage abbreviation tables](https://github.com/OpenCageData/address-formatting/tree/master/conf/abbreviations).

```dart
print(AddressFormatter.multiLineFormat({
  'road': 'Park Avenue',
  'city': 'London',
  'postcode': 'W1K 1PN',
  'country': 'United Kingdom',
  'country_code': 'gb',
}, abbreviate: true));
// Park Ave
// London
// W1K 1PN
// UK
```

#### `appendCountry` — omit the country name

Setting `appendCountry: false` removes the country line from the output. Useful when the country is already implied by the context.

```dart
print(AddressFormatter.multiLineFormat({
  'house_number': '28',
  'road': 'Avenue Dumas',
  'city': 'Genève',
  'postcode': '1206',
  'country': 'Suisse',
  'country_code': 'ch',
}, appendCountry: false));
// Avenue Dumas 28
// 1206 Genève
```

#### `fallbackCountryCode` — handle missing country codes

When `country_code` is absent from the components map, pass a fallback ISO 3166-1 alpha-2 code to ensure the correct template is applied.

```dart
print(AddressFormatter.multiLineFormat({
  'road': "O'Connell Street",
  'city': 'Dublin',
  'postcode': 'D01 K8C4',
  'country': 'Ireland',
}, fallbackCountryCode: 'IE'));
// O'Connell Street
// Dublin
// D01 K8C4
// Ireland
```


## Examples of small-to-big and big-to-small formats

### Small-to-big format

Most countries order address elements from the most specific (street and house number) to the most general (city and country). The street line structure varies: some countries place the house number before the road name (France, United States), others place it after (Germany, Switzerland).

```dart
// France: house number before road name
print(AddressFormatter.multiLineFormat({
  'attention': 'Jean Dumoulin',
  'house': 'Euro Transport SA',
  'road': 'Rue de la Tour',
  'house_number': '1',
  'city': 'Rungis',
  'postcode': '94150',
  'country': 'France',
  'country_code': 'fr',
}));
// Jean Dumoulin
// Euro Transport SA
// 1 Rue de la Tour
// 94150 Rungis
// France

// United States: state code and postcode on the city line
print(AddressFormatter.multiLineFormat({
  'road': 'Hollywood Boulevard',
  'house_number': '6925',
  'city': 'Los Angeles',
  'state': 'California',
  'postcode': '90028',
  'country': 'United States',
  'country_code': 'us',
}));
// 6925 Hollywood Boulevard
// Los Angeles, CA 90028
// United States of America
```

### Big-to-small format

East Asian countries (China, Japan, South Korea, Taiwan) and several post-Soviet states (Belarus, Kazakhstan, Kyrgyzstan) order address elements from the largest administrative area down to the street and house number.

```dart
// Taiwan (default, zh): country → postcode → city + district + road + number
print(AddressFormatter.multiLineFormat({
  'house_number': '1',
  'road': 'Zhongshan South Road',
  'neighbourhood': 'Zhongzheng District',
  'city': 'Taipei',
  'postcode': '100',
  'country': 'Taiwan',
  'country_code': 'tw',
}));
// Taiwan
// 100
// Taipei Zhongzheng District Zhongshan South Road 1

// South Korea: country → city + road + number → postcode
print(AddressFormatter.multiLineFormat({
  'road': 'Sejong-daero',
  'house_number': '110',
  'city': 'Seoul',
  'postcode': '04520',
  'country': 'South Korea',
  'country_code': 'kr',
}));
// South Korea
// Seoul Sejong-daero 110
// 04520
```

## License

This project is licensed under the MIT License. See the `LICENSE` for details.
