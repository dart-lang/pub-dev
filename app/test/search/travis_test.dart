// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:test/test.dart';

import 'package:pub_dev/search/index_simple.dart';
import 'package:pub_dev/search/search_service.dart';
import 'package:pub_dev/search/text_utils.dart';

void main() {
  group('travis', () {
    SimplePackageIndex index;

    setUpAll(() async {
      index = SimplePackageIndex();
      final packageNames = [
        'rainbow_vis',
        'mongo_dart_query',
        'angular_aria',
        'dartemis_transformer',
        'w_transport',
        'sass_transformer',
      ];
      await index.addPackage(PackageDocument(
        package: 'travis',
        version: '0.0.1-dev',
        description: compactDescription(
            'A starting point for Dart libraries or applications.'),
      ));
      for (String packageName in packageNames) {
        await index.addPackage(PackageDocument(
          package: packageName,
          version: '1.0.0',
          description:
              compactDescription('$packageName a package for $packageName'),
          readme: compactReadme('''
# $packageName

[![Pub](https://img.shields.io/pub/v/$packageName.svg?maxAge=2592000?style=flat-square)](https://pub.dartlang.org/packages/$packageName)
[![Travis](https://img.shields.io/travis/$packageName/$packageName.svg?maxAge=2592000?style=flat-square)](https://travis-ci.org/$packageName/$packageName)

## Usage

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
'''),
        ));
      }
      await index.markReady();
    });

    test('travis', () async {
      final PackageSearchResult result = await index
          .search(SearchQuery.parse(query: 'travis', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {
            'package': 'travis',
            'score': 1.0,
          },
        ],
      });
    });
  });
}
