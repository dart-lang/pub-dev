// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/frontend/request_context.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:test/test.dart';

import '../shared/test_models.dart';
import '../shared/test_services.dart';
import 'backend_test_utils.dart';

void main() {
  final refTime = clock.now().subtract(Duration(days: 2));

  group('Upload rate limit', () {
    Future<void> upload({
      required String version,
      required Duration time,
    }) async {
      final pubspecContent = '''name: new_package
version: $version
author: $userAtPubDevEmail
homepage: https://github.com/example/package
description: 'my package description'
environment:
  sdk: '>=2.19.0 <3.0.0'
''';
      final uploadId = await createPubApiClient(authToken: userClientToken)
          .preparePackageUpload(
              await packageArchiveBytes(pubspecContent: pubspecContent));
      await accountBackend.withBearerToken(
        userClientToken,
        () async {
          await withClock(
            Clock.fixed(refTime.add(time)),
            () async {
              registerRequestContext(RequestContext(checkRateLimits: true));
              await packageBackend.publishUploadedBlob(uploadId);
            },
          );
        },
      );
    }

    testWithProfile(
      '1 per minute',
      testProfile: TestProfile(packages: [], defaultUser: adminAtPubDevEmail),
      fn: () async {
        await upload(version: '1.0.0', time: Duration.zero);
        final rs = upload(version: '1.0.1', time: Duration(seconds: 1));
        await expectLater(
          rs,
          throwsA(
            isA<PackageRejectedException>().having(
              (e) => e.message,
              'message',
              contains(
                  'has reached the rate limit of 1 uploads in one minute.'),
            ),
          ),
        );
        await upload(version: '1.0.1', time: Duration(minutes: 2));
      },
    );

    testWithProfile(
      '12 per hour',
      testProfile: TestProfile(packages: [], defaultUser: adminAtPubDevEmail),
      fn: () async {
        for (var i = 0; i < 12; i++) {
          await upload(version: '1.0.$i', time: Duration(minutes: i * 2));
        }

        final rs = upload(version: '1.0.12', time: Duration(minutes: 12 * 2));
        await expectLater(
          rs,
          throwsA(
            isA<PackageRejectedException>().having(
              (e) => e.message,
              'message',
              contains('has reached the rate limit of 12 uploads in one hour.'),
            ),
          ),
        );
        await upload(version: '1.0.12', time: Duration(hours: 1, minutes: 1));
      },
    );

    testWithProfile(
      '24 per day',
      testProfile: TestProfile(packages: [], defaultUser: adminAtPubDevEmail),
      fn: () async {
        for (var i = 0; i < 24; i++) {
          await upload(version: '1.0.$i', time: Duration(minutes: i * 10));
        }

        final rs = upload(version: '1.0.24', time: Duration(minutes: 24 * 10));
        await expectLater(
          rs,
          throwsA(
            isA<PackageRejectedException>().having(
              (e) => e.message,
              'message',
              contains('has reached the rate limit of 24 uploads in one day.'),
            ),
          ),
        );
        await upload(version: '1.0.24', time: Duration(days: 1, minutes: 1));
      },
    );
  });
}
