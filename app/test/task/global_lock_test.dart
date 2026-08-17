// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:clock/clock.dart';
import 'package:pub_dev/task/global_lock.dart';
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

  testWithProfile(
    'Race to acquire lock with tryClaim',
    fn: () async {
      final lock = GlobalLock.create(
        'race-test-${Ulid()}',
        expiration: Duration(seconds: 10),
      );

      // concurrent attempts to claim the same lock, only one of them should succeed
      final claims = await Future.wait(
        List.generate(10, (_) => lock.tryClaim()),
      );
      final acquired = claims.whereType<GlobalLockClaim>().toList();
      expect(acquired, hasLength(1));
      expect(claims.where((c) => c == null), hasLength(9));

      await acquired.single.release();

      // another race
      final claims2 = await Future.wait(
        List.generate(10, (_) => lock.tryClaim()),
      );
      final acquired2 = claims2.whereType<GlobalLockClaim>().toList();
      expect(acquired2, hasLength(1));
      expect(claims2.where((c) => c == null), hasLength(9));

      await acquired2.single.release();
    },
  );

  testWithProfile(
    'Simple GlobalLock withClaim',
    fn: () async {
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
    },
  );

  testWithProfile(
    'Race to acquire lock with withClaim',
    fn: () async {
      final lock = GlobalLock.create(
        'controlled-test-${Ulid()}',
        expiration: Duration(seconds: 2),
      );

      const concurrency = 3;
      final started = List.generate(concurrency, (_) => Completer<void>());
      final progressed = List.generate(concurrency, (_) => Completer<void>());
      final order = <int>[];
      var running = 0;

      final futures = List.generate(concurrency, (i) {
        return lock.withClaim((claim) async {
          running++;
          expect(running, equals(1));

          final round = order.length;
          order.add(i);
          started[round].complete();

          await progressed[i].future;

          expect(running, equals(1));
          running--;
        });
      });

      for (var round = 0; round < concurrency; round++) {
        await started[round].future;
        expect(running, equals(1));
        for (var r = round + 1; r < concurrency; r++) {
          expect(started[r].isCompleted, isFalse);
        }
        progressed[order[round]].complete();
      }

      await Future.wait(futures);
      expect(order.toSet(), List.generate(concurrency, (i) => i).toSet());
    },
  );
}
