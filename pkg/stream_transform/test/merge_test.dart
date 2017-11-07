import 'dart:async';

import 'package:test/test.dart';

import 'package:stream_transform/stream_transform.dart';

void main() {
  group('merge', () {
    test('includes all values', () async {
      var first = new Stream.fromIterable([1, 2, 3]);
      var second = new Stream.fromIterable([4, 5, 6]);
      var allValues = await first.transform(merge(second)).toList();
      expect(allValues, containsAllInOrder([1, 2, 3]));
      expect(allValues, containsAllInOrder([4, 5, 6]));
      expect(allValues, hasLength(6));
    });

    test('cancels both sources', () async {
      var firstCanceled = false;
      var first = new StreamController()
        ..onCancel = () {
          firstCanceled = true;
        };
      var secondCanceled = false;
      var second = new StreamController()
        ..onCancel = () {
          secondCanceled = true;
        };
      var subscription =
          first.stream.transform(merge(second.stream)).listen((_) {});
      await subscription.cancel();
      expect(firstCanceled, true);
      expect(secondCanceled, true);
    });

    test('completes when both sources complete', () async {
      var first = new StreamController();
      var second = new StreamController();
      var isDone = false;
      first.stream.transform(merge(second.stream)).listen((_) {}, onDone: () {
        isDone = true;
      });
      await first.close();
      expect(isDone, false);
      await second.close();
      expect(isDone, true);
    });

    test('can cancel and relisten to broadcast stream', () async {
      var first = new StreamController.broadcast();
      var second = new StreamController();
      var emittedValues = [];
      var transformed = first.stream.transform((merge(second.stream)));
      var subscription = transformed.listen(emittedValues.add);
      first.add(1);
      second.add(2);
      await new Future(() {});
      expect(emittedValues, contains(1));
      expect(emittedValues, contains(2));
      await subscription.cancel();
      emittedValues = [];
      subscription = transformed.listen(emittedValues.add);
      first.add(3);
      second.add(4);
      await new Future(() {});
      expect(emittedValues, contains(3));
      expect(emittedValues, contains(4));
    });
  });

  group('mergeAll', () {
    test('includes all values', () async {
      var first = new Stream.fromIterable([1, 2, 3]);
      var second = new Stream.fromIterable([4, 5, 6]);
      var third = new Stream.fromIterable([7, 8, 9]);
      var allValues = await first.transform(mergeAll([second, third])).toList();
      expect(allValues, containsAllInOrder([1, 2, 3]));
      expect(allValues, containsAllInOrder([4, 5, 6]));
      expect(allValues, containsAllInOrder([7, 8, 9]));
      expect(allValues, hasLength(9));
    });

    test('handles mix of broadcast and single-subscription', () async {
      var firstCanceled = false;
      var first = new StreamController.broadcast()
        ..onCancel = () {
          firstCanceled = true;
        };
      var secondBroadcastCanceled = false;
      var secondBroadcast = new StreamController.broadcast()
        ..onCancel = () {
          secondBroadcastCanceled = true;
        };
      var secondSingleCanceled = false;
      var secondSingle = new StreamController()
        ..onCancel = () {
          secondSingleCanceled = true;
        };

      var merged = first.stream
          .transform(mergeAll([secondBroadcast.stream, secondSingle.stream]));

      var firstListenerValues = [];
      var secondListenerValues = [];

      var firstSubscription = merged.listen(firstListenerValues.add);
      var secondSubscription = merged.listen(secondListenerValues.add);

      first.add(1);
      secondBroadcast.add(2);
      secondSingle.add(3);

      await new Future(() {});
      await firstSubscription.cancel();

      expect(firstCanceled, false);
      expect(secondBroadcastCanceled, false);
      expect(secondSingleCanceled, false);

      first.add(4);
      secondBroadcast.add(5);
      secondSingle.add(6);

      await new Future(() {});
      await secondSubscription.cancel();

      await new Future(() {});
      expect(firstCanceled, true);
      expect(secondBroadcastCanceled, true);
      expect(secondSingleCanceled, false,
          reason: 'Single subscription streams merged into broadcast streams '
              'are not canceled');

      expect(firstListenerValues, [1, 2, 3]);
      expect(secondListenerValues, [1, 2, 3, 4, 5, 6]);
    });
  });
}
