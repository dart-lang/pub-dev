// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:test/test.dart';

import 'package:stream_transform/stream_transform.dart';

void main() {
  var streamTypes = {
    'single subscription': () => new StreamController(),
    'broadcast': () => new StreamController.broadcast()
  };
  StreamController values;
  List emittedValues;
  bool valuesCanceled;
  bool isDone;
  List errors;
  Stream transformed;
  StreamSubscription subscription;

  Completer finishWork;
  List workArgument;

  /// Represents the async `convert` function and asserts that is is only called
  /// after the previous iteration has completed.
  Future work(List values) {
    expect(finishWork, isNull,
        reason: 'See $values befor previous work is complete');
    workArgument = values;
    finishWork = new Completer();
    finishWork.future.then((_) {
      workArgument = null;
      finishWork = null;
    }).catchError((_) {
      workArgument = null;
      finishWork = null;
    });
    return finishWork.future;
  }

  for (var streamType in streamTypes.keys) {
    group('asyncMapBuffer for stream type: [$streamType]', () {
      setUp(() {
        valuesCanceled = false;
        values = streamTypes[streamType]()
          ..onCancel = () {
            valuesCanceled = true;
          };
        emittedValues = [];
        errors = [];
        isDone = false;
        finishWork = null;
        workArgument = null;
        transformed = values.stream.transform(asyncMapBuffer(work));
        subscription = transformed
            .listen(emittedValues.add, onError: errors.add, onDone: () {
          isDone = true;
        });
      });

      test('does not emit before work finishes', () async {
        values.add(1);
        await new Future(() {});
        expect(emittedValues, isEmpty);
        expect(workArgument, [1]);
        finishWork.complete(workArgument);
        await new Future(() {});
        expect(emittedValues, [
          [1]
        ]);
      });

      test('buffers values while work is ongoing', () async {
        values.add(1);
        await new Future(() {});
        values.add(2);
        values.add(3);
        await new Future(() {});
        finishWork.complete();
        await new Future(() {});
        expect(workArgument, [2, 3]);
      });

      test('forwards errors without waiting for work', () async {
        values.add(1);
        await new Future(() {});
        values.addError('error');
        await new Future(() {});
        expect(errors, ['error']);
      });

      test('forwards errors which occur during the work', () async {
        values.add(1);
        await new Future(() {});
        finishWork.completeError('error');
        await new Future(() {});
        expect(errors, ['error']);
      });

      test('can continue handling events after an error', () async {
        values.add(1);
        await new Future(() {});
        finishWork.completeError('error');
        values.add(2);
        await new Future(() {});
        expect(workArgument, [2]);
        finishWork.completeError('another');
        await new Future(() {});
        expect(errors, ['error', 'another']);
      });

      test('does not start next work early due to an error in values',
          () async {
        values.add(1);
        await new Future(() {});
        values.addError('error');
        values.add(2);
        await new Future(() {});
        expect(errors, ['error']);
        // [work] will assert that the second iteration is not called because
        // the first has not completed.
      });

      test('cancels value subscription when output canceled', () async {
        expect(valuesCanceled, false);
        await subscription.cancel();
        expect(valuesCanceled, true);
      });

      test('closes when values end if no work is pending', () async {
        expect(isDone, false);
        await values.close();
        await new Future(() {});
        expect(isDone, true);
      });

      test('waits for pending work when values close', () async {
        values.add(1);
        await new Future(() {});
        expect(isDone, false);
        values.add(2);
        await values.close();
        expect(isDone, false);
        finishWork.complete(null);
        await new Future(() {});
        // Still a pending value
        expect(isDone, false);
        finishWork.complete(null);
        await new Future(() {});
        expect(isDone, true);
      });

      test('forwards errors from values', () async {
        values.addError('error');
        await new Future(() {});
        expect(errors, ['error']);
      });

      if (streamType == 'broadcast') {
        test('multiple listeners all get values', () async {
          var otherValues = [];
          transformed.listen(otherValues.add);
          values.add(1);
          await new Future(() {});
          finishWork.complete('result');
          await new Future(() {});
          expect(emittedValues, ['result']);
          expect(otherValues, ['result']);
        });

        test('multiple listeners get done when values end', () async {
          var otherDone = false;
          transformed.listen(null, onDone: () => otherDone = true);
          values.add(1);
          await new Future(() {});
          await values.close();
          expect(isDone, false);
          expect(otherDone, false);
          finishWork.complete();
          await new Future(() {});
          expect(isDone, true);
          expect(otherDone, true);
        });

        test('can cancel and relisten', () async {
          values.add(1);
          await new Future(() {});
          finishWork.complete('first');
          await new Future(() {});
          await subscription.cancel();
          values.add(2);
          await new Future(() {});
          subscription = transformed.listen(emittedValues.add);
          values.add(3);
          await new Future(() {});
          expect(workArgument, [3]);
          finishWork.complete('second');
          await new Future(() {});
          expect(emittedValues, ['first', 'second']);
        });
      }
    });
  }
}
