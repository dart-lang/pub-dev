// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:_pub_shared/search/search_form.dart';
import 'package:pub_dev/search/mem_index.dart';
import 'package:pub_dev/search/search_service.dart';
import 'package:pub_dev/search/text_utils.dart';
import 'package:test/test.dart';

void main() {
  group('in app payments', () {
    late InMemoryPackageIndex index;

    setUpAll(() async {
      index = InMemoryPackageIndex(documents: [
        PackageDocument(
            package: 'flutter_iap',
            version: '1.0.1',
            description: compactDescription('in app purchases for flutter'),
            readme: compactReadme('''# flutter_iap

Add _In-App Payments_ to your Flutter app with this plugin.''')),
      ]);
    });

    test('IAP', () async {
      final PackageSearchResult result = index.search(
          ServiceSearchQuery.parse(query: 'IAP', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {
            'package': 'flutter_iap',
            'score': 1.0,
          },
        ],
      });
    });

    test('in app payments', () async {
      final PackageSearchResult result = index.search(ServiceSearchQuery.parse(
          query: 'in app payments', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {
            'package': 'flutter_iap',
            'score': closeTo(0.70, 0.01),
          },
        ],
      });
    });
  });
}
