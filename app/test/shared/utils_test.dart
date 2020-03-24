// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:test/test.dart';

import 'package:pub_dev/shared/utils.dart';

void main() {
  group('Randomize Stream', () {
    test('Single batch', () async {
      final input = List.generate(10, (i) => i);
      final Stream<int> randomizedStream = randomizeStream(
        Stream.fromIterable(input),
        duration: Duration(milliseconds: 100),
        random: Random(123),
      );
      final result = await randomizedStream.toList();
      expect(input.every(result.contains), isTrue);
      expect(result, isNot(input)); // checks that items are randomized
    });

    test('Two batches', () async {
      final StreamController<int> controller = StreamController<int>();
      final Stream<int> randomizedStream = randomizeStream(
        controller.stream,
        duration: Duration(milliseconds: 100),
        random: Random(123),
      );
      final Future<List<int>> valuesFuture = randomizedStream.toList();
      List.generate(8, (i) => i).forEach(controller.add);
      await Future.delayed(Duration(milliseconds: 200));
      List.generate(8, (i) => i + 10).forEach(controller.add);
      controller.close();
      final result = await valuesFuture;
      final input = [0, 1, 2, 3, 4, 5, 6, 7, 10, 11, 12, 13, 14, 15, 16, 17];
      expect(input.every(result.contains), isTrue);
      expect(result, isNot(input)); // checks that items are randomized
    });

    test('Small slices', () async {
      final StreamController<int> controller = StreamController<int>();
      final Stream<int> randomizedStream = randomizeStream(
        controller.stream,
        duration: Duration(milliseconds: 100),
        maxPositionDiff: 4,
        random: Random(123),
      );
      final Future<List<int>> valuesFuture = randomizedStream.toList();
      List.generate(8, (i) => i).forEach(controller.add);
      List.generate(8, (i) => i + 10).forEach(controller.add);
      controller.close();
      final result = await valuesFuture;
      final input = [0, 1, 2, 3, 4, 5, 6, 7, 10, 11, 12, 13, 14, 15, 16, 17];
      expect(input.every(result.contains), isTrue);
      expect(result, isNot(input)); // checks that items are randomized
    });
  });

  group('boundedList', () {
    final numbers10 = List.generate(10, (i) => i);

    test('empty bounds', () {
      expect(boundedList(numbers10), numbers10);
    });

    test('offset only', () {
      expect(boundedList(numbers10, offset: 6), [6, 7, 8, 9]);
      expect(boundedList(numbers10, offset: 16), []);
    });

    test('limit only', () {
      expect(boundedList(numbers10, limit: 0), numbers10);
      expect(boundedList(numbers10, limit: 3), [0, 1, 2]);
      expect(boundedList(numbers10, limit: 13), numbers10);
    });

    test('offset and limit', () {
      expect(boundedList(numbers10, offset: 1, limit: 3), [1, 2, 3]);
      expect(boundedList(numbers10, offset: 9, limit: 10), [9]);
    });
  });

  group('parseCookieHeader', () {
    test('no value', () {
      expect(parseCookieHeader(null), {});
      expect(parseCookieHeader(' '), {});
    });

    test('single value', () {
      expect(parseCookieHeader('a=b'), {'a': 'b'});
    });

    test('two values', () {
      expect(parseCookieHeader('a=b; c=dd'), {'a': 'b', 'c': 'dd'});
    });
  });

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
}
