// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dartlang_org/search/index_simple.dart';

void main() {
  group('TokenIndex', () {
    test('No match', () {
      final TokenIndex index = new TokenIndex()
        ..add('uri://http', 'http')
        ..add('uri://http_magic', 'http_magic');

      expect(index.search('xml'), {
        // no match for http
        // the letter 'm' matches from http_magic
        'uri://http_magic': closeTo(0.02, 0.1),
      });
    });

    test('Scoring exact and partial matches', () {
      final TokenIndex index = new TokenIndex()
        ..add('uri://http', 'http')
        ..add('uri://http_magic', 'http_magic');
      expect(index.search('http'), {
        'uri://http': closeTo(100.0, 0.1),
        'uri://http_magic': closeTo(32.9, 0.1),
      });
    });

    test('CamelCase indexing', () {
      final String queueText = '.DoubleLinkedQueue()';
      final TokenIndex index = new TokenIndex()
        ..add('queue', queueText)
        ..add('queue_lower', queueText.toLowerCase())
        ..add('unmodifiable', 'CustomUnmodifiableMapBase');
      expect(index.search('queue'), {
        'queue': closeTo(7.6, 0.1),
        'queue_lower': closeTo(5.8, 0.1),
        'unmodifiable': closeTo(0.0, 0.1),
      });
      expect(index.search('unmodifiab'), {
        'queue': closeTo(0.0, 0.1),
        'queue_lower': closeTo(0.0, 0.1),
        'unmodifiable': closeTo(15.0, 0.1),
      });
      expect(index.search('unmodifiable'), {
        'queue': closeTo(0.1, 0.1),
        'queue_lower': closeTo(0.1, 0.1),
        'unmodifiable': closeTo(20.6, 0.1),
      });
    });

    test('Wierd cases: riak client', () {
      final TokenIndex index = new TokenIndex()
        ..add('uri://cli', 'cli')
        ..add('uri://riak_client', 'riak_client')
        ..add('uri://teamspeak', 'teamspeak');

      expect(index.search('riak'), {
        'uri://riak_client': closeTo(24.6, 0.1),
        'uri://cli': closeTo(0.1, 0.1),
        'uri://teamspeak': closeTo(0.2, 0.1),
      });

      expect(index.search('riak client'), {
        'uri://riak_client': closeTo(100.0, 0.1),
        'uri://cli': closeTo(9.8, 0.1),
        'uri://teamspeak': closeTo(0.1, 0.1),
      });
    });

    test('Free up memory', () {
      final TokenIndex index = new TokenIndex();
      expect(index.tokenCount, 0);
      index.add('url1', 'text');
      expect(index.tokenCount, 9);
      index.add('url2', 'another');
      expect(index.tokenCount, 29);
      index.removeUrl('url2');
      expect(index.tokenCount, 9);
    });
  });
}
