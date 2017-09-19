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
      expect(new SearchQuery(null).isValid, isFalse);
      expect(new SearchQuery('').isValid, isFalse);
    });

    test('contains text', () {
      expect(new SearchQuery('text').isValid, isTrue);
    });

    test('has package prefix', () {
      expect(new SearchQuery('', packagePrefix: 'angular_').isValid, isTrue);
    });

    test('has text-based ordering', () {
      expect(new SearchQuery('', order: SearchOrder.overall).isValid, isTrue);
      expect(new SearchQuery('', order: SearchOrder.text).isValid, isFalse);

      expect(
          new SearchQuery('text', order: SearchOrder.overall).isValid, isTrue);
      expect(new SearchQuery('text', order: SearchOrder.text).isValid, isTrue);

      expect(
          new SearchQuery(
            '',
            packagePrefix: 'angular_',
            order: SearchOrder.overall,
          )
              .isValid,
          isTrue);
      expect(
          new SearchQuery(
            '',
            packagePrefix: 'angular_',
            order: SearchOrder.text,
          )
              .isValid,
          isFalse);
    });

    test('has non-text-based ordering', () {
      expect(new SearchQuery('', order: SearchOrder.updated).isValid, isTrue);
      expect(
          new SearchQuery('', order: SearchOrder.popularity).isValid, isTrue);
      expect(new SearchQuery('', order: SearchOrder.health).isValid, isTrue);
    });
  });
}
