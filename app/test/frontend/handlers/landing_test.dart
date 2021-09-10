// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:http/testing.dart';
import 'package:pub_dev/frontend/static_files.dart';
import 'package:pub_dev/search/search_client.dart';
import 'package:test/test.dart';

import '../../shared/handlers_test_utils.dart';
import '../../shared/test_services.dart';
import '_utils.dart';

void main() {
  setUpAll(() => updateLocalBuiltFilesIfNeeded());

  group('ui', () {
    testWithProfile('/', fn: () async {
      final rs = await issueGet('/');
      await expectHtmlResponse(
        rs,
        present: [
          '/packages/oxygen',
          '/packages/neon',
          'oxygen is awesome',
        ],
        absent: [
          '/packages/http',
          '/packages/event_bus',
          'lightweight library for parsing',
        ],
      );
    });

    testWithProfile('/ without a working search service', fn: () async {
      registerSearchClient(
          SearchClient(MockClient((_) async => throw Exception())));
      final rs = await issueGet('/');
      await expectHtmlResponse(
        rs,
        present: [
          'The official package repository for',
        ],
        absent: [
          '/packages/neon',
          '/packages/oxygen',
          'Awesome package',
        ],
      );
    });

    testWithProfile('/flutter', fn: () async {
      final rs = await issueGet('/flutter');
      await expectRedirectResponse(rs, '/flutter/packages');
    });

    testWithProfile('/xxx - not found page', fn: () async {
      final rs = await issueGet('/xxx');
      await expectHtmlResponse(rs, status: 404, present: [
        'You\'ve stumbled onto a page',
      ], absent: [
        '/packages/http',
        '/packages/event_bus',
        'lightweight library for parsing',
        '/packages/neon',
        '/packages/oxygen',
        'Awesome package',
      ]);
    });
  });
}
