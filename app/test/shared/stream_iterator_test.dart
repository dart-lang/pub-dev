// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:test/test.dart';

import 'package:pub_dartlang_org/shared/task_scheduler.dart';

void main() {
  final Duration millis10 = new Duration(milliseconds: 10);
  final Duration millis100 = new Duration(milliseconds: 100);

  group('Initialization', () {
    test('Calling current without moveNext().', () async {
      final Completer c = new Completer();
      final iterator = new PrioritizedStreamIterator([
        new Stream.fromFutures([c.future]),
      ]);
      expect(() => iterator.current, throwsStateError);
      c.complete();
      expect(() => iterator.current, throwsStateError);
      expect(await iterator.moveNext(), isTrue);
      expect(iterator.current, isNull);
      expect(await iterator.moveNext(), isFalse);
    });

    test('Calling moveNext() while another is being evaluated.', () async {
      final Completer c = new Completer();
      final iterator = new PrioritizedStreamIterator([
        new Stream.fromFutures([c.future]),
      ]);
      final Future f = iterator.moveNext();
      expect(() => iterator.moveNext(), throwsStateError);
      c.complete();
      expect(await f, isTrue);
      expect(iterator.current, isNull);
      expect(await iterator.moveNext(), isFalse);
    });
  });

  group('Completes', () {
    test('single stream', () async {
      final iterator = new PrioritizedStreamIterator([
        new Stream.fromFutures([
          new Future.delayed(millis10, () => 1),
          new Future.delayed(millis10, () => 2),
        ])
      ]);
      expect(await iterator.moveNext(), isTrue);
      expect(iterator.current, 1);
      expect(await iterator.moveNext(), isTrue);
      expect(iterator.current, 2);
      expect(await iterator.moveNext(), isFalse);
      expect(() => iterator.current, throwsStateError);
    });

    test('two streams', () async {
      final iterator = new PrioritizedStreamIterator([
        new Stream.fromFutures([
          new Future.delayed(millis10, () => 1),
          new Future.delayed(millis10, () => 2),
        ]),
        new Stream.fromFutures([
          new Future.delayed(millis100, () => 100),
        ]),
      ]);
      expect(await iterator.moveNext(), isTrue);
      expect(iterator.current, 1);
      expect(await iterator.moveNext(), isTrue);
      expect(iterator.current, 2);
      expect(await iterator.moveNext(), isTrue);
      expect(iterator.current, 100);
      expect(await iterator.moveNext(), isFalse);
      expect(await iterator.moveNext(), isFalse);
      expect(() => iterator.current, throwsStateError);
    });
  });

  group('Priorities', () {
    test('in mixed order', () async {
      final Completer c1 = new Completer.sync();
      final Completer c2 = new Completer.sync();
      final Completer c3 = new Completer.sync();
      final iterator = new PrioritizedStreamIterator([
        new Stream.fromFutures([c1.future]),
        new Stream.fromFutures([c2.future, c3.future]),
      ]);
      c2.complete(1);
      c1.complete(100);
      c3.complete(2);
      expect(await iterator.moveNext(), isTrue);
      expect(iterator.current, 100);
      expect(await iterator.moveNext(), isTrue);
      expect(iterator.current, 1);
      expect(await iterator.moveNext(), isTrue);
      expect(iterator.current, 2);
      expect(await iterator.moveNext(), isFalse);
    });
  });

  group('Duplicates', () {
    test('keeps duplicates', () async {
      final iterator = new PrioritizedStreamIterator([
        new Stream.fromIterable([1, 2, 1, 2]),
      ]);
      expect(await iterator.moveNext(), isTrue);
      expect(iterator.current, 1);
      expect(await iterator.moveNext(), isTrue);
      expect(iterator.current, 2);
      expect(await iterator.moveNext(), isTrue);
      expect(iterator.current, 1);
      expect(await iterator.moveNext(), isTrue);
      expect(iterator.current, 2);
      expect(await iterator.moveNext(), isFalse);
    });

    test('removes duplicates', () async {
      final iterator = new PrioritizedStreamIterator(
        [
          new Stream.fromIterable([1, 2, 1, 2]),
        ],
        deduplicateWaiting: true,
      );
      // allow Stream listeners to be triggered
      await new Future.delayed(Duration.ZERO);
      expect(await iterator.moveNext(), isTrue);
      expect(iterator.current, 1);
      expect(await iterator.moveNext(), isTrue);
      expect(iterator.current, 2);
      expect(await iterator.moveNext(), isFalse);
    });
  });
}
