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
  group('flutter_iap', () {
    late InMemoryPackageIndex index;

    setUpAll(() async {
      index = InMemoryPackageIndex(documents: [
        PackageDocument(
          package: 'flutter_iap',
          version: '1.0.0',
          description: compactDescription('in app purchases for flutter'),
        ),
        PackageDocument(
          package: 'flutter_blue',
          version: '0.2.3',
          description: compactDescription('Bluetooth plugin for Flutter.'),
        ),
        PackageDocument(
          package: 'flutter_redux',
          version: '0.3.4',
          description: compactDescription(
              'A library that connects Widgets to a Redux Store.'),
        ),
        PackageDocument(
          package: 'flutter_web_view',
          version: '0.0.2',
          description: compactDescription(
              'A native WebView plugin for Flutter with Nav Bar support. Works with iOS and Android'),
        ),
        PackageDocument(
          package: 'flutter_3d_obj',
          version: '0.0.3',
          description: compactDescription(
              'A new flutter package to render wavefront obj files into a canvas.'),
        ),
      ]);
    });

    test('flutter iap', () async {
      final PackageSearchResult result = index.search(ServiceSearchQuery.parse(
          query: 'flutter iap', order: SearchOrder.text));
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

    test('flutter_iap', () async {
      final PackageSearchResult result = index.search(ServiceSearchQuery.parse(
          query: 'flutter_iap', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'nameMatches': ['flutter_iap'],
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'flutter_iap', 'score': 1.0},
        ],
      });
    });
  });
}
