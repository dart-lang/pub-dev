// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/search/token_index.dart';
import 'package:test/test.dart';

void main() {
  group('TokenIndex', () {
    test('partial token lookup', () {
      final index = TokenIndex()..add('x', 'SomeCamelCasedWord and others');
      expect(index.lookupTokens('word').tokenWeights, {'word': 1.0});
      expect(index.lookupTokens('OtherCased').tokenWeights,
          {'cased': closeTo(0.70, 0.01)});
      expect(index.lookupTokens('SomethingElse').tokenWeights, {});
      // do not return `cased` here:
      expect(index.lookupTokens('SomethingElse OtherCased').tokenWeights, {});
    });

    test('No match', () {
      final TokenIndex index = TokenIndex()
        ..add('uri://http', 'http')
        ..add('uri://http_magic', 'http_magic');

      expect(index.search('xml'), {
        // no match for http
        // no match for http_magic
      });
    });

    test('Scoring exact and partial matches', () {
      final TokenIndex index = TokenIndex()
        ..add('uri://http', 'http')
        ..add('uri://http_magic', 'http_magic');
      expect(index.search('http'), {
        'uri://http': closeTo(0.993, 0.001),
        'uri://http_magic': closeTo(0.989, 0.001),
      });
    });

    test('CamelCase indexing', () {
      final String queueText = '.DoubleLinkedQueue()';
      final TokenIndex index = TokenIndex()
        ..add('queue', queueText)
        ..add('queue_lower', queueText.toLowerCase())
        ..add('unmodifiable', 'CustomUnmodifiableMapBase');
      expect(index.search('queue'), {
        'queue': closeTo(0.53, 0.01),
      });
      expect(index.search('unmodifiabl'), {}); // no partial matches
      expect(index.search('unmodifiable'), {
        'unmodifiable': closeTo(0.68, 0.01),
      });
    });

    test('Wierd cases: riak client', () {
      final TokenIndex index = TokenIndex()
        ..add('uri://cli', 'cli')
        ..add('uri://riak_client', 'riak_client')
        ..add('uri://teamspeak', 'teamspeak');

      expect(index.search('riak'), {
        'uri://riak_client': closeTo(0.99, 0.01),
      });

      expect(index.search('riak client'), {
        'uri://riak_client': closeTo(0.99, 0.01),
      });
    });

    test('Free up memory', () {
      final TokenIndex index = TokenIndex();
      expect(index.tokenCount, 0);
      index.add('url1', 'text');
      expect(index.tokenCount, 1);
      index.add('url2', 'another');
      expect(index.tokenCount, 2);
    });

    test('Do not overweight partial matches', () {
      final index = TokenIndex()..add('flutter_qr_reader', 'flutter_qr_reader');
      final data = index.search('ByteDataReader');
      // The partial match should not return more than 0.65 as score.
      expect(data, {'flutter_qr_reader': lessThan(0.65)});
    });

    test('longer words', () {
      final index = TokenIndex();
      final names = [
        'location',
        'geolocator',
        'firestore_helpers',
        'geolocation',
        'location_context',
        'amap_location',
        'flutter_location_picker',
        'flutter_amap_location',
        'location_picker',
        'background_location_updates',
      ];
      for (String name in names) {
        index.add(name, name);
      }
      final match = index.search('location');
      // location should be the top value, everything else should be lower
      final locationValue = match['location'];
      expect(
          match.keys
              .where((k) => k != 'location')
              .map((k) => match[k])
              .every((v) => v! < locationValue!),
          isTrue);
    });
  });

  group('Score', () {
    late Score score;
    setUp(() {
      score = Score({'a': 100.0, 'b': 30.0, 'c': 55.0});
    });

    test('remove low scores', () {
      expect(score.getValues(), {
        'a': 100.0,
        'b': 30.0,
        'c': 55.0,
      });
      expect(score.removeLowValues(fraction: 0.31).getValues(), {
        'a': 100.0,
        'c': 55.0,
      });
      expect(score.removeLowValues(minValue: 56.0).getValues(), {
        'a': 100.0,
      });
    });

    test('top', () {
      expect(score.top(1).getValues(), {'a': 100.0});
      expect(score.top(2).getValues(), {'a': 100.0, 'c': 55.0});
      expect(score.top(2, minValue: 60).getValues(), {'a': 100.0});
    });
  });
}
