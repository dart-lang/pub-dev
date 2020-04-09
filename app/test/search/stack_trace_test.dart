// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:test/test.dart';

import 'package:pub_dev/search/index_simple.dart';
import 'package:pub_dev/search/search_service.dart';
import 'package:pub_dev/search/text_utils.dart';

void main() {
  group('stack_trace', () {
    SimplePackageIndex index;

    setUpAll(() async {
      index = SimplePackageIndex();
      await index.addPackages([
        PackageDocument(
          package: 'stack_trace',
          version: '1.9.3',
          description: compactDescription(
              'A package for manipulating stack traces and printing them readably.'),
        ),
      ]);
      await index.markReady();
    });

    // should find full word
    test('stacktrace', () async {
      final PackageSearchResult result = await index.search(
          SearchQuery.parse(query: 'stacktrace', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {
            'package': 'stack_trace',
            'score': 1.0,
          },
        ]
      });
    });
  });
}
