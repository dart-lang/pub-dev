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

    test('defaultsTo', () {
      expect(() => parseSearchOrder('foobar'), throwsException);
      expect(parseSearchOrder('foobar', defaultsTo: SearchOrder.popularity),
          SearchOrder.popularity);
    });
  });

  group('SearchQuery.isValid', () {
    test('empty', () {
      expect(new SearchQuery.parse().isValid, isFalse);
      expect(new SearchQuery.parse().isValid, isFalse);
    });

    test('contains text', () {
      expect(new SearchQuery.parse(text: 'text').isValid, isTrue);
    });

    test('has package prefix', () {
      expect(new SearchQuery.parse(text: 'package:angular_').isValid, isTrue);
    });

    test('has text-based ordering', () {
      expect(new SearchQuery.parse(order: SearchOrder.top).isValid, isTrue);
      expect(new SearchQuery.parse(order: SearchOrder.text).isValid, isFalse);

      expect(
          new SearchQuery.parse(text: 'text', order: SearchOrder.top).isValid,
          isTrue);
      expect(
          new SearchQuery.parse(text: 'text', order: SearchOrder.text).isValid,
          isTrue);

      expect(
          new SearchQuery.parse(
                  text: 'package:angular_', order: SearchOrder.top)
              .isValid,
          isTrue);
      expect(
          new SearchQuery.parse(
                  text: 'package:angular_', order: SearchOrder.text)
              .isValid,
          isFalse);
    });

    test('has non-text-based ordering', () {
      expect(new SearchQuery.parse(order: SearchOrder.created).isValid, isTrue);
      expect(new SearchQuery.parse(order: SearchOrder.updated).isValid, isTrue);
      expect(
          new SearchQuery.parse(order: SearchOrder.popularity).isValid, isTrue);
      expect(new SearchQuery.parse(order: SearchOrder.health).isValid, isTrue);
      expect(new SearchQuery.parse(order: SearchOrder.maintenance).isValid,
          isTrue);
    });
  });

  group('Search URLs', () {
    test('empty', () {
      final query = new SearchQuery.parse();
      expect(query.packagePrefix, isNull);
      expect(query.toSearchLink(v2: true), '/packages');
    });

    test('platform: flutter', () {
      final query = new SearchQuery.parse(platform: 'flutter');
      expect(query.text, isNull);
      expect(query.packagePrefix, isNull);
      expect(query.toSearchLink(v2: true), '/flutter/packages');
    });

    test('package prefix: angular', () {
      final query = new SearchQuery.parse(text: 'package:angular');
      expect(query.text, isNull);
      expect(query.packagePrefix, 'angular');
      expect(query.toSearchLink(v2: true), '/packages?q=package%3Aangular');
    });

    test('complex search', () {
      final query = new SearchQuery.parse(
          text: 'package:angular widget', order: SearchOrder.top);
      expect(query.text, 'widget');
      expect(query.packagePrefix, 'angular');
      expect(query.toSearchLink(v2: true),
          '/packages?q=widget+package%3Aangular&sort=top');
    });
  });
}
