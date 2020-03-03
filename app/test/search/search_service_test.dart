// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dev/search/search_service.dart';

void main() {
  group('SearchOrder enum', () {
    test('serialization', () {
      for (var value in SearchOrder.values) {
        final String serialized = serializeSearchOrder(value);
        expect(serialized, isNotEmpty);
        final SearchOrder deserialized = parseSearchOrder(serialized);
        expect(deserialized, value);
      }
    });

    test('unknown', () {
      expect(parseSearchOrder('foobar'), isNull);
    });
  });

  group('ParsedQuery', () {
    test('trim', () {
      expect(SearchQuery.parse(query: 'text').parsedQuery.text, 'text');
      expect(SearchQuery.parse(query: ' text ').query, 'text');
      expect(SearchQuery.parse(query: ' text ').parsedQuery.text, 'text');
    });

    test('no dependency', () {
      final query = SearchQuery.parse(query: 'text');
      expect(query.parsedQuery.text, 'text');
      expect(query.parsedQuery.refDependencies, []);
      expect(query.parsedQuery.allDependencies, []);
      expect(query.parsedQuery.hasAnyDependency, isFalse);
    });

    test('only one dependency', () {
      final query = SearchQuery.parse(query: 'dependency:pkg');
      expect(query.parsedQuery.text, isNull);
      expect(query.parsedQuery.refDependencies, ['pkg']);
      expect(query.parsedQuery.allDependencies, []);
      expect(query.parsedQuery.hasAnyDependency, isTrue);
    });

    test('only one dependency*', () {
      final query = SearchQuery.parse(query: 'dependency*:pkg');
      expect(query.parsedQuery.text, isNull);
      expect(query.parsedQuery.refDependencies, []);
      expect(query.parsedQuery.allDependencies, ['pkg']);
      expect(query.parsedQuery.hasAnyDependency, isTrue);
    });

    test('two dependencies with text blocks', () {
      final query = SearchQuery.parse(
          query: 'text1 dependency:pkg1 text2 dependency:pkg2');
      expect(query.parsedQuery.text, 'text1 text2');
      expect(query.parsedQuery.refDependencies, ['pkg1', 'pkg2']);
      expect(query.parsedQuery.allDependencies, []);
      expect(query.parsedQuery.hasAnyDependency, isTrue);
    });

    test('two mixed dependencies with text blocks', () {
      final query = SearchQuery.parse(
          query: 'text1 dependency:pkg1 text2 dependency*:pkg2');
      expect(query.parsedQuery.text, 'text1 text2');
      expect(query.parsedQuery.refDependencies, ['pkg1']);
      expect(query.parsedQuery.allDependencies, ['pkg2']);
      expect(query.parsedQuery.hasAnyDependency, isTrue);
    });

    test('only publisher', () {
      final query = SearchQuery.parse(query: 'publisher:example.com');
      expect(query.parsedQuery.text, isNull);
      expect(query.parsedQuery.publisher, 'example.com');
    });

    test('only email', () {
      final query = SearchQuery.parse(query: 'email:user@domain.com');
      expect(query.parsedQuery.text, isNull);
      expect(query.parsedQuery.emails, ['user@domain.com']);
    });

    test('known tag', () {
      final query = SearchQuery.parse(query: 'is:legacy');
      expect(query.parsedQuery.text, isNull);
      expect(
          query.parsedQuery.tagsPredicate.toQueryParameters(), ['is:legacy']);
    });

    test('forbidden known tag', () {
      final query = SearchQuery.parse(query: '-is:legacy');
      expect(query.parsedQuery.text, isNull);
      expect(
          query.parsedQuery.tagsPredicate.toQueryParameters(), ['-is:legacy']);
    });

    test('known tag + package prefix + search text', () {
      final query = SearchQuery.parse(query: 'json is:legacy package:foo_');
      expect(query.parsedQuery.text, 'json');
      expect(
          query.parsedQuery.tagsPredicate.toQueryParameters(), ['is:legacy']);
      expect(query.parsedQuery.packagePrefix, 'foo_');
    });

    test('publisher + email + text + dependency', () {
      final query = SearchQuery.parse(
          query:
              'publisher:example.com email:user@domain.com text dependency:pkg1');
      expect(query.parsedQuery.text, 'text');
      expect(query.parsedQuery.refDependencies, ['pkg1']);
      expect(query.parsedQuery.allDependencies, []);
      expect(query.parsedQuery.publisher, 'example.com');
      expect(query.parsedQuery.emails, ['user@domain.com']);
    });
  });

  group('Search URLs', () {
    test('empty', () {
      final query = SearchQuery.parse();
      expect(query.parsedQuery.text, isNull);
      expect(query.parsedQuery.packagePrefix, isNull);
      expect(query.toSearchLink(), '/packages');
    });

    test('platform: flutter', () {
      final query = SearchQuery.parse(sdk: 'flutter');
      expect(query.parsedQuery.text, isNull);
      expect(query.parsedQuery.packagePrefix, isNull);
      expect(query.toSearchLink(), '/flutter/packages');
    });

    test('Flutter favorites', () {
      final query = SearchQuery.parse(
          tagsPredicate: TagsPredicate(requiredTags: ['is:flutter-favorite']));
      expect(query.toSearchLink(page: 2), '/flutter/favorites?page=2');
    });

    test('publisher: example.com', () {
      final query = SearchQuery.parse(publisherId: 'example.com');
      expect(query.toSearchLink(), '/publishers/example.com/packages');
      expect(query.toSearchLink(page: 2),
          '/publishers/example.com/packages?page=2');
    });

    test('publisher: example.com with query', () {
      final query =
          SearchQuery.parse(publisherId: 'example.com', query: 'json');
      expect(query.toSearchLink(), '/publishers/example.com/packages?q=json');
      expect(query.toSearchLink(page: 2),
          '/publishers/example.com/packages?q=json&page=2');
    });

    test('package prefix: angular', () {
      final query = SearchQuery.parse(query: 'package:angular');
      expect(query.parsedQuery.text, isNull);
      expect(query.parsedQuery.packagePrefix, 'angular');
      expect(query.toSearchLink(), '/packages?q=package%3Aangular');
    });

    test('complex search', () {
      final query = SearchQuery.parse(
          query: 'package:angular widget', order: SearchOrder.top);
      expect(query.parsedQuery.text, 'widget');
      expect(query.parsedQuery.packagePrefix, 'angular');
      expect(query.toSearchLink(),
          '/packages?q=package%3Aangular+widget&sort=top');
    });
  });

  group('new sdk queries', () {
    test('sdk:flutter & platform:android', () {
      final query = parseFrontendSearchQuery(
        {'platform': 'android'},
        sdk: 'flutter',
        tagsPredicate: TagsPredicate.regularSearch(),
      );
      expect(
        query.tagsPredicate.toQueryParameters(),
        ['-is:discontinued', 'sdk:flutter', 'platform:android'],
      );
      expect(query.toSearchLink(), '/flutter/packages?platform=android');
    });

    test('sdk:flutter & platform:android & platform:ios', () {
      final query = parseFrontendSearchQuery(
        Uri.parse('/flutter/packages?platform=android++ios').queryParameters,
        sdk: 'flutter',
        tagsPredicate: TagsPredicate.regularSearch(),
      );
      expect(
        query.tagsPredicate.toQueryParameters(),
        ['-is:discontinued', 'sdk:flutter', 'platform:android', 'platform:ios'],
      );
      expect(query.toSearchLink(), '/flutter/packages?platform=android+ios');
    });

    test('sdk:dart & runtime:web', () {
      final query = parseFrontendSearchQuery(
        Uri.parse('/dart/packages?runtime=web').queryParameters,
        sdk: 'dart',
        tagsPredicate: TagsPredicate.regularSearch(),
      );
      expect(
        query.tagsPredicate.toQueryParameters(),
        [
          '-is:discontinued',
          'sdk:dart',
          'runtime:web',
        ],
      );
      expect(query.toSearchLink(), '/dart/packages?runtime=web');
    });
  });
}
