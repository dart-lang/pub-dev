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
  group('travis', () {
    late InMemoryPackageIndex index;

    setUpAll(() async {
      final packageNames = [
        'rainbow_vis',
        'mongo_dart_query',
        'angular_aria',
        'dartemis_transformer',
        'w_transport',
        'sass_transformer',
      ];
      index = InMemoryPackageIndex(documents: [
        PackageDocument(
          package: 'travis',
          version: '0.0.1-dev',
          description: compactDescription(
              'A starting point for Dart libraries or applications.'),
        ),
        ...packageNames.map((packageName) => PackageDocument(
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
            )),
      ]);
    });

    test('travis', () async {
      final PackageSearchResult result = index.search(
          ServiceSearchQuery.parse(query: 'travis', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'travis', 'score': 1.0},
        ],
      });
    });
  });
}
