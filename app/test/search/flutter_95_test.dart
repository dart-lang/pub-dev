// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.9

import 'dart:convert';

import 'package:test/test.dart';

import 'package:pub_dev/search/mem_index.dart';
import 'package:pub_dev/search/search_service.dart';
import 'package:pub_dev/search/text_utils.dart';

void main() {
  group('flutter_95', () {
    InMemoryPackageIndex index;

    setUpAll(() async {
      index = InMemoryPackageIndex();
      await index.addPackage(PackageDocument(
        package: 'flutter95',
        version: '0.0.7',
        description: compactDescription(
            'Windows95 UI components for Flutter apps. Bring back the nostalgic look and feel of old operating systems with this set of UI components ready to use.'),
      ));
      await index.markReady();
    });

    test('flutter 95', () async {
      final PackageSearchResult result = await index.search(
          ServiceSearchQuery.parse(
              query: 'flutter 95', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {
            'package': 'flutter95',
            'score': 1.0,
          },
        ],
      });
    });
  });
}
