// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:pub_dev/shared/parallel_foreach.dart';
import 'package:test/test.dart';

void main() {
  group('Notifier', () {
    test('Notifier.wait/notify', () async {
      final notified = Completer<void>();

      final notifier = Notifier();
      unawaited(notifier.wait.then((value) => notified.complete()));
      expect(notified.isCompleted, isFalse);

      notifier.notify();
      expect(notified.isCompleted, isFalse);

      await notified.future;
      expect(notified.isCompleted, isTrue);
    });

    test('Notifier.wait is never resolved', () async {
      var count = 0;

      final notifier = Notifier();
      unawaited(notifier.wait.then((value) => count++));
      expect(count, 0);

      await Future.delayed(Duration.zero);
      expect(count, 0);

      notifier.notify();
      expect(count, 0);

      await Future.delayed(Duration.zero);
      expect(count, 1);

      unawaited(notifier.wait.then((value) => count++));
      unawaited(notifier.wait.then((value) => count++));

      await Future.delayed(Duration.zero);
      expect(count, 1);

      notifier.notify();
      expect(count, 1);

      await Future.delayed(Duration.zero);
      expect(count, 3);
    });
  });

  group('parallelForEach', () {
    test('sum (maxParallel: 1)', () async {
      var sum = 0;
      await Stream.fromIterable([1, 2, 3]).parallelForEach(1, (item) {
        sum += item;
      });
      expect(sum, 6);
    });

    test('sum (maxParallel: 2)', () async {
      var sum = 0;
      var active = 0;
      var maxActive = 0;
      await Stream.fromIterable([1, 2, 3]).parallelForEach(2, (item) async {
        active++;
        expect(active, lessThanOrEqualTo(2));
        maxActive = max(active, maxActive);
        await Future.delayed(Duration(milliseconds: 50));
        expect(active, lessThanOrEqualTo(2));
        maxActive = max(active, maxActive);
        sum += item;
        active--;
      });
      expect(sum, 6);
      expect(maxActive, 2);
    });

    test('abort when error is thrown (maxParallel: 1)', () async {
      var sum = 0;
      await expectLater(
        Stream.fromIterable([1, 2, 3]).parallelForEach(1, (item) async {
          sum += item;
          if (sum > 2) {
            throw Exception('abort');
          }
        }),
        throwsException,
      );
      expect(sum, 3);
    });

    test('abort will not comsume the entire stream', () async {
      var countedTo = 0;
      Stream<int> countToN(int N) async* {
        for (var i = 1; i <= N; i++) {
          await Future.delayed(Duration.zero);
          yield i;
          countedTo = i;
        }
      }

      var sum = 0;
      await countToN(20).parallelForEach(2, (item) async {
        sum += item;
      });
      expect(sum, greaterThan(20));
      expect(countedTo, 20);

      countedTo = 0;
      await expectLater(
        countToN(20).parallelForEach(2, (item) async {
          if (item > 10) throw Exception('abort');
        }),
        throwsException,
      );
      expect(countedTo, greaterThanOrEqualTo(10));
      expect(countedTo, lessThan(20));
    });

    test('onError can ignore errors', () async {
      var countedTo = 0;
      Stream<int> countToN(int N) async* {
        for (var i = 1; i <= N; i++) {
          await Future.delayed(Duration.zero);
          yield i;
          countedTo = i;
        }
      }

      var sum = 0;
      await countToN(20).parallelForEach(2, (item) async {
        sum += item;
        if (sum > 10) {
          throw Exception('ignore this');
        }
      }, onError: (_, __) => null);
      expect(sum, greaterThan(20));
      expect(countedTo, 20);

      countedTo = 0;
      await expectLater(
        countToN(20).parallelForEach(
          2,
          (item) async {
            sum += item;
            if (countedTo > 15) {
              throw Exception('break');
            }
            if (countedTo > 10) {
              throw Exception('ignore this');
            }
          },
          onError: (e, st) {
            if (e.toString().contains('break')) {
              throw e as Exception;
            }
          },
        ),
        throwsException,
      );
      expect(countedTo, greaterThanOrEqualTo(10));
      expect(countedTo, lessThan(20));
    });
  });
}
