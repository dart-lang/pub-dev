// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:test/test.dart';

import 'package:pub_dartlang_org/search/index_simple.dart';
import 'package:pub_dartlang_org/search/text_utils.dart';
import 'package:pub_dartlang_org/shared/search_service.dart';

void main() {
  group('exact name match', () {
    SimplePackageIndex index;

    setUpAll(() async {
      index = new SimplePackageIndex();
      await index.addPackage(new PackageDocument(
        package: 'build_config',
        version: '0.0.1',
        description: compactDescription(
            'Support for parsing `build.yaml` configuration.'),
        readme: compactReadme('blah'),
        popularity: 0.1,
      ));
      await index.addPackage(new PackageDocument(
        package: 'build',
        version: '0.0.1',
        description: compactDescription('A build system for Dart.'),
        readme: compactReadme('build and configure'),
        popularity: 1.0,
      ));
      await index.merge();
    });

    test('build_config', () async {
      final PackageSearchResult result =
          await index.search(new SearchQuery.parse(query: 'build_config'));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 2,
        'packages': [
          {
            'package': 'build_config',
            'score': closeTo(0.579, 0.001),
          },
          {
            'package': 'build',
            'score': closeTo(0.573, 0.001),
          },
        ],
      });
    });
  });
}
