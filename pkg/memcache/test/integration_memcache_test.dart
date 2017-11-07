// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library integration_memcache_test;

import 'dart:async';

import 'package:test/test.dart';
import 'package:memcache/memcache.dart';
import 'package:memcache/memcache_raw.dart' as raw;
import 'package:memcache/src/memcache_impl.dart';

import 'memcache_native_connection_test.dart' show Memcached;

main() async {
  final Memcached memcached = await Memcached.start();
  final raw.BinaryMemcacheProtocol rawMemcache =
      new raw.BinaryMemcacheProtocol('127.0.0.1', memcached.port);
  final Memcache memcache = new MemCacheImpl(rawMemcache);

  // Wait a bit for the memchaced server to startup.
  setUpAll(() async {
    await new Future.delayed(const Duration(seconds: 1));
  });

  // After running all tests we tear down the memcached server.
  tearDownAll(() async {
    await rawMemcache.close();
    return memcached.stop();
  });

  group('memcache', () {
    // Before each test, we'll clear the cache.
    setUp(() => memcache.clear());

    test('get-set-get', () async {
      expect(await memcache.get([1]), isNull);
      expect(await memcache.set('ABC', 'abc'), isNull);
      expect(await memcache.get('ABC'), 'abc');
    });

    test('get-add-replace', () async {
      expect(await memcache.get([1]), isNull);
      expect(await memcache.set('ABC', 'abc'), isNull);
      expect(await memcache.get('ABC'), 'abc');
      expect(
          await memcache.set('ABC', 'ABC', action: SetAction.REPLACE), isNull);
      expect(await memcache.get('ABC'), 'ABC');
    });

    test('error-replace', () async {
      expect(await memcache.get('A'), isNull);
      expect(memcache.set('A', 'ABC', action: SetAction.REPLACE),
          throwsA(isMemcacheNotStored));
    });

    test('error-add', () async {
      expect(await memcache.get('A'), isNull);
      expect(await memcache.set('A', 'ABC'), isNull);
      expect(memcache.set('A', 'ABC', action: SetAction.ADD),
          throwsA(isMemcacheNotStored));
    });

    test('all-get-set-get', () async {
      expect(await memcache.getAll(['A', 'B']), {'A': null, 'B': null});
      expect(await memcache.setAll({'A': 'ABC', 'B': 'abc'}), isNull);
      expect(await memcache.getAll(['A', 'B']), {'A': 'ABC', 'B': 'abc'});
      expect(await memcache.setAll({'A': 'abc', 'B': 'ABC'}), isNull);
      expect(await memcache.getAll(['A', 'B']), {'A': 'abc', 'B': 'ABC'});
    });

    test('all-get-add-replace', () async {
      expect(await memcache.getAll(['A', 'B']), {'A': null, 'B': null});
      expect(
          await memcache
              .setAll({'A': 'ABC', 'B': 'abc'}, action: SetAction.ADD),
          isNull);
      expect(await memcache.getAll(['A', 'B']), {'A': 'ABC', 'B': 'abc'});
      expect(
          await memcache
              .setAll({'A': 'abc', 'B': 'ABC'}, action: SetAction.REPLACE),
          isNull);
      expect(await memcache.getAll(['A', 'B']), {'A': 'abc', 'B': 'ABC'});
    });

    test('all-error-replace', () async {
      expect(await memcache.getAll(['A', 'B']), {'A': null, 'B': null});
      expect(
          memcache.setAll({'A': 'ABC', 'B': 'abc'}, action: SetAction.REPLACE),
          throwsA(isMemcacheNotStored));
    });

    test('all-error-add', () async {
      expect(await memcache.getAll(['A', 'B']), {'A': null, 'B': null});
      expect(await memcache.setAll({'A': 'ABC', 'B': 'abc'}), isNull);
      expect(memcache.setAll({'A': 'ABC', 'B': 'abc'}, action: SetAction.ADD),
          throwsA(isMemcacheNotStored));
    });

    // Description of increment operations:
    //
    //     "If the key doesn't exist, the server will respond with the initial
    //      value. If not the incremented value will be returned. Let's assume
    //      that the key didn't exist, so the initial value is returned:"
    //
    // We are flushing/clearing the cache in `testSetup`, which ensures all
    // tests start from an empty cache. So the result of the first increment
    // will always be the "initialValue: <...>" (which defaults to 0).
    //
    test('increment-increment', () async {
      expect(await memcache.increment('A'), 0);
      expect(await memcache.increment([65]), 1);
    });

    test('initial-increment-increment', () async {
      expect(await memcache.increment('A', initialValue: 2), 2);
      expect(await memcache.increment([65], delta: 2), 4);
    });

    test('initial-max-increment-wrap-increment', () async {
      expect(await memcache.increment('A', initialValue: 0xFFFFFFFFFFFFFFFF),
          0xFFFFFFFFFFFFFFFF);
      expect(await memcache.increment([65], delta: 2), 1);
    });

    test('initial-almost-max-increment-increment-wrap', () async {
      expect(await memcache.increment('A', initialValue: 0xFFFFFFFFFFFFFFFE),
          0xFFFFFFFFFFFFFFFE);
      expect(await memcache.increment([65], delta: 2), 0);
    });

    test('increment-max-delta-increment-wrap', () async {
      expect(await memcache.increment('A', delta: 0xFFFFFFFFFFFFFFFF), 0);
      expect(await memcache.increment([65], delta: 2), 2);
    });

    test('decrement-decrement', () async {
      expect(await memcache.decrement('A'), 0);
      expect(await memcache.decrement([65]), 0);
    });

    test('initial-decrement-decrement', () async {
      expect(await memcache.decrement('A', initialValue: 3), 3);
      expect(await memcache.decrement([65], delta: 2), 1);
    });

    test('initial-max-decrement-max-decrement', () async {
      expect(
          await memcache.decrement('A',
              delta: 0xFFFFFFFFFFFFFFFF, initialValue: 0xFFFFFFFFFFFFFFFF),
          0xFFFFFFFFFFFFFFFF);
      expect(await memcache.decrement([65], delta: 0xFFFFFFFFFFFFFFFF), 0);
    });

    test('initial-max-decrement-decrement', () async {
      expect(await memcache.decrement('A', initialValue: 0xFFFFFFFFFFFFFFFF),
          0xFFFFFFFFFFFFFFFF);
      expect(await memcache.decrement([65], delta: 0xFFFFFFFFFFFFFFFF), 0);
    });

    test('test-expiry', () async {
      const delay = const Duration(seconds: 2);

      await memcache.set('A', 'foo');
      await memcache.set('B', 'bar', expiration: delay);

      expect(await memcache.get('A'), 'foo');
      expect(await memcache.get('B'), 'bar');

      await new Future.delayed(delay);

      expect(await memcache.get('A'), 'foo');
      expect(await memcache.get('B'), null);
    });
  });
}

class _MemcacheError extends TypeMatcher {
  const _MemcacheError() : super("MemcacheError");
  bool matches(item, Map matchState) => item is MemcacheError;
}

class _MemcacheNotStoredError extends TypeMatcher {
  const _MemcacheNotStoredError() : super("NotStoredError");
  bool matches(item, Map matchState) => item is NotStoredError;
}

const isMemcacheError = const _MemcacheError();
const isMemcacheNotStored = const _MemcacheNotStoredError();
