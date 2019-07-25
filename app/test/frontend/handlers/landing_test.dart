// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dartlang_org/frontend/backend.dart';
import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/search_service.dart';
import 'package:pub_dartlang_org/frontend/static_files.dart';
import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/search_client.dart';
import 'package:pub_dartlang_org/shared/search_service.dart';

import '../../shared/test_models.dart';
import '../../shared/test_services.dart';
import '../mocks.dart';

import '_utils.dart';

void main() {
  setUpAll(() => updateLocalBuiltFiles());

  group('ui', () {
    testWithServices('/', () async {
      final rs = await issueGet('/');
      await expectHtmlResponse(
        rs,
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

    testWithServices('/ without a working search service', () async {
      registerSearchClient(null);
      final rs = await issueGet('/');
      await expectHtmlResponse(
        rs,
        present: [
          '/packages/http',
          '/packages/event_bus',
          'lightweight library for parsing',
        ],
        absent: [
          '/packages/helium',
          '/packages/hydrogen',
          'hydrogen is a Dart package',
        ],
      );
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
          [PackageView.fromModel(version: foobarStablePV)],
        );
      }));
      final backend = BackendMock(latestPackageVersionsFun: ({offset, limit}) {
        expect(offset, isNull);
        expect(limit, equals(5));
        return [foobarStablePV];
      });
      registerBackend(backend);
      registerAnalyzerClient(AnalyzerClientMock());

      await expectHtmlResponse(await issueGet('/flutter'));
    });

    testWithServices('/xxx - not found page', () async {
      final rs = await issueGet('/xxx');
      await expectHtmlResponse(rs, status: 404, present: [
        'You\'ve stumbled onto a page',
        '/packages/helium',
        '/packages/hydrogen',
        'hydrogen is a Dart package',
      ], absent: [
        '/packages/http',
        '/packages/event_bus',
        'lightweight library for parsing',
      ]);
    });
  });
}
