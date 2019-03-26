// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dartlang_org/shared/search_service.dart';

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
      expect(
          SearchQuery.parse(query: ' text ').parsedQuery.isApiEnabled, isFalse);
    });

    test('experimental API search', () {
      expect(
          SearchQuery.parse(query: '!!api').parsedQuery.isApiEnabled, isTrue);
      expect(SearchQuery.parse(query: 'text !!api').parsedQuery.isApiEnabled,
          isTrue);
      expect(SearchQuery.parse(query: '!!api text').parsedQuery.isApiEnabled,
          isTrue);
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

    test('only email', () {
      final query = SearchQuery.parse(query: 'email:user@domain.com');
      expect(query.parsedQuery.text, isNull);
      expect(query.parsedQuery.emails, ['user@domain.com']);
    });

    test('email + text + dependency', () {
      final query = SearchQuery.parse(
          query: 'email:user@domain.com text dependency:pkg1');
      expect(query.parsedQuery.text, 'text');
      expect(query.parsedQuery.refDependencies, ['pkg1']);
      expect(query.parsedQuery.allDependencies, []);
      expect(query.parsedQuery.emails, ['user@domain.com']);
    });
  });

  group('SearchQuery.isValid', () {
    test('empty', () {
      expect(SearchQuery.parse().isValid, isFalse);
      expect(SearchQuery.parse().isValid, isFalse);
    });

    test('contains text', () {
      expect(SearchQuery.parse(query: 'text').isValid, isTrue);
    });

    test('has package prefix', () {
      expect(SearchQuery.parse(query: 'package:angular_').isValid, isTrue);
    });

    test('has text-based ordering', () {
      expect(SearchQuery.parse(order: SearchOrder.top).isValid, isTrue);
      expect(SearchQuery.parse(order: SearchOrder.text).isValid, isFalse);

      expect(SearchQuery.parse(query: 'text', order: SearchOrder.top).isValid,
          isTrue);
      expect(SearchQuery.parse(query: 'text', order: SearchOrder.text).isValid,
          isTrue);

      expect(
          SearchQuery.parse(query: 'package:angular_', order: SearchOrder.top)
              .isValid,
          isTrue);
      expect(
          SearchQuery.parse(query: 'package:angular_', order: SearchOrder.text)
              .isValid,
          isFalse);
    });

    test('has non-text-based ordering', () {
      expect(SearchQuery.parse(order: SearchOrder.created).isValid, isTrue);
      expect(SearchQuery.parse(order: SearchOrder.updated).isValid, isTrue);
      expect(SearchQuery.parse(order: SearchOrder.popularity).isValid, isTrue);
      expect(SearchQuery.parse(order: SearchOrder.health).isValid, isTrue);
      expect(SearchQuery.parse(order: SearchOrder.maintenance).isValid, isTrue);
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
      final query = SearchQuery.parse(platform: 'flutter');
      expect(query.parsedQuery.text, isNull);
      expect(query.parsedQuery.packagePrefix, isNull);
      expect(query.toSearchLink(), '/flutter/packages');
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
}
