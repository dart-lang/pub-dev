// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dartlang_org/account/backend.dart';
import 'package:pub_dartlang_org/account/models.dart';
import 'package:pub_dartlang_org/frontend/backend.dart';
import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/name_tracker.dart';
import 'package:pub_dartlang_org/frontend/search_service.dart';
import 'package:pub_dartlang_org/frontend/static_files.dart';
import 'package:pub_dartlang_org/scorecard/backend.dart';
import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/search_client.dart';
import 'package:pub_dartlang_org/shared/search_service.dart';

import '../../shared/handlers_test_utils.dart';
import '../../shared/utils.dart';
import '../backend_test_utils.dart';
import '../mocks.dart';
import '../utils.dart';

import '_utils.dart';

void main() {
  setUpAll(() => updateLocalBuiltFiles());

  group('old api', () {
    scopedTest('/packages.json', () async {
      final backend =
          BackendMock(latestPackagesFun: ({offset, limit, detectedType}) {
        expect(offset, 0);
        expect(limit, greaterThan(pageSize));
        return [testPackage];
      }, lookupLatestVersionsFun: (List<Package> packages) {
        expect(packages.length, 1);
        expect(packages.first, testPackage);
        return [testPackageVersion];
      });
      registerBackend(backend);
      await expectJsonResponse(await issueGet('/packages.json'), body: {
        'packages': ['https://pub.dev/packages/foobar_pkg.json'],
        'next': null
      });
    });

    tScopedTest('/packages/foobar_pkg.json', () async {
      final backend = BackendMock(lookupPackageFun: (String package) {
        expect(package, 'foobar_pkg');
        return testPackage;
      }, versionsOfPackageFun: (String package) {
        expect(package, 'foobar_pkg');
        return [testPackageVersion];
      });
      registerAccountBackend(AccountBackendMock(users: [
        User()
          ..id = 'hans-at-juergen-dot-com'
          ..email = 'hans@juergen.com',
      ]));
      registerBackend(backend);
      await expectJsonResponse(await issueGet('/packages/foobar_pkg.json'),
          body: {
            'name': 'foobar_pkg',
            'uploaders': ['hans@juergen.com'],
            'versions': ['0.1.1+5'],
          });
    });
  });

  group('ui', () {
    tScopedTest('/packages', () async {
      registerSearchService(SearchServiceMock(
        (SearchQuery query) {
          expect(query.offset, 0);
          expect(query.limit, pageSize);
          expect(query.platform, isNull);
          expect(query.isAd, isFalse);
          return SearchResultPage(query, 1, [
            PackageView.fromModel(
                package: testPackage,
                version: testPackageVersion,
                scoreCard: null)
          ]);
        },
      ));
      final backend = BackendMock(
        lookupPackageFun: (packageName) {
          return packageName == testPackage.name ? testPackage : null;
        },
        lookupLatestVersionsFun: (List<Package> packages) {
          expect(packages.length, 1);
          expect(packages.first, testPackage);
          return [testPackageVersion];
        },
      );
      registerBackend(backend);
      registerAnalyzerClient(AnalyzerClientMock());
      await expectHtmlResponse(await issueGet('/packages'));
    });

    tScopedTest('/packages?q=foobar', () async {
      registerSearchService(SearchServiceMock(
        (SearchQuery query) {
          expect(query.query, 'foobar');
          expect(query.offset, 0);
          expect(query.limit, pageSize);
          expect(query.platform, isNull);
          expect(query.isAd, isFalse);
          return SearchResultPage(query, 1, [
            PackageView.fromModel(
                package: testPackage,
                version: testPackageVersion,
                scoreCard: null)
          ]);
        },
      ));
      final backend = BackendMock(
        lookupPackageFun: (packageName) {
          return packageName == testPackage.name ? testPackage : null;
        },
        lookupLatestVersionsFun: (List<Package> packages) {
          expect(packages.length, 1);
          expect(packages.first, testPackage);
          return [testPackageVersion];
        },
      );
      registerBackend(backend);
      registerAnalyzerClient(AnalyzerClientMock());
      await expectHtmlResponse(await issueGet('/packages?q=foobar'));
    });

    tScopedTest('/packages?q=foo without working search', () async {
      registerSearchClient(null);
      registerSearchService(SearchService());
      registerNameTracker(NameTracker(null));
      nameTracker.add('foobar_pkg');
      nameTracker.markReady();
      final backend = BackendMock(
        lookupPackageFun: (packageName) {
          return packageName == testPackage.name ? testPackage : null;
        },
        lookupLatestVersionsFun: (List<Package> packages) {
          expect(packages.length, 1);
          expect(packages.first, testPackage);
          return [testPackageVersion];
        },
      );
      registerBackend(backend);
      registerAnalyzerClient(AnalyzerClientMock());
      registerScoreCardBackend(ScoreCardBackendMock());
      final content =
          await expectHtmlResponse(await issueGet('/packages?q=foo'));
      expect(content, contains('my package description'));
    });

    tScopedTest('/packages?page=2', () async {
      registerSearchService(SearchServiceMock(
        (SearchQuery query) {
          expect(query.offset, 10);
          expect(query.limit, pageSize);
          expect(query.platform, isNull);
          expect(query.isAd, isFalse);
          return SearchResultPage(query, 1, [
            PackageView.fromModel(
                package: testPackage,
                version: testPackageVersion,
                scoreCard: null)
          ]);
        },
      ));
      final backend = BackendMock(
        lookupPackageFun: (packageName) {
          return packageName == testPackage.name ? testPackage : null;
        },
        lookupLatestVersionsFun: (List<Package> packages) {
          expect(packages.length, 1);
          expect(packages.first, testPackage);
          return [testPackageVersion];
        },
      );
      registerBackend(backend);
      registerAnalyzerClient(AnalyzerClientMock());
      await expectHtmlResponse(await issueGet('/packages?page=2'));
    });

    tScopedTest('/flutter/packages', () async {
      registerSearchService(SearchServiceMock(
        (SearchQuery query) {
          expect(query.offset, 0);
          expect(query.limit, pageSize);
          expect(query.platform, 'flutter');
          expect(query.isAd, isFalse);
          return SearchResultPage(query, 1, [
            PackageView.fromModel(
                package: testPackage,
                version: testPackageVersion,
                scoreCard: null)
          ]);
        },
      ));
      final backend = BackendMock(
        lookupPackageFun: (packageName) {
          return packageName == testPackage.name ? testPackage : null;
        },
        lookupLatestVersionsFun: (List<Package> packages) {
          expect(packages.length, 1);
          expect(packages.first, testPackage);
          return [testPackageVersion];
        },
      );
      registerBackend(backend);
      registerAnalyzerClient(AnalyzerClientMock());
      await expectHtmlResponse(await issueGet('/flutter/packages'));
    });

    tScopedTest('/flutter/packages&page=2', () async {
      registerSearchService(SearchServiceMock(
        (SearchQuery query) {
          expect(query.offset, 10);
          expect(query.limit, pageSize);
          expect(query.platform, 'flutter');
          expect(query.isAd, isFalse);
          return SearchResultPage(query, 1, [
            PackageView.fromModel(
                package: testPackage,
                version: testPackageVersion,
                scoreCard: null)
          ]);
        },
      ));
      final backend = BackendMock(
        lookupPackageFun: (packageName) {
          return packageName == testPackage.name ? testPackage : null;
        },
        lookupLatestVersionsFun: (List<Package> packages) {
          expect(packages.length, 1);
          expect(packages.first, testPackage);
          return [testPackageVersion];
        },
      );
      registerBackend(backend);
      registerAnalyzerClient(AnalyzerClientMock());
      await expectHtmlResponse(await issueGet('/flutter/packages?page=2'));
    });
  });
}
