// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:_pub_shared/data/admin_api.dart';
import 'package:clock/clock.dart';
import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:test/test.dart';

import '../../package/backend_test_utils.dart';
import '../../shared/test_models.dart';
import '../../shared/test_services.dart';

class UserAndTime {
  final String uploaderEmail;
  final DateTime publishingTime;
  UserAndTime(this.uploaderEmail, this.publishingTime);
}

void main() {
  testWithProfile('uploader count report',
      testProfile: TestProfile.fromJson(
          {'defaultUser': 'user@domain.com', 'packages': []}), fn: () async {
    Future<void> uploadAtTime(UserAndTime userAndTime, int cnt) async {
      await withClock(Clock.fixed(userAndTime.publishingTime), () async {
        final token = createFakeAuthTokenForEmail(userAndTime.uploaderEmail,
            audience: 'fake-client-audience');
        final pubspecContent = '''
name: 'new_package_$cnt'
version: '1.2.$cnt'
author: 'Hans Juergen <hans@juergen.com>'
description: 'my package description'
environment:
  sdk: '>=2.10.0 <3.0.0'
''';
        await createPubApiClient(authToken: token).uploadPackageBytes(
          await packageArchiveBytes(pubspecContent: pubspecContent),
        );
      });
    }

    var i = 0;
    for (final t in [
      UserAndTime('user1@pub.dev',
          DateTime(2021, 12, 2)), // Before range, should not be counted.
      UserAndTime('user1@pub.dev', DateTime(2022, 1, 5)),
      UserAndTime('user1@pub.dev',
          DateTime(2022, 1, 6)), // Same user, should not be counted.
      UserAndTime('user1@pub.dev', DateTime(2022, 2, 26)),
      UserAndTime('user2@pub.dev', DateTime(2022, 2, 21)),
      UserAndTime('user3@pub.dev', DateTime(2022, 2, 22)),
      UserAndTime('user2@pub.dev', DateTime(2022, 12, 11)),
    ]) {
      await uploadAtTime(t, i);
      i++;
    }

    await withClock(Clock.fixed(DateTime(2022, 12, 13)), () async {
      final response =
          await createPubApiClient(authToken: siteAdminToken).adminInvokeAction(
        'uploader-count-report',
        AdminInvokeActionArguments(arguments: {}),
      );

      expect(response.output['report'], '''
Monthly unique uploading users:
January 2022: 1
February 2022: 3
March 2022: 0
April 2022: 0
May 2022: 0
June 2022: 0
July 2022: 0
August 2022: 0
September 2022: 0
October 2022: 0
November 2022: 0
December 2022: 1
''');
    });
  });
}
