// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:test/test.dart';

import 'package:pub_dartlang_org/search/index_simple.dart';
import 'package:pub_dartlang_org/search/search_service.dart';
import 'package:pub_dartlang_org/search/text_utils.dart';

void main() {
  group('api doc page', () {
    SimplePackageIndex index;

    setUpAll(() async {
      index = SimplePackageIndex();
      await index.addPackage(PackageDocument(
        package: 'foo',
        version: '1.0.0',
        description: compactDescription('Yet another web framework.'),
        apiDocPages: [
          ApiDocPage(
            relativePath: 'generator.html',
            symbols: [
              'generateWebPage',
              'WebPageGenerator',
            ],
            textBlocks: [
              'Some fancy goal is described here.',
            ],
          ),
        ],
      ));
      await index.addPackage(PackageDocument(
        package: 'other_with_api',
        version: '2.0.0',
        description: compactDescription('Unrelated package'),
        apiDocPages: [
          ApiDocPage(relativePath: 'main.html', symbols: ['foo']),
          ApiDocPage(relativePath: 'serve.html', symbols: ['serveWebPages']),
        ],
      ));
      await index.addPackage(PackageDocument(
        package: 'other_without_api',
        version: '2.0.0',
        description: compactDescription('Unrelated package'),
      ));
      await index.merge();
    });

    test('foo', () async {
      final PackageSearchResult result = await index
          .search(SearchQuery.parse(query: 'foo', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 2,
        'packages': [
          {
            'package': 'foo',
            'score': closeTo(0.993, 0.001), // finds package name
          },
          {
            'package': 'other_with_api',
            'score': closeTo(0.943, 0.001), // finds foo method
            'apiPages': [
              {'title': null, 'path': 'main.html'},
            ],
          },
          // should not contain `other_without_api`
        ],
      });
    });

    test('server', () async {
      final PackageSearchResult result = await index
          .search(SearchQuery.parse(query: 'server', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {
            'package': 'other_with_api',
            'score': closeTo(0.360, 0.001), // find serveWebPages
            'apiPages': [
              {'title': null, 'path': 'serve.html'},
            ],
          },
          // should not contain `other_without_api`
        ],
      });
    });

    test('page generator', () async {
      final PackageSearchResult result = await index.search(
          SearchQuery.parse(query: 'page generator', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {
            'package': 'foo',
            'score': closeTo(0.133, 0.001), // find WebPageGenerator
            'apiPages': [
              {'title': null, 'path': 'generator.html'},
            ],
          },
          // should not contain `other_without_api`
        ],
      });
    });

    test('web page', () async {
      final PackageSearchResult result = await index.search(
          SearchQuery.parse(query: 'web page', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {
            'package': 'foo',
            'score': closeTo(0.236, 0.001), // find WebPageGenerator
            'apiPages': [
              {'title': null, 'path': 'generator.html'},
            ],
          },
          // serveWebPages get low score
          // should not contain `other_without_api`
        ],
      });
    });

    test('text block', () async {
      final PackageSearchResult result = await index.search(
          SearchQuery.parse(query: 'goal fancy', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {
            'package': 'foo',
            'score': closeTo(0.795, 0.001),
            'apiPages': [
              {'title': null, 'path': 'generator.html'},
            ],
          },
        ],
      });
    });
  });
}
