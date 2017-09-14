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

    group('trigger analysis', () {
      scopedTest('/packages/pkg_foo', () async {
        // TODO: mock notification secret and re-enable testing task receive
        await expectJsonResponse(await issuePost('/packages/pkg_foo'),
            body: {'success': false});
      });
    });

    group('search', () {
      Future setUpInServiceScope() async {
        registerSearchBackend(new MockSearchBackend());
        registerPackageIndex(new SimplePackageIndex());
        await packageIndex
            .addAll(await searchBackend.loadDocuments(['pkg_foo']));
        await packageIndex.merge();
      }

      scopedTest('Finds package by name', () async {
        await setUpInServiceScope();
        expectJsonResponse(await issueGet('/search?q=pkg_foo'), body: {
          'indexUpdated': isNotNull,
          'totalCount': 1,
          'packages': [
            {
              'url': 'https://pub.domain/packages/pkg_foo',
              'package': 'pkg_foo',
              'version': '1.0.1',
              'devVersion': '1.0.1-dev',
              'platforms': ['server', 'web'],
              'score': closeTo(71.1, 0.1),
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
              'url': 'https://pub.domain/packages/pkg_foo',
              'package': 'pkg_foo',
              'version': '1.0.1',
              'devVersion': '1.0.1-dev',
              'platforms': ['server', 'web'],
              'score': closeTo(2.4, 0.1),
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
                  'url': 'https://pub.domain/packages/pkg_foo',
                  'package': 'pkg_foo',
                  'version': '1.0.1',
                  'devVersion': '1.0.1-dev',
                  'platforms': ['server', 'web'],
                  'score': closeTo(2.4, 0.1),
                }
              ],
            });
      });

      scopedTest('Finds package by pkg-prefix search only', () async {
        await setUpInServiceScope();
        expectJsonResponse(await issueGet('/search?q=&pkg-prefix=pk'), body: {
          'indexUpdated': isNotNull,
          'totalCount': 1,
          'packages': [
            {
              'url': 'https://pub.domain/packages/pkg_foo',
              'package': 'pkg_foo',
              'version': '1.0.1',
              'devVersion': '1.0.1-dev',
              'platforms': ['server', 'web'],
              'score': closeTo(13.3, 0.1),
            }
          ],
        });
      });

      scopedTest('pkg-prefix filters out results', () async {
        await setUpInServiceScope();
        expectJsonResponse(await issueGet('/search?q=json&pkg-prefix=foo'),
            body: {
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
  Future updatePackage(PackageDocument document) {
    throw new UnimplementedError();
  }

  @override
  Stream<PackageDocument> listRecentPackages({DateTime since}) {
    throw new UnimplementedError();
  }

  @override
  Future<List<PackageDocument>> loadDocuments(List<String> packages) async {
    return packages.map((String package) {
      return new PackageDocument(
        url: 'https://pub.domain/packages/$package',
        package: package,
        version: '1.0.1',
        devVersion: '1.0.1-dev',
        platforms: ['server', 'web'],
        description: 'Foo package about nothing really. Maybe JSON.',
        readme: 'Some JSON to XML mapping.',
        popularity: 0.1,
      );
    }).toList();
  }
}
