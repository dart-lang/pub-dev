// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/audit/models.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/shared/configuration.dart';
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
              await packageBackend.publishUploadedBlob(uploadId);
            },
          );
        },
      );
    }

    Future<R> _withRateLimits<R>(
        List<RateLimit> limits, FutureOr<R> Function() fn) async {
      final map = activeConfiguration.toJson();
      map['rateLimits'] = json.decode(json.encode(limits));
      final configuration = Configuration.fromJson(map);
      return await fork(() async {
        registerActiveConfiguration(configuration);
        return await fn();
      }) as R;
    }

    testWithProfile(
      '1 per minute',
      testProfile: TestProfile(packages: [], defaultUser: adminAtPubDevEmail),
      fn: () async {
        await _withRateLimits(
          [
            RateLimit(
              operation: AuditLogRecordKind.packagePublished,
              scope: RateLimitScope.package,
              burst: 1,
            ),
          ],
          () async {
            await upload(version: '1.0.0', time: Duration.zero);
            final rs = upload(version: '1.0.1', time: Duration(seconds: 16));
            await expectLater(
              rs,
              throwsA(
                isA<RateLimitException>().having(
                  (e) => e.message,
                  'message',
                  contains('(1 in the last few minutes)'),
                ),
              ),
            );
            await upload(version: '1.0.1', time: Duration(minutes: 3));
          },
        );
      },
    );

    testWithProfile(
      '12 per hour',
      testProfile: TestProfile(packages: [], defaultUser: adminAtPubDevEmail),
      fn: () async {
        await _withRateLimits(
          [
            RateLimit(
              operation: AuditLogRecordKind.packagePublished,
              scope: RateLimitScope.package,
              hourly: 12,
            ),
          ],
          () async {
            for (var i = 0; i < 12; i++) {
              await upload(version: '1.0.$i', time: Duration(minutes: i * 2));
            }

            final rs =
                upload(version: '1.0.12', time: Duration(minutes: 12 * 2));
            await expectLater(
              rs,
              throwsA(
                isA<RateLimitException>().having(
                  (e) => e.message,
                  'message',
                  contains('(12 in the last hour)'),
                ),
              ),
            );
            await upload(
                version: '1.0.12', time: Duration(hours: 1, minutes: 1));
          },
        );
      },
    );

    testWithProfile(
      '24 per day',
      testProfile: TestProfile(packages: [], defaultUser: adminAtPubDevEmail),
      fn: () async {
        await _withRateLimits(
          [
            RateLimit(
              operation: AuditLogRecordKind.packagePublished,
              scope: RateLimitScope.package,
              daily: 24,
            ),
          ],
          () async {
            for (var i = 0; i < 24; i++) {
              await upload(version: '1.0.$i', time: Duration(minutes: i * 10));
            }

            final rs =
                upload(version: '1.0.24', time: Duration(minutes: 24 * 10));
            await expectLater(
              rs,
              throwsA(
                isA<RateLimitException>().having(
                  (e) => e.message,
                  'message',
                  contains('(24 in the last day)'),
                ),
              ),
            );
            await upload(
                version: '1.0.24', time: Duration(days: 1, minutes: 1));
          },
        );
      },
    );
  });
}
