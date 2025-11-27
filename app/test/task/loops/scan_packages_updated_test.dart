// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:clock/clock.dart';
import 'package:pub_dev/task/loops/scan_packages_updated.dart';
import 'package:test/test.dart';

void main() {
  group('task scan: packages updated', () {
    final referenceNow = clock.now();

    test('every new package gets updated', () async {
      await withClock(Clock.fixed(referenceNow), () async {
        final state = ScanPackagesUpdatedState.init();
        final next = await calculateScanPackagesUpdatedLoop(
          state,
          Stream.fromIterable([
            (name: 'a', updated: clock.ago(minutes: 3)),
            (name: 'b', updated: clock.ago(minutes: 2)),
          ]),
          () => false,
        );
        expect(next.packages, ['a', 'b']);
        expect(next.state.seen, {
          'a': clock.ago(minutes: 3),
          'b': clock.ago(minutes: 2),
        });
        expect(next.state.since, clock.ago(minutes: 30));
        expect(next.state.nextLongerOverlap, state.nextLongerOverlap);
      });
    });

    test('some packages will be updated', () async {
      await withClock(Clock.fixed(referenceNow), () async {
        final state = ScanPackagesUpdatedState.init(
          seen: {'a': clock.ago(minutes: 5), 'b': clock.ago(minutes: 4)},
        );
        final next = await calculateScanPackagesUpdatedLoop(
          state,
          Stream.fromIterable([
            (name: 'a', updated: clock.ago(minutes: 5)), // same
            (name: 'b', updated: clock.ago(minutes: 2)), // updated
            (name: 'c', updated: clock.ago(minutes: 1)), // new
          ]),
          () => false,
        );
        expect(next.packages, ['b', 'c']);
        expect(next.state.seen, {
          'a': clock.ago(minutes: 5),
          'b': clock.ago(minutes: 2),
          'c': clock.ago(minutes: 1),
        });
      });
    });

    test('some packages are removed from seen', () async {
      await withClock(Clock.fixed(referenceNow), () async {
        final state = ScanPackagesUpdatedState.init(
          seen: {'a': clock.ago(minutes: 5), 'b': clock.ago(minutes: 40)},
        );
        final next = await calculateScanPackagesUpdatedLoop(
          state,
          Stream.empty(),
          () => false,
        );
        expect(next.packages, isEmpty);
        expect(next.state.seen, {'a': clock.ago(minutes: 5)});
      });
    });

    test('next long scan triggered', () async {
      await withClock(Clock.fixed(referenceNow), () async {
        final state = ScanPackagesUpdatedState(
          seen: {},
          since: clock.ago(minutes: 30),
          nextLongerOverlap: clock.ago(minutes: 1),
        );
        final next = await calculateScanPackagesUpdatedLoop(
          state,
          Stream.empty(),
          () => false,
        );
        expect(next.packages, isEmpty);
        expect(next.state.since, clock.ago(days: 1));
        expect(next.state.nextLongerOverlap, clock.fromNow(hours: 6));
      });
    });

    test('seen an older timestamp does trigger an update', () async {
      await withClock(Clock.fixed(referenceNow), () async {
        final state = ScanPackagesUpdatedState.init(
          seen: {'a': clock.ago(minutes: 5)},
        );
        final next = await calculateScanPackagesUpdatedLoop(
          state,
          Stream.fromIterable([(name: 'a', updated: clock.ago(minutes: 7))]),
          () => false,
        );
        expect(next.packages, ['a']);
        expect(next.state.seen, {'a': clock.ago(minutes: 7)});
      });
    });

    test('abort signal stops processing', () async {
      await withClock(Clock.fixed(referenceNow), () async {
        final state = ScanPackagesUpdatedState.init();
        var stopped = false;

        final controller =
            StreamController<({String name, DateTime updated})>();
        final nextFuture = calculateScanPackagesUpdatedLoop(
          state,
          controller.stream,
          () => stopped,
        );

        controller.add((name: 'a', updated: clock.ago(minutes: 3)));
        controller.add((name: 'b', updated: clock.ago(minutes: 2)));
        await Future.delayed(Duration(milliseconds: 200));
        stopped = true;
        controller.add((name: 'c', updated: clock.ago(minutes: 1)));
        await controller.close();

        final next = await nextFuture;
        expect(next.packages, ['a', 'b']);
        expect(next.state.seen, {
          'a': clock.ago(minutes: 3),
          'b': clock.ago(minutes: 2),
        });
      });
    });
  });
}
