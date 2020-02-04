// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dev/frontend/static_files.dart';
import 'package:pub_dev/search/search_client.dart';

import '../../shared/handlers_test_utils.dart';
import '../../shared/test_services.dart';

import '_utils.dart';

void main() {
  setUpAll(() => updateLocalBuiltFilesIfNeeded());

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

    testWithServices('/flutter', () async {
      final rs = await issueGet('/flutter');
      expectRedirectResponse(rs, '/flutter/packages');
    });

    testWithServices('/xxx - not found page', () async {
      final rs = await issueGet('/xxx');
      await expectHtmlResponse(rs, status: 404, present: [
        'You\'ve stumbled onto a page',
      ], absent: [
        '/packages/http',
        '/packages/event_bus',
        'lightweight library for parsing',
        '/packages/helium',
        '/packages/hydrogen',
        'hydrogen is a Dart package',
      ]);
    });
  });
}
