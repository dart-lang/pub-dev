// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'package:simple_cache/simple_cache.dart';
import 'package:simple_cache/cache_provider.dart';
import 'package:test/test.dart';

void testCacheT<T>({
  String name,
  Future<Cache<T>> Function() create,
  Future Function() destroy,
  T Function() valueA,
  T Function() valueB,
}) =>
    group(name, () {
      Cache<T> cache;
      setUpAll(() async => cache = await create());
      tearDownAll(() => destroy != null ? destroy() : null);

      test('get empty key', () async {
        await cache['test-key-1'].purge();
        final r = await cache['test-key-1'].get();
        expect(r, isNull);
      });

      test('get/set key', () async {
        await cache['test-key-2'].set(valueA());
        final r = await cache['test-key-2'].get();
        expect(r, equals(valueA()));
      });

      test('set key (overwrite)', () async {
        await cache['test-key-3'].set(valueA());
        final r = await cache['test-key-3'].get();
        expect(r, equals(valueA()));

        await cache['test-key-3'].set(valueB());
        final r2 = await cache['test-key-3'].get();
        expect(r2, equals(valueB()));
      });

      test('purge key', () async {
        await cache['test-key-4'].set(valueA());
        final r = await cache['test-key-4'].get();
        expect(r, equals(valueA()));

        await cache['test-key-4'].purge();
        final r2 = await cache['test-key-4'].get();
        expect(r2, isNull);
      });

      test('set key w. ttl', () async {
        await cache['test-key-5'].set(valueA(), Duration(seconds: 2));
        final r = await cache['test-key-5'].get();
        expect(r, equals(valueA()));

        await Future.delayed(Duration(seconds: 3));

        final r2 = await cache['test-key-5'].get();
        expect(r2, isNull);
      }, tags: ['ttl']);

      test('withPrefix + get', () async {
        final c2 = cache.withPrefix('test-pfx/');
        await cache['test-pfx/key-6'].set(valueA());
        final r = await c2['key-6'].get();
        expect(r, equals(valueA()));
      });

      test('withPrefix(a) is isolated from withPrefix(b)', () async {
        final cA = cache.withPrefix('test-prefix-A');
        final cB = cache.withPrefix('test-prefix-B');

        await cA['key-1'].set(valueA());
        final rA = await cA['key-1'].get();
        expect(rA, equals(valueA()));

        final rB = await cB['key-1'].get();
        expect(rB, isNull);
      });
    });

void testCache({
  String name,
  Future<Cache<List<int>>> Function() create,
  Future Function() destroy,
}) =>
    group(name, () {
      testCacheT(
        name: 'raw',
        create: create,
        destroy: destroy,
        valueA: () => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 0, 0, 0, 0, 42],
        valueB: () => [1, 5, 5, 5, 5, 5, 42],
      );

      testCacheT(
        name: 'withCodec (utf8)',
        create: () async => (await create()).withCodec(utf8),
        destroy: destroy,
        valueA: () => 'hello world',
        valueB: () => 'hello world again, but different!',
      );

      testCacheT(
        name: 'withPrefix',
        create: () async => (await create()).withPrefix('test-prefix-1/'),
        destroy: destroy,
        valueA: () => [4, 4, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 0, 0, 0, 0, 42],
        valueB: () => [4, 4, 1, 5, 5, 5, 5, 5, 42],
      );

      testCacheT(
        name: 'withPrefix + withPrefix',
        create: () async {
          return (await create()).withPrefix('test-prefix-2/').withPrefix('L2');
        },
        destroy: destroy,
        valueA: () => [4, 4, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 0, 0, 0, 0, 42],
        valueB: () => [4, 4, 1, 5, 5, 5, 5, 5, 42],
      );

      testCacheT(
        name: 'withPrefix + withCodec (utf8)',
        create: () async {
          return (await create()).withPrefix('test-prefix-1/').withCodec(utf8);
        },
        destroy: destroy,
        valueA: () => 'hello world',
        valueB: () => 'hello world again, but different!',
      );

      testCacheT(
        name: 'withTTL',
        create: () async => (await create()).withTTL(Duration(seconds: 30)),
        destroy: destroy,
        valueA: () => [4, 4, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 0, 0, 0, 0, 42],
        valueB: () => [4, 4, 1, 5, 5, 5, 5, 5, 42],
      );
    });

void main() {
  testCache(
    name: 'in-memory cache',
    create: () async => Cache(Cache.inMemoryCacheProvider(4096)),
  );

  CacheProvider<List<int>> p;
  testCache(
    name: 'redis cache',
    create: () async {
      p = Cache.redisCacheProvider('redis://localhost:6379');
      return Cache(p);
    },
    destroy: () async => p.close(),
  );
}
