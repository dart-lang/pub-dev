// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:test/test.dart';

import 'package:pub_dartlang_org/search/index_simple.dart';
import 'package:pub_dartlang_org/search/text_utils.dart';
import 'package:pub_dartlang_org/shared/search_service.dart';

void main() {
  group('api', () {
    SimplePackageIndex index;

    setUpAll(() async {
      index = new SimplePackageIndex();
      await index.addPackage(new PackageDocument(
        package: 'foo',
        version: '1.0.0',
        description: compactDescription('Yet another web framework.'),
        publicApiSymbols: [
          'generateWebPage',
          'WebPageGenerator',
        ],
      ));
      await index.addPackage(new PackageDocument(
        package: 'other_with_api',
        version: '2.0.0',
        description: compactDescription('Unrelated package'),
        publicApiSymbols: [
          'foo',
          'serveWebPages',
        ],
      ));
      await index.addPackage(new PackageDocument(
        package: 'other_without_api',
        version: '2.0.0',
        description: compactDescription('Unrelated package'),
      ));
      await index.merge();
    });

    test('foo', () async {
      final PackageSearchResult result = await index
          .search(new SearchQuery.parse(query: 'foo', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 2,
        'packages': [
          {
            'package': 'foo',
            'score': closeTo(0.986, 0.001), // finds package name
          },
          {
            'package': 'other_with_api',
            'score': closeTo(0.772, 0.001), // finds foo method
          },
          // should not contain `other_without_api`
        ],
      });
    });

    test('server', () async {
      final PackageSearchResult result = await index.search(
          new SearchQuery.parse(query: 'server', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {
            'package': 'other_with_api',
            'score': closeTo(0.772, 0.001), // find serveWebPages
          },
          // should not contain `other_without_api`
        ],
      });
    });

    test('page generator', () async {
      final PackageSearchResult result = await index.search(
          new SearchQuery.parse(
              query: 'page generator', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {
            'package': 'foo',
            'score': closeTo(0.614, 0.001), // find WebPageGenerator
          },
          // should not contain `other_without_api`
        ],
      });
    });

    test('web page', () async {
      final PackageSearchResult result = await index.search(
          new SearchQuery.parse(query: 'web page', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 2,
        'packages': [
          {
            'package': 'foo',
            'score': closeTo(0.731, 0.001), // find WebPageGenerator
          },
          {
            'package': 'other_with_api',
            'score': closeTo(0.617, 0.001), // find serveWebPages
          },
          // should not contain `other_without_api`
        ],
      });
    });
  });
}
