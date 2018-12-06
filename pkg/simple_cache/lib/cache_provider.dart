// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

/// Low-level interface for a cache.
///
/// This can be an in-memory cache, something that writes to disk or to an
/// cache service such as memcached or redis.
///
/// The `Cache` provided by the `simple_cache` package, is intended to wrap
/// a [CacheProvider] and provide a more convinient high-level interface.
///
/// Implementers of [CacheProvider] can implement something that stores a value
/// of anytime `T`, but usually implementers should aim to implement
/// `CacheProvider<List<int>>` which stores binary data.
///
/// If interfacing a remote system over network where intermittent errors may
/// occur, implementers should take care to retry operations as appropripate.
///
/// **Cache eviction**: implementers must support [purge] to clear cache entries
/// on demand. However, implementers are not required to keep entries in the
/// cache until their TTL have expired.
abstract class CacheProvider<T> {
  /// Fetch data stored under [key].
  ///
  /// If nothing is cached for [key], this **must** return `null`.
  Future<T> get(String key);

  /// Set [value] stored at [key] with optional [ttl].
  ///
  /// If a value is already stored at [key], that value should be overwritten
  /// with the new [value] given here.
  ///
  /// When given [ttl] is advisory, however, implementers should avoid returning
  /// entries that are far past their [ttl].
  Future<void> set(String key, T value, [Duration ttl]);

  /// Clear value stored at [key].
  ///
  /// After this has returned future calls to [get] for the given [key] should
  /// not return any value, unless a new value have been set.
  Future<void> purge(String key);

  /// Close all connections and throw [CacheProviderClosedException] on all
  /// future operations.
  ///
  /// Calling [close] multiple times does not throw.
  Future<void> close();
}

/// Excpetion thrown when a [CacheProvider] have been closed.
class CacheProviderClosedException implements Exception {
  const CacheProviderClosedException();
  @override
  String toString() => 'CacheProvider cannot be used after being closed';
}
