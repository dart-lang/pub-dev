// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:pub_dev/search/backend.dart';
import 'package:pub_dev/search/dart_sdk_mem_index.dart';
import 'package:pub_dev/search/flutter_sdk_mem_index.dart';
import 'package:pub_dev/search/mem_index.dart';
import 'package:pub_dev/search/search_service.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:test/test.dart';

import '../frontend/handlers/_utils.dart' as _utils;
import '../shared/handlers_test_utils.dart';
import '../shared/test_services.dart';
import '../shared/utils.dart';
import 'handlers_test_utils.dart';

void main() {
  group('handlers', () {
    group('not found', () {
      scopedTest('/xxx', () async {
        await expectNotFoundResponse(await issueGet('/xxx'));
      });
      scopedTest('/packages', () async {
        await expectNotFoundResponse(await issueGet('/packages'));
      });

      scopedTest('/packages/pkg_foo', () async {
        registerSearchBackend(MockSearchBackend());
        await expectNotFoundResponse(await issueGet('/packages/unknown'));
      });
    });

    group('search', () {
      Future<void> setUpInServiceScope() async {
        registerSearchBackend(MockSearchBackend());
        registerPackageIndex(InMemoryPackageIndex());
        registerDartSdkMemIndex(DartSdkMemIndex());
        registerFlutterSdkMemIndex(FlutterSdkMemIndex());
        await packageIndex
            .addPackage(await searchBackend.loadDocument('pkg_foo'));
        await packageIndex.markReady();
      }

      scopedTest('Finds package by name', () async {
        await setUpInServiceScope();
        await expectJsonResponse(await issueGet('/search?q=pkg_foo'), body: {
          'timestamp': isNotNull,
          'totalCount': 1,
          'sdkLibraryHits': [],
          'packageHits': [
            {'package': 'pkg_foo', 'score': 0.4}
          ],
        });
      });

      scopedTest('Finds text in description or readme', () async {
        await setUpInServiceScope();
        await expectJsonResponse(await issueGet('/search?q=json'), body: {
          'timestamp': isNotNull,
          'totalCount': 1,
          'sdkLibraryHits': [],
          'packageHits': [
            {
              'package': 'pkg_foo',
              'score': closeTo(0.35, 0.01),
            },
          ],
        });
      });

      scopedTest('pkg-prefix doesn\'t affect score', () async {
        await setUpInServiceScope();
        await expectJsonResponse(await issueGet('/search?q=json&pkg-prefix=pk'),
            body: {
              'timestamp': isNotNull,
              'totalCount': 1,
              'sdkLibraryHits': [],
              'packageHits': [
                {
                  'package': 'pkg_foo',
                  'score': closeTo(0.35, 0.01),
                },
              ],
            });
      });

      scopedTest('Finds package by package-prefix search only', () async {
        await setUpInServiceScope();
        await expectJsonResponse(await issueGet('/search?q=package:pk'), body: {
          'timestamp': isNotNull,
          'totalCount': 1,
          'sdkLibraryHits': [],
          'packageHits': [
            {
              'package': 'pkg_foo',
              'score': closeTo(0.40, 0.01),
            },
          ],
        });
      });

      scopedTest('pkg-prefix filters out results', () async {
        await setUpInServiceScope();
        await expectJsonResponse(await issueGet('/search?q=json+package:foo'),
            body: {
              'timestamp': isNotNull,
              'totalCount': 0,
              'sdkLibraryHits': [],
              'packageHits': [],
            });
      });
    });
  });

  group('sort', () {
    Future<List<String>> queryPackageOrder(String url) async {
      final rs = await _utils.issueGet(url);
      return html_parser
          .parse(await rs.readAsString())
          .body!
          .querySelectorAll('a')
          .map((e) => e.attributes['href'])
          .whereNotNull()
          .where((p) => p.startsWith('/packages/'))
          .where((p) => p.endsWith('/score'))
          .map((p) => p.split('/')[2])
          .toList();
    }

    testWithProfile(
      'input text predicate overrides URL parameter',
      fn: () async {
        expect(
          await queryPackageOrder('/packages?sort=points'),
          ['oxygen', 'neon', 'flutter_titanium'],
        );
        expect(
          await queryPackageOrder('/packages?sort=popularity'),
          ['flutter_titanium', 'neon', 'oxygen'],
        );
        expect(
          await queryPackageOrder('/packages?sort=popularity&q=sort:points'),
          ['oxygen', 'neon', 'flutter_titanium'],
        );
      },
      processJobsWithFakeRunners: true,
    );
  });
}

class MockSearchBackend implements SearchBackend {
  List<String> packages = ['pkg_foo'];

  @override
  Future<PackageDocument> loadDocument(String packageName,
      {bool requireAnalysis = false}) async {
    if (!packages.contains(packageName)) {
      throw RemovedPackageException();
    }
    return PackageDocument(
      package: packageName,
      version: '1.0.1',
      tags: ['sdk:dart'],
      description: 'Foo package about nothing really. Maybe JSON.',
      readme: 'Some JSON to XML mapping.',
    );
  }

  @override
  Stream<PackageDocument> loadMinimumPackageIndex() async* {
    throw UnimplementedError();
  }

  @override
  Future<String> fetchSdkIndexContentAsString({
    required Uri baseUri,
    required String relativePath,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, String>> fetchSdkLibraryDescriptions({
    required Uri baseUri,
    required Map<String, String> libraryRelativeUrls,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> close() {
    throw UnimplementedError();
  }
}
