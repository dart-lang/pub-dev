// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library memcache;

import "dart:async";

import "memcache_raw.dart";
import "src/memcache_impl.dart" show MemCacheImpl;

/**
 * General memcache exception.
 */
class MemcacheError implements Exception {
  final Status status;
  final String message;

  const MemcacheError(this.status, this.message);

  const MemcacheError.internalError()
      : message = 'An internal error occurred.',
        status = null;

  String toString() => 'MemcacheError(status: $status, message: $message)';
}

/**
 * Exception thrown by [Memcache.set] and [Memcache.setAll] if the item was
 * not stored.
 */
class NotStoredError extends MemcacheError {
  const NotStoredError() : super(null, 'Item was not stored.');
}

/**
 * Exception thrown by [Memcache.set] and [Memcache.setAll] if CAS tracking
 * is used and the item has been modified after it was fetched.
 */
class ModifiedError extends MemcacheError {
  const ModifiedError() : super(null, 'Item exists with a different CAS value.');
}

/**
 * Exception thrown if there was a network error.
 */
class NetworkException extends MemcacheError {
  final error;
  NetworkException(this.error) : super(null, null);

  String toString() => 'NetworkError: "$error"';
}

/**
 * Access to a memcache service.
 *
 * The memcache service – referred to as simply 'memcache' below – provides a
 * shared cache organized as a map from keys to values where both keys and
 * values are binary values (i.e. list of bytes).
 * For each entry in the cache an expiry time can be set to ensure the item is
 * evicted from the cache after a given interval or at a specific point in time.
 * The cache has a limited size, so items can be evicted by the service at any
 * point in time, typically using a LRU-policy.
 *
 * The key value used in memcache is a binary value with a maximum length of
 * 250 bytes.
 *
 * The values stored in memcache are binary values. The maximum size for a
 * value depends on the configuration of the memcache service. The most common
 * default is 1M (one megabyte).
 *
 * In all cases where a key is passed it can be of type `List<int>` or of
 * type `String`. In the case of `List<int>` the key value is passed directly
 * to memcache. In the case of a `String` the key value is converted into
 * bytes by using the UTF-8 encoding. Note that when combining both types of
 * keys in an application a key of one type can alias a key of the other type.
 * E.g. the keys `[64]` and `'A'` are the same key.
 *
 * When the type `List<int>` is used note the values are bytes and each value
 * in the list must be in the range [0..255]. Using the class `Uint8List`
 * from `dart:typed_data` provides a compact and efficient represetation.
 */
abstract class Memcache {
  /**
   * Makes a new [Memcache] instance based on a [RawMemcache].
   */
  factory Memcache.fromRaw(RawMemcache raw) => new MemCacheImpl(raw);

  /**
   * Retreives a value from memcache.
   *
   * If the value is not found the future completes with `null`.
   *
   * If the value is found the value of [asBinary] determins the type of
   * the value the future completes with. If [asBinary] is `false` (the
   * default) the future completes with a `String`. Otherwise the future
   * completes with a list of bytes.
   *
   * The internal representation in memcache is binary. When a `String` is
   * returned it uses a UTF-8 decoder to produce a `String`.
   */
  Future get(key, {bool asBinary: false});

  /**
   * Retreives multiple values from memcache.
   *
   * The values are returned in a map where the keys are the same instances
   * as where passed in the [keys] argument.
   */
  Future<Map> getAll(Iterable keys, {bool asBinary: false});

