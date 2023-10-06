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
  group('api doc page', () {
    late InMemoryPackageIndex index;

    setUpAll(() async {
      index = InMemoryPackageIndex(documents: [
        PackageDocument(
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
            ),
          ],
        ),
        PackageDocument(
          package: 'other_with_api',
          version: '2.0.0',
          description: compactDescription('Unrelated package'),
          apiDocPages: [
            ApiDocPage(relativePath: 'main.html', symbols: ['foo']),
            ApiDocPage(relativePath: 'serve.html', symbols: ['serveWebPages']),
          ],
        ),
        PackageDocument(
          package: 'other_without_api',
          version: '2.0.0',
          description: compactDescription('Unrelated package'),
        ),
      ]);
    });

    test('foo', () async {
      final PackageSearchResult result = index.search(
          ServiceSearchQuery.parse(query: 'foo', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 2,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'foo', 'score': 1.0}, // finds package name
          {
            'package': 'other_with_api',
            'score': closeTo(0.695, 0.001), // finds foo method
            'apiPages': [
              {'path': 'main.html'},
            ],
          },
          // should not contain `other_without_api`
        ],
      });
    });

    test('serve', () async {
      final PackageSearchResult result = index.search(
          ServiceSearchQuery.parse(query: 'serve', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {
            'package': 'other_with_api',
            'score': closeTo(0.42, 0.01), // find serveWebPages
            'apiPages': [
              {'path': 'serve.html'},
            ],
          },
          // should not contain `other_without_api`
        ],
      });
    });

    test('page generator', () async {
      final PackageSearchResult result = index.search(ServiceSearchQuery.parse(
          query: 'page generator', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {
            'package': 'foo',
            'score': closeTo(0.18, 0.01), // find WebPageGenerator
            'apiPages': [
              {'path': 'generator.html'},
            ],
          },
          // should not contain `other_without_api`
        ],
      });
    });

    test('web page', () async {
      final PackageSearchResult result = index.search(
          ServiceSearchQuery.parse(query: 'web page', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {
            'package': 'foo',
            'score': closeTo(0.11, 0.01), // find WebPageGenerator
            'apiPages': [
              {'path': 'generator.html'},
            ],
          },
          // should contain 'other_with_api' finding `serveWebPages`
          // should not contain `other_without_api`
        ],
      });
    });
  });
}
