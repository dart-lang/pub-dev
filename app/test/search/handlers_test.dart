// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.handlers_test;

import 'dart:async';

import 'package:pub_dartlang_org/shared/search_service.dart';
import 'package:test/test.dart';

import 'package:pub_dartlang_org/search/backend.dart';
import 'package:pub_dartlang_org/search/index_simple.dart';

import '../shared/handlers_test_utils.dart';
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
        registerSearchBackend(new MockSearchBackend());
        await expectNotFoundResponse(await issueGet('/packages/unknown'));
      });
    });

    group('search', () {
      Future setUpInServiceScope() async {
        registerSearchBackend(new MockSearchBackend());
        registerPackageIndex(new SimplePackageIndex());
        registerDartSdkIndex(new SimplePackageIndex());
        await packageIndex
            .addPackage(await searchBackend.loadDocument('pkg_foo'));
        await packageIndex.merge();
      }

      scopedTest('Finds package by name', () async {
        await setUpInServiceScope();
        expectJsonResponse(await issueGet('/search?q=pkg_foo'), body: {
          'indexUpdated': isNotNull,
          'totalCount': 1,
          'packages': [
            {
              'package': 'pkg_foo',
              'score': closeTo(0.33, 0.01),
            }
          ],
        });
      });

      scopedTest('Finds text in description or readme', () async {
        await setUpInServiceScope();
        expectJsonResponse(await issueGet('/search?q=json'), body: {
          'indexUpdated': isNotNull,
          'totalCount': 1,
          'packages': [
            {
              'package': 'pkg_foo',
              'score': closeTo(0.31, 0.01),
            }
          ],
        });
      });

      scopedTest('pkg-prefix doesn\'t affect score', () async {
        await setUpInServiceScope();
        expectJsonResponse(await issueGet('/search?q=json&pkg-prefix=pk'),
            body: {
              'indexUpdated': isNotNull,
              'totalCount': 1,
              'packages': [
                {
                  'package': 'pkg_foo',
                  'score': closeTo(0.31, 0.01),
                }
              ],
            });
      });

      scopedTest('Finds package by package-prefix search only', () async {
        await setUpInServiceScope();
        expectJsonResponse(await issueGet('/search?q=package:pk'), body: {
          'indexUpdated': isNotNull,
          'totalCount': 1,
          'packages': [
            {
              'package': 'pkg_foo',
              'score': closeTo(0.4, 0.1),
            }
          ],
        });
      });

      scopedTest('pkg-prefix filters out results', () async {
        await setUpInServiceScope();
        expectJsonResponse(await issueGet('/search?q=json+package:foo'), body: {
          'indexUpdated': isNotNull,
          'totalCount': 0,
          'packages': [],
        });
      });
    });
  });
}

class MockSearchBackend implements SearchBackend {
  List<String> packages = ['pkg_foo'];

  @override
  Future<PackageDocument> loadDocument(String packageName) async {
    if (!packages.contains(packageName)) {
      return null;
    }
    return PackageDocument(
      package: packageName,
      version: '1.0.1',
      devVersion: '1.0.1-dev',
      platforms: ['web', 'other'],
      description: 'Foo package about nothing really. Maybe JSON.',
      readme: 'Some JSON to XML mapping.',
      popularity: 0.1,
    );
  }
}
