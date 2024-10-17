// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:_pub_shared/search/search_form.dart';
import 'package:pub_dev/search/mem_index.dart';
import 'package:pub_dev/search/search_service.dart';
import 'package:test/test.dart';

void main() {
  group('maps vs map', () {
    late InMemoryPackageIndex index;

    setUpAll(() async {
      index = InMemoryPackageIndex(documents: [
        PackageDocument(package: 'maps', updated: DateTime(2020, 10, 2)),
        PackageDocument(package: 'map', updated: DateTime(2020, 10, 1)),
      ]);
    });

    test('maps', () async {
      final PackageSearchResult result = index.search(
          ServiceSearchQuery.parse(query: 'maps', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 2,
        'nameMatches': ['maps'],
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'maps', 'score': 1.0},
          {'package': 'map', 'score': 1.0},
        ],
      });
    });

    test('map', () async {
      final PackageSearchResult result = index.search(
          ServiceSearchQuery.parse(query: 'map', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 2,
        'nameMatches': ['map'],
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'maps', 'score': 1.0},
          {'package': 'map', 'score': 1.0},
        ],
      });
    });
  });
}
