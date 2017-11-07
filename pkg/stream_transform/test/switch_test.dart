import 'package:test/test.dart';
import 'dart:async';

import 'package:stream_transform/stream_transform.dart';

void main() {
  var streamTypes = {
    'single subscription': () => new StreamController(),
    'broadcast': () => new StreamController.broadcast()
  };
  for (var outerType in streamTypes.keys) {
    for (var innerType in streamTypes.keys) {
      group('Outer type: [$outerType], Inner type: [$innerType]', () {
        StreamController first;
        StreamController second;
        StreamController outer;

        List emittedValues;
        bool firstCanceled;
        bool outerCanceled;
        bool isDone;
        List errors;
        StreamSubscription subscription;

        setUp(() async {
          firstCanceled = false;
          outerCanceled = false;
          outer = streamTypes[outerType]()
            ..onCancel = () {
              outerCanceled = true;
            };
          first = streamTypes[innerType]()
            ..onCancel = () {
              firstCanceled = true;
            };
          second = streamTypes[innerType]();
          emittedValues = [];
          errors = [];
          isDone = false;
          subscription = outer.stream
              .transform(switchLatest())
              .listen(emittedValues.add, onError: errors.add, onDone: () {
            isDone = true;
          });
        });

        test('forwards events', () async {
          outer.add(first.stream);
          await new Future(() {});
          first.add(1);
          first.add(2);
          await new Future(() {});

          outer.add(second.stream);
          await new Future(() {});
          second.add(3);
          second.add(4);
          await new Future(() {});

          expect(emittedValues, [1, 2, 3, 4]);
        });

        test('forwards errors from outer Stream', () async {
          outer.addError('error');
          await new Future(() {});
          expect(errors, ['error']);
        });

        test('forwards errors from inner Stream', () async {
          outer.add(first.stream);
          await new Future(() {});
          first.addError('error');
          await new Future(() {});
          expect(errors, ['error']);
        });

        test('closes when final stream is done', () async {
          outer.add(first.stream);
          await new Future(() {});

          outer.add(second.stream);
          await new Future(() {});

          await outer.close();
          expect(isDone, false);

          await second.close();
          expect(isDone, true);
        });

        test(
            'closes when outer stream closes if latest inner stream already '
            'closed', () async {
          outer.add(first.stream);
          await new Future(() {});
          await first.close();
          expect(isDone, false);

          await outer.close();
          expect(isDone, true);
        });

        test('cancels listeners on previous streams', () async {
          outer.add(first.stream);
          await new Future(() {});

          outer.add(second.stream);
          await new Future(() {});
          expect(firstCanceled, true);
        });

        test('cancels listener on current and outer stream on cancel',
            () async {
          outer.add(first.stream);
          await new Future(() {});
          await subscription.cancel();

          await new Future(() {});
          expect(outerCanceled, true);
          expect(firstCanceled, true);
        });
      });
    }
  }

  group('switchMap', () {
    test('uses map function', () async {
      var outer = new StreamController();

      var values = [];
      outer.stream
          .transform(switchMap((l) => new Stream.fromIterable(l)))
          .listen(values.add);

      outer.add([1, 2, 3]);
      await new Future(() {});
      outer.add([4, 5, 6]);
      await new Future(() {});
      expect(values, [1, 2, 3, 4, 5, 6]);
    });

    test('can create a broadcast stream', () async {
      var outer = new StreamController.broadcast();

      var transformed = outer.stream.transform(switchMap(null));

      expect(transformed.isBroadcast, true);
    });
  });
}
