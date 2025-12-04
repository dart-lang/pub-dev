// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:pub_dev/task/cloudcompute/fakecloudcompute.dart';
import 'package:pub_dev/task/loops/delete_instances.dart';
import 'package:test/test.dart';

void main() {
  group('task scan: delete cloud instances', () {
    final referenceNow = clock.now();

    test('fresh instance is not deleted', () async {
      await withClock(Clock.fixed(referenceNow), () async {
        final cloudCompute = FakeCloudCompute.noop();
        cloudCompute.fakeCreateRunningInstance(
          zone: 'zone-a',
          instanceName: 'a',
          ago: Duration(minutes: 18),
        );
        final next = await scanAndDeleteInstances(
          DeleteInstancesState.init(),
          cloudCompute,
          () => false,
          maxTaskRunHours: 1,
        );
        expect(next.deletions, isEmpty);
        expect(await cloudCompute.listInstances().toList(), hasLength(1));
      });
    });

    test('old instance is deleted', () async {
      await withClock(Clock.fixed(referenceNow), () async {
        final cloudCompute = FakeCloudCompute.noop();
        cloudCompute.fakeCreateRunningInstance(
          zone: 'zone-a',
          instanceName: 'a',
          ago: Duration(minutes: 78),
        );

        final next = await scanAndDeleteInstances(
          DeleteInstancesState.init(),
          cloudCompute,
          () => false,
          maxTaskRunHours: 1,
        );
        expect(next.deletions, hasLength(1));
        expect(next.deletions.containsKey('a'), isTrue);
        expect(await cloudCompute.listInstances().toList(), isEmpty);
      });
    });

    test('terminated instance is deleted', () async {
      await withClock(Clock.fixed(referenceNow), () async {
        final cloudCompute = FakeCloudCompute.noop();
        cloudCompute.fakeCreateRunningInstance(
          zone: 'zone-a',
          instanceName: 'a',
          ago: Duration(minutes: 18),
          isTerminated: true,
        );
        final next = await scanAndDeleteInstances(
          DeleteInstancesState.init(),
          cloudCompute,
          () => false,
          maxTaskRunHours: 1,
        );
        expect(next.deletions, hasLength(1));
        expect(next.deletions.containsKey('a'), isTrue);
        expect(await cloudCompute.listInstances().toList(), isEmpty);
      });
    });

    test('pending delete is kept within 5 minutes', () async {
      await withClock(Clock.fixed(referenceNow), () async {
        final cloudCompute = FakeCloudCompute.noop();
        cloudCompute.fakeCreateRunningInstance(
          zone: 'zone-a',
          instanceName: 'a',
          ago: Duration(minutes: 78),
        );
        final next = await scanAndDeleteInstances(
          DeleteInstancesState(deletions: {'a': clock.ago(minutes: 3)}),
          cloudCompute,
          () => false,
          maxTaskRunHours: 1,
        );
        expect(next.deletions, hasLength(1));
        expect(await cloudCompute.listInstances().toList(), hasLength(1));
      });
    });

    test('pending delete is removed after 5 minutes', () async {
      await withClock(Clock.fixed(referenceNow), () async {
        final cloudCompute = FakeCloudCompute.noop();
        cloudCompute.fakeCreateRunningInstance(
          zone: 'zone-a',
          instanceName: 'b',
          ago: Duration(minutes: 18),
        );
        final next = await scanAndDeleteInstances(
          DeleteInstancesState(deletions: {'a': clock.ago(minutes: 8)}),
          cloudCompute,
          () => false,
          maxTaskRunHours: 1,
        );
        expect(next.deletions, isEmpty);
        expect(await cloudCompute.listInstances().toList(), hasLength(1));
      });
    });

    test('pending delete is refreshed after 5 minutes', () async {
      await withClock(Clock.fixed(referenceNow), () async {
        final cloudCompute = FakeCloudCompute.noop();
        cloudCompute.fakeCreateRunningInstance(
          zone: 'zone-a',
          instanceName: 'a',
          ago: Duration(minutes: 78),
        );
        final next = await scanAndDeleteInstances(
          DeleteInstancesState(deletions: {'a': clock.ago(minutes: 8)}),
          cloudCompute,
          () => false,
          maxTaskRunHours: 1,
        );
        expect(next.deletions, hasLength(1));
        next.deletions['a']!.isAfter(clock.ago(minutes: 2));
        expect(await cloudCompute.listInstances().toList(), isEmpty);
      });
    });
  });
}
