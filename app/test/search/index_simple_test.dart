// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:test/test.dart';

import 'package:pub_dartlang_org/search/index_simple.dart';
import 'package:pub_dartlang_org/shared/platform.dart';
import 'package:pub_dartlang_org/shared/search_service.dart';

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
        'uri://http_magic': closeTo(31.8, 0.1),
      });
    });

    test('CamelCase indexing', () {
      final String queueText = '.DoubleLinkedQueue()';
      final TokenIndex index = new TokenIndex()
        ..add('queue', queueText)
        ..add('queue_lower', queueText.toLowerCase())
        ..add('unmodifiable', 'CustomUnmodifiableMapBase');
      expect(index.search('queue'), {
        'queue': closeTo(5.0, 0.1),
        'queue_lower': closeTo(3.6, 0.1),
        'unmodifiable': closeTo(0.0, 0.1),
      });
      expect(index.search('unmodifiab'), {
        'queue': closeTo(0.0, 0.1),
        'queue_lower': closeTo(0.0, 0.1),
        'unmodifiable': closeTo(11.9, 0.1),
      });
      expect(index.search('unmodifiable'), {
        'queue': closeTo(0.1, 0.1),
        'queue_lower': closeTo(0.1, 0.1),
        'unmodifiable': closeTo(17.1, 0.1),
      });
    });

    test('Wierd cases: riak client', () {
      final TokenIndex index = new TokenIndex()
        ..add('uri://cli', 'cli')
        ..add('uri://riak_client', 'riak_client')
        ..add('uri://teamspeak', 'teamspeak');

      expect(index.search('riak'), {
        'uri://riak_client': closeTo(22.7, 0.1),
        'uri://cli': closeTo(0.1, 0.1),
        'uri://teamspeak': closeTo(0.16, 0.1),
      });

      expect(index.search('riak client'), {
        'uri://riak_client': closeTo(100.0, 0.1),
        'uri://cli': closeTo(9.1, 0.1),
        'uri://teamspeak': closeTo(0.1, 0.1),
      });
    });

    test('Free up memory', () {
      final TokenIndex index = new TokenIndex();
      expect(index.tokenCount, 0);
      index.add('url1', 'text');
      expect(index.tokenCount, 9);
      index.add('url2', 'another');
      expect(index.tokenCount, 32);
      index.remove('url2');
      expect(index.tokenCount, 9);
    });
  });

  group('Score', () {
    Score score;
    setUp(() {
      score = new Score()..addValues({'a': 100.0, 'b': 30.0, 'c': 55.0}, 1.0);
    });

    test('add values with weight', () {
      score.addValues({'c': 50.0, 'd': 10.0}, 0.1);
      expect(score.values, {
        'a': 100.0,
        'b': 30.0,
        'c': 60.0,
        'd': 1.0,
      });
    });

    test('remove low scores', () {
      expect(score.values, {
        'a': 100.0,
        'b': 30.0,
        'c': 55.0,
      });
      score.removeLowScores(0.31);
      expect(score.values, {
        'a': 100.0,
        'c': 55.0,
      });
    });
  });

  group('SimplePackageIndex', () {
    SimplePackageIndex index;

    setUpAll(() async {
      index = new SimplePackageIndex();
      await index.addPackage(new PackageDocument(
        package: 'http',
        version: '0.11.3+14',
        devVersion: '0.11.3+14',
        description: 'A composable, Future-based API for making HTTP requests.',
        readme: '''http
          A composable, Future-based library for making HTTP requests.
          This package contains a set of high-level functions and classes that make it easy to consume HTTP resources. It's platform-independent, and can be used on both the command-line and the browser. Currently the global utility functions are unsupported on the browser; see "Using on the Browser" below.''',
        created: new DateTime.utc(2015, 01, 01),
        updated: new DateTime.utc(2017, 07, 20),
        platforms: ['flutter', 'server', 'web'],
        popularity: 0.7,
        health: 1.0,
        maintenance: 1.0,
      ));
      await index.addPackage(new PackageDocument(
        package: 'async',
        version: '1.13.3',
        devVersion: '1.13.3',
        description:
            'Utility functions and classes related to the \'dart:async\' library.',
        readme:
            '''Contains utility classes in the style of dart:async to work with asynchronous computations.
The AsyncCache class allows expensive asynchronous computations values to be cached for a period of time.
The AsyncMemoizer class makes it easy to only run an asynchronous operation once on demand.
The CancelableOperation class defines an operation that can be canceled by its consumer. The producer can then listen for this cancellation and stop producing the future when it's received. It can be created using a CancelableCompleter.
The delegating wrapper classes allow users to easily add functionality on top of existing instances of core types from dart:async. These include DelegatingFuture, DelegatingStream, DelegatingStreamSubscription, DelegatingStreamConsumer, DelegatingSink, DelegatingEventSink, and DelegatingStreamSink.''',
        created: new DateTime.utc(2015, 04, 01),
        updated: new DateTime.utc(2017, 05, 17),
        platforms: ['flutter', 'server', 'web'],
        popularity: 0.8,
        health: 1.0,
        maintenance: 1.0,
      ));
      await index.addPackage(new PackageDocument(
        package: 'chrome_net',
        version: '0.1.0',
        devVersion: '0.1.0',
        description: 'A set of networking library for Chrome Apps.',
        readme: '''TCP client and server libraries for Dart based Chrome Apps.
tcp.dart contains abstractions over chrome.sockets to aid in working with TCP client sockets and server sockets (TcpClient and TcpServer).
server.dart adds a small, prescriptive server (PicoServer) that can be configured with different handlers for HTTP requests.''',
        created: new DateTime.utc(2014, 04, 01),
        updated: new DateTime.utc(2014, 09, 17),
        platforms: ['server'],
        popularity: 0.0,
        health: 0.5,
        maintenance: 0.9,
      ));
      await index.merge();
    });

    test('normalized health scores', () {
      expect(index.getHealthScore(['http', 'async', 'chrome_net']), {
        'http': 100.0,
        'async': 100.0,
        'chrome_net': 50.0,
      });
    });

    test('popularity scores', () {
      expect(index.getPopularityScore(['http', 'async', 'chrome_net']), {
        'http': 70.0,
        'async': 80.0,
        'chrome_net': 0.0,
      });
    });

    test('maintenance scores', () {
      expect(index.getMaintenanceScore(['http', 'async', 'chrome_net']), {
        'http': 100.0,
        'async': 100.0,
        'chrome_net': 90.0,
      });
    });

    test('package name match: async', () async {
      final PackageSearchResult result =
          await index.search(new SearchQuery('async'));
      expect(JSON.decode(JSON.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {
            'package': 'async',
            'score': closeTo(75.4, 0.1),
          },
        ]
      });
    });

    test('description match: composable', () async {
      final PackageSearchResult result =
          await index.search(new SearchQuery('composable'));
      expect(JSON.decode(JSON.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {
            'package': 'http',
            'score': closeTo(31.2, 0.1),
          },
        ]
      });
    });

    test('readme match: chrome.sockets', () async {
      final PackageSearchResult result =
          await index.search(new SearchQuery('chrome.sockets'));
      expect(JSON.decode(JSON.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {
            'package': 'chrome_net',
            'score': closeTo(33.2, 0.1),
          },
        ]
      });
    });

    test('package prefix: chrome', () async {
      final PackageSearchResult result =
          await index.search(new SearchQuery('', packagePrefix: 'chrome'));
      expect(JSON.decode(JSON.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {
            'package': 'chrome_net',
            'score': closeTo(2.5, 0.1),
          },
        ]
      });
    });

    test('order by text: single-letter t', () async {
      final PackageSearchResult result =
          await index.search(new SearchQuery('t', order: SearchOrder.text));
      expect(JSON.decode(JSON.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 0,
        'packages': [],
      });
    });

    test('order by text: double-letter tt', () async {
      final PackageSearchResult result =
          await index.search(new SearchQuery('tt', order: SearchOrder.text));
      expect(JSON.decode(JSON.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {
            'package': 'http',
            'score': closeTo(9.6, 0.1),
          },
        ],
      });
    });

    test('order by created: no filter', () async {
      final PackageSearchResult result =
          await index.search(new SearchQuery('', order: SearchOrder.created));
      expect(JSON.decode(JSON.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 3,
        'packages': [
          {'package': 'async'},
          {'package': 'http'},
          {'package': 'chrome_net'},
        ],
      });
    });

    test('order by updated: no filter', () async {
      final PackageSearchResult result =
          await index.search(new SearchQuery('', order: SearchOrder.updated));
      expect(JSON.decode(JSON.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 3,
        'packages': [
          {'package': 'http'},
          {'package': 'async'},
          {'package': 'chrome_net'},
        ],
      });
    });

    test('order by updated: platform filter', () async {
      final PackageSearchResult result = await index.search(new SearchQuery(
        '',
        order: SearchOrder.updated,
        platformPredicate: new PlatformPredicate(
          required: ['web'],
        ),
      ));
      expect(JSON.decode(JSON.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 2,
        'packages': [
          {'package': 'http'},
          {'package': 'async'},
        ],
      });
    });

    test('order by popularity', () async {
      final PackageSearchResult result = await index
          .search(new SearchQuery('', order: SearchOrder.popularity));
      expect(JSON.decode(JSON.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 3,
        'packages': [
          {'package': 'async', 'score': 80.0},
          {'package': 'http', 'score': 70.0},
          {'package': 'chrome_net', 'score': 0.0},
        ],
      });
    });

    test('order by health', () async {
      final PackageSearchResult result =
          await index.search(new SearchQuery('', order: SearchOrder.health));
      expect(JSON.decode(JSON.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 3,
        'packages': [
          {'package': 'http', 'score': 100.0},
          {'package': 'async', 'score': 100.0},
          {'package': 'chrome_net', 'score': 50.0},
        ],
      });
    });

    test('order by maintenance', () async {
      final PackageSearchResult result = await index
          .search(new SearchQuery('', order: SearchOrder.maintenance));
      expect(JSON.decode(JSON.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 3,
        'packages': [
          {'package': 'http', 'score': 100.0},
          {'package': 'async', 'score': 100.0},
          {'package': 'chrome_net', 'score': 90.0},
        ],
      });
    });
  });
}
