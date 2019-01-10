// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.handlers_test;

import 'dart:async';

import 'package:test/test.dart';

import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/search_service.dart';
import 'package:pub_dartlang_org/frontend/static_files.dart';
import 'package:pub_dartlang_org/shared/search_service.dart';

import '../../shared/handlers_test_utils.dart';
import '../mocks.dart';
import '../utils.dart';

import '_utils.dart';

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
      tScopedTest('/authorized', () async {
        await expectHtmlResponse(await issueGet('/authorized'));
      });
    });
  });
}
