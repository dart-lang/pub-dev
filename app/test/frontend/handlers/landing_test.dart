// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dartlang_org/frontend/backend.dart';
import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/search_service.dart';
import 'package:pub_dartlang_org/frontend/static_files.dart';
import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/search_service.dart';

import '../mocks.dart';
import '../utils.dart';

import '_utils.dart';

void main() {
  setUpAll(() => updateLocalBuiltFiles());

  group('ui', () {
    tScopedTest('/', () async {
      registerSearchService(SearchServiceMock((SearchQuery query) {
        expect(query.order, isNull);
        expect(query.offset, 0);
        expect(query.limit, topQueryLimit);
        expect(query.platform, isNull);
        expect(query.query, isNull);
        expect(query.isAd, isTrue);
        return SearchResultPage(
          query,
          1,
          [PackageView.fromModel(version: testPackageVersion)],
        );
      }));
      final backend = BackendMock(latestPackageVersionsFun: ({offset, limit}) {
        expect(offset, isNull);
        expect(limit, equals(5));
        return [testPackageVersion];
      });
      registerBackend(backend);
      registerAnalyzerClient(AnalyzerClientMock());

      await expectHtmlResponse(await issueGet('/'));
    });

    tScopedTest('/ without a working search service', () async {
      registerSearchService(SearchService());
      final rs = await issueGet('/');
      final content = await expectHtmlResponse(rs);
      expect(content, contains('/packages/http'));
      expect(content, contains('/packages/event_bus'));
      expect(content, contains('lightweight library for parsing'));
    });

    tScopedTest('/flutter', () async {
      registerSearchService(SearchServiceMock((SearchQuery query) {
        expect(query.order, isNull);
        expect(query.offset, 0);
        expect(query.limit, topQueryLimit);
        expect(query.platform, 'flutter');
        expect(query.query, isNull);
        expect(query.isAd, isTrue);
        return SearchResultPage(
          query,
          1,
          [PackageView.fromModel(version: testPackageVersion)],
        );
      }));
      final backend = BackendMock(latestPackageVersionsFun: ({offset, limit}) {
        expect(offset, isNull);
        expect(limit, equals(5));
        return [testPackageVersion];
      });
      registerBackend(backend);
      registerAnalyzerClient(AnalyzerClientMock());

      await expectHtmlResponse(await issueGet('/flutter'));
    });
  });
}
