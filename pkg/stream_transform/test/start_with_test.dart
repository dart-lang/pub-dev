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
  Stream transformed;
  StreamSubscription subscription;

  List emittedValues;
  bool isDone;

  setupForStreamType(String streamType, StreamTransformer transformer) {
    emittedValues = [];
    isDone = false;
    values = streamTypes[streamType]();
    transformed = values.stream.transform(transformer);
    subscription =
        transformed.listen(emittedValues.add, onDone: () => isDone = true);
  }

  for (var streamType in streamTypes.keys) {
    group('startWith then [$streamType]', () {
      setUp(() => setupForStreamType(streamType, startWith(1)));

      test('outputs all values', () async {
        values..add(2)..add(3);
        await new Future(() {});
        expect(emittedValues, [1, 2, 3]);
      });

      test('outputs initial when followed by empty stream', () async {
        await values.close();
        expect(emittedValues, [1]);
      });

      test('closes with values', () async {
        expect(isDone, false);
        await values.close();
        expect(isDone, true);
      });

      if (streamType == 'broadcast') {
        test('can cancel and relisten', () async {
          values.add(2);
          await new Future(() {});
          await subscription.cancel();
          subscription = transformed.listen(emittedValues.add);
          values.add(3);
          await new Future(() {});
          await new Future(() {});
          expect(emittedValues, [1, 2, 3]);
        });
      }
    });

    group('startWithMany then [$streamType]', () {
      setUp(() async {
        setupForStreamType(streamType, startWithMany([1, 2]));
        // Ensure all initial values go through
        await new Future(() {});
      });

      test('outputs all values', () async {
        values..add(3)..add(4);
        await new Future(() {});
        expect(emittedValues, [1, 2, 3, 4]);
      });

      test('outputs initial when followed by empty stream', () async {
        await values.close();
        expect(emittedValues, [1, 2]);
      });

      test('closes with values', () async {
        expect(isDone, false);
        await values.close();
        expect(isDone, true);
      });

      if (streamType == 'broadcast') {
        test('can cancel and relisten', () async {
          values.add(3);
          await new Future(() {});
          await subscription.cancel();
          subscription = transformed.listen(emittedValues.add);
          values.add(4);
          await new Future(() {});
          expect(emittedValues, [1, 2, 3, 4]);
        });
      }
    });

    for (var startingStreamType in streamTypes.keys) {
      group('startWithStream [$startingStreamType] then [$streamType]', () {
        StreamController starting;
        setUp(() async {
          starting = streamTypes[startingStreamType]();
          setupForStreamType(streamType, startWithStream(starting.stream));
        });

        test('outputs all values', () async {
          starting..add(1)..add(2);
          await starting.close();
          values..add(3)..add(4);
          await new Future(() {});
          expect(emittedValues, [1, 2, 3, 4]);
        });

        test('closes with values', () async {
          expect(isDone, false);
          await starting.close();
          expect(isDone, false);
          await values.close();
          expect(isDone, true);
        });

        if (streamType == 'broadcast') {
          test('can cancel and relisten during starting', () async {
            starting.add(1);
            await new Future(() {});
            await subscription.cancel();
            subscription = transformed.listen(emittedValues.add);
            starting.add(2);
            await starting.close();
            values..add(3)..add(4);
            await new Future(() {});
            expect(emittedValues, [1, 2, 3, 4]);
          });

          test('can cancel and relisten during values', () async {
            starting..add(1)..add(2);
            await starting.close();
            values.add(3);
            await new Future(() {});
            await subscription.cancel();
            subscription = transformed.listen(emittedValues.add);
            values.add(4);
            await new Future(() {});
            expect(emittedValues, [1, 2, 3, 4]);
          });
        }
      });
    }
  }
}
