import 'dart:convert';
import 'package:address_formatter/address_formatter.dart';
import 'package:http/http.dart' as http;

// Example usages of the package to format addresses from the Nominatim
// search API. The `addressdetails=1` query parameter is required so the
// response includes an `address` map of components.
// See https://nominatim.org/release-docs/develop/api/Search/.
//
// The "smallest-to-largest" order of address components is commonly used
// to format postal addresses worldwide, except in some countries such as
// China, Japan or Korea where the "largest-to-smallest" order is used.
//
// This application contains information from OpenStreetMap, which is made
// available at openstreetmap.org under the Open Database License (ODbL).
void main() async {
  print('Chicago City Hall:');

  final nominatimUri = Uri.https('nominatim.openstreetmap.org', '/search', {
    'q': 'chicago+town+hall',
    'addressdetails': '1',
    'format': 'geojson',
  });

  final nominatimResponse =
      await http.get(nominatimUri, headers: {'User-Agent': 'dart_example'});

  if (nominatimResponse.statusCode == 200) {
    final collection =
        jsonDecode(nominatimResponse.body) as Map<String, dynamic>;
    final features = collection['features'] as List<dynamic>;

    // Prefer the town hall amenity when Nominatim returns several places.
    // See https://wiki.openstreetmap.org/wiki/Map_features#Primary_features
    final chicagoTownHall = features.cast<Map<String, dynamic>>().firstWhere(
      (feature) {
        final properties = feature['properties'] as Map<String, dynamic>?;
        return properties?['category'] == 'amenity' &&
            properties?['type'] == 'townhall';
      },
      orElse: () => features.isEmpty
          ? <String, dynamic>{}
          : features.first as Map<String, dynamic>,
    );

    final chicagoAddress = (chicagoTownHall['properties']
        as Map<String, dynamic>?)?['address'] as Map<String, dynamic>?;
    if (chicagoAddress == null) {
      print('No relevant result found in the Nominatim API response.');
    } else {
      print(formatAddress(chicagoAddress, abbreviate: true));
      // 121 North LaSalle St
      // Chicago, IL 60602
      // United States of America
    }
  } else {
    print(
        'Failed to fetch data from Nominatim API. Status code: ${nominatimResponse.statusCode}');
  }

  print('\nThe Palace Museum (Beijing):');

  final palaceMuseumUri = Uri.https('nominatim.openstreetmap.org', '/search', {
    'q': 'palace+museum+beijing',
    'addressdetails': '1',
    'format': 'geojson',
  });

  final palaceMuseumResponse =
      await http.get(palaceMuseumUri, headers: {'User-Agent': 'dart_example'});

  if (palaceMuseumResponse.statusCode == 200) {
    final collection =
        jsonDecode(palaceMuseumResponse.body) as Map<String, dynamic>;
    final features = collection['features'] as List<dynamic>;

    final palaceMuseum = features.cast<Map<String, dynamic>>().firstWhere(
      (feature) {
        final properties = feature['properties'] as Map<String, dynamic>?;
        return properties?['category'] == 'tourism' &&
            properties?['type'] == 'museum';
      },
      orElse: () => features.isEmpty
          ? <String, dynamic>{}
          : features.first as Map<String, dynamic>,
    );

    final palaceAddress = (palaceMuseum['properties']
        as Map<String, dynamic>?)?['address'] as Map<String, dynamic>?;
    if (palaceAddress == null) {
      print('No relevant result found in the Nominatim API response.');
    } else {
      print(formatAddress(palaceAddress));
      // 100010 中国
      // 东城区
      // 东华门街道
      // 景山前街 4号
    }
  } else {
    print(
        'Failed to fetch data from Nominatim API. Status code: ${palaceMuseumResponse.statusCode}');
  }
}