  /**
   * Sets the value for a key in memcache. The value is set unconditionally.
   *
   * If [expiration] is not set the value is set without
   * any explicit lifetime. [expiration] cannot exceed 30 days.
   *
   * If [action] is [SetAction.SET] (the default) the
   * value is set unconditionally in memcache. That is, if the key does not
   * already exist it is created and if the key already exists its current
   * value is overwritten.
   * The value [SetAction.ADD] is used to indicate that the value will only be
   * set if the key was not in mamcache already. The value
   * [SetAction.REPLACE] is used to indicate that the value will only be set
   * if the key was already in memcache.
   *
   * The key and value can have type `String` or `List<int>`. When a `String`
   * is used for either key or value a UTF-8 encoder is used to produce the
   * binary value which is stored in memecache.
   *
   *     Memcache m = ...;
   *     m.set('mykey', 'myvalue');
   *     m.set([0, 1, 2], [3, 4, 5], expiration: new Duration(hours: 1));
   */
  Future set(key, value,
             {Duration expiration, SetAction action: SetAction.SET});

  /**
   * Sets multiple values in memcache.
   *
   * The keys and values passed in `keysAndValues` can have type `String`
   * or `List<int>`.
   *
   *     Memcache m = ...;
   *     m.setAll(
   *         {'mykey': 'myvalue',
   *          [0, 1, 2]: [3, 4, 5]
   *         });
   *
   * The values passed for [expiration] and [action] are applied to all values
   * set.
   *
   * See [set] for information on [expiration] and [action].
   *
   * Note that memcache is not transactional, so if this operation fails some
   * of the updates might still have succeeded.
   *
   * Also note that when this operation fails the exception reported is the
   * first failure encountered. There might be different failures as well.
   */
  Future setAll(Map keysAndValues,
                {Duration expiration, SetAction action: SetAction.SET});

  /**
   * Removes the key from memcache.
   */
  Future remove(key);

  /**
   * Removes all the keys in [keys] from memcache.
   *
   * Note that memcache is not transactional, so if this operation fails some
   * of the keys might still have been removed.
   */
  Future removeAll(Iterable keys);

  /**
   * Increments the value of a key in memcache.
   *
   * The current value of [key] will be incremented with the value [delta]. If
   * [key] does not exist it will be added with the value [initialValue].
   *
   * Increment in memcache works on 64-bit unsigned integers. If incrementing
   * causes the value to exceed the maximum value for a 64-bit integer the
   * value will wrap.
   *
   * If the value is negative this will work as if `decrement` was called.
   *
   * The updated value is returned.
   */
  Future<int> increment(key, {int delta: 1, int initialValue: 0});

  /**
   * Decrement the value of a key in memcache.
   *
   * The current value of [key] will be incremented with the value [delta]. If
   * [key] does not exist it will be added with the value [initialValue].
   *
   * Decrement in memcache works on 64-bit unsigned integers. If decrementing
   * causes the value to become negative it will stay at 0.
   *
   * If the value is negative this will work as if `increment` was called.
   *
   * The updated value is returned.
   */
  Future<int> decrement(key, {int delta: 1, int initialValue: 0});

  /**
   * Delete all items in memcache.
   */
  Future clear();

  /**
   * Returns a new instance of `Memcache` which keeps track of the
   * Data Version Check, also called 'Compare And Set' (CAS).
   *
   * When using this instance each `get` and `getAll` operation will retreive
   * the CAS value and keep track of that.
   *
   * When a `set` or `setAll` operation is performed, the CAS value retrieved
   * from the `get` or `getAll` operation will be used, to ensure that setting
   * a value only happens if the value has not been modified since it was
   * retreived.
   *
   * The CAS check is only in effect when `set` or `setAll` uses the action
   * `SetAction.SET`. This is the default action.
   *
   * For the other operations `remove`, `increment` and `decrement` the CAS
   * value is not used and these operations will be preformed unconditialally.
   *
   * NOTE: There is no way of clearing the tracked CAS values. Just create a
   * new `withCAS` instance when needed.
   */
  Memcache withCAS();
}

class SetAction {
  final int _action;
  final String _name;
  static const SetAction SET = const SetAction._(0, "SET");
  static const SetAction ADD = const SetAction._(1, "ADD");
  static const SetAction REPLACE = const SetAction._(2, "REPLACE");

  const SetAction._(this._action, this._name);

  int get hashCode => _action.hashCode;

  String toString() => 'SetAction($_name)';
}
