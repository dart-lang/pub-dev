// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library memcache.impl;

import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import '../memcache.dart';
import '../memcache_raw.dart' as raw;


class MemCacheImpl implements Memcache {
  final raw.RawMemcache _raw;
  final bool _withCas;
  Map<List<int>, int> _cas;
  Expando _hashCache;

  MemCacheImpl(this._raw, { withCas: false})
      : _withCas = withCas {
    if (withCas) {
      _cas = new HashMap(equals: _keyCompare, hashCode: _keyHash);
      _hashCache = new Expando<int>();
    }
  }

  // Jenkins's one-at-a-time hash, see:
  // http://en.wikipedia.org/wiki/Jenkins_hash_function.
  int _keyHash(List<int> key) {
    final MASK_32 = 0xffffffff;
    int add32(x, y) => (x + y) & MASK_32;
    int shl32(x, y) => (x << y) & MASK_32;

    var cached = _hashCache[key];
    if (cached != null) {
      return cached;
    }

    int hash = 0;
    for (int i = 0; i < key.length; i++) {
      hash = add32(hash, key[i]);
      hash = add32(hash, shl32(hash, 10));
      hash ^= hash >> 6;
    }

    hash = add32(hash, shl32(hash, 3));
    hash ^= hash >> 11;
    hash = add32(hash, shl32(hash, 15));
    _hashCache[key] = hash;
    return hash;
  }

  bool _keyCompare(List<int> key1, List<int> key2) {
    if (key1.length != key2.length) return false;
    for (int i = 0; i < key1.length; i++) {
      if (key1[i] != key2[i]) return false;
    }
    return true;
  }

  List<int> _createKey(Object key) {
    if (key is String) {
      key = UTF8.encode(key);
    } else {
      if (key is! List<int>) {
        throw new ArgumentError('Key must have type String or List<int>');
      }
    }
    return key;
  }

  List<int> _createValue(Object value) {
    if (value is String) {
      value = UTF8.encode(value);
    } else {
      if (value is! List<int>) {
        throw new ArgumentError('Value must have type String or List<int>');
      }
    }
    return value;
  }

  void _checkExpiration(Duration expiration) {
    const int secondsInThirtyDays = 60 * 60 * 24 * 30;
    // Expiration cannot exceed 30 days.
    if (expiration != null && expiration.inSeconds > secondsInThirtyDays) {
      throw new ArgumentError('Expiration cannot exceed 30 days');
    }
  }

  raw.GetOperation _createGetOperation(List<int> key) {
    return new raw.GetOperation(key);
  }

  raw.SetOperation _createSetOperation(
      Object key, Object value, SetAction action, Duration expiration) {
    var operation;
    var cas;
    switch (action) {
      case SetAction.SET:
        operation = raw.SetOperation.SET;
        if (_withCas) cas = _findCas(key);
        break;
      case SetAction.ADD: operation = raw.SetOperation.ADD; break;
      case SetAction.REPLACE: operation = raw.SetOperation.REPLACE; break;
      default: throw new ArgumentError('Unsupported set action $action');
    }
    var exp = expiration != null ? expiration.inSeconds : 0;
    return new raw.SetOperation(
        operation, key, 0, cas, _createValue(value), exp);
  }

  raw.RemoveOperation _createRemoveOperation(Object key) {
    return new raw.RemoveOperation(_createKey(key));
  }

  raw.IncrementOperation _createIncrementOperation(
      Object key, int direction, int delta, int initialValue) {
    if (delta is! int) {
      throw new ArgumentError('Delta value must have type int');
    }
    return new raw.IncrementOperation(
        _createKey(key), delta, direction, 0, initialValue);
  }

  void _addCas(List<int> key, int cas) {
    _cas[key] = cas;
  }

  int _findCas(List<int> key) {
    return _cas[key];
  }

  Future get(Object key, {bool asBinary: false}) {
    key = _createKey(key);
    return new Future.sync(() => _raw.get([_createGetOperation(key)]))
        .then((List<raw.GetResult> response) {
          if (response.length != 1) {
            throw const MemcacheError.internalError();
          }
          var result = response.first;
          if (_withCas) {
            _addCas(key, result.cas);
          }
          if (result.status == raw.Status.KEY_NOT_FOUND) return null;
          return asBinary ? result.value : UTF8.decode(result.value);
        });
  }

