// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:_pub_shared/search/search_form.dart';
import 'package:pub_dev/search/mem_index.dart';
import 'package:pub_dev/search/search_service.dart';
import 'package:pub_dev/search/text_utils.dart';
import 'package:test/test.dart';

void main() {
  group('angular', () {
    late InMemoryPackageIndex index;

    setUpAll(() async {
      index = InMemoryPackageIndex(documents: [
        PackageDocument(
          package: 'angular',
          version: '4.0.0',
          description: compactDescription('Fast and productive web framework.'),
        ),
        PackageDocument(
          package: 'angular_ui',
          version: '0.6.5',
          description: compactDescription('Port of Angular-UI to Dart.'),
        ),
      ]);
    });

    test('angular', () async {
      final PackageSearchResult result = index.search(
          ServiceSearchQuery.parse(query: 'angular', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 2,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'angular', 'score': 1.0},
          {'package': 'angular_ui', 'score': 1.0},
        ],
      });
    });
  });
}
