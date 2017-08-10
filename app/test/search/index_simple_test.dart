// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:test/test.dart';

import 'package:pub_dartlang_org/search/index_simple.dart';
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
      expect(index.tokenCount, 32);
      index.removeUrl('url2');
      expect(index.tokenCount, 9);
    });
  });

  group('SimplePackageIndex', () {
    SimplePackageIndex index;

    setUpAll(() async {
      index = new SimplePackageIndex();
      await index.add(new PackageDocument(
        url: 'uri://http',
        package: 'http',
        version: '0.11.3+14',
        devVersion: '0.11.3+14',
        description: 'A composable, Future-based API for making HTTP requests.',
        readme: '''http
          A composable, Future-based library for making HTTP requests.
          This package contains a set of high-level functions and classes that make it easy to consume HTTP resources. It's platform-independent, and can be used on both the command-line and the browser. Currently the global utility functions are unsupported on the browser; see "Using on the Browser" below.''',
        lastUpdated: 'Jul 20, 2017',
        popularity: 0.7,
      ));
      await index.add(new PackageDocument(
        url: 'uri://async',
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
        lastUpdated: 'May 17, 2017',
        popularity: 0.8,
      ));
      await index.add(new PackageDocument(
        url: 'uri://chrome_net',
        package: 'chrome_net',
        version: '0.1.0',
        devVersion: '0.1.0',
        description: 'A set of networking library for Chrome Apps.',
        readme: '''TCP client and server libraries for Dart based Chrome Apps.
tcp.dart contains abstractions over chrome.sockets to aid in working with TCP client sockets and server sockets (TcpClient and TcpServer).
server.dart adds a small, prescriptive server (PicoServer) that can be configured with different handlers for HTTP requests.''',
        lastUpdated: 'Sep 17, 2014',
        popularity: 0.0,
      ));
      await index.merge();
    });

    test('package name match: async', () async {
      final PackageSearchResult result =
          await index.search(new PackageQuery('async'));
      expect(JSON.decode(JSON.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 2,
        'packages': [
          {
            'url': 'uri://async',
            'package': 'async',
            'version': '1.13.3',
            'devVersion': '1.13.3',
            'score': closeTo(84.4345, 0.0001),
          },
          {
            'url': 'uri://http',
            'package': 'http',
            'version': '0.11.3+14',
            'devVersion': '0.11.3+14',
            'score': closeTo(3.5116, 0.0001),
          },
        ]
      });
    });

    test('description match: composable', () async {
      final PackageSearchResult result =
          await index.search(new PackageQuery('composable'));
      expect(JSON.decode(JSON.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 2,
        'packages': [
          {
            'url': 'uri://http',
            'package': 'http',
            'version': '0.11.3+14',
            'devVersion': '0.11.3+14',
            'score': closeTo(7.4149, 0.0001),
          },
          {
            'url': 'uri://async',
            'package': 'async',
            'version': '1.13.3',
            'devVersion': '1.13.3',
            'score': closeTo(4.0258, 0.0001),
          },
        ]
      });
    });

    test('readme match: chrome.sockets', () async {
      final PackageSearchResult result =
          await index.search(new PackageQuery('chrome.sockets'));
      expect(JSON.decode(JSON.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 3,
        'packages': [
          {
            'url': 'uri://chrome_net',
            'package': 'chrome_net',
            'version': '0.1.0',
            'devVersion': '0.1.0',
            'score': closeTo(33.5032, 0.0001),
          },
          {
            'url': 'uri://async',
            'package': 'async',
            'version': '1.13.3',
            'devVersion': '1.13.3',
            'score': closeTo(4.0155, 0.0001),
          },
          {
            'url': 'uri://http',
            'package': 'http',
            'version': '0.11.3+14',
            'devVersion': '0.11.3+14',
            'score': closeTo(3.5291, 0.0001),
          },
        ]
      });
    });

    test('package prefix: chrome', () async {
      final PackageSearchResult result =
          await index.search(new PackageQuery('', packagePrefix: 'chrome'));
      expect(JSON.decode(JSON.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {
            'url': 'uri://chrome_net',
            'package': 'chrome_net',
            'version': '0.1.0',
            'devVersion': '0.1.0',
            'score': closeTo(71.2139, 0.0001),
          },
        ]
      });
    });
  });
}
