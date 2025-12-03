// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:pub_dev/task/cloudcompute/cloudcompute.dart';
import 'package:pub_dev/task/cloudcompute/zone_tracker.dart';
import 'package:test/test.dart';

void main() {
  group('ComputeZoneTracker', () {
    test('no zones provided', () {
      final tracker = ComputeZoneTracker([]);
      expect(tracker.hasAvailableZone(), false);
      expect(tracker.tryPickZone(), null);
    });

    test('unrelated zone gets banned', () {
      final tracker = ComputeZoneTracker(['a']);
      expect(tracker.hasAvailableZone(), true);
      expect(tracker.tryPickZone(), 'a');
      expect(tracker.tryPickZone(), 'a');

      tracker.banZone('b', minutes: 2);
      expect(tracker.tryPickZone(), 'a');
    });

    test('single zone gets banned and ban expires', () {
      final tracker = ComputeZoneTracker(['a']);
      expect(tracker.hasAvailableZone(), true);
      expect(tracker.tryPickZone(), 'a');
      expect(tracker.tryPickZone(), 'a');

      tracker.banZone('a', minutes: 2);
      expect(tracker.tryPickZone(), null);

      withClock(Clock.fixed(clock.fromNow(minutes: 3)), () {
        expect(tracker.tryPickZone(), 'a');
      });
    });

    test('round robin with one zone banned', () {
      final tracker = ComputeZoneTracker(['a', 'b', 'c']);
      expect(tracker.hasAvailableZone(), true);
      expect(tracker.tryPickZones(7), ['a', 'b', 'c', 'a', 'b', 'c', 'a']);

      tracker.banZone('b', minutes: 2);
      expect(tracker.tryPickZones(5), ['c', 'a', 'c', 'a', 'c']);

      withClock(Clock.fixed(clock.fromNow(minutes: 30)), () {
        expect(tracker.tryPickZones(5), ['a', 'b', 'c', 'a', 'b']);
      });
    });

    test('ZoneExhaustedException bans single zone', () async {
      final tracker = ComputeZoneTracker(['a', 'b', 'c']);
      await tracker.withZoneAndInstance(
        'a',
        'instance-a',
        () => throw ZoneExhaustedException('a', 'exhausted'),
      );
      expect(tracker.tryPickZones(6), ['b', 'c', 'b', 'c', 'b', 'c']);

      withClock(Clock.fixed(clock.fromNow(minutes: 30)), () {
        expect(tracker.tryPickZones(5), ['a', 'b', 'c', 'a', 'b']);
      });
    });

    test('QuotaExhaustedException bans all zones', () async {
      final tracker = ComputeZoneTracker(['a', 'b', 'c']);
      await tracker.withZoneAndInstance(
        'a',
        'instance-a',
        () => throw QuotaExhaustedException('exhausted'),
      );
      expect(tracker.hasAvailableZone(), isFalse);
      expect(tracker.tryPickZones(2), [null, null]);

      withClock(Clock.fixed(clock.fromNow(minutes: 30)), () {
        expect(tracker.tryPickZones(5), ['a', 'b', 'c', 'a', 'b']);
      });
    });

    test('generic Exception bans single zone', () async {
      final tracker = ComputeZoneTracker(['a', 'b', 'c']);
      await tracker.withZoneAndInstance(
        'a',
        'instance-a',
        () => throw Exception('unrelated'),
      );
      expect(tracker.tryPickZones(6), ['b', 'c', 'b', 'c', 'b', 'c']);

      withClock(Clock.fixed(clock.fromNow(minutes: 30)), () {
        expect(tracker.tryPickZones(5), ['a', 'b', 'c', 'a', 'b']);
      });
    });
  });
}
