// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';
import 'package:test/test.dart';

import 'package:pub_dev/frontend/static_files.dart';
import 'package:pub_dev/package/models.dart';

import '../../shared/handlers_test_utils.dart';
import '../../shared/test_services.dart';

import '_utils.dart';

void main() {
  setUpAll(() => updateLocalBuiltFilesIfNeeded());

  group('ui', () {
    testWithProfile('/packages/oxygen - found', fn: () async {
      await expectHtmlResponse(
        await issueGet('/packages/oxygen'),
        present: [
          'oxygen 1.2.0',
          '<a href="/packages/oxygen">1.2.0</a>',
          '<a href="/packages/oxygen/versions/2.0.0-dev">2.0.0-dev</a>',
        ],
        absent: [
          'data-name="-admin-tab-"',
        ],
      );
    });

    testWithProfile('withheld package - not found', fn: () async {
      final pkg = await dbService.lookupValue<Package>(
          dbService.emptyKey.append(Package, id: 'oxygen'));
      await dbService.commit(inserts: [pkg..isWithheld = true]);
      await expectNotFoundResponse(await issueGet('/packages/oxygen'));
      await expectNotFoundResponse(await issueGet('/packages/oxygen/score'));
      await expectNotFoundResponse(await issueGet('/packages/oxygen/versions'));
      await expectNotFoundResponse(
          await issueGet('/packages/oxygen/versions/${pkg.latestVersion}'));
      await expectNotFoundResponse(await issueGet(
          '/packages/oxygen/versions/${pkg.latestVersion}/score'));
    });

    testWithProfile('/packages/foobar_not_found - not found', fn: () async {
      await expectNotFoundResponse(
          await issueGet('/packages/foobar_not_found'));
    });

    testWithProfile('/packages/oxygen/versions - found', fn: () async {
      await expectHtmlResponse(
        await issueGet('/packages/oxygen/versions'),
        present: [
          'oxygen 1.2.0',
          '<a href="/packages/oxygen">1.2.0</a>',
          '<a href="/packages/oxygen/versions/2.0.0-dev">2.0.0-dev</a>',
        ],
      );
    });

    testWithProfile(
      '/packages/foobar_not_found/versions - not found',
      fn: () async {
        await expectNotFoundResponse(
            await issueGet('/packages/foobar_not_found/versions'));
      },
    );

    testWithProfile('/packages/oxygen/versions/1.0.0 - found', fn: () async {
      await expectHtmlResponse(
        await issueGet('/packages/oxygen/versions/1.0.0'),
        present: [
          'oxygen 1.0.0',
          '<a href="/packages/oxygen">1.2.0</a>',
          '<a href="/packages/oxygen/versions/2.0.0-dev">2.0.0-dev</a>',
        ],
      );
    });

    testWithProfile('/packages/oxygen/versions/2.0.0%2Ddev - found',
        fn: () async {
      await expectHtmlResponse(
        await issueGet('/packages/oxygen/versions/2.0.0%2Ddev'),
        present: [
          'oxygen 2.0.0-dev',
          '<a href="/packages/oxygen">1.2.0</a>',
          '<a href="/packages/oxygen/versions/2.0.0-dev">2.0.0-dev</a>',
        ],
      );
    });

    testWithProfile(
      '/packages/oxygen/versions/0.1.2 - not found',
      fn: () async {
        await expectNotFoundResponse(
            await issueGet('/packages/oxygen/versions/0.1.2'));
      },
    );

    testWithProfile(
      '/packages/oxygen/versions/xyz - bad version',
      fn: () async {
        await expectNotFoundResponse(
            await issueGet('/packages/oxygen/versions/xyz'));
      },
    );

    testWithProfile(
      '/packages/oxygen/admin - without session',
      fn: () async {
        await expectHtmlResponse(
          await issueGet('/packages/oxygen/admin'),
          present: [],
          absent: [
            '<li class="tab-button -active" data-name="-admin-tab-" role="button">',
          ],
        );
      },
    );
  });
}
