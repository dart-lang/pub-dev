// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:_pub_shared/search/search_form.dart';
import 'package:pub_dev/search/mem_index.dart';
import 'package:pub_dev/search/search_service.dart';
import 'package:test/test.dart';

void main() {
  group('without content', () {
    late InMemoryPackageIndex index;

    setUpAll(() async {
      index = InMemoryPackageIndex(documents: [
        PackageDocument(package: 'jsontool'),
        PackageDocument(package: 'json2entity'),
        PackageDocument(package: 'json_to_model'),
      ]);
    });

    test('json_tool', () async {
      final PackageSearchResult result = index.search(ServiceSearchQuery.parse(
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
    late InMemoryPackageIndex index;

    setUpAll(() async {
      index = InMemoryPackageIndex(documents: [
        PackageDocument(
          package: 'jsontool',
          description:
              'Low-level tools for working with JSON without creating intermediate objects.',
        ),
        PackageDocument(
          package: 'json2entity',
          description:
              'A tool for converting JSON strings into dart entity classes. Support json_serializable.',
        ),
        PackageDocument(
          package: 'json_to_model',
          description:
              'Generate model class from Json file. partly inspired by json_model.',
          readme:
              'Command line tool for generating Dart models (json_serializable) from Json file.',
        ),
      ]);
    });

    test('json_tool', () async {
      final PackageSearchResult result = index.search(ServiceSearchQuery.parse(
          query: 'json_tool', order: SearchOrder.text));
      expect(json.decode(json.encode(result)), {
        'timestamp': isNotNull,
        'totalCount': 3,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'json2entity', 'score': 1.0},
          {'package': 'jsontool', 'score': 1.0},
          {'package': 'json_to_model', 'score': closeTo(0.73, 0.01)},
        ],
      });
    });
  });
}
