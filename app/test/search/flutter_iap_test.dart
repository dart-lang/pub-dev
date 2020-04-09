// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:test/test.dart';

import 'package:pub_dev/search/index_simple.dart';
import 'package:pub_dev/search/search_service.dart';
import 'package:pub_dev/search/text_utils.dart';

void main() {
  group('flutter_iap', () {
    SimplePackageIndex index;

    setUpAll(() async {
      index = SimplePackageIndex();
      await index.addPackage(PackageDocument(
        package: 'flutter_iap',
        version: '1.0.0',
        description: compactDescription('in app purchases for flutter'),
      ));
      await index.addPackage(PackageDocument(
        package: 'flutter_blue',
        version: '0.2.3',
        description: compactDescription('Bluetooth plugin for Flutter.'),
      ));
      await index.addPackage(PackageDocument(
        package: 'flutter_redux',
        version: '0.3.4',
        description: compactDescription(
            'A library that connects Widgets to a Redux Store.'),
      ));
      await index.addPackage(PackageDocument(
        package: 'flutter_web_view',
        version: '0.0.2',
        description: compactDescription(
            'A native WebView plugin for Flutter with Nav Bar support. Works with iOS and Android'),
      ));
      await index.addPackage(PackageDocument(
        package: 'flutter_3d_obj',
        version: '0.0.3',
        description: compactDescription(
            'A new flutter package to render wavefront obj files into a canvas.'),
      ));

      await index.markReady();
    });

    test('flutter iap', () async {
      final PackageSearchResult result = await index.search(
          SearchQuery.parse(query: 'flutter iap', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {
            'package': 'flutter_iap',
            'score': 1.0,
          },
        ],
      });
    });

    test('flutter_iap', () async {
      final PackageSearchResult result = await index.search(
          SearchQuery.parse(query: 'flutter_iap', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {
            'package': 'flutter_iap',
            'score': 1.0,
          },
        ],
      });
    });
  });
}
