// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dartlang_org/frontend/static_files.dart';

import '../../shared/handlers_test_utils.dart';
import '../../shared/test_services.dart';

import '_utils.dart';

void main() {
  setUpAll(() => updateLocalBuiltFiles());

  group('ui', () {
    testWithServices('/packages/foobar_pkg - found', () async {
      await expectHtmlResponse(
        await issueGet('/packages/foobar_pkg'),
        present: [
          '<h2 class="title">foobar_pkg 0.1.1+5</h2>',
          '<a href="/packages/foobar_pkg">0.1.1+5</a>',
          '<a href="/packages/foobar_pkg/versions/0.2.0-dev">0.2.0-dev</a>',
          '<li class="tab-link -hidden" data-name="-admin-tab-" role="button">',
        ],
        absent: [
          '<li class="tab-button -active" data-name="-admin-tab-" role="button">',
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

    testWithServices('/packages/foobar_pkg/versions/0.1.1 - found', () async {
      await expectHtmlResponse(
        await issueGet('/packages/foobar_pkg/versions/0.1.1+5'),
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
            '/packages/foobar_pkg#-versions-tab-');
      },
    );

    testWithServices(
      '/packages/foobar_pkg/admin',
      () async {
        await expectHtmlResponse(
          await issueGet('/packages/foobar_pkg/admin'),
          present: [
            '<li class="tab-button -active" data-name="-admin-tab-" role="button">',
          ],
          absent: [
            '<li class="tab-link -hidden" data-name="-admin-tab-" role="button">',
          ],
        );
      },
    );
  });
}
