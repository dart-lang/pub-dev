// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:test/test.dart';

import 'package:pub_dartlang_org/search/index_simple.dart';
import 'package:pub_dartlang_org/shared/platform.dart';
import 'package:pub_dartlang_org/shared/search_service.dart';

void main() {
  group('platform rank', () {
    SimplePackageIndex index;

    setUpAll(() async {
      index = new SimplePackageIndex();
      await index.addPackage(new PackageDocument(
        package: 'json_0',
      ));
      await index.addPackage(new PackageDocument(
        package: 'json_1',
        platforms: ['flutter'],
      ));
      await index.addPackage(new PackageDocument(
        package: 'json_2',
        platforms: ['flutter', 'server'],
      ));
      await index.addPackage(new PackageDocument(
        package: 'json_3',
        platforms: KnownPlatforms.all,
      ));
      await index.merge();
    });

    test('text search without platform', () async {
      final PackageSearchResult withoutPlatform =
          await index.search(new SearchQuery.parse(query: 'json'));
      expect(JSON.decode(JSON.encode(withoutPlatform)), {
        'indexUpdated': isNotNull,
        'totalCount': 4,
        'packages': [
          {
            'package': 'json_0',
            'score': closeTo(0.12, 0.01),
          },
          {
            'package': 'json_1',
            'score': closeTo(0.12, 0.01),
          },
          {
            'package': 'json_2',
            'score': closeTo(0.12, 0.01),
          },
          {
            'package': 'json_3',
            'score': closeTo(0.12, 0.01),
          },
        ],
      });
    });

    test('text search with platform', () async {
      final PackageSearchResult withPlatform =
          await index.search(new SearchQuery.parse(
        query: 'json',
        platform: 'flutter',
      ));
      expect(JSON.decode(JSON.encode(withPlatform)), {
        'indexUpdated': isNotNull,
        'totalCount': 3,
        'packages': [
          {
            'package': 'json_1',
            'score': closeTo(0.1224, 0.0001),
          },
          {
            'package': 'json_2',
            'score': closeTo(0.1212, 0.0001),
          },
          {
            'package': 'json_3',
            'score': closeTo(0.0979, 0.0001),
          },
        ],
      });
    });
  });
}
