// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:_pub_shared/search/search_form.dart';
import 'package:pub_dev/search/mem_index.dart';
import 'package:pub_dev/search/search_service.dart';
import 'package:test/test.dart';

void main() {
  group('lombok', () {
    late InMemoryPackageIndex index;

    setUpAll(() async {
      index = InMemoryPackageIndex();
      index.addPackage(PackageDocument(
        package: 'lombok',
        version: '1.0.0',
      ));
      index.markReady();
    });

    test('lombock', () async {
      final PackageSearchResult result = index.search(
          ServiceSearchQuery.parse(query: 'lombock', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {
            'package': 'lombok',
            'score': closeTo(0.60, 0.01),
          },
        ],
      });
    });
  });
}
