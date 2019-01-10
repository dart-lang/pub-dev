// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.handlers_test;

import 'dart:async';

import 'package:test/test.dart';

import 'package:pub_dartlang_org/frontend/backend.dart';
import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/search_service.dart';
import 'package:pub_dartlang_org/frontend/static_files.dart';
import 'package:pub_dartlang_org/scorecard/backend.dart';
import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/dartdoc_client.dart';
import 'package:pub_dartlang_org/shared/search_service.dart';

import '../shared/handlers_test_utils.dart';
import '../shared/utils.dart';

import 'handlers/_utils.dart';
import 'mocks.dart';
import 'utils.dart';

void tScopedTest(String name, Future func()) {
  scopedTest(name, () {
    return func();
  });
}

Future main() async {
  await updateLocalBuiltFiles();

  group('handlers', () {
    group('not found', () {
      tScopedTest('/xxx', () async {
        registerSearchService(new SearchServiceMock((SearchQuery query) {
          expect(query.order, isNull);
          expect(query.offset, 0);
          expect(query.limit, topQueryLimit);
          expect(query.platform, isNull);
          expect(query.query, isNull);
          expect(query.isAd, isTrue);
          return new SearchResultPage(
            query,
            1,
            [new PackageView.fromModel(version: testPackageVersion)],
          );
        }));
        await expectNotFoundResponse(await issueGet('/xxx'));
      });
    });

    group('ui', () {
      tScopedTest('/', () async {
        registerSearchService(new SearchServiceMock((SearchQuery query) {
          expect(query.order, isNull);
          expect(query.offset, 0);
          expect(query.limit, topQueryLimit);
          expect(query.platform, isNull);
          expect(query.query, isNull);
          expect(query.isAd, isTrue);
          return new SearchResultPage(
            query,
            1,
            [new PackageView.fromModel(version: testPackageVersion)],
          );
        }));
        final backend =
            new BackendMock(latestPackageVersionsFun: ({offset, limit}) {
          expect(offset, isNull);
          expect(limit, equals(5));
          return [testPackageVersion];
        });
        registerBackend(backend);
        registerAnalyzerClient(new AnalyzerClientMock());

        await expectHtmlResponse(await issueGet('/'));
      });

      tScopedTest('/packages/foobar_pkg - found', () async {
        final backend = new BackendMock(lookupPackageFun: (String packageName) {
          expect(packageName, 'foobar_pkg');
          return testPackage;
        }, versionsOfPackageFun: (String package) {
          expect(package, testPackage.name);
          return [testPackageVersion];
        }, downloadUrlFun: (String package, String version) {
          return Uri.parse('http://blobstore/$package/$version');
        });
        registerBackend(backend);
        registerAnalyzerClient(new AnalyzerClientMock());
        registerDartdocClient(new DartdocClientMock());
        registerScoreCardBackend(new ScoreCardBackendMock());
        await expectHtmlResponse(await issueGet('/packages/foobar_pkg'));
      });

      tScopedTest('/packages/foobar_pkg - not found', () async {
        final backend = new BackendMock(lookupPackageFun: (String packageName) {
          expect(packageName, 'foobar_pkg');
          return null;
        });
        registerBackend(backend);
        await expectRedirectResponse(
            await issueGet('/packages/foobar_pkg'), '/packages?q=foobar_pkg');
      });

      tScopedTest('/packages/foobar_pkg/versions - found', () async {
        final backend = new BackendMock(versionsOfPackageFun: (String package) {
          expect(package, testPackage.name);
          return [testPackageVersion];
        }, downloadUrlFun: (String package, String version) {
          return Uri.parse('http://blobstore/$package/$version');
        });
        registerBackend(backend);
        registerDartdocClient(new DartdocClientMock());
        await expectHtmlResponse(
            await issueGet('/packages/foobar_pkg/versions'));
      });

      tScopedTest('/packages/foobar_pkg/versions - not found', () async {
        final backend = new BackendMock(versionsOfPackageFun: (String package) {
          expect(package, testPackage.name);
          return [];
        });
        registerBackend(backend);
        await expectRedirectResponse(
            await issueGet('/packages/foobar_pkg/versions'),
            '/packages?q=foobar_pkg');
      });

      tScopedTest('/packages/foobar_pkg/versions/0.1.1 - found', () async {
        final backend = new BackendMock(lookupPackageFun: (String package) {
          expect(package, testPackage.name);
          return testPackage;
        }, versionsOfPackageFun: (String package) {
          expect(package, testPackage.name);
          return [testPackageVersion];
        }, downloadUrlFun: (String package, String version) {
          return Uri.parse('http://blobstore/$package/$version');
        });
        registerBackend(backend);
        registerAnalyzerClient(new AnalyzerClientMock());
        registerDartdocClient(new DartdocClientMock());
        registerScoreCardBackend(new ScoreCardBackendMock());
        await expectHtmlResponse(
            await issueGet('/packages/foobar_pkg/versions/0.1.1+5'));
      });

      tScopedTest('/packages/foobar_pkg/versions/0.1.2 - not found', () async {
        final backend = new BackendMock(lookupPackageFun: (String package) {
          expect(package, testPackage.name);
          return testPackage;
        }, versionsOfPackageFun: (String package) {
          expect(package, testPackage.name);
          return [testPackageVersion];
        }, downloadUrlFun: (String package, String version) {
          return Uri.parse('http://blobstore/$package/$version');
        });
        registerBackend(backend);
        registerAnalyzerClient(new AnalyzerClientMock());
        registerDartdocClient(new DartdocClientMock());
        await expectRedirectResponse(
            await issueGet('/packages/foobar_pkg/versions/0.1.2'),
            '/packages/foobar_pkg#-versions-tab-');
      });

      tScopedTest('/packages/flutter - redirect', () async {
        expectRedirectResponse(
          await issueGet('/packages/flutter'),
          'https://pub.dartlang.org/flutter',
        );
      });

      tScopedTest('/packages/flutter/versions/* - redirect', () async {
        expectRedirectResponse(
          await issueGet('/packages/flutter/versions/0.20'),
          'https://pub.dartlang.org/flutter',
        );
      });

      tScopedTest('/flutter', () async {
        registerSearchService(new SearchServiceMock((SearchQuery query) {
          expect(query.order, isNull);
          expect(query.offset, 0);
          expect(query.limit, topQueryLimit);
          expect(query.platform, 'flutter');
          expect(query.query, isNull);
          expect(query.isAd, isTrue);
          return new SearchResultPage(
            query,
            1,
            [new PackageView.fromModel(version: testPackageVersion)],
          );
        }));
        final backend =
            new BackendMock(latestPackageVersionsFun: ({offset, limit}) {
          expect(offset, isNull);
          expect(limit, equals(5));
          return [testPackageVersion];
        });
        registerBackend(backend);
        registerAnalyzerClient(new AnalyzerClientMock());

        await expectHtmlResponse(await issueGet('/flutter'));
      });

      tScopedTest('/authorized', () async {
        await expectHtmlResponse(await issueGet('/authorized'));
      });
    });
  });
}
