// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:identity_codec/identity_codec.dart';
import 'package:logging/logging.dart';
import 'cache_provider.dart';
import 'src/providers/inmemory.dart';
import 'src/providers/redis.dart';

final _logger = Logger('simple_cache');

/// Cache for objects of type [T], wrapping a [CacheProvider] to provide a
/// high-level interface.
///
/// Cache entries are accessed using the indexing operator `[]`, this returns a
/// [Entry<T>] wrapper that can be used to get/set data cached at given key.
///
/// **Example**
/// ```dart
/// final Cache<List<int>> cache = Cache.inMemoryCache(4096);
///
/// // Write data to cache
/// await cache['cached-zeros'].set([0, 0, 0, 0]);
///
/// // Read data from cache
/// var r = await cache['cached-zeros'].get();
/// expect(r, equals([0, 0, 0, 0]));
/// ```
///
/// A [Cache] can be _fused_ with a [Codec] using [withCodec] to get a cache
/// that stores a different kind of objects. It is also possible to create
/// a chuild cache using [withPrefix], such that all entries in the child
/// cache have a given prefix.
abstract class Cache<T> {
  /// Get [Entry] wrapping data cached at [key].
  Entry<T> operator [](String key);

  /// Get a [Cache] wrapping of this cache with given [prefix].
  Cache<T> withPrefix(String prefix);

  /// Get a [Cache] wrapping of this cache while logging operations to [logger].
  ///
  /// If [ignoreErrors] is `false` (default), errors are logged as warnings
  /// with [logger.warning()] and propagated to the caller.
  ///
  /// If [ignoreErrors] is `true`, errors are logged are logged as errors with
  /// [logger.severe()] and ignored, instead calls to `Entry.get` will return
  /// `null`.
  ///
  /// Reading and writing to the cache is always logged with [logger.finest()].
  ///
  /// If [withLogger] is called again the previous [logger] is overwritten.
  Cache<T> withLogger(Logger logger, {bool ignoreErrors = false});

  /// Get a [Cache] wrapping of this cache by encoding objects of type [S] as
  /// [T] using the given [codec].
  Cache<S> withCodec<S>(Codec<S, T> codec);

  /// Get a [Cache] wrapping of this cache with given [ttl] as default for all
  /// entries being set using [Entry.set].
  ///
  /// This only specifies a different default [ttl], to be used when [Entry.set]
  /// is called without a [ttl] parameter.
  Cache<T> withTTL(Duration ttl);

  /// Create a [Cache] wrapping a [CacheProvider].
  factory Cache(CacheProvider<T> provider) {
    return _Cache<T, T>(provider, '', _logger, false, IdentityCodec());
  }

  /// Create an in-memory [CacheProvider] holding a maximum of [maxSize] cache
  /// entries.
  static CacheProvider<List<int>> inMemoryCacheProvider(int maxSize) {
    return InMemoryCacheProvider(maxSize);
  }

  /// Create a redis [CacheProvider] by connecting using a [connectionString] on
  /// the form `redis://<host>:<port>`.
  static CacheProvider<List<int>> redisCacheProvider(String connectionString) {
    return RedisCacheProvider(connectionString);
  }
}

/// Pointer to a location in the cache.
///
/// This simply wraps a cache key, such that you don't need to supply a cache
/// key for [get], [set] and [purge] operations.
abstract class Entry<T> {
  /// Get value stored in this cache entry.
  ///
  /// If used without [create], this function simply gets the value or `null` if
  /// no value is stored.
  ///
  /// If used with [create], this function becomes an upsert, returning the
  /// value stored if any, otherwise creating a new value and storing it with
  /// optional [ttl]. If multiple callers are using the same cache this is an
  /// inherently racy operation, that is multiple instances of the value may
  /// be created.
  Future<T> get([Future<T> Function() create, Duration ttl]);

  /// Set the value stored in this cache entry.
  ///
  /// If given [ttl] specifies the time-to-live. Notice that this is advisatory,
  /// the underlying [CacheProvider] may choose to evit cache entries at any
  /// time. However, you should not expect entries to live far past their [ttl].
  Future<T> set(T value, [Duration ttl]);

  /// Clear the value stored in this cache entry.
  Future purge();
}

class _Cache<T, V> implements Cache<T> {
  final CacheProvider<V> _provider;
  final String _prefix;
  final Codec<T, V> _codec;
  final Duration _ttl;
  final Logger _logger;
  final bool _ignoreErrors;

  _Cache(this._provider, this._prefix, this._logger, this._ignoreErrors,
      this._codec,
      [this._ttl]);

  @override
  Entry<T> operator [](String key) =>
      _Entry(this, _prefix + key, _logger, _ignoreErrors);

  @override
  Cache<T> withPrefix(String prefix) =>
      _Cache(_provider, _prefix + prefix, _logger, _ignoreErrors, _codec, _ttl);

  @override
  Cache<T> withLogger(Logger logger, {bool ignoreErrors = false}) =>
      _Cache(_provider, _prefix, logger, ignoreErrors, _codec, _ttl);

  @override
  Cache<S> withCodec<S>(Codec<S, T> codec) => _Cache(
      _provider, _prefix, _logger, _ignoreErrors, codec.fuse(_codec), _ttl);

  @override
  Cache<T> withTTL(Duration ttl) =>
      _Cache(_provider, _prefix, _logger, _ignoreErrors, _codec, ttl);
}

class _Entry<T, V> implements Entry<T> {
  final _Cache<T, V> _owner;
  final String _key;
  final Logger _logger;
  final bool _ignoreErrors;
  _Entry(this._owner, this._key, this._logger, this._ignoreErrors);

  @override
  Future<T> get([Future<T> Function() create, Duration ttl]) async {
    V value;
    try {
      _logger.finest(() => 'reading cache entry for "$_key"');
      value = await _owner._provider.get(_key);
    } on Exception catch (e, st) {
      if (!_ignoreErrors) {
        _logger.warning(() => 'failed to get cache entry for "$_key"', e, st);
        rethrow;
      }
      _logger.severe(
        () => 'failed to get cache entry for "$_key", returning "null"',
        e,
        st,
      );
      value = null;
    }
    if (value == null) {
      if (create == null) {
        return null;
      }
      return await set(await create(), ttl);
    }
    return _owner._codec.decode(value);
  }

  @override
  Future<T> set(T value, [Duration ttl]) async {
    if (value == null) {
      await purge();
      return null;
    }
    ttl ??= _owner._ttl;
    final raw = _owner._codec.encode(value);
    try {
      await _owner._provider.set(_key, raw, ttl);
    } on Exception catch (e, st) {
      if (!_ignoreErrors) {
        _logger.warning(() => 'failed to set cache entry for "$_key"', e, st);
        rethrow;
      }
      _logger.severe(
          () => 'failed to set cache entry for "$_key", ignoring error', e, st);
    }
    return value;
  }

  @override
  Future<void> purge() async {
    try {
      await _owner._provider.purge(_key);
    } on Exception catch (e, st) {
      if (!_ignoreErrors) {
        _logger.warning(() => 'failed to clear cache entry for "$_key"', e, st);
        rethrow;
      }
      _logger.severe(
        () => 'failed to clear cache entry for "$_key", ignoring error',
        e,
        st,
      );
    }
  }
}
