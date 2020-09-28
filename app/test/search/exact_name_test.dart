// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:test/test.dart';

import 'package:pub_dev/search/mem_index.dart';
import 'package:pub_dev/search/search_service.dart';
import 'package:pub_dev/search/text_utils.dart';

void main() {
  group('exact name match', () {
    InMemoryPackageIndex index;

    setUpAll(() async {
      index = InMemoryPackageIndex();
      await index.addPackage(PackageDocument(
        package: 'build_config',
        version: '0.0.1',
        description: compactDescription(
            'Support for parsing `build.yaml` configuration.'),
        readme: compactReadme('blah'),
        popularity: 0.1,
        grantedPoints: 10,
        maxPoints: 110,
      ));
      await index.addPackage(PackageDocument(
        package: 'build',
        version: '0.0.1',
        description: compactDescription('A build system for Dart.'),
        readme: compactReadme('build and configure'),
        popularity: 1.0,
        grantedPoints: 110,
        maxPoints: 110,
      ));
      await index.markReady();
    });

    test('build_config', () async {
      final PackageSearchResult result = await index.search(
          SearchQuery.parse(query: 'build_config', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'timestamp': isNotNull,
        'totalCount': 1,
        'packages': [
          {
            'package': 'build_config',
            'score': 1.0,
          },
          // would be nice if `package:build` would show up here
        ],
      });
    });
  });
}
