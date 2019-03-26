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
      index = SimplePackageIndex();
      await index.addPackage(PackageDocument(
        package: 'build_config',
        version: '0.0.1',
        description: compactDescription(
            'Support for parsing `build.yaml` configuration.'),
        readme: compactReadme('blah'),
        popularity: 0.1,
        maintenance: 0.1,
      ));
      await index.addPackage(PackageDocument(
        package: 'build',
        version: '0.0.1',
        description: compactDescription('A build system for Dart.'),
        readme: compactReadme('build and configure'),
        popularity: 1.0,
        maintenance: 1.0,
      ));
      await index.merge();
    });

    test('build_config', () async {
      final PackageSearchResult result =
          await index.search(SearchQuery.parse(query: 'build_config'));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 2,
        'packages': [
          {
            'package': 'build_config',
            'score': closeTo(0.704, 0.001),
          },
          {
            'package': 'build',
            'score': closeTo(0.697, 0.001),
          },
        ],
      });
    });
  });
}
