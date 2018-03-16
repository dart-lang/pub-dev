// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:test/test.dart';

import 'package:pub_dartlang_org/search/index_simple.dart';
import 'package:pub_dartlang_org/search/text_utils.dart';
import 'package:pub_dartlang_org/shared/search_service.dart';

void main() {
  group('angular', () {
    SimplePackageIndex index;

    setUpAll(() async {
      index = new SimplePackageIndex();
      await index.addPackage(new PackageDocument(
        package: 'angular',
        version: '4.0.0',
        description: compactDescription('Fast and productive web framework.'),
      ));
      await index.addPackage(new PackageDocument(
        package: 'angular_ui',
        version: '0.6.5',
        description: compactDescription('Port of Angular-UI to Dart.'),
      ));
      await index.merge();
    });

    test('angular', () async {
      final PackageSearchResult result = await index.search(
          new SearchQuery.parse(query: 'angular', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 2,
        'packages': [
          {
            'package': 'angular',
            'score': closeTo(0.971, 0.001),
          },
          {
            'package': 'angular_ui',
            'score': closeTo(0.970, 0.001),
          },
        ],
      });
    });
  });
}
