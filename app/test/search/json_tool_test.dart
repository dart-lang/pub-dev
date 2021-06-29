// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.9

import 'dart:convert';

import 'package:test/test.dart';

import 'package:pub_dev/search/mem_index.dart';
import 'package:pub_dev/search/search_service.dart';

void main() {
  group('without content', () {
    InMemoryPackageIndex index;

    setUpAll(() async {
      index = InMemoryPackageIndex();
      await index.addPackage(PackageDocument(package: 'jsontool'));
      await index.addPackage(PackageDocument(package: 'json2entity'));
      await index.addPackage(PackageDocument(package: 'json_to_model'));
      await index.markReady();
    });

    test('json_tool', () async {
      final PackageSearchResult result = await index.search(
          ServiceSearchQuery.parse(
              query: 'json_tool', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'jsontool', 'score': 1.0},
        ],
      });
    });
  });

  group('with content', () {
    InMemoryPackageIndex index;

    setUpAll(() async {
      index = InMemoryPackageIndex();
      await index.addPackage(PackageDocument(
        package: 'jsontool',
        description:
            'Low-level tools for working with JSON without creating intermediate objects.',
      ));
      await index.addPackage(PackageDocument(
        package: 'json2entity',
        description:
            'A tool for converting JSON strings into dart entity classes. Support json_serializable.',
      ));
      await index.addPackage(PackageDocument(
        package: 'json_to_model',
        description:
            'Gernerate model class from Json file. partly inspired by json_model.',
        readme:
            'Command line tool for generating Dart models (json_serializable) from Json file.',
      ));
      await index.markReady();
    });

    test('json_tool', () async {
      final PackageSearchResult result = await index.search(
          ServiceSearchQuery.parse(
              query: 'json_tool', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 3,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'jsontool', 'score': 1.0},
          {'package': 'json2entity', 'score': closeTo(0.79, 0.01)},
          {'package': 'json_to_model', 'score': closeTo(0.55, 0.01)},
        ],
      });
    });
  });
}
