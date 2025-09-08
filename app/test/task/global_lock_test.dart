// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:appengine/appengine.dart';
import 'package:clock/clock.dart';
import 'package:pub_dev/shared/env_config.dart';
import 'package:pub_dev/task/global_lock.dart' show GlobalLock;
import 'package:test/test.dart';
import 'package:ulid/ulid.dart' show Ulid;

import '../shared/test_services.dart';

void main() {
  testWithProfile(
    'Simple GlobalLock use case',
    fn: () async {
      final lock = GlobalLock.create(
        'simple-test-${Ulid()}',
        expiration: Duration(seconds: 10),
      );

      final claim = await lock.claim();
      expect(claim.valid, isTrue);

      final claim2 = await lock.tryClaim();
      expect(claim2, isNull);

      final refreshed = await claim.refresh();
      expect(refreshed, isTrue);

      await claim.release();
      expect(claim.valid, isFalse);
    },
  );

  test(
    'Simple GlobalLock withClaim',
    () async {
      await withAppEngineServices(() async {
        final lock = GlobalLock.create(
          'simple-test-${Ulid()}',
          expiration: Duration(seconds: 3),
        );

        var running = 0;
        await Future.wait([
          Future.microtask(() async {
            await lock.withClaim((claim) async {
              running++;
              expect(running, equals(1));
              expect(claim.valid, isTrue);
              expect(claim.expires.isAfter(clock.now().toUtc()), isTrue);

              final oldExpires = claim.expires;
              await Future.delayed(Duration(seconds: 5));
              expect(running, equals(1));
              expect(claim.valid, isTrue);
              expect(claim.expires.isAfter(clock.now().toUtc()), isTrue);
              expect(claim.expires != oldExpires, isTrue);
              running--;
            });
          }),
          Future.microtask(() async {
            await lock.withClaim((claim) async {
              running++;
              expect(running, equals(1));
              expect(claim.valid, isTrue);
              expect(claim.expires.isAfter(clock.now().toUtc()), isTrue);

              final oldExpires = claim.expires;
              await Future.delayed(Duration(seconds: 3));
              expect(running, equals(1));
              expect(claim.valid, isTrue);
              expect(claim.expires.isAfter(clock.now().toUtc()), isTrue);
              expect(claim.expires != oldExpires, isTrue);
              running--;
            });
          }),
        ]);
      });
    },
    skip:
        envConfig.googleCloudProject != null &&
            envConfig.googleCloudProject!.isNotEmpty &&
            // Avoid running against production by accident
            envConfig.googleCloudProject != 'dartlang-pub'
        ? false
        : 'GlobalLock testing requires GOOGLE_CLOUD_PROJECT',
  );
}
