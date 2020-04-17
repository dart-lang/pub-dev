// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:math';

import 'package:test/test.dart';

import 'package:pub_dev/search/index_simple.dart';
import 'package:pub_dev/search/search_service.dart';

void main() {
  group('TokenIndex', () {
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
        'queue': closeTo(0.29, 0.01),
      });
      expect(index.search('unmodifiab'), {
        'unmodifiable': closeTo(0.47, 0.01),
      });
      expect(index.search('unmodifiable'), {
        'unmodifiable': closeTo(0.47, 0.01),
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
      index.remove('url2');
      expect(index.tokenCount, 1);
    });
  });

  group('TokenMatch', () {
    test('longer words', () {
      final index = TokenIndex(minLength: 2);
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
      final match = index.lookupTokens('location');
      // location should be the top value, everything else should be lower
      expect(match.tokenWeights, {
        'location': 1.0,
        'geolocation': closeTo(0.727, 0.001),
      });
    });

    test('short words: lookup for app', () {
      final index = TokenIndex(minLength: 2);
      index.add('app', 'app');
      index.add('apps', 'apps');
      final match = index.lookupTokens('app');
      expect(match.tokenWeights, {'app': 1.0, 'apps': 0.75});
    });
  });

  group('Score', () {
    Score score;
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
  });

  group('SimplePackageIndex', () {
    SimplePackageIndex index;

    setUpAll(() async {
      index = SimplePackageIndex();
      await index.addPackage(PackageDocument(
        package: 'http',
        version: '0.11.3+14',
        devVersion: '0.11.3+14',
        description: 'A composable, Future-based API for making HTTP requests.',
        readme: '''http
          A composable, Future-based library for making HTTP requests.
          This package contains a set of high-level functions and classes that make it easy to consume HTTP resources. It's platform-independent, and can be used on both the command-line and the browser. Currently the global utility functions are unsupported on the browser; see "Using on the Browser" below.''',
        created: DateTime.utc(2015, 01, 01),
        updated: DateTime.utc(2017, 07, 20),
        tags: ['sdk:dart', 'sdk:flutter', 'runtime:native', 'runtime:web'],
        popularity: 0.7,
        health: 1.0,
        maintenance: 1.0,
        likeCount: 10,
        dependencies: {'async': 'direct', 'test': 'dev', 'foo': 'transitive'},
        uploaderEmails: ['user1@example.com'],
      ));
      await index.addPackage(PackageDocument(
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
        created: DateTime.utc(2015, 04, 01),
        updated: DateTime.utc(2017, 05, 17),
        tags: ['sdk:dart', 'sdk:flutter', 'runtime:native', 'runtime:web'],
        popularity: 0.8,
        health: 1.0,
        maintenance: 1.0,
        likeCount: 1,
        dependencies: {'test': 'dev'},
        publisherId: 'dart.dev',
        uploaderEmails: ['user1@example.com'],
      ));
      await index.addPackage(PackageDocument(
        package: 'chrome_net',
        version: '0.1.0',
        devVersion: '0.1.0',
        description: 'A set of networking library for Chrome Apps.',
        readme: '''TCP client and server libraries for Dart based Chrome Apps.
tcp.dart contains abstractions over chrome.sockets to aid in working with TCP client sockets and server sockets (TcpClient and TcpServer).
server.dart adds a small, prescriptive server (PicoServer) that can be configured with different handlers for HTTP requests.''',
        created: DateTime.utc(2014, 04, 01),
        updated: DateTime.utc(2014, 09, 17),
        tags: ['sdk:dart', 'runtime:web'],
        popularity: 0.0,
        health: 0.5,
        maintenance: 0.9,
        dependencies: {'foo': 'direct'},
      ));
      await index.markReady();
    });

    test('health scores', () {
      expect(index.getHealthScore(['http', 'async', 'chrome_net']), {
        'http': 1.0,
        'async': 1.0,
        'chrome_net': 0.5,
      });
    });

    test('popularity scores', () {
      expect(index.getPopularityScore(['http', 'async', 'chrome_net']), {
        'http': 0.7,
        'async': 0.8,
        'chrome_net': 0.0,
      });
    });

    test('maintenance scores', () {
      expect(index.getMaintenanceScore(['http', 'async', 'chrome_net']), {
        'http': 1.0,
        'async': 1.0,
        'chrome_net': 0.9,
      });
    });

    test('like scores', () {
      expect(index.getLikeScore(['http', 'async', 'chrome_net']), {
        'http': 10.0,
        'async': 1.0,
        'chrome_net': 0.0,
      });
    });

    test('package name match: async', () async {
      final PackageSearchResult result =
          await index.search(SearchQuery.parse(query: 'async'));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {
            'package': 'async',
            'score': closeTo(0.92, 0.01),
          },
        ]
      });
    });

    test('description match: composable', () async {
      final PackageSearchResult result =
          await index.search(SearchQuery.parse(query: 'composable'));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {
            'package': 'http',
            'score': closeTo(0.79, 0.01),
          },
        ]
      });
    });

    test('readme match: chrome.sockets', () async {
      final PackageSearchResult result =
          await index.search(SearchQuery.parse(query: 'chrome.sockets'));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {
            'package': 'chrome_net',
            'score': closeTo(0.39, 0.01),
          },
        ]
      });
    });

    test('typo match: utilito', () async {
      final PackageSearchResult result =
          await index.search(SearchQuery.parse(query: 'utilito'));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 2,
        'packages': [
          {'package': 'async', 'score': closeTo(0.82, 0.01)},
          {'package': 'http', 'score': closeTo(0.65, 0.01)},
        ]
      });
    });

    test('exact phrase match: utilito', () async {
      final PackageSearchResult result =
          await index.search(SearchQuery.parse(query: '"utilito"'));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 0,
        'packages': [],
      });
    });

    test('exact phrase match: utility', () async {
      final PackageSearchResult result =
          await index.search(SearchQuery.parse(query: '"utility"'));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 2,
        'packages': [
          {'package': 'async', 'score': closeTo(0.81, 0.01)},
          {'package': 'http', 'score': closeTo(0.65, 0.01)},
        ],
      });
    });

    test('exact phrase with dot: "once on demand."', () async {
      final result =
          await index.search(SearchQuery.parse(query: '"once on demand."'));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {'package': 'async', 'score': closeTo(0.38, 0.01)},
        ],
      });
    });

    test('package prefix: chrome', () async {
      final PackageSearchResult result =
          await index.search(SearchQuery.parse(query: 'package:chrome'));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {
            'package': 'chrome_net',
            'score': closeTo(0.53, 0.1),
          },
        ]
      });
    });

    test('order by text: single-letter t', () async {
      final PackageSearchResult result = await index
          .search(SearchQuery.parse(query: 't', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 0,
        'packages': [],
      });
    });

    test('order by created: no filter', () async {
      final PackageSearchResult result =
          await index.search(SearchQuery.parse(order: SearchOrder.created));
      expect(json.decode(json.encode(result)), {
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
      final PackageSearchResult result = await index
          .search(SearchQuery.parse(query: '', order: SearchOrder.updated));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 3,
        'packages': [
          {'package': 'http'},
          {'package': 'async'},
          {'package': 'chrome_net'},
        ],
      });
    });

    test('order by updated: query text filter', () async {
      final PackageSearchResult result = await index
          .search(SearchQuery.parse(query: 'http', order: SearchOrder.updated));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 2,
        'packages': [
          {'package': 'http'},
          {'package': 'chrome_net'},
        ],
      });
    });

    test('order by updated: runtime filter', () async {
      final PackageSearchResult result = await index.search(SearchQuery.parse(
        sdk: 'dart',
        order: SearchOrder.updated,
        runtimes: ['native'],
      ));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 2,
        'packages': [
          {'package': 'http'},
          {'package': 'async'},
        ],
      });
    });

    test('order by popularity', () async {
      final PackageSearchResult result =
          await index.search(SearchQuery.parse(order: SearchOrder.popularity));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 3,
        'packages': [
          {'package': 'async', 'score': 0.8},
          {'package': 'http', 'score': 0.7},
          {'package': 'chrome_net', 'score': 0.0},
        ],
      });
    });

    test('order by health', () async {
      final PackageSearchResult result =
          await index.search(SearchQuery.parse(order: SearchOrder.health));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 3,
        'packages': [
          {'package': 'http', 'score': 1.0},
          {'package': 'async', 'score': 1.0},
          {'package': 'chrome_net', 'score': 0.5},
        ],
      });
    });

    test('order by maintenance', () async {
      final PackageSearchResult result =
          await index.search(SearchQuery.parse(order: SearchOrder.maintenance));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 3,
        'packages': [
          {'package': 'http', 'score': 1.0},
          {'package': 'async', 'score': 1.0},
          {'package': 'chrome_net', 'score': 0.9},
        ],
      });
    });

    test('order by like count', () async {
      final PackageSearchResult result =
          await index.search(SearchQuery.parse(order: SearchOrder.like));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 3,
        'packages': [
          {'package': 'http', 'score': 10.0},
          {'package': 'async', 'score': 1.0},
          {'package': 'chrome_net', 'score': 0.0},
        ],
      });
    });

    test('filter by one dependency', () async {
      final PackageSearchResult result =
          await index.search(SearchQuery.parse(query: 'dependency:test'));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 2,
        'packages': [
          {'package': 'async', 'score': closeTo(0.930, 0.001)},
          {'package': 'http', 'score': closeTo(0.895, 0.001)},
        ],
      });
    });

    test('filter by foo as direct/dev dependency', () async {
      final PackageSearchResult result =
          await index.search(SearchQuery.parse(query: 'dependency:foo'));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {'package': 'chrome_net', 'score': closeTo(0.531, 0.001)},
        ],
      });
    });

    test('filter by foo as transitive dependency', () async {
      final PackageSearchResult result =
          await index.search(SearchQuery.parse(query: 'dependency*:foo'));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 2,
        'packages': [
          {'package': 'http', 'score': closeTo(0.895, 0.001)},
          {'package': 'chrome_net', 'score': closeTo(0.531, 0.001)},
        ],
      });
    });

    test('filter by text and dependency', () async {
      final PackageSearchResult result = await index
          .search(SearchQuery.parse(query: 'composable dependency:test'));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {'package': 'http', 'score': closeTo(0.79, 0.01)},
        ],
      });
    });

    test('filter by two dependencies', () async {
      final PackageSearchResult result = await index
          .search(SearchQuery.parse(query: 'dependency:async dependency:test'));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {'package': 'http', 'score': closeTo(0.895, 0.001)},
        ],
      });
    });

    test('no results via publisher', () async {
      final PackageSearchResult result = await index
          .search(SearchQuery.parse(query: 'publisher:other-domain.com'));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 0,
        'packages': [],
      });
    });

    test('filter by publisher', () async {
      final PackageSearchResult result =
          await index.search(SearchQuery.parse(query: 'publisher:dart.dev'));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {'package': 'async', 'score': closeTo(0.930, 0.001)},
        ],
      });
    });

    test('no results via owners', () async {
      final PackageSearchResult result = await index.search(
          SearchQuery.parse(uploaderOrPublishers: ['other-domain.com']));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 0,
        'packages': [],
      });
    });

    test('filter by a single owner', () async {
      final PackageSearchResult result = await index
          .search(SearchQuery.parse(uploaderOrPublishers: ['dart.dev']));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {'package': 'async', 'score': closeTo(0.930, 0.001)},
        ],
      });
    });

    test('filter by multiple owners', () async {
      final PackageSearchResult result =
          await index.search(SearchQuery.parse(uploaderOrPublishers: [
        'dart.dev',
        'user1@example.com',
      ]));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 2,
        'packages': [
          {'package': 'async', 'score': closeTo(0.930, 0.001)},
          {'package': 'http', 'score': closeTo(0.895, 0.001)},
        ],
      });
    });

    test('no results via email', () async {
      final PackageSearchResult result =
          await index.search(SearchQuery.parse(query: 'email:some@other.com'));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 0,
        'packages': [],
      });
    });

    test('filter by email', () async {
      final PackageSearchResult result = await index
          .search(SearchQuery.parse(query: 'email:user1@example.com'));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 2,
        'packages': [
          {'package': 'async', 'score': closeTo(0.930, 0.001)},
          {'package': 'http', 'score': closeTo(0.895, 0.001)},
        ],
      });
    });

    test('multiword query: implicit AND', () async {
      final PackageSearchResult composable = await index.search(
          SearchQuery.parse(query: 'composable', order: SearchOrder.text));
      expect(json.decode(json.encode(composable)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {'package': 'http', 'score': closeTo(0.88, 0.01)},
        ],
      });

      final PackageSearchResult library = await index
          .search(SearchQuery.parse(query: 'library', order: SearchOrder.text));
      expect(json.decode(json.encode(library)), {
        'indexUpdated': isNotNull,
        'totalCount': 3,
        'packages': [
          {'package': 'chrome_net', 'score': closeTo(0.88, 0.01)},
          {'package': 'async', 'score': closeTo(0.88, 0.01)},
          {'package': 'http', 'score': closeTo(0.72, 0.01)},
        ],
      });

      // Without the implicit AND, the end result would be close to the result
      // of the `library` search.
      final PackageSearchResult both = await index.search(SearchQuery.parse(
          query: 'composable library', order: SearchOrder.text));
      expect(json.decode(json.encode(both)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {'package': 'http', 'score': closeTo(0.65, 0.01)},
        ],
      });
    });
  });

  group('SimplePackageIndex + randomize', () {
    final index = SimplePackageIndex(random: Random(12345));

    setUpAll(() async {
      for (int i = 0; i < 1000; i++) {
        await index
            .addPackage(PackageDocument(package: 'd$i', popularity: i / 1000));
      }
    });

    test('random1', () async {
      final results =
          await index.search(SearchQuery.parse(randomize: true, limit: 3));
      // should not contain d899 or below
      expect(results.packages.map((sr) => sr.package).toList(), [
        'd909',
        'd982',
        'd925',
        'd993',
        'd989',
        'd915',
        'd992',
        'd902',
        'd984',
        'd901',
      ]);
    });

    // uses the same index, the Random object is on its second use
    test('random2', () async {
      final results =
          await index.search(SearchQuery.parse(randomize: true, limit: 20));
      // could contain d899 or below
      expect(results.packages.map((sr) => sr.package).take(3).toList(), [
        'd857',
        'd969',
        'd809',
      ]);
    });
  });
}
