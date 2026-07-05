import 'dart:convert';
import 'package:address_formatter/address_formatter.dart';
import 'package:http/http.dart' as http;

// Example usages of the AddressFormatter package to format addresses from
// the Nominatim search API. The `addressdetails=1` query parameter is required
// to ensure that the response includes the `address` field that contains the
// address components.
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

  // Free-form search query for the address of Chicago City Hall.
  final nominatimUri = Uri.https('nominatim.openstreetmap.org', '/search', {
    'q': 'chicago+town+hall',
    'addressdetails': '1',
    'format': 'jsonv2',
  });

  final nominatimResponse =
      await http.get(nominatimUri, headers: {'User-Agent': 'dart_example'});

  if (nominatimResponse.statusCode == 200) {
    // Parse the JSON response.
    final places = jsonDecode(nominatimResponse.body) as List<dynamic>;

    // In order to sort through the results returned by the API, search for the
    // first result whose "category" and "type" are equal to "amenity" and
    // "townhall", respectively.
    // See https://wiki.openstreetmap.org/wiki/Map_features#Primary_features
    final chicagoTownHall = places.firstWhere(
      (place) =>
          place?['category'] == 'amenity' &&
          place?['type'] as String == 'townhall',
      orElse: () => null,
    );

    if (chicagoTownHall == null) {
      print('No relevant result found in the Nominatim API response.');
    } else {
      // Format the postal address using the components contained in the value
      // of the `address` field.
      final chicagoTownHallAddressComponents =
          chicagoTownHall['address'] as Map<String, dynamic>;
      final chicagoTownHallAddress =
          AddressFormatter.multiLineFormat(chicagoTownHallAddressComponents);
      print(chicagoTownHallAddress);
      // 121 North LaSalle Street
      // Chicago, IL 60602
      // United States of America
    }
  } else {
    print(
        'Failed to fetch data from Nominatim API. Status code: ${nominatimResponse.statusCode}');
  }

  print('\nThe Palace Museum (Beijing):');

  // Free-form search query for the address of the Palace Museum of Beijing.
  final palaceMuseumUri = Uri.https('nominatim.openstreetmap.org', '/search', {
    'q': 'palace+museum+beijing',
    'addressdetails': '1',
    'format': 'jsonv2',
  });

  final palaceMuseumResponse =
      await http.get(palaceMuseumUri, headers: {'User-Agent': 'dart_example'});

  if (palaceMuseumResponse.statusCode == 200) {
    final places = jsonDecode(palaceMuseumResponse.body) as List<dynamic>;

    // In order to sort through the results returned by the API, search for the
    // first one whose "category" and "type" are equal to "tourism" and
    // "museum", respectively.
    final palaceMuseum = places.firstWhere(
      (place) =>
          place?['category'] == 'tourism' &&
          place?['type'] as String == 'museum',
      orElse: () => null,
    );

    if (palaceMuseum == null) {
      print('No relevant result found in the Nominatim API response.');
    } else {
      // Format the postal address using the components contained in the value
      // of the `address` field.
      final palaceMuseumAddressComponents =
          palaceMuseum['address'] as Map<String, dynamic>;
      final palaceMuseumAddress =
          AddressFormatter.multiLineFormat(palaceMuseumAddressComponents);
      print(palaceMuseumAddress);
      // 100010 中国
      // 东城区
      // 东华门街道
      //景山前街 4号
    }
  } else {
    print(
        'Failed to fetch data from Nominatim API. Status code: ${palaceMuseumResponse.statusCode}');
  }
}
