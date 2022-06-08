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
  group('exact name match', () {
    late InMemoryPackageIndex index;

    setUpAll(() async {
      index = InMemoryPackageIndex(
        popularityValueFn: (p) =>
            const <String, double>{
              'build_config': 0.1,
              'build': 1.0,
            }[p] ??
            0.0,
      );
      await index.addPackage(PackageDocument(
        package: 'build_config',
        version: '0.0.1',
        description: compactDescription(
            'Support for parsing `build.yaml` configuration.'),
        readme: compactReadme('blah'),
        grantedPoints: 10,
        maxPoints: 110,
      ));
      await index.addPackage(PackageDocument(
        package: 'build',
        version: '0.0.1',
        description: compactDescription('A build system for Dart.'),
        readme: compactReadme('build and configure'),
        grantedPoints: 110,
        maxPoints: 110,
      ));
      await index.markReady();
    });

    test('build_config', () async {
      final PackageSearchResult result = await index.search(
          ServiceSearchQuery.parse(
              query: 'build_config', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 2,
        'highlightedHit': {'package': 'build_config'},
        'sdkLibraryHits': [],
        'packageHits': [
          {
            'package': 'build',
            'score': closeTo(0.60, 0.01),
          },
        ],
      });
    });
  });
}
