// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:test/test.dart';

import '../../shared/handlers_test_utils.dart';
import '../../shared/test_services.dart';
import '_utils.dart';

void main() {
  group('ui', () {
    testWithProfile('/packages/oxygen - found', fn: () async {
      await expectHtmlResponse(
        await issueGet('/packages/oxygen'),
        present: [
          'oxygen 1.2.0',
          RegExp(r'<a href="/packages/oxygen" title=".*">1.2.0</a>'),
          RegExp(
              r'<a href="/packages/oxygen/versions/2.0.0-dev" title=".*">2.0.0-dev</a>'),
        ],
        absent: [
          'data-name="-admin-tab-"',
        ],
      );
    });

    testWithProfile('package name and version redirects', fn: () async {
      await expectRedirectResponse(
          await issueGet('/packages/oxYgen'), '/packages/oxygen');
      await expectRedirectResponse(await issueGet('/packages/oxYgen/changelog'),
          '/packages/oxygen/changelog');
      await expectRedirectResponse(await issueGet('/packages/oxYgen/versions'),
          '/packages/oxygen/versions');
      await expectRedirectResponse(
          await issueGet('/packages/oxYgen/versions/1.2.0/changelog'),
          '/packages/oxygen/versions/1.2.0/changelog');
      await expectRedirectResponse(
          await issueGet('/packages/oxygen/versions/1.2.00/changelog'),
          '/packages/oxygen/versions/1.2.0/changelog');
    });

    testWithProfile('withheld package - not found', fn: () async {
      final pkg = await dbService.lookupValue<Package>(
          dbService.emptyKey.append(Package, id: 'oxygen'));
      await dbService.commit(inserts: [pkg..updateIsBlocked(isBlocked: true)]);
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
          RegExp(r'<a href="/packages/oxygen" title=".*">1.2.0</a>'),
          RegExp(
              r'<a href="/packages/oxygen/versions/2.0.0-dev" title=".*">2.0.0-dev</a>'),
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
          RegExp(r'<a href="/packages/oxygen" title=".*">1.2.0</a>'),
          RegExp(
              r'<a href="/packages/oxygen/versions/2.0.0-dev" title=".*">2.0.0-dev</a>'),
        ],
      );
    });

    testWithProfile('/packages/oxygen/versions/2.0.0%2Ddev - found',
        fn: () async {
      await expectHtmlResponse(
        await issueGet('/packages/oxygen/versions/2.0.0%2Ddev'),
        present: [
          'oxygen 2.0.0-dev',
          RegExp(r'<a href="/packages/oxygen" title=".*">1.2.0</a>'),
          RegExp(
              r'<a href="/packages/oxygen/versions/2.0.0-dev" title=".*">2.0.0-dev</a>'),
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
        final rs = await issueGet('/packages/oxygen/versions/xyz');
        expect(rs.statusCode, 400);
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

    testWithProfile(
      'package pages without homepage',
      testProfile: TestProfile(
        packages: [
          TestPackage(
              name: 'pkg',
              versions: [TestVersion(version: '1.0.0-nohomepage')]),
        ],
        defaultUser: 'admin@pub.dev',
      ),
      processJobsWithFakeRunners: true,
      fn: () async {
        final urls = [
          '/packages/pkg',
          '/packages/pkg/changelog',
          '/packages/pkg/example',
          '/packages/pkg/versions',
          '/packages/pkg/pubspec',
          '/packages/pkg/license',
          '/packages/pkg/score',
        ];
        for (final url in urls) {
          await expectHtmlResponse(
            await issueGet(url),
            present: [],
            absent: [
              'Homepage',
            ],
          );
        }
      },
    );

    testWithProfile(
      'publisher redirect',
      fn: () async {
        await expectRedirectResponse(
          await issueGet('/packages/neon/publisher'),
          '/publishers/example.com',
        );
      },
    );

    testWithProfile(
      'publisher redirect - no publisher',
      fn: () async {
        await expectRedirectResponse(
          await issueGet('/packages/oxygen/publisher'),
          '/packages/oxygen',
        );
      },
    );
  });
}