  Future<Map> getAll(Iterable keys, {bool asBinary: false}) {
    return new Future.sync(() {
      // Copy the keys as they might get mutated by _createKey below.
      var keysList = keys.toList();
      var binaryKeys = new List(keysList.length);
      var request = new List(keysList.length);
      for (int i = 0; i < keysList.length; i++) {
        binaryKeys[i] = _createKey(keysList[i]);
        request[i] = _createGetOperation(binaryKeys[i]);
      }
      return _raw.get(request).then((List<raw.GetResult> response) {
        if (response.length != request.length) {
          throw const MemcacheError.internalError();
        }
        var result = new Map();
        for (int i = 0; i < keysList.length; i++) {
          var value;
          if (response[i].status == raw.Status.KEY_NOT_FOUND) {
            value = null;
          } else {
            value =
                asBinary ? response[i].value : UTF8.decode(response[i].value);
            if (_withCas) {
              _addCas(binaryKeys[i], response[i].cas);
            }
          }
          result[keysList[i]] = value;
        };
        return result;
      });
    });
  }

  Future set(key, value,
             {Duration expiration, SetAction action: SetAction.SET}) {
    return new Future.sync(() {
      _checkExpiration(expiration);
      key = _createKey(key);
      return _raw.set([_createSetOperation(key, value, action, expiration)])
          .then((List<raw.SetResult> response) {
            if (response.length != 1) {
              // TODO(sgjesse): Improve error.
              throw const MemcacheError.internalError();
            }
            var result = response.first;
            if (result.status == raw.Status.NO_ERROR) return null;
            if (result.status == raw.Status.NOT_STORED) {
              throw const NotStoredError();
            }
            if (result.status == raw.Status.KEY_EXISTS) {
              throw const ModifiedError();
            }
            throw new MemcacheError(result.status, 'Error storing item');
          });
    });
  }

  Future setAll(Map keysAndValues,
                {Duration expiration, SetAction action: SetAction.SET}) {
    return new Future.sync(() {
      _checkExpiration(expiration);
      var request = [];
      keysAndValues.forEach((key, value) {
        key = _createKey(key);
        request.add(_createSetOperation(key, value, action, expiration));
      });
      return _raw.set(request)
          .then((List<raw.SetResult> response) {
            if (response.length != request.length) {
              throw const MemcacheError.internalError();
            }
            response.forEach((raw.SetResult result) {
              if (result.status == raw.Status.NO_ERROR) return;
              if (result.status == raw.Status.NOT_STORED) {
                // If one element is not stored throw NotStored.
                throw const NotStoredError();
              }
              if (result.status == raw.Status.KEY_EXISTS) {
                // If one element is modified throw Modified.
                throw const ModifiedError();
              }
              // If one element has another status throw.
              throw new MemcacheError(result.status, 'Error storing item');
            });
            return null;
          });
    });
  }

  Future remove(key) {
    return new Future.sync(() => _raw.remove([_createRemoveOperation(key)]))
        .then((List<raw.RemoveResult> response) {
          // The remove is considered succesful no matter whether the key was
          // there or not.
          return null;
        });
  }

  Future removeAll(Iterable keys) {
    return new Future.sync(() {
      var request = [];
      keys.forEach((key) {
        request.add(_createRemoveOperation(key));
      });
      return _raw.remove(request).then((List<raw.RemoveResult> response) {
        if (response.length != request.length) {
          throw const MemcacheError.internalError();
        }
        // The remove is considered succesful no matter whether the key was
        // there or not.
        return null;
      });
    });
  }

  Future<int> increment(key, {int delta: 1, int initialValue: 0}) {
    var direction = delta >= 0 ? raw.IncrementOperation.INCREMENT
                               : raw.IncrementOperation.DECREMENT;
    return new Future.sync(() => _raw.increment(
        [_createIncrementOperation(key, direction, delta.abs(), initialValue)]))
        .then((List<raw.IncrementResult> responses) {
          if (responses.length != 1) {
            // TODO(sgjesse): Improve error.
            throw const MemcacheError.internalError();
          }
          var response = responses[0];
          if (response.status != raw.Status.NO_ERROR) {
            throw new MemcacheError(response.status, response.message);
          }
          return response.value;
        });
  }

  Future<int> decrement(key, {int delta: 1, int initialValue: 0}) {
    return increment(key, delta: -delta, initialValue: initialValue);
  }

  Future clear() {
    return new Future.sync(() => _raw.clear());
  }

  Memcache withCAS() {
    return new MemCacheImpl(_raw, withCas: true);
  }
}
