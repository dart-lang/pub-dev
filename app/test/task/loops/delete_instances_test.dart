// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:clock/clock.dart';
import 'package:pub_dev/task/cloudcompute/cloudcompute.dart';
import 'package:pub_dev/task/loops/delete_instances.dart';
import 'package:test/test.dart';

void main() {
  group('task scan: delete cloud instances', () {
    final referenceNow = clock.now();

    test('fresh instance is not deleted', () async {
      await withClock(Clock.fixed(referenceNow), () async {
        final deletions = <String, String>{};
        final next = await scanAndDeleteInstances(
          DeleteInstancesState.init(),
          Stream.fromIterable([
            _CloudInstance(
              instanceName: 'a',
              created: referenceNow.subtract(Duration(minutes: 18)),
            ),
          ]),
          (zone, name) async {
            deletions[name] = zone;
          },
          () => false,
          maxTaskRunHours: 1,
        );
        expect(next.instances, 1);
        expect(next.state.deletions, isEmpty);
        expect(deletions, {});
      });
    });

    test('old instance is deleted', () async {
      await withClock(Clock.fixed(referenceNow), () async {
        final deletions = <String, String>{};
        final next = await scanAndDeleteInstances(
          DeleteInstancesState.init(),
          Stream.fromIterable([
            _CloudInstance(
              instanceName: 'a',
              created: referenceNow.subtract(Duration(minutes: 78)),
            ),
          ]),
          (zone, name) async {
            deletions[name] = zone;
          },
          () => false,
          maxTaskRunHours: 1,
        );
        expect(next.instances, 1);
        expect(next.state.deletions, hasLength(1));
        expect(next.state.deletions.containsKey('a'), isTrue);

        // Wait for the async deletion to complete
        await next.state.deletions['a']!.completer.future;
        expect(deletions, {'a': 'z1'});
      });
    });

    test('terminated instance is deleted', () async {
      await withClock(Clock.fixed(referenceNow), () async {
        final deletions = <String, String>{};
        final next = await scanAndDeleteInstances(
          DeleteInstancesState.init(),
          Stream.fromIterable([
            _CloudInstance(
              instanceName: 'a',
              created: referenceNow.subtract(Duration(minutes: 18)),
              state: InstanceState.terminated,
            ),
          ]),
          (zone, name) async {
            deletions[name] = zone;
          },
          () => false,
          maxTaskRunHours: 1,
        );
        expect(next.instances, 1);
        expect(next.state.deletions, hasLength(1));
        expect(next.state.deletions.containsKey('a'), isTrue);

        // Wait for the async deletion to complete
        await next.state.deletions['a']!.completer.future;
        expect(deletions, {'a': 'z1'});
      });
    });

    test('pending delete is kept within 5 minutes', () async {
      await withClock(Clock.fixed(referenceNow), () async {
        final deletions = <String, String>{};
        final next = await scanAndDeleteInstances(
          DeleteInstancesState(
            deletions: {
              'a': DeletionInProgress(
                completer: Completer(),
                started: clock.ago(minutes: 3),
              ),
            },
          ),
          Stream.fromIterable([
            _CloudInstance(
              instanceName: 'a',
              created: referenceNow.subtract(Duration(minutes: 78)),
            ),
          ]),
          (zone, name) async {
            deletions[name] = zone;
          },
          () => false,
          maxTaskRunHours: 1,
        );
        expect(next.instances, 1);
        expect(next.state.deletions, hasLength(1));
        next.state.deletions['a']!.started.isBefore(clock.ago(minutes: 2));
        expect(deletions, {});
      });
    });

    test('pending delete is removed after 5 minutes', () async {
      await withClock(Clock.fixed(referenceNow), () async {
        final deletions = <String, String>{};
        final next = await scanAndDeleteInstances(
          DeleteInstancesState(
            deletions: {
              'a': DeletionInProgress(
                completer: Completer(),
                started: clock.ago(minutes: 8),
              ),
            },
          ),
          Stream.fromIterable([
            _CloudInstance(created: clock.now(), instanceName: 'b'),
          ]),
          (zone, name) async {
            deletions[name] = zone;
          },
          () => false,
          maxTaskRunHours: 1,
        );
        expect(next.instances, 1);
        expect(next.state.deletions, isEmpty);
        expect(deletions, {});
      });
    });

    test('pending delete is refreshed after 5 minutes', () async {
      await withClock(Clock.fixed(referenceNow), () async {
        final deletions = <String, String>{};
        final next = await scanAndDeleteInstances(
          DeleteInstancesState(
            deletions: {
              'a': DeletionInProgress(
                completer: Completer(),
                started: clock.ago(minutes: 8),
              ),
            },
          ),
          Stream.fromIterable([
            _CloudInstance(created: clock.ago(minutes: 78), instanceName: 'a'),
          ]),
          (zone, name) async {
            deletions[name] = zone;
          },
          () => false,
          maxTaskRunHours: 1,
        );
        expect(next.instances, 1);
        expect(next.state.deletions, hasLength(1));
        next.state.deletions['a']!.started.isAfter(clock.ago(minutes: 2));
        await next.state.deletions['a']!.completer.future;
        expect(deletions, {'a': 'z1'});
      });
    });
  });
}

class _CloudInstance implements CloudInstance {
  @override
  final DateTime created;
  @override
  final String instanceName;
  @override
  final InstanceState state;
  @override
  final String zone;

  _CloudInstance({
    required this.created,
    required this.instanceName,
    this.state = InstanceState.running,
    this.zone = 'z1',
  });
}
