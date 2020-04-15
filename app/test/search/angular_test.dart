// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:test/test.dart';

import 'package:pub_dev/search/index_simple.dart';
import 'package:pub_dev/search/search_service.dart';
import 'package:pub_dev/search/text_utils.dart';

void main() {
  group('angular', () {
    SimplePackageIndex index;

    setUpAll(() async {
      index = SimplePackageIndex();
      await index.addPackage(PackageDocument(
        package: 'angular',
        version: '4.0.0',
        description: compactDescription('Fast and productive web framework.'),
      ));
      await index.addPackage(PackageDocument(
        package: 'angular_ui',
        version: '0.6.5',
        description: compactDescription('Port of Angular-UI to Dart.'),
      ));
      await index.markReady();
    });

    test('angular', () async {
      final PackageSearchResult result = await index
          .search(SearchQuery.parse(query: 'angular', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 2,
        'packages': [
          {
            'package': 'angular',
            'score': 1.0,
          },
          {
            'package': 'angular_ui',
            'score': closeTo(0.989, 0.001),
          },
        ],
      });
    });
  });
}
