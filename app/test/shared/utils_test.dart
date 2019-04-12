// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:test/test.dart';

import 'package:pub_dartlang_org/shared/utils.dart';

void main() {
  group('Randomize Stream', () {
    test('Single batch', () async {
      final Stream<int> randomizedStream = randomizeStream(
        Stream.fromIterable(List.generate(10, (i) => i)),
        duration: Duration(milliseconds: 100),
        random: Random(123),
      );
      expect(await randomizedStream.toList(), [4, 3, 2, 8, 7, 5, 9, 1, 0, 6]);
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
      // 0-7, 10-17 in separate batches
      expect(await valuesFuture,
          [1, 0, 7, 5, 6, 3, 4, 2, 10, 14, 11, 17, 13, 16, 15, 12]);
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
      // 0-3, 4-7, 10-13, 14-17 in separate batches
      expect(await valuesFuture,
          [3, 1, 0, 2, 4, 5, 6, 7, 11, 13, 12, 10, 16, 14, 17, 15]);
    });
  });

  group('package name validation', () {
    test('reject unknown mixed-case', () {
      expect(() => validatePackageName('myNewPackage'), throwsException);
    });

    test('accept only lower-case babylon (original author continues it)', () {
      expect(() => validatePackageName('Babylon'), throwsException);
      validatePackageName('babylon'); // does not throw
    });

    test('accept only upper-case Pong (no contact with author)', () {
      expect(() => validatePackageName('pong'), throwsException);
      validatePackageName('Pong'); // does not throw
    });

    test('reject unknown mixed-case', () {
      expect(() => validatePackageName('pong'), throwsException);
    });

    test('accept lower-case', () {
      validatePackageName('my_package'); // does not throw
    });

    test('reject reserved words', () {
      expect(() => validatePackageName('do'), throwsException);
      expect(() => validatePackageName('d_o'), throwsException);
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
}
