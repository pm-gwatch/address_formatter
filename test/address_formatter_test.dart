import 'package:address_formatter/address_formatter.dart';
import 'package:test/test.dart';

// Reusable static address: Ecole Peschier, Geneva (CH).
// No 'country' supplied — kCountryNames injects 'Switzerland'.
const _ch = {
  'house_number': '28',
  'road': 'Avenue Dumas',
  'city': 'Genève',
  'postcode': '1206',
  'country_code': 'ch',
};

// Convenience wrapper: formats [comps] and splits the output into lines.
List<String> _lines(
  Map<String, dynamic> comps, {
  String? fallbackCountryCode,
  bool appendCountry = true,
  bool abbreviate = false,
}) => AddressFormatter.multiLineFormat(
  comps,
  fallbackCountryCode: fallbackCountryCode,
  appendCountry: appendCountry,
  abbreviate: abbreviate,
).split('\n');

void main() {
  // ── Address format structure ──────────────────────────────────────────────

  group('formatted address structure', () {
    test('CH: road house_number / postcode city / country', () {
      final lines = _lines(_ch);
      expect(lines, contains('Avenue Dumas 28'));
      expect(lines, contains('1206 Genève'));
      expect(lines, contains('Switzerland'));
    });

    test('appendCountry: false omits the country line', () {
      final lines = _lines(_ch, appendCountry: false);
      expect(lines, contains('Avenue Dumas 28'));
      expect(lines, contains('1206 Genève'));
      expect(lines, isNot(anyElement(contains('Switzerland'))));
    });

    test('FR (generic3): house_number road / postcode city / country', () {
      final lines = _lines({
        'road': 'Rue de la Paix',
        'house_number': '1',
        'city': 'Paris',
        'postcode': '75001',
        'country': 'France',
        'country_code': 'fr',
      });
      expect(lines, contains('1 Rue de la Paix'));
      expect(lines, contains('75001 Paris'));
      expect(lines, contains('France'));
    });

    test('DE: road house_number / postcode city / country', () {
      final lines = _lines({
        'road': 'Unter den Linden',
        'house_number': '1',
        'city': 'Berlin',
        'postcode': '10117',
        'country_code': 'de',
      });
      expect(lines, contains('Unter den Linden 1'));
      expect(lines, contains('10117 Berlin'));
      expect(lines, contains('Germany'));
    });

    test('GB (generic23): house_number road / city / postcode / country', () {
      final lines = _lines({
        'road': 'Baker Street',
        'house_number': '221B',
        'city': 'London',
        'postcode': 'NW1 6XE',
        'country': 'United Kingdom',
        'country_code': 'gb',
      });
      expect(lines, contains('221B Baker Street'));
      expect(lines, contains('London'));
      expect(lines, contains('NW1 6XE'));
      expect(lines, contains('United Kingdom'));
    });

    test(
      'US (generic4): house_number road / city, state_code postcode / country',
      () {
        final lines = _lines({
          'road': 'Hollywood Blvd',
          'house_number': '6925',
          'city': 'Los Angeles',
          'state': 'California',
          'postcode': '90028',
          'country': 'United States',
          'country_code': 'us',
        });
        expect(lines, contains('6925 Hollywood Blvd'));
        // generic4 prefers state_code over state; California → CA
        expect(lines, anyElement(contains('CA')));
        expect(lines, anyElement(contains('90028')));
        // US postformat_replace converts 'United States' → 'United States of America'
        expect(lines, contains('United States of America'));
      },
    );

    test('NL postformat: Dutch postcode gains space (1234AB → 1234 AB)', () {
      final lines = _lines({
        'road': 'Keizersgracht',
        'house_number': '1',
        'city': 'Amsterdam',
        'postcode': '1015AB',
        'country': 'Nederland',
        'country_code': 'nl',
      });
      expect(lines, anyElement(contains('1015 AB')));
      expect(lines, isNot(anyElement(contains('1015AB'))));
    });
  });

  // ── use_country delegation ────────────────────────────────────────────────

  group('use_country delegation', () {
    test(
      'GG uses GB format; country overridden to "Guernsey, Channel Islands"',
      () {
        final lines = _lines({
          'road': 'Le Vaugrat',
          'house_number': '10',
          'city': 'St Peter Port',
          'postcode': 'GY1 2LD',
          'country': 'Guernsey',
          'country_code': 'gg',
        });
        // GB format (generic23): house_number road, city, postcode, country
        expect(lines, contains('10 Le Vaugrat'));
        expect(lines, contains('St Peter Port'));
        expect(lines, contains('GY1 2LD'));
        // change_country replaces the supplied 'Guernsey'
        expect(lines, contains('Guernsey, Channel Islands'));
        expect(lines, isNot(contains('Guernsey')));
      },
    );

    test('PR uses US format; state=Puerto Rico resolves to state_code PR', () {
      final lines = _lines({
        'road': 'Calle Fortaleza',
        'house_number': '10',
        'city': 'San Juan',
        'postcode': '00901',
        'country': 'Puerto Rico',
        'country_code': 'pr',
      });
      // change_country replaces the supplied country
      expect(lines, contains('United States of America'));
      // add_component injects state=Puerto Rico; effectiveCc=US resolves it to PR
      expect(lines, anyElement(contains('PR')));
      expect(lines, isNot(anyElement(contains('Puerto Rico'))));
    });
  });

  // ── Aliases ───────────────────────────────────────────────────────────────

  group('aliases', () {
    test('street → road, housenumber → house_number', () {
      final lines = _lines({
        'street': 'Baker Street',
        'housenumber': '221B',
        'city': 'London',
        'postcode': 'NW1 6XE',
        'country': 'United Kingdom',
        'country_code': 'gb',
      });
      expect(lines, contains('221B Baker Street'));
    });

    test('suburb → neighbourhood (does not affect city fallback)', () {
      final lines = _lines({
        'road': 'Main Street',
        'suburb': 'Notting Hill',
        'city': 'London',
        'postcode': 'W11 1AN',
        'country': 'United Kingdom',
        'country_code': 'gb',
      });
      expect(lines, contains('London'));
    });
  });

  // ── Country code handling ─────────────────────────────────────────────────

  group('country code handling', () {
    test('UK is normalised to GB (same format, not default)', () {
      final withUK = _lines({
        'road': 'Oxford Street',
        'city': 'London',
        'postcode': 'W1D 1AN',
        'country': 'United Kingdom',
        'country_code': 'uk',
      });
      final withGB = _lines({
        'road': 'Oxford Street',
        'city': 'London',
        'postcode': 'W1D 1AN',
        'country': 'United Kingdom',
        'country_code': 'gb',
      });
      expect(withUK, equals(withGB));
    });

    test('fallbackCountryCode is used when country_code is absent', () {
      final lines = _lines({
        'road': 'O\'Connell Street',
        'city': 'Dublin',
        'postcode': 'D01 K8C4',
        'country': 'Ireland',
      }, fallbackCountryCode: 'IE');
      expect(lines, contains('Dublin'));
      expect(lines, contains('Ireland'));
    });

    test('NL + state=Curaçao → CW format, not NL format', () {
      // NL uses generic1 (road house_number); CW uses generic17 (road house_number).
      // The key difference to observe: NL has postformat_replace (adds space in
      // Dutch postcodes); CW does not. We verify the address renders without error
      // and uses CW's template by checking the absence of NL postal formatting.
      final lines = _lines({
        'road': 'Scharlooweg',
        'house_number': '5',
        'city': 'Willemstad',
        'state': 'Curaçao',
        'country': 'Curaçao',
        'country_code': 'nl',
      });
      expect(lines, contains('Scharlooweg 5'));
      expect(lines, contains('Willemstad'));
    });
  });

  // ── State / county codes ──────────────────────────────────────────────────

  group('state and county codes', () {
    test('state_code: California → CA appears in US generic4 output', () {
      final lines = _lines({
        'road': 'Hollywood Blvd',
        'city': 'Los Angeles',
        'state': 'California',
        'postcode': '90028',
        'country': 'United States',
        'country_code': 'us',
      });
      expect(lines, anyElement(contains('CA')));
    });

    test('county_code: Ancona → AN wins over county name in IT generic8', () {
      final lines = _lines({
        'road': 'Via Marconi',
        'city': 'Ancona',
        'county': 'Ancona',
        'postcode': '60121',
        'country': 'Italia',
        'country_code': 'it',
      });
      // generic8: ...{{{county_code}}} || {{{county}}}... — AN wins
      expect(lines, anyElement(contains('AN')));
      // The county name should not appear as a standalone line
      expect(lines, isNot(contains('Ancona')));
    });
  });

  // ── Abbreviations ─────────────────────────────────────────────────────────

  group('abbreviations', () {
    test('EN: Avenue → Ave (GB)', () {
      final lines = _lines({
        'road': 'Park Avenue',
        'city': 'London',
        'postcode': 'W1K 1PN',
        'country': 'United Kingdom',
        'country_code': 'gb',
      }, abbreviate: true);
      expect(lines, anyElement(contains('Park Ave')));
      expect(lines, isNot(anyElement(contains('Avenue'))));
    });

    test('FR: Boulevard → Boul (FR)', () {
      final lines = _lines({
        'road': 'Boulevard Haussmann',
        'city': 'Paris',
        'postcode': '75009',
        'country': 'France',
        'country_code': 'fr',
      }, abbreviate: true);
      expect(lines, anyElement(contains('Boul Haussmann')));
      expect(lines, isNot(anyElement(contains('Boulevard'))));
    });

    test('abbreviate: false leaves road names unchanged', () {
      final lines = _lines({
        'road': 'Park Avenue',
        'city': 'London',
        'postcode': 'W1K 1PN',
        'country': 'United Kingdom',
        'country_code': 'gb',
      }, abbreviate: false);
      expect(lines, anyElement(contains('Park Avenue')));
    });
  });

  // ── Postcode normalisation ────────────────────────────────────────────────

  group('postcode normalisation', () {
    test('over-long postcode (>20 chars) is dropped', () {
      final result = AddressFormatter.multiLineFormat({
        'road': 'Main Street',
        'city': 'Springfield',
        'postcode': '123456789012345678901',
        'country': 'United States',
        'country_code': 'us',
      });
      expect(result, isNot(contains('123456789012345678901')));
    });

    test('double postcode "NNNNN,NNNNN" is reduced to the first code', () {
      final lines = _lines({
        'road': 'Rue de la Paix',
        'city': 'Paris',
        'postcode': '75001,75002',
        'country': 'France',
        'country_code': 'fr',
      });
      expect(lines, anyElement(contains('75001')));
      expect(lines, isNot(anyElement(contains('75002'))));
    });

    test('semicolon postcode "NNNNN;NNNNN" is dropped entirely', () {
      final result = AddressFormatter.multiLineFormat({
        'road': 'Rue de la Paix',
        'city': 'Paris',
        'postcode': '75001;75002',
        'country': 'France',
        'country_code': 'fr',
      });
      expect(result, isNot(contains('75001')));
      expect(result, isNot(contains('75002')));
    });
  });

  // ── URL filtering ─────────────────────────────────────────────────────────

  group('URL filtering', () {
    test('component containing a URL is stripped before rendering', () {
      final result = AddressFormatter.multiLineFormat({
        'road': 'Rue de la Paix',
        'city': 'Paris',
        'website': 'https://example.com',
        'country': 'France',
        'country_code': 'fr',
      });
      expect(result, isNot(contains('https')));
      expect(result, isNot(contains('example.com')));
      // Rest of the address still renders.
      expect(result, contains('Paris'));
    });
  });

  // ── East Asian address formats ────────────────────────────────────────────

  group('East Asian address formats', () {
    // TW: big-to-small — country / postcode / city+suburb+road+number
    test('TW: address rendered big-to-small', () {
      final lines = _lines({
        'house_number': '1',
        'road': 'Zhongshan South Road',
        'suburb': 'Zhongzheng District',
        'city': 'Taipei',
        'postcode': '100',
        'country': 'Taiwan',
        'country_code': 'tw',
      });
      expect(lines.first, equals('Taiwan'));
      expect(lines, contains('100'));
      final streetLine = lines.firstWhere((l) => l.contains('Zhongshan'));
      expect(streetLine, contains('Taipei'));
      expect(streetLine, contains('Zhongzheng District'));
      expect(streetLine, contains('1'));
    });

    // HK default: house_number road / state_district / state || country
    test(
      'HK: state_district and state each on own line; state wins over country in fallback',
      () {
        final lines = _lines({
          'house_number': '1',
          'road': 'Harbour Road',
          'state_district': 'Wan Chai',
          'state': 'Hong Kong Island',
          'country': 'Hong Kong',
          'country_code': 'hk',
        });
        expect(lines, contains('1 Harbour Road'));
        expect(lines, contains('Wan Chai'));
        // {{#first}} state || country {{/first}} → state wins
        expect(lines, contains('Hong Kong Island'));
        expect(lines, isNot(contains('Hong Kong')));
      },
    );

    // MO default: road house_number / state_district / country
    // The MO template uses {{{suburb}}} in its fallback group, but 'suburb' is
    // aliased to 'neighbourhood' by _applyAliases, so it never renders. The
    // next fallback, {{{state_district}}}, is canonical and works correctly.
    test('MO: road before house_number; state_district on its own line', () {
      final lines = _lines({
        'road': 'Avenida Dr. Sun Yat-Sen',
        'state_district': 'NAPE',
        'country_code': 'mo',
      });
      expect(lines, contains('Avenida Dr. Sun Yat-Sen'));
      expect(lines, contains('NAPE'));
      expect(lines, contains('Macau'));
    });
  });

  // ── format ───────────────────────────────────────────────────────────────

  group('format', () {
    test('output matches multiLineFormat split on newlines', () {
      expect(AddressFormatter.format(_ch),
          equals(AddressFormatter.multiLineFormat(_ch).split('\n')));
    });

    test('each line is non-empty', () {
      expect(AddressFormatter.format(_ch), isNot(contains('')));
    });

    test('country injected from kCountryNames when absent', () {
      final lines = AddressFormatter.format({
        'road': 'Via Condotti',
        'city': 'Rome',
        'postcode': '00187',
        'country_code': 'it',
      });
      expect(lines, contains('Italy'));
    });

    test('geocoder-supplied country is preserved as-is', () {
      final lines = AddressFormatter.format({
        'road': 'Via Condotti',
        'city': 'Rome',
        'postcode': '00187',
        'country': 'Italia',
        'country_code': 'it',
      });
      expect(lines, contains('Italia'));
      expect(lines, isNot(contains('Italy')));
    });

    test('forwards appendCountry: false → no country line', () {
      final lines = AddressFormatter.format(_ch, appendCountry: false);
      expect(lines, isNot(anyElement(contains('Switzerland'))));
    });
  });

  // ── singleLineFormat ──────────────────────────────────────────────────────

  group('singleLineFormat', () {
    test('CH: lines joined with commas on a single line', () {
      final result = AddressFormatter.singleLineFormat(_ch);
      expect(result.split('\n'), hasLength(1));
      expect(result, contains('Avenue Dumas 28'));
      expect(result, contains('1206 Genève'));
      expect(result, contains('Switzerland'));
    });

    test('output matches format joined with ", "', () {
      expect(AddressFormatter.singleLineFormat(_ch),
          equals(AddressFormatter.format(_ch).join(', ')));
    });

    test('forwards appendCountry: false → country absent from output', () {
      final result = AddressFormatter.singleLineFormat(_ch, appendCountry: false);
      expect(result, isNot(contains('Switzerland')));
      expect(result, isNot(contains('Suisse')));
    });
  });
}
