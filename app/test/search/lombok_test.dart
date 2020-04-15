// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:test/test.dart';

import 'package:pub_dev/search/index_simple.dart';
import 'package:pub_dev/search/search_service.dart';

void main() {
  group('lombok', () {
    SimplePackageIndex index;

    setUpAll(() async {
      index = SimplePackageIndex();
      await index.addPackage(PackageDocument(
        package: 'lombok',
        version: '1.0.0',
      ));
      await index.markReady();
    });

    test('lombock', () async {
      final PackageSearchResult result = await index
          .search(SearchQuery.parse(query: 'lombock', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {
            'package': 'lombok',
            'score': closeTo(0.99, 0.01),
          },
        ],
      });
    });
  });
}
