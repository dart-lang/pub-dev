import 'package:test/test.dart';
import 'dart:async';

import 'package:stream_transform/stream_transform.dart';

void main() {
  test('calls function for values', () async {
    var valuesSeen = [];
    var stream = new Stream.fromIterable([1, 2, 3]);
    await stream.transform(tap(valuesSeen.add)).last;
    expect(valuesSeen, [1, 2, 3]);
  });

  test('forwards values', () async {
    var stream = new Stream.fromIterable([1, 2, 3]);
    var values = await stream.transform(tap((_) {})).toList();
    expect(values, [1, 2, 3]);
  });

  test('calls function for errors', () async {
    var error;
    var source = new StreamController();
    source.stream
        .transform(tap((_) {}, onError: (e, st) {
          error = e;
        }))
        .listen((_) {}, onError: (_) {});
    source.addError('error');
    await new Future(() {});
    expect(error, 'error');
  });

  test('forwards errors', () async {
    var error;
    var source = new StreamController();
    source.stream.transform(tap((_) {}, onError: (e, st) {})).listen((_) {},
        onError: (e) {
      error = e;
    });
    source.addError('error');
    await new Future(() {});
    expect(error, 'error');
  });

  test('calls function on done', () async {
    var doneCalled = false;
    var source = new StreamController();
    source.stream
        .transform((tap((_) {}, onDone: () {
          doneCalled = true;
        })))
        .listen((_) {});
    await source.close();
    expect(doneCalled, true);
  });

  test('forwards only once with multiple listeners on a broadcast stream',
      () async {
    var dataCallCount = 0;
    var source = new StreamController.broadcast();
    source.stream.transform(tap((_) {
      dataCallCount++;
    }))
      ..listen((_) {})
      ..listen((_) {});
    source.add(1);
    await new Future(() {});
    expect(dataCallCount, 1);
  });

  test(
      'forwards errors only once with multiple listeners on a broadcast stream',
      () async {
    var errorCallCount = 0;
    var source = new StreamController.broadcast();
    source.stream.transform(tap((_) {}, onError: (_, __) {
      errorCallCount++;
    }))
      ..listen((_) {}, onError: (_, __) {})
      ..listen((_) {}, onError: (_, __) {});
    source.addError('error');
    await new Future(() {});
    expect(errorCallCount, 1);
  });

  test('calls onDone only once with multiple listeners on a broadcast stream',
      () async {
    var doneCallCount = 0;
    var source = new StreamController.broadcast();
    source.stream.transform(tap((_) {}, onDone: () {
      doneCallCount++;
    }))
      ..listen((_) {})
      ..listen((_) {});
    await source.close();
    expect(doneCallCount, 1);
  });

  test('forwards values to multiple listeners', () async {
    var source = new StreamController.broadcast();
    var emittedValues1 = [];
    var emittedValues2 = [];
    source.stream.transform(tap((_) {}))
      ..listen(emittedValues1.add)
      ..listen(emittedValues2.add);
    source.add(1);
    await new Future(() {});
    expect(emittedValues1, [1]);
    expect(emittedValues2, [1]);
  });
}
