// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:test/test.dart';

import 'package:pub_dartlang_org/search/index_simple.dart';
import 'package:pub_dartlang_org/shared/platform.dart';
import 'package:pub_dartlang_org/shared/search_service.dart';

void main() {
  group('query rewrite', () {
    SimplePackageIndex index;

    setUpAll(() async {
      index = new SimplePackageIndex();
      await index.addPackage(new PackageDocument(
        package: 'something',
        platforms: ['flutter', 'web'],
      ));
      await index.addPackage(new PackageDocument(
        package: 'something_dart',
        platforms: ['flutter', 'web'],
      ));
      await index.addPackage(new PackageDocument(
        package: 'something_other',
        platforms: ['web'],
      ));
      await index.addPackage(new PackageDocument(
        package: 'other_dart',
        platforms: ['server'],
      ));
      await index.merge();
    });

    test('without common phrase', () async {
      final PackageSearchResult withoutPlatform =
          await index.search(new SearchQuery.parse(text: 'something'));
      expect(JSON.decode(JSON.encode(withoutPlatform)), {
        'indexUpdated': isNotNull,
        'totalCount': 3,
        'packages': [
          {
            'package': 'something',
            'score': closeTo(0.059, 0.001),
          },
          {
            'package': 'something_dart',
            'score': closeTo(0.053, 0.001),
          },
          {
            'package': 'something_other',
            'score': closeTo(0.051, 0.001),
          },
        ],
      });
    });

    test('with common phrase', () async {
      final PackageSearchResult withoutPlatform =
          await index.search(new SearchQuery.parse(text: 'dartsomething'));
      expect(JSON.decode(JSON.encode(withoutPlatform)), {
        'indexUpdated': isNotNull,
        'totalCount': 4,
        'packages': [
          {
            'package': 'something_dart',
            'score': closeTo(0.053, 0.001),
          },
          {
            'package': 'something',
            'score': closeTo(0.047, 0.001),
          },
          {
            'package': 'something_other',
            'score': closeTo(0.041, 0.001),
          },
          {
            'package': 'other_dart',
            'score': closeTo(0.023, 0.001),
          },
        ],
      });
    });

    test('control without common phrase', () async {
      final PackageSearchResult withoutPlatform =
          await index.search(new SearchQuery.parse(text: 'xxxxsomething'));
      expect(JSON.decode(JSON.encode(withoutPlatform)), {
        'indexUpdated': isNotNull,
        'totalCount': 3,
        'packages': [
          {
            'package': 'something',
            'score': closeTo(0.059, 0.001),
          },
          {
            'package': 'something_dart',
            'score': closeTo(0.053, 0.001),
          },
          {
            'package': 'something_other',
            'score': closeTo(0.051, 0.001),
          },
        ],
      });
    });

    test('of common phrase', () async {
      final PackageSearchResult withoutPlatform =
          await index.search(new SearchQuery.parse(text: 'dart'));
      expect(JSON.decode(JSON.encode(withoutPlatform)), {
        'indexUpdated': isNotNull,
        'totalCount': 2,
        'packages': [
          {
            'package': 'other_dart',
            'score': closeTo(0.075, 0.001),
          },
          {
            'package': 'something_dart',
            'score': closeTo(0.053, 0.001),
          },
        ],
      });
    });
  });
}
