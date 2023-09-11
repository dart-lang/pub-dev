// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:test/test.dart';

import '../frontend/handlers/_utils.dart';
import '../shared/test_services.dart';

void main() {
  group('doc url resolution', () {
    final _testProfile = TestProfile(
      defaultUser: 'admin@pub.dev',
      packages: [
        TestPackage(
          name: 'oxygen',
          versions: [
            TestVersion(version: '1.0.0'),
            TestVersion(version: '2.0.0'),
          ],
        ),
      ],
      users: [TestUser(email: 'admin@pub.dev', likes: [])],
    );

    testWithProfile(
      'doc url redirects',
      fn: () async {
        final segments = ['1.0.0', '2.0.0', 'latest'];
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
  });
}
