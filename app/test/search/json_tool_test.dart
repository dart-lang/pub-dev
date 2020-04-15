// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:test/test.dart';

import 'package:pub_dev/search/index_simple.dart';
import 'package:pub_dev/search/search_service.dart';

void main() {
  group('without content', () {
    SimplePackageIndex index;

    setUpAll(() async {
      index = SimplePackageIndex();
      await index.addPackage(PackageDocument(package: 'jsontool'));
      await index.addPackage(PackageDocument(package: 'json2entity'));
      await index.addPackage(PackageDocument(package: 'json_to_model'));
      await index.markReady();
    });

    test('json_tool', () async {
      final PackageSearchResult result = await index.search(
          SearchQuery.parse(query: 'json_tool', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 1,
        'packages': [
          {'package': 'jsontool', 'score': 1.0},
        ],
      });
    });
  });

  group('with content', () {
    SimplePackageIndex index;

    setUpAll(() async {
      index = SimplePackageIndex();
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
          SearchQuery.parse(query: 'json_tool', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'indexUpdated': isNotNull,
        'totalCount': 3,
        'packages': [
          {'package': 'jsontool', 'score': 1.0},
          {'package': 'json2entity', 'score': closeTo(0.789, 0.001)},
          {'package': 'json_to_model', 'score': closeTo(0.736, 0.001)},
        ],
      });
    });
  });
}
