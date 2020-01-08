// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dev/frontend/static_files.dart';

import '../../shared/handlers_test_utils.dart';
import '../../shared/test_services.dart';

import '_utils.dart';

void main() {
  setUpAll(() => updateLocalBuiltFilesIfNeeded());

  group('ui', () {
    testWithServices('/packages/foobar_pkg - found', () async {
      await expectHtmlResponse(
        await issueGet('/packages/foobar_pkg'),
        present: [
          '<h2 class="title">foobar_pkg 0.1.1+5</h2>',
          '<a href="/packages/foobar_pkg">0.1.1+5</a>',
          '<a href="/packages/foobar_pkg/versions/0.2.0-dev">0.2.0-dev</a>',
        ],
        absent: [
          'data-name="-admin-tab-"',
        ],
      );
    });

    testWithServices('/packages/foobar_not_found - not found', () async {
      await expectRedirectResponse(await issueGet('/packages/foobar_not_found'),
          '/packages?q=foobar_not_found');
    });

    testWithServices('/packages/foobar_pkg/versions - found', () async {
      await expectHtmlResponse(
        await issueGet('/packages/foobar_pkg/versions'),
        present: [
          '<h2 class="title">foobar_pkg 0.1.1+5</h2>',
          '<a href="/packages/foobar_pkg">0.1.1+5</a>',
          '<a href="/packages/foobar_pkg/versions/0.2.0-dev">0.2.0-dev</a>',
        ],
      );
    });

    testWithServices(
      '/packages/foobar_not_found/versions - not found',
      () async {
        await expectRedirectResponse(
            await issueGet('/packages/foobar_not_found/versions'),
            '/packages?q=foobar_not_found');
      },
    );

    testWithServices('/packages/foobar_pkg/versions/0.1.1+5 - found', () async {
      await expectHtmlResponse(
        await issueGet('/packages/foobar_pkg/versions/0.1.1+5'),
        present: [
          '<h2 class="title">foobar_pkg 0.1.1+5</h2>',
          '<a href="/packages/foobar_pkg">0.1.1+5</a>',
          '<a href="/packages/foobar_pkg/versions/0.2.0-dev">0.2.0-dev</a>',
        ],
      );
    });

    testWithServices('/packages/foobar_pkg/versions/0.1.1%2B5 - found',
        () async {
      await expectHtmlResponse(
        await issueGet('/packages/foobar_pkg/versions/0.1.1%2B5'),
        present: [
          '<h2 class="title">foobar_pkg 0.1.1+5</h2>',
          '<a href="/packages/foobar_pkg">0.1.1+5</a>',
          '<a href="/packages/foobar_pkg/versions/0.2.0-dev">0.2.0-dev</a>',
        ],
      );
    });

    testWithServices(
      '/packages/foobar_pkg/versions/0.1.2 - not found',
      () async {
        await expectRedirectResponse(
            await issueGet('/packages/foobar_pkg/versions/0.1.2'),
            '/packages/foobar_pkg/versions');
      },
    );

    testWithServices(
      '/packages/foobar_pkg/versions/xyz - bad version',
      () async {
        await expectRedirectResponse(
            await issueGet('/packages/foobar_pkg/versions/xyz'),
            '/packages/foobar_pkg/versions');
      },
    );

    testWithServices(
      '/packages/foobar_pkg/admin - without session',
      () async {
        await expectHtmlResponse(
          await issueGet('/packages/foobar_pkg/admin'),
          present: [],
          absent: [
            '<li class="tab-button -active" data-name="-admin-tab-" role="button">',
          ],
        );
      },
    );
  });
}
