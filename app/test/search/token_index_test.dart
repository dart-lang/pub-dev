// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/search/text_utils.dart';
import 'package:pub_dev/search/token_index.dart';
import 'package:test/test.dart';

Future<Map<String, double>> _search(
  TokenIndex index,
  List<String> keys,
  String text,
) {
  return index.withSearchWords(splitForQuery(text), (score) async {
    final result = <String, double>{};
    for (var i = 0; i < score.length; i++) {
      final v = score.getValue(i);
      if (v > 0.0) result[keys[i]] = v;
    }
    return result;
  });
}

void main() {
  group('TokenIndex', () {
    test('partial token lookup', () async {
      final index = TokenIndex(['SomeCamelCasedWord and others']);
      expect((await index.lookupTokens('word')).tokenWeights, {'word': 1.0});
      expect((await index.lookupTokens('OtherCased')).tokenWeights, {
        'cased': closeTo(0.70, 0.01),
      });
      expect((await index.lookupTokens('SomethingElse')).tokenWeights, {});
      // do not return `cased` here:
      expect(
        (await index.lookupTokens('SomethingElse OtherCased')).tokenWeights,
        {},
      );
    });

    test('No match', () async {
      final keys = ['uri://http', 'uri://http_magic'];
      final index = TokenIndex(['http', 'http_magic']);

      expect(await _search(index, keys, 'xml'), {
        // no match for http
        // no match for http_magic
      });
    });

    test('Scoring exact and partial matches', () async {
      final keys = ['uri://http', 'uri://http_magic'];
      final index = TokenIndex(['http', 'http_magic']);
      expect(await _search(index, keys, 'http'), {
        'uri://http': closeTo(0.993, 0.001),
        'uri://http_magic': closeTo(0.989, 0.001),
      });
    });

    test('CamelCase indexing', () async {
      final String queueText = '.DoubleLinkedQueue()';
      final keys = ['queue', 'queue_lower', 'unmodifiable'];
      final index = TokenIndex([
        queueText,
        queueText.toLowerCase(),
        'CustomUnmodifiableMapBase',
      ]);
      expect(await _search(index, keys, 'queue'), {
        'queue': closeTo(0.53, 0.01),
      });
      expect(
        await _search(index, keys, 'unmodifiabl'),
        {},
      ); // no partial matches
      expect(await _search(index, keys, 'unmodifiable'), {
        'unmodifiable': closeTo(0.68, 0.01),
      });
    });

    test('Wierd cases: riak client', () async {
      final keys = ['uri://cli', 'uri://riak_client', 'uri://teamspeak'];
      final index = TokenIndex(['cli', 'riak_client', 'teamspeak']);

      expect(await _search(index, keys, 'riak'), {
        'uri://riak_client': closeTo(0.99, 0.01),
      });
      expect(await _search(index, keys, 'riak client'), {
        'uri://riak_client': closeTo(0.98, 0.01),
      });
    });

    test('Do not overweight partial matches', () async {
      final keys = ['flutter_qr_reader'];
      final index = TokenIndex(['flutter_qr_reader']);
      final data = await _search(index, keys, 'ByteDataReader');
      // The partial match should not return more than 0.65 as score.
      expect(data, {'flutter_qr_reader': lessThan(0.65)});
    });

    test('longer words', () async {
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
      final index = TokenIndex(names);
      final match = await _search(index, names, 'location');
      // location should be the top value, everything else should be lower
      final locationValue = match['location'];
      expect(
        match.keys
            .where((k) => k != 'location')
            .map((k) => match[k])
            .every((v) => v! < locationValue!),
        isTrue,
      );
    });
  });

  group('IndexedScore', () {
    const keys = ['a', 'b', 'c'];
    final score = IndexedScore(3)
      ..setValue(0, 100.0)
      ..setValue(1, 30.0)
      ..setValue(2, 55.0);

    test('topIndices', () {
      expect(score.topIndices(1).map((i) => keys[i]), ['a']);
      expect(score.topIndices(2).map((i) => keys[i]), ['a', 'c']);
      expect(score.topIndices(2, minValue: 60).map((i) => keys[i]), ['a']);
    });
  });
}
