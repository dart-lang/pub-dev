// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:_pub_shared/search/search_form.dart';
import 'package:pub_dartdoc_data/dartdoc_index.dart';
import 'package:pub_dev/search/dart_sdk_mem_index.dart';
import 'package:pub_dev/search/flutter_sdk_mem_index.dart';
import 'package:pub_dev/search/mem_index.dart';
import 'package:pub_dev/search/result_combiner.dart';
import 'package:pub_dev/search/search_service.dart';
import 'package:test/test.dart';

void main() {
  group('ResultCombiner', () {
    final primaryIndex = InMemoryPackageIndex(
      documents: [
        PackageDocument(
          package: 'stringutils',
          version: '1.0.0',
          description: 'many utils utils',
          readme: 'Many useful string methods like substring.',
          grantedPoints: 110,
          maxPoints: 110,
          popularityScore: 0.4,
        ),
      ],
    );
    final dartSdkMemIndex = DartSdkMemIndex();
    final flutterSdkMemIndex = FlutterSdkMemIndex();
    final combiner = SearchResultCombiner(
      primaryIndex: primaryIndex,
      dartSdkMemIndex: dartSdkMemIndex,
      flutterSdkMemIndex: flutterSdkMemIndex,
    );

    setUpAll(() async {
      dartSdkMemIndex.setDartdocIndex(
        DartdocIndex.fromJsonList([
          {
            'name': 'dart:core',
            'qualifiedName': 'dart:core',
            'href': 'dart-core/dart-core-library.html',
            'kind': 8,
            'overriddenDepth': 0,
            'packageName': 'Dart'
          },
          {
            'name': 'String',
            'qualifiedName': 'dart:core.String',
            'href': 'dart-core/String-class.html',
            'kind': 3,
            'overriddenDepth': 0,
            'packageName': 'Dart',
            'enclosedBy': {'name': 'dart:core', 'kind': 8}
          },
          {
            'name': 'substring',
            'qualifiedName': 'dart:core.String.substring',
            'href': 'dart-core/String/substring.html',
            'kind': 9,
            'overriddenDepth': 0,
            'packageName': 'Dart',
            'enclosedBy': {'name': 'String', 'kind': 3}
          },
          {
            // fake method for checking the package name matches
            'name': 'stringutils',
            'qualifiedName': 'dart:core.String.stringutils',
            'href': 'dart-core/String/stringutils.html',
            'kind': 9,
            'overriddenDepth': 0,
            'packageName': 'Dart',
            'enclosedBy': {'name': 'String', 'kind': 3}
          },
        ]),
        version: '2.0.0',
      );
    });

    test('non-text ranking', () async {
      final results = combiner
          .search(ServiceSearchQuery.parse(order: SearchOrder.popularity));
      expect(json.decode(json.encode(results.toJson())), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'stringutils', 'score': 0.4},
        ],
      });
    });

    test('no actual text query', () async {
      final results =
          combiner.search(ServiceSearchQuery.parse(query: 'package:s'));
      expect(json.decode(json.encode(results.toJson())), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'stringutils', 'score': closeTo(0.85, 0.01)},
        ],
      });
    });

    test('search: substring', () async {
      final results =
          combiner.search(ServiceSearchQuery.parse(query: 'substring'));
      expect(json.decode(json.encode(results.toJson())), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [
          {
            'sdk': 'dart',
            'version': '2.0.0',
            'library': 'dart:core',
            'url':
                'https://api.dart.dev/stable/2.0.0/dart-core/dart-core-library.html',
            'score': closeTo(0.98, 0.01),
            'apiPages': [
              {
                'path': 'dart-core/String/substring.html',
                'url':
                    'https://api.dart.dev/stable/2.0.0/dart-core/String/substring.html'
              }
            ]
          },
        ],
        'packageHits': [
          {'package': 'stringutils', 'score': closeTo(0.67, 0.01)}
        ],
      });
    });
  });
}
