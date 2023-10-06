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
  group('bluetooth', () {
    late InMemoryPackageIndex index;

    setUpAll(() async {
      index = InMemoryPackageIndex(documents: [
        PackageDocument(
          package: 'flutter_blue',
          version: '0.2.3',
          description: compactDescription('Bluetooth plugin for Flutter.'),
        ),
        PackageDocument(
          package: 'smooth_scroll',
          version: '0.0.3',
          description: compactDescription(
              'A Dart library for smooth scroll effect on a web page.'),
        ),
      ]);
    });

    test('bluetooth', () async {
      final PackageSearchResult result = index.search(ServiceSearchQuery.parse(
          query: 'bluetooth', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {
            'package': 'flutter_blue',
            'score': closeTo(0.89, 0.01),
          },
        ],
      });
    });
  });
}
