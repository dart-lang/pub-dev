// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:http/testing.dart';
import 'package:test/test.dart';

import 'package:pub_dartlang_org/frontend/backend.dart';
import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/name_tracker.dart';
import 'package:pub_dartlang_org/frontend/search_service.dart';
import 'package:pub_dartlang_org/frontend/static_files.dart';
import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/search_service.dart';
import 'package:pub_dartlang_org/shared/search_client.dart';

import '../../shared/handlers_test_utils.dart';
import '../../shared/test_models.dart';
import '../../shared/test_services.dart';
import '../mocks.dart';

import '_utils.dart';

void main() {
  setUpAll(() => updateLocalBuiltFiles());

  group('old api', () {
    testWithServices('/packages.json', () async {
      await expectJsonResponse(await issueGet('/packages.json'), body: {
        'packages': [
          'https://pub.dev/packages/foobar_pkg.json',
          'https://pub.dev/packages/lithium.json',
          'https://pub.dev/packages/helium.json',
          'https://pub.dev/packages/hydrogen.json',
        ],
        'next': null
      });
    });

    testWithServices('/packages/foobar_pkg.json', () async {
      await expectJsonResponse(await issueGet('/packages/foobar_pkg.json'),
          body: {
            'name': 'foobar_pkg',
            'uploaders': ['hans@juergen.com'],
            'versions': ['0.1.1+5'],
          });
    });
  });

  group('ui', () {
    testWithServices('/packages', () async {
      await expectHtmlResponse(
        await issueGet('/packages'),
        present: [
          '/packages/helium',
          '/packages/hydrogen',
          'hydrogen is a Dart package',
        ],
        absent: [
          '/packages/http',
          '/packages/event_bus',
          'lightweight library for parsing',
        ],
      );
    });

    testWithServices('/packages?q="hydrogen is"', () async {
      await expectHtmlResponse(
        await issueGet('/packages?q="hydrogen is"'),
        present: [
          '/packages/hydrogen',
          'hydrogen is a Dart package',
        ],
        absent: [
          '/packages/helium',
          '/packages/http',
          '/packages/event_bus',
          'lightweight library for parsing',
        ],
      );
    });

    testWithServices('/packages?q=heliu without working search', () async {
      registerSearchClient(
          SearchClient(MockClient((_) async => throw Exception())));
      await nameTracker.scanDatastore();
      final content =
          await expectHtmlResponse(await issueGet('/packages?q=heliu'));
      expect(content, contains('helium is a Dart package'));
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
                package: foobarPackage,
                version: foobarStablePV,
                scoreCard: null)
          ]);
        },
      ));
      final backend = BackendMock(
        lookupPackageFun: (packageName) {
          return packageName == foobarPackage.name ? foobarPackage : null;
        },
        lookupLatestVersionsFun: (List<Package> packages) {
          expect(packages.length, 1);
          expect(packages.first, foobarPackage);
          return [foobarStablePV];
        },
      );
      registerBackend(backend);
      registerAnalyzerClient(AnalyzerClientMock());
      await expectHtmlResponse(await issueGet('/packages?page=2'));
    });

    testWithServices('/flutter/packages', () async {
      await expectHtmlResponse(
        await issueGet('/flutter/packages'),
        present: [
          '/packages/helium',
        ],
        absent: [
          '/packages/hydrogen',
          'hydrogen is a Dart package',
          '/packages/http',
          '/packages/event_bus',
          'lightweight library for parsing',
        ],
      );
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
                package: foobarPackage,
                version: foobarStablePV,
                scoreCard: null)
          ]);
        },
      ));
      final backend = BackendMock(
        lookupPackageFun: (packageName) {
          return packageName == foobarPackage.name ? foobarPackage : null;
        },
        lookupLatestVersionsFun: (List<Package> packages) {
          expect(packages.length, 1);
          expect(packages.first, foobarPackage);
          return [foobarStablePV];
        },
      );
      registerBackend(backend);
      registerAnalyzerClient(AnalyzerClientMock());
      await expectHtmlResponse(await issueGet('/flutter/packages?page=2'));
    });
  });
}
