// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

// ignore: import_of_legacy_library_into_null_safe
import 'package:neat_cache/neat_cache.dart' as nc;

// ignore_for_file: comment_references

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
/// A [CacheWrapper] can be _fused_ with a [Codec] using [withCodec] to get a cache
/// that stores a different kind of objects. It is also possible to create
/// a chuild cache using [withPrefix], such that all entries in the child
/// cache have a given prefix.
class CacheWrapper<T> {
  final nc.Cache<T> _cache;
  CacheWrapper(this._cache);

  /// Get [Entry] wrapping data cached at [key].
  Entry<T> operator [](String key) => Entry._(_cache[key]);

  /// Get a [CacheWrapper] wrapping of this cache with given [prefix].
  CacheWrapper<T> withPrefix(String prefix) =>
      CacheWrapper(_cache.withPrefix(prefix));

  /// Get a [CacheWrapper] wrapping of this cache by encoding objects of type [S] as
  /// [T] using the given [codec].
  CacheWrapper<S> withCodec<S>(Codec<S, T> codec) =>
      CacheWrapper(_cache.withCodec<S>(codec));

  /// Get a [CacheWrapper] wrapping of this cache with given [ttl] as default for all
  /// entries being set using [Entry.set].
  ///
  /// This only specifies a different default [ttl], to be used when [Entry.set]
  /// is called without a [ttl] parameter.
  CacheWrapper<T> withTTL(Duration ttl) => CacheWrapper(_cache.withTTL(ttl));
}

/// Pointer to a location in the cache.
///
/// This simply wraps a cache key, such that you don't need to supply a cache
/// key for [get], [set] and [purge] operations.
class Entry<T> {
  final nc.Entry<T> _entry;
  Entry._(this._entry);

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
  ///
  /// The [get] method is a best-effort method. In case of intermittent failures
  /// from the underlying [CacheProvider] the [get] method will ignore failures
  /// and return `null` (or result from [create] if specified).
  Future<T?> get([Future<T?> Function()? create, Duration? ttl]) async {
    final f = await _entry.get(create, ttl);
    return f as T?;
  }

  /// Set the value stored in this cache entry.
  ///
  /// If given [ttl] specifies the time-to-live. Notice that this is advisatory,
  /// the underlying [CacheProvider] may choose to evit cache entries at any
  /// time. However, it can be assumed that entries will not live far past
  /// their [ttl].
  ///
  /// The [set] method is a best-effort method. In case of intermittent failures
  /// from the underlying [CacheProvider] the [set] method will ignore failures.
  ///
  /// To ensure that cache entries are purged, use the [purge] method with
  /// `retries` not set to zero.
  Future<T?> set(T? value, [Duration? ttl]) async {
    final f = await _entry.set(value, ttl);
    return f as T?;
  }

  /// Clear the value stored in this cache entry.
  ///
  /// If [retries] is `0` (default), this is a best-effort method, which will
  /// ignore intermittent failures. If [retries] is non-zero the operation will
  /// be retried with exponential back-off, and [IntermittentCacheException]
  /// will be thrown if all retries fails.
  Future purge({int retries = 0}) async {
    await _entry.purge(retries: retries);
  }
}
