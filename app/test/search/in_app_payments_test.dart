// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:test/test.dart';

import 'package:pub_dartlang_org/search/index_simple.dart';
import 'package:pub_dartlang_org/search/text_utils.dart';
import 'package:pub_dartlang_org/shared/search_service.dart';

void main() {
  group('in app payments', () {
    SimplePackageIndex index;

    setUpAll(() async {
      index = SimplePackageIndex();
      await index.addPackage(PackageDocument(
          package: 'flutter_iap',
          version: '1.0.1',
          description: compactDescription('in app purchases for flutter'),
          readme: compactReadme('''# flutter_iap

Add _In-App Payments_ to your Flutter app with this plugin.''')));
      await index.merge();
    });

    test('IAP', () async {
      final PackageSearchResult result = await index
          .search(SearchQuery.parse(query: 'IAP', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {
            'package': 'flutter_iap',
            'score': closeTo(0.989, 0.001),
          },
        ],
      });
    });

    test('in app payments', () async {
      final PackageSearchResult result = await index.search(
          SearchQuery.parse(query: 'in app payments', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {
            'package': 'flutter_iap',
            'score': closeTo(0.796, 0.001),
          },
        ],
      });
    });
  });
}
