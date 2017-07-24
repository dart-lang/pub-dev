// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:test/test.dart';

import 'package:pub_dartlang_org/shared/task_scheduler.dart';

void main() {
  final Duration millis10 = new Duration(milliseconds: 10);
  final Duration millis100 = new Duration(milliseconds: 100);

  group('Completes', () {
    test('single stream', () async {
      final iterator = new PrioritizedAsyncIterator([
        new Stream.fromFutures([
          new Future.delayed(millis10, () => 1),
          new Future.delayed(millis10, () => 2),
        ])
      ]);
      expect(await iterator.hasNext, isTrue);
      expect(await iterator.next, 1);
      expect(await iterator.hasNext, isTrue);
      expect(await iterator.next, 2);
      expect(await iterator.hasNext, isFalse);
      expect(() => iterator.next, throwsA(isException));
    });

    test('two streams', () async {
      final iterator = new PrioritizedAsyncIterator([
        new Stream.fromFutures([
          new Future.delayed(millis10, () => 1),
          new Future.delayed(millis10, () => 2),
        ]),
        new Stream.fromFutures([
          new Future.delayed(millis100, () => 100),
        ]),
      ]);
      expect(await iterator.hasNext, isTrue);
      expect(await iterator.next, 1);
      expect(await iterator.hasNext, isTrue);
      expect(await iterator.next, 2);
      expect(await iterator.hasNext, isTrue);
      expect(await iterator.next, 100);
      expect(await iterator.hasNext, isFalse);
      expect(await iterator.hasNext, isFalse);
      expect(() => iterator.next, throwsA(isException));
    });
  });

  group('Priorities', () {
    test('in mixed order', () async {
      final Completer c1 = new Completer.sync();
      final Completer c2 = new Completer.sync();
      final Completer c3 = new Completer.sync();
      final iterator = new PrioritizedAsyncIterator([
        new Stream.fromFutures([c1.future]),
        new Stream.fromFutures([c2.future, c3.future]),
      ]);
      expect(iterator.hasAvailable, isFalse);
      c2.complete(1);
      expect(await iterator.hasNext, isTrue);
      expect(iterator.hasAvailable, isTrue);
      c1.complete(100);
      c3.complete(2);
      expect(await iterator.next, 100);
      expect(await iterator.next, 1);
      expect(await iterator.next, 2);
      expect(await iterator.hasNext, isFalse);
    });
  });
}
