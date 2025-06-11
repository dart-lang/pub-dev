// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:pub_dev/shared/utils.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';

void main() {
  group('uuid', () {
    test('format known UUId', () {
      expect(createUuid(List<int>.filled(16, 0)),
          '00000000-0000-4000-8000-000000000000');
      expect(
          createUuid(
              [11, 111, 22, 222, 33, 3, 44, 4, 55, 5, 66, 6, 77, 7, 88, 8]),
          '0b6f16de-2103-4c04-b705-42064d075808');
      expect(createUuid(List<int>.filled(16, 255)),
          'ffffffff-ffff-4fff-bfff-ffffffffffff');
    });

    test('random uuid', () {
      final uuidRegexp = RegExp(
          r'^[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[8-9A-B][0-9A-F]{3}-[0-9A-F]{12}$',
          caseSensitive: false);
      expect(createUuid(), matches(uuidRegexp));
    });
  });

  group('semantic versions', () {
    test('latest of empty version list', () {
      expect(<Version>[].latestVersion, isNull);
    });

    test('latest of a mixed values', () {
      final versions = [
        '1.0.0',
        '1.2.0',
        '2.0.0-beta',
        '1.1.0',
      ].map((e) => Version.parse(e));
      expect(versions.latestVersion.toString(), '1.2.0');
    });

    test('priority order', () {
      int compare(String a, String b) {
        return compareSemanticVersionsDesc(
            Version.parse(a), Version.parse(b), true, true);
      }

      expect(compare('2.0.0', '1.9.0'), -1);
      expect(compare('2.0.0', '1.9.0-dev'), -1);
      expect(compare('2.0.0-dev', '1.9.0-dev'), -1);
      expect(compare('2.0.0-dev', '1.9.0'), 1);
    });
  });

  group('DecayingMaxLatencyTracker', () {
    late final DateTime now;

    DateTime _nowPlus(int seconds) => now.add(Duration(seconds: seconds));

    test('decays', () {
      final tracker =
          DecayingMaxLatencyTracker(halfLifePeriod: Duration(seconds: 10));
      now = clock.now();
      tracker.observe(Duration(seconds: 40), now: now);
      expect(tracker.getLatency(now: now).inMilliseconds, 40000);
      expect(tracker.getLatency(now: _nowPlus(10)).inMilliseconds, 20000);
      expect(tracker.getLatency(now: _nowPlus(20)).inMilliseconds, 10000);
      tracker.observe(Duration(seconds: 20), now: _nowPlus(25));
      expect(tracker.getLatency().inMilliseconds, greaterThan(15000));
    });
  });

  group('top-k sorted list', () {
    int compare(int a, int b) => -a.compareTo(b);

    test('no items', () {
      final builder = TopKSortedListBuilder(5, compare);
      expect(builder.getTopK().toList(), []);
    });

    test('single item', () {
      final builder = TopKSortedListBuilder(5, compare);
      builder.add(1);
      expect(builder.getTopK().toList(), [1]);
    });

    test('three items ascending', () {
      final builder = TopKSortedListBuilder(5, compare);
      builder.addAll([1, 2, 3]);
      expect(builder.getTopK().toList(), [3, 2, 1]);
    });

    test('three items descending', () {
      final builder = TopKSortedListBuilder(5, compare);
      builder.addAll([3, 2, 1]);
      expect(builder.getTopK().toList(), [3, 2, 1]);
    });

    test('10 items + repeated', () {
      final builder = TopKSortedListBuilder(5, compare);
      builder.addAll([1, 10, 2, 9, 3, 8, 4, 7, 6, 5, 9]);
      expect(builder.getTopK().toList(), [10, 9, 9, 8, 7]);
    });
  });
}
