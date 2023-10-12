// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:_pub_shared/search/search_form.dart';
import 'package:clock/clock.dart';
import 'package:pub_dev/search/mem_index.dart';
import 'package:pub_dev/search/search_service.dart';
import 'package:test/test.dart';

void main() {
  group('InMemoryPackageIndex', () {
    late InMemoryPackageIndex index;
    late DateTime lastPackageUpdated;

    setUpAll(() async {
      final docs = [
        PackageDocument(
          package: 'http',
          version: '0.11.3+14',
          description:
              'A composable, Future-based API for making HTTP requests.',
          readme: '''http
          A composable, Future-based library for making HTTP requests.
          This package contains a set of high-level functions and classes that make it easy to consume HTTP resources. It's platform-independent, and can be used on both the command-line and the browser. Currently the global utility functions are unsupported on the browser; see "Using on the Browser" below.''',
          created: DateTime.utc(2015, 01, 01),
          updated: DateTime.utc(2017, 07, 20),
          tags: [
            'sdk:dart',
            'sdk:flutter',
            'runtime:native-jit',
            'runtime:web'
          ],
          likeCount: 10,
          popularityScore: 0.7,
          grantedPoints: 110,
          maxPoints: 110,
          dependencies: {'async': 'direct', 'test': 'dev', 'foo': 'transitive'},
        ),
        PackageDocument(
          package: 'async',
          version: '1.13.3',
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
          tags: [
            'publisher:dart.dev',
            'sdk:dart',
            'sdk:flutter',
            'runtime:native-jit',
            'runtime:web'
          ],
          likeCount: 1,
          grantedPoints: 10,
          maxPoints: 110,
          dependencies: {'test': 'dev'},
          popularityScore: 0.8,
        ),
        PackageDocument(
          package: 'chrome_net',
          version: '0.1.0',
          description: 'A set of networking library for Chrome Apps.',
          readme: '''TCP client and server libraries for Dart based Chrome Apps.
tcp.dart contains abstractions over chrome.sockets to aid in working with TCP client sockets and server sockets (TcpClient and TcpServer).
server.dart adds a small, prescriptive server (PicoServer) that can be configured with different handlers for HTTP requests.''',
          created: DateTime.utc(2014, 04, 01),
          updated: DateTime.utc(2014, 09, 17),
          tags: ['sdk:dart', 'runtime:web'],
          dependencies: {'foo': 'direct'},
          grantedPoints: 0,
          maxPoints: 110,
        ),
      ];
      lastPackageUpdated =
          docs.map((p) => p.updated).reduce((a, b) => a.isAfter(b) ? a : b);
      index = InMemoryPackageIndex(documents: docs);
    });

    test('package name match: async', () async {
      final PackageSearchResult result =
          index.search(ServiceSearchQuery.parse(query: 'async'));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'async', 'score': closeTo(0.65, 0.01)},
        ],
      });
    });

    test('description match: composable', () async {
      final PackageSearchResult result =
          index.search(ServiceSearchQuery.parse(query: 'composable'));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {
            'package': 'http',
            'score': closeTo(0.85, 0.01),
          },
        ],
      });
    });

    test('readme match: chrome.sockets', () async {
      final PackageSearchResult result =
          index.search(ServiceSearchQuery.parse(query: 'chrome.sockets'));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {
            'package': 'chrome_net',
            'score': closeTo(0.33, 0.01),
          },
        ],
      });
    });

    test('exact phrase match: utility', () async {
      final PackageSearchResult result =
          index.search(ServiceSearchQuery.parse(query: '"utility"'));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 2,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'http', 'score': closeTo(0.69, 0.01)},
          {'package': 'async', 'score': closeTo(0.57, 0.01)},
        ],
      });
    });

    test('exact phrase: multiple words with matching cases', () async {
      final result =
          index.search(ServiceSearchQuery.parse(query: '"AsyncCache class"'));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'async', 'score': closeTo(0.34, 0.01)},
        ],
      });
    });

    test('exact phrase: multiple words with non-matching cases', () async {
      final result =
          index.search(ServiceSearchQuery.parse(query: '"asynccache Class"'));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 0,
        'sdkLibraryHits': [],
        'packageHits': [
          // TODO: make sure package:async shows up
        ],
      });
    });

    test('exact phrase with dot: "once on demand."', () async {
      final result =
          index.search(ServiceSearchQuery.parse(query: '"once on demand."'));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'async', 'score': closeTo(0.24, 0.01)},
        ],
      });
    });

    test('package prefix: chrome', () async {
      final PackageSearchResult result =
          index.search(ServiceSearchQuery.parse(query: 'package:chrome'));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {
            'package': 'chrome_net',
            'score': closeTo(0.54, 0.1),
          },
        ],
      });
    });

    test('order by text: single-letter t', () async {
      final PackageSearchResult result = index.search(
          ServiceSearchQuery.parse(query: 't', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 2,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'http', 'score': 1},
          {'package': 'chrome_net', 'score': 1},
        ],
      });
    });

    test('order by created: no filter', () async {
      final PackageSearchResult result =
          index.search(ServiceSearchQuery.parse(order: SearchOrder.created));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 3,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'async'},
          {'package': 'http'},
          {'package': 'chrome_net'},
        ],
      });
    });

    test('order by updated: no filter', () async {
      final PackageSearchResult result = index.search(
          ServiceSearchQuery.parse(query: '', order: SearchOrder.updated));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 3,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'http'},
          {'package': 'async'},
          {'package': 'chrome_net'},
        ],
      });
    });

    test('order by updated: query text filter', () async {
      final PackageSearchResult result = index.search(
          ServiceSearchQuery.parse(query: 'http', order: SearchOrder.updated));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 2,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'http'},
          {'package': 'chrome_net'},
        ],
      });
    });

    test('order by update with sdk filter', () async {
      final result = index.search(
        SearchForm(
          query: 'sdk:dart runtime:native-jit',
          order: SearchOrder.updated,
        ).toServiceQuery(),
      );
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 2,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'http'},
          {'package': 'async'},
        ],
      });
    });

    test('order by popularity', () async {
      final PackageSearchResult result =
          index.search(ServiceSearchQuery.parse(order: SearchOrder.popularity));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 3,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'async', 'score': 0.8},
          {'package': 'http', 'score': 0.7},
          {'package': 'chrome_net', 'score': 0.0},
        ],
      });
    });

    test('order by like count', () async {
      final PackageSearchResult result =
          index.search(ServiceSearchQuery.parse(order: SearchOrder.like));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 3,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'http', 'score': 10.0},
          {'package': 'async', 'score': 1.0},
          {'package': 'chrome_net', 'score': 0.0},
        ],
      });
    });

    test('order by pub points', () async {
      final PackageSearchResult result =
          index.search(ServiceSearchQuery.parse(order: SearchOrder.points));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 3,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'http', 'score': 110.0},
          {'package': 'async', 'score': 10.0},
          {'package': 'chrome_net', 'score': 0.0},
        ],
      });
    });

    test('filter by one dependency', () async {
      final PackageSearchResult result =
          index.search(ServiceSearchQuery.parse(query: 'dependency:test'));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 2,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'http', 'score': closeTo(0.96, 0.01)},
          {'package': 'async', 'score': closeTo(0.65, 0.01)},
        ],
      });

      // do not highlight package if otherwise exact match is in the query
      final rs2 =
          index.search(ServiceSearchQuery.parse(query: 'http dependency:test'));
      expect(rs2.totalCount, 1);
    });

    test('filter by foo as direct/dev dependency', () async {
      final PackageSearchResult result =
          index.search(ServiceSearchQuery.parse(query: 'dependency:foo'));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'chrome_net', 'score': closeTo(0.45, 0.01)},
        ],
      });
    });

    test('filter by foo as transitive dependency', () async {
      final PackageSearchResult result =
          index.search(ServiceSearchQuery.parse(query: 'dependency*:foo'));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 2,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'http', 'score': closeTo(0.96, 0.01)},
          {'package': 'chrome_net', 'score': closeTo(0.45, 0.01)},
        ],
      });

      // do not highlight package if otherwise exact match is in the query
      final rs2 =
          index.search(ServiceSearchQuery.parse(query: 'http dependency*:foo'));
      expect(rs2.totalCount, 2);
    });

    test('filter by text and dependency', () async {
      final PackageSearchResult result = index.search(
          ServiceSearchQuery.parse(query: 'composable dependency:test'));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'http', 'score': closeTo(0.85, 0.01)},
        ],
      });
    });

    test('filter by two dependencies', () async {
      final PackageSearchResult result = index.search(
          ServiceSearchQuery.parse(query: 'dependency:async dependency:test'));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'http', 'score': closeTo(0.96, 0.01)},
        ],
      });
    });

    test('no results via publisher', () async {
      final PackageSearchResult result = index.search(
          ServiceSearchQuery.parse(query: 'publisher:other-domain.com'));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 0,
        'sdkLibraryHits': [],
        'packageHits': [],
      });
    });

    test('filter by publisher', () async {
      final PackageSearchResult result =
          index.search(ServiceSearchQuery.parse(query: 'publisher:dart.dev'));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'async', 'score': closeTo(0.65, 0.01)},
        ],
      });

      // do not highlight package if otherwise exact match is in the query
      final rs2 = index
          .search(ServiceSearchQuery.parse(query: 'async publisher:dart.dev'));
      expect(rs2.totalCount, 1);
    });

    test('no results with minPoints', () async {
      final result = index.search(ServiceSearchQuery.parse(minPoints: 100000));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 0,
        'sdkLibraryHits': [],
        'packageHits': [],
      });
    });

    test('filter with minPoints', () async {
      final result = index.search(ServiceSearchQuery.parse(minPoints: 10));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 2,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'http', 'score': isNotNull},
          {'package': 'async', 'score': isNotNull},
        ],
      });
    });

    test('no results with updatedInDays', () async {
      final result = index.search(ServiceSearchQuery.parse(updatedInDays: 1));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 0,
        'sdkLibraryHits': [],
        'packageHits': [],
      });
    });

    test('filter with updatedInDays', () async {
      final days = clock.now().difference(lastPackageUpdated).inDays;
      final result1 =
          index.search(ServiceSearchQuery.parse(updatedInDays: days - 1));
      expect(json.decode(json.encode(result1)), {
        'timestamp': isNotNull,
        'totalCount': 0,
        'sdkLibraryHits': [],
        'packageHits': [],
      });

      final result2 =
          index.search(ServiceSearchQuery.parse(updatedInDays: days + 1));
      expect(json.decode(json.encode(result2)), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'http', 'score': isNotNull},
        ],
      });
    });

    test('multiword query: implicit AND', () async {
      final PackageSearchResult composable = index.search(
          ServiceSearchQuery.parse(
              query: 'composable', order: SearchOrder.text));
      expect(json.decode(json.encode(composable)), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'http', 'score': closeTo(0.87, 0.01)},
        ],
      });

      final PackageSearchResult library = index.search(
          ServiceSearchQuery.parse(query: 'library', order: SearchOrder.text));
      expect(json.decode(json.encode(library)), {
        'timestamp': isNotNull,
        'totalCount': 3,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'chrome_net', 'score': closeTo(0.88, 0.01)},
          {'package': 'async', 'score': closeTo(0.88, 0.01)},
          {'package': 'http', 'score': closeTo(0.72, 0.01)},
        ],
      });

      // Without the implicit AND, the end result would be close to the result
      // of the `library` search.
      final PackageSearchResult both = index.search(ServiceSearchQuery.parse(
          query: 'composable library', order: SearchOrder.text));
      expect(json.decode(json.encode(both)), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'http', 'score': closeTo(0.63, 0.01)},
        ],
      });
    });

    test('non-word query with default order', () async {
      final rs = index.search(ServiceSearchQuery.parse(query: '='));
      expect(rs.isEmpty, isTrue);
    });

    test('non-word query with text order', () async {
      final rs = index.search(
          ServiceSearchQuery.parse(query: '=', order: SearchOrder.text));
      expect(rs.isEmpty, isTrue);
    });
  });

  group('special cases', () {
    test('short words: lookup for app(s)', () async {
      final index = InMemoryPackageIndex(documents: [
        PackageDocument(
          package: 'app',
          updated: DateTime(2020, 10, 2),
        ),
        PackageDocument(
          package: 'apps',
          updated: DateTime(2020, 10, 1),
        ),
      ]);
      final match = index.search(
          ServiceSearchQuery.parse(query: 'app', order: SearchOrder.text));
      expect(match.packageHits.map((e) => e.toJson()), [
        {'package': 'app', 'score': 1.0},
        {'package': 'apps', 'score': 1.0},
      ]);
      final match2 = index.search(
          ServiceSearchQuery.parse(query: 'apps', order: SearchOrder.text));
      expect(match2.packageHits.map((e) => e.toJson()), [
        {'package': 'app', 'score': 1.0},
        {'package': 'apps', 'score': 1.0},
      ]);
    });

    test('short words: lookup for app(z)', () async {
      final index = InMemoryPackageIndex(documents: [
        PackageDocument(
          package: 'app',
          updated: DateTime(2020, 10, 2),
        ),
        PackageDocument(
          package: 'appz',
          updated: DateTime(2020, 10, 2),
        ),
      ]);
      final match = index.search(
          ServiceSearchQuery.parse(query: 'app', order: SearchOrder.text));
      expect(match.packageHits.map((e) => e.toJson()), [
        {'package': 'app', 'score': 1.0},
        {'package': 'appz', 'score': 1.0},
      ]);
      final match2 = index.search(
          ServiceSearchQuery.parse(query: 'appz', order: SearchOrder.text));
      expect(match2.packageHits.map((e) => e.toJson()), [
        {'package': 'appz', 'score': 1.0},
        {'package': 'app', 'score': closeTo(0.5, 0.01)},
      ]);
    });

    group('exact name match', () {
      test('exact match vs description', () async {
        final index = InMemoryPackageIndex(documents: [
          PackageDocument(
            package: 'abc',
            description: 'def xyz',
            maxPoints: 100,
            grantedPoints: 0,
            tags: ['sdk:dart'],
          ),
          PackageDocument(
            package: 'def',
            description: 'abc xyz',
            maxPoints: 100,
            grantedPoints: 100,
            tags: ['sdk:dart'],
          ),
        ]);

        // default order
        expect(
          (index.search(ServiceSearchQuery.parse(query: 'xyz'))).toJson(),
          {
            'timestamp': isNotEmpty,
            'totalCount': 2,
            'sdkLibraryHits': [],
            'packageHits': [
              {'package': 'def', 'score': closeTo(0.69, 0.01)},
              {'package': 'abc', 'score': closeTo(0.42, 0.01)},
            ]
          },
        );
        // exact name match without tags
        expect(
            (index.search(ServiceSearchQuery.parse(query: 'abc'))).toJson(), {
          'timestamp': isNotEmpty,
          'totalCount': 2,
          'sdkLibraryHits': [],
          'packageHits': [
            // `abc` is first, despite its lower score
            {'package': 'abc', 'score': closeTo(0.48, 0.01)},
            {'package': 'def', 'score': closeTo(0.69, 0.01)},
          ]
        });
        // exact name match with tags
        expect(
            (index.search(ServiceSearchQuery.parse(query: 'abc sdk:dart')))
                .toJson(),
            {
              'timestamp': isNotEmpty,
              'totalCount': 2,
              'sdkLibraryHits': [],
              'packageHits': [
                // `abc` is first, despite its lower score
                {'package': 'abc', 'score': closeTo(0.48, 0.01)},
                {'package': 'def', 'score': closeTo(0.69, 0.01)},
              ]
            });
      });
    });
  });

  group('package name weight', () {
    test('modular', () async {
      final index = InMemoryPackageIndex(documents: [
        PackageDocument(
          package: 'serveme',
          description:
              'Backend server framework designed for a quick development of modular WebSocket based server applications with MongoDB integration.',
        ),
        PackageDocument(
          package: 'flutter_modular',
          description:
              'Smart project structure with dependency injection and route management',
        ),
      ]);
      final rs = index.search(
          ServiceSearchQuery.parse(query: 'modular', order: SearchOrder.text));
      expect(
        rs.toJson(),
        {
          'timestamp': isNotEmpty,
          'totalCount': 2,
          'sdkLibraryHits': [],
          'packageHits': [
            {'package': 'flutter_modular', 'score': 1.0},
            {'package': 'serveme', 'score': closeTo(0.87, 0.01)},
          ]
        },
      );
    });
  });
}
