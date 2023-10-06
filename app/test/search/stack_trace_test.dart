// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:_pub_shared/search/search_form.dart';
import 'package:pub_dev/search/mem_index.dart';
import 'package:pub_dev/search/search_service.dart';
import 'package:pub_dev/search/text_utils.dart';
import 'package:test/test.dart';

void main() {
  group('stack_trace', () {
    late InMemoryPackageIndex index;

    setUpAll(() async {
      index = InMemoryPackageIndex(documents: [
        PackageDocument(
          package: 'stack_trace',
          version: '1.9.3',
          description: compactDescription(
              'A package for manipulating stack traces and printing them readably.'),
        ),
      ]);
    });

    // should find full word
    test('stacktrace', () async {
      final PackageSearchResult result = index.search(ServiceSearchQuery.parse(
          query: 'stacktrace', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {
            'package': 'stack_trace',
            'score': 1.0,
          },
        ],
      });
    });
  });
}
