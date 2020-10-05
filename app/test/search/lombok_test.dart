// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:test/test.dart';

import 'package:pub_dev/search/mem_index.dart';
import 'package:pub_dev/search/search_service.dart';

void main() {
  group('lombok', () {
    InMemoryPackageIndex index;

    setUpAll(() async {
      index = InMemoryPackageIndex();
      await index.addPackage(PackageDocument(
        package: 'lombok',
        version: '1.0.0',
      ));
      await index.markReady();
    });

    test('lombock', () async {
      final PackageSearchResult result = await index.search(
          ServiceSearchQuery.parse(query: 'lombock', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'timestamp': isNotNull,
        'totalCount': 1,
        'packages': [
          {
            'package': 'lombok',
            'score': closeTo(0.63, 0.01),
          },
        ],
      });
    });
  });
}
