// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:test/test.dart';

import '../frontend/handlers/_utils.dart';
import '../package/backend_test_utils.dart';
import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('doc url resolution', () {
    final _testProfile = TestProfile(
      defaultUser: 'admin@pub.dev',
      packages: [
        TestPackage(
          name: 'oxygen',
          versions: [
            TestVersion(version: '1.0.0'), // won't get analyzed
            TestVersion(version: '1.1.0'), // will get analyzed
            TestVersion(version: '2.0.0'), // won't get analyzed
            TestVersion(version: '2.1.0'), // will get analyzed
          ],
        ),
      ],
      users: [TestUser(email: 'admin@pub.dev', likes: [])],
    );

    testWithProfile(
      'doc url is serving',
      fn: () async {
        final segments = ['1.1.0', '2.1.0', 'latest'];
        for (final segment in segments) {
          await expectHtmlResponse(
              await issueGet('/documentation/oxygen/$segment/'),
              present: [
                '<link rel="canonical" href="https://pub.dev/documentation/oxygen/$segment/"/>'
              ]);
        }
      },
      testProfile: _testProfile,
      processJobsWithFakeRunners: true,
    );

    testWithProfile(
      'doc url redirects',
      fn: () async {
        await expectRedirectResponse(
          await issueGet('/documentation/oxygen/1.0.0/'),
          '/documentation/oxygen/1.1.0/',
        );
        await expectRedirectResponse(
          await issueGet('/documentation/oxygen/1.0.0/x.html'),
          '/documentation/oxygen/1.1.0/x.html',
        );
        await expectRedirectResponse(
          await issueGet('/documentation/oxygen/2.0.0/'),
          '/documentation/oxygen/2.1.0/',
        );
      },
      testProfile: _testProfile,
      processJobsWithFakeRunners: true,
    );

    testWithProfile(
      'doc url missing',
      fn: () async {
        await expectNotFoundResponse(
            await issueGet('/documentation/oxygen/1.2.0/'));
        await expectNotFoundResponse(
            await issueGet('/documentation/oxygen/1.2.0/x.html'));
      },
      testProfile: _testProfile,
      processJobsWithFakeRunners: true,
    );

    testWithProfile(
      'right after new version upload',
      fn: () async {
        await createPubApiClient(authToken: adminClientToken)
            .uploadPackageBytes(await packageArchiveBytes(
                pubspecContent: generatePubspecYaml('oxygen', '2.5.0')));
        await expectRedirectResponse(
          await issueGet('/documentation/oxygen/1.0.0/'),
          '/documentation/oxygen/1.1.0/',
        );
        await expectRedirectResponse(
          await issueGet('/documentation/oxygen/2.0.0/'),
          '/documentation/oxygen/2.1.0/',
        );
        await expectRedirectResponse(
          await issueGet('/documentation/oxygen/2.5.0/'),
          '/documentation/oxygen/2.1.0/',
        );
        await expectRedirectResponse(
          await issueGet('/documentation/oxygen/latest/'),
          '/documentation/oxygen/2.1.0/',
        );
      },
      testProfile: _testProfile,
      processJobsWithFakeRunners: true,
    );
  });
}
