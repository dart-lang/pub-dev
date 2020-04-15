// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:test/test.dart';

import 'package:pub_dev/search/index_simple.dart';
import 'package:pub_dev/search/search_service.dart';

void main() {
  group('maps vs map', () {
    SimplePackageIndex index;

    setUpAll(() async {
      index = SimplePackageIndex();
      await index.addPackage(PackageDocument(package: 'maps'));
      await index.addPackage(PackageDocument(package: 'map'));
      await index.markReady();
    });

    test('maps', () async {
      final PackageSearchResult result = await index
          .search(SearchQuery.parse(query: 'maps', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 2,
        'packages': [
          {'package': 'maps', 'score': 1.0},
          {'package': 'map', 'score': closeTo(0.745, 0.001)},
        ],
      });
    });

    test('map', () async {
      final PackageSearchResult result = await index
          .search(SearchQuery.parse(query: 'map', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 2,
        'packages': [
          {'package': 'map', 'score': 1.0},
          {'package': 'maps', 'score': 0.75},
        ],
      });
    });
  });
}
