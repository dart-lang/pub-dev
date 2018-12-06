// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'package:simple_cache/simple_cache.dart';
import 'package:simple_cache/cache_provider.dart';
import 'package:identity_codec/identity_codec.dart';
import 'package:test/test.dart';

/// Simple class to wrap a `CacheProvider<T>` + `Codec<String, T>` to get a
/// `CacheProvider<String>`.
///
/// This is just meant to be useful for testing.
class StringCacheProvider<T> implements CacheProvider<String> {
  final CacheProvider<T> cache;
  final Codec<String, T> codec;
  StringCacheProvider({this.cache, this.codec = const IdentityCodec()});

  @override
  Future<String> get(String key) async {
    final val = await cache.get(key);
    if (val == null) {
      return null;
    }
    return codec.decode(val);
  }

  @override
  Future set(String key, String value, [Duration ttl]) =>
      cache.set(key, codec.encode(value), ttl);

  @override
  Future purge(String key) => cache.purge(key);

  @override
  Future close() => cache.close();
}

void testCacheProvider({
  String name,
  Future<CacheProvider<String>> Function() create,
  Future Function() destroy,
}) =>
    group(name, () {
      CacheProvider<String> cache;
      setUpAll(() async => cache = await create());
      tearDownAll(() => destroy != null ? destroy() : null);

      test('get empty key', () async {
        await cache.purge('test-key');
        final r = await cache.get('test-key');
        expect(r, isNull);
      });

      test('get/set key', () async {
        await cache.set('test-key-2', 'hello-world-42');
        final r = await cache.get('test-key-2');
        expect(r, equals('hello-world-42'));
      });

      test('set key (overwrite)', () async {
        await cache.set('test-key-3', 'hello-once');
        final r = await cache.get('test-key-3');
        expect(r, equals('hello-once'));

        await cache.set('test-key-3', 'hello-again');
        final r2 = await cache.get('test-key-3');
        expect(r2, equals('hello-again'));
      });

      test('purge key', () async {
        await cache.set('test-key-4', 'hello-once');
        final r = await cache.get('test-key-4');
        expect(r, equals('hello-once'));

        await cache.purge('test-key-4');
        final r2 = await cache.get('test-key-4');
        expect(r2, isNull);
      });

      test('set key w. ttl', () async {
        await cache.set('test-key-5', 'should-expire', Duration(seconds: 2));
        final r = await cache.get('test-key-5');
        expect(r, equals('should-expire'));

        await Future.delayed(Duration(seconds: 3));

        final r2 = await cache.get('test-key-5');
        expect(r2, isNull);
      }, tags: ['ttl']);
    });

void main() {
  testCacheProvider(
    name: 'in-memory cache',
    create: () async => StringCacheProvider(
          cache: Cache.inMemoryCacheProvider(4096),
          codec: utf8,
        ),
  );

  CacheProvider<List<int>> p;
  testCacheProvider(
    name: 'redis cache',
    create: () async {
      p = Cache.redisCacheProvider('redis://localhost:6379');
      return StringCacheProvider(cache: p, codec: utf8);
    },
    destroy: () => p.close(),
  );
}
