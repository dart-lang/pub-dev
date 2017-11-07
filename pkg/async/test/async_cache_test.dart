// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:async/async.dart';
import 'package:fake_async/fake_async.dart';
import 'package:test/test.dart';

void main() {
  AsyncCache<String> cache;

  setUp(() {
    // Create a cache that is fresh for an hour.
    cache = new AsyncCache(const Duration(hours: 1));
  });

  test('should fetch via a callback when no cache exists', () async {
    expect(await cache.fetch(() async => 'Expensive'), 'Expensive');
  });

  test('should not fetch via callback when a cache exists', () async {
    await cache.fetch(() async => 'Expensive');
    expect(await cache.fetch(expectAsync0(() {}, count: 0)), 'Expensive');
  });

  test('should not fetch via callback when a future is in-flight', () async {
    // No actual caching is done, just avoid duplicate requests.
    cache = new AsyncCache.ephemeral();

    var completer = new Completer<String>();
    expect(cache.fetch(() => completer.future), completion('Expensive'));
    expect(cache.fetch(expectAsync0(() {}, count: 0)), completion('Expensive'));
    await completer.complete('Expensive');
  });

  test('should fetch via a callback again when cache expires', () {
    new FakeAsync().run((fakeAsync) async {
      var timesCalled = 0;
      call() async => 'Called ${++timesCalled}';
      expect(await cache.fetch(call), 'Called 1');
      expect(await cache.fetch(call), 'Called 1', reason: 'Cache still fresh');

      fakeAsync.elapse(const Duration(hours: 1) - const Duration(seconds: 1));
      expect(await cache.fetch(call), 'Called 1', reason: 'Cache still fresh');

      fakeAsync.elapse(const Duration(seconds: 1));
      expect(await cache.fetch(call), 'Called 2');
      expect(await cache.fetch(call), 'Called 2', reason: 'Cache fresh again');

      fakeAsync.elapse(const Duration(hours: 1));
      expect(await cache.fetch(call), 'Called 3');
    });
  });

  test('should fetch via a callback when manually invalidated', () async {
    var timesCalled = 0;
    call() async => 'Called ${++timesCalled}';
    expect(await cache.fetch(call), 'Called 1');
    await cache.invalidate();
    expect(await cache.fetch(call), 'Called 2');
    await cache.invalidate();
    expect(await cache.fetch(call), 'Called 3');
  });

  test('should fetch a stream via a callback', () async {
    expect(
        await cache.fetchStream(expectAsync0(() {
          return new Stream.fromIterable(['1', '2', '3']);
        })).toList(),
        ['1', '2', '3']);
  });

  test('should not fetch stream via callback when a cache exists', () async {
    await cache.fetchStream(() async* {
      yield '1';
      yield '2';
      yield '3';
    }).toList();
    expect(await cache.fetchStream(expectAsync0(() {}, count: 0)).toList(),
        ['1', '2', '3']);
  });

  test('should not fetch stream via callback when request in flight', () async {
    // Unlike the above test, we want to verify that we don't make multiple
    // calls if a cache is being filled currently, and instead wait for that
    // cache to be completed.
    var controller = new StreamController<String>();
    Stream<String> call() => controller.stream;
    expect(cache.fetchStream(call).toList(), completion(['1', '2', '3']));
    controller.add('1');
    controller.add('2');
    await new Future.value();
    expect(cache.fetchStream(call).toList(), completion(['1', '2', '3']));
    controller.add('3');
    await controller.close();
  });

  test('should fetch stream via a callback again when cache expires', () {
    new FakeAsync().run((fakeAsync) async {
      var timesCalled = 0;
      Stream<String> call() {
        return new Stream.fromIterable(['Called ${++timesCalled}']);
      }

      expect(await cache.fetchStream(call).toList(), ['Called 1']);
      expect(await cache.fetchStream(call).toList(), ['Called 1'],
          reason: 'Cache still fresh');

      fakeAsync.elapse(const Duration(hours: 1) - const Duration(seconds: 1));
      expect(await cache.fetchStream(call).toList(), ['Called 1'],
          reason: 'Cache still fresh');

      fakeAsync.elapse(const Duration(seconds: 1));
      expect(await cache.fetchStream(call).toList(), ['Called 2']);
      expect(await cache.fetchStream(call).toList(), ['Called 2'],
          reason: 'Cache fresh again');

      fakeAsync.elapse(const Duration(hours: 1));
      expect(await cache.fetchStream(call).toList(), ['Called 3']);
    });
  });

  test('should fetch via a callback when manually invalidated', () async {
    var timesCalled = 0;
    Stream<String> call() {
      return new Stream.fromIterable(['Called ${++timesCalled}']);
    }

    expect(await cache.fetchStream(call).toList(), ['Called 1']);
    await cache.invalidate();
    expect(await cache.fetchStream(call).toList(), ['Called 2']);
    await cache.invalidate();
    expect(await cache.fetchStream(call).toList(), ['Called 3']);
  });

  test('should cancel a cached stream without affecting others', () async {
    Stream<String> call() => new Stream.fromIterable(['1', '2', '3']);

    expect(cache.fetchStream(call).toList(), completion(['1', '2', '3']));

    // Listens to the stream for the initial value, then cancels subscription.
    expect(await cache.fetchStream(call).first, '1');
  });

  test('should pause a cached stream without affecting others', () async {
    Stream<String> call() => new Stream.fromIterable(['1', '2', '3']);

    StreamSubscription sub;
    sub = cache.fetchStream(call).listen(expectAsync1((event) {
      if (event == '1') sub.pause();
    }));
    expect(cache.fetchStream(call).toList(), completion(['1', '2', '3']));
  });
}
