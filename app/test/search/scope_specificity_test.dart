// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:test/test.dart';

import 'package:pub_dev/search/index_simple.dart';
import 'package:pub_dev/search/scope_specificity.dart';
import 'package:pub_dev/search/search_service.dart';

void main() {
  group('specificity score', () {
    final String any = null;
    final flutter = 'flutter';
    final dart = 'dart';

    test('empty or null values', () {
      expect(scoreScopeSpecificity(any, null), 1.0);
      expect(scoreScopeSpecificity(any, []), 1.0);
      expect(scoreScopeSpecificity(null, []), 1.0);
      expect(scoreScopeSpecificity(flutter, []), 0.8);
      expect(scoreScopeSpecificity(dart, []), 0.9);
    });

    test('single', () {
      expect(scoreScopeSpecificity(null, ['sdk:flutter']), 1.0);
      expect(scoreScopeSpecificity(flutter, ['sdk:flutter']), 1.0);
      expect(scoreScopeSpecificity(dart, ['sdk:dart']), 1.0);
    });

    test('two platforms', () {
      expect(scoreScopeSpecificity(null, ['sdk:dart', 'sdk:flutter']), 1.0);
      expect(scoreScopeSpecificity(dart, ['sdk:dart', 'sdk:flutter']), 0.95);
      expect(scoreScopeSpecificity(flutter, ['sdk:dart', 'sdk:flutter']), 0.9);
    });
  });

  group('platform rank', () {
    SimplePackageIndex index;

    setUpAll(() async {
      index = SimplePackageIndex();
      await index.addPackage(PackageDocument(
        package: 'json_0',
      ));
      await index.addPackage(PackageDocument(
        package: 'json_1',
        tags: ['sdk:flutter'],
      ));
      await index.addPackage(PackageDocument(
        package: 'json_2',
        tags: ['sdk:dart'],
      ));
      await index.addPackage(PackageDocument(
        package: 'json_3',
        tags: ['sdk:dart', 'sdk:flutter'],
      ));
      await index.markReady();
    });

    test('text search without platform', () async {
      final PackageSearchResult withoutPlatform =
          await index.search(SearchQuery.parse(query: 'json'));
      expect(json.decode(json.encode(withoutPlatform)), {
        'indexUpdated': isNotNull,
        'totalCount': 4,
        'packages': [
          {
            'package': 'json_0',
            'score': closeTo(0.29, 0.01),
          },
          {
            'package': 'json_1',
            'score': closeTo(0.29, 0.01),
          },
          {
            'package': 'json_2',
            'score': closeTo(0.29, 0.01),
          },
          {
            'package': 'json_3',
            'score': closeTo(0.29, 0.01),
          },
        ],
      });
    });

    test('text search with platform', () async {
      final PackageSearchResult withPlatform =
          await index.search(SearchQuery.parse(
        query: 'json',
        sdk: 'flutter',
      ));
      expect(json.decode(json.encode(withPlatform)), {
        'indexUpdated': isNotNull,
        'totalCount': 2,
        'packages': [
          {
            'package': 'json_1',
            'score': closeTo(0.2967, 0.0001),
          },
          {
            'package': 'json_3',
            'score': closeTo(0.2671, 0.0001),
          },
        ],
      });
    });
  });
}
