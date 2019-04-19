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
