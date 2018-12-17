// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import '../../cache_provider.dart';

class _InMemoryEntry<T> {
  final T value;
  final DateTime _expires;
  _InMemoryEntry(this.value, [this._expires]);
  bool get isExpired => _expires != null && _expires.isBefore(DateTime.now());
}

/// Simple two-generational LRU cache inspired by:
/// https://github.com/sindresorhus/quick-lru
class InMemoryCacheProvider<T> extends CacheProvider<T> {
  /// New generation of cache entries.
  Map<String, _InMemoryEntry<T>> _new = <String, _InMemoryEntry<T>>{};

  /// Old generation of cache entries.
  Map<String, _InMemoryEntry<T>> _old = <String, _InMemoryEntry<T>>{};

  /// Maximum size before clearing old generation.
  final int _maxSize;

  /// Have this been closed.
  bool _isClosed = false;

  InMemoryCacheProvider(this._maxSize);

  /// Clear old generation, if _maxSize have been reached.
  void _maintainGenerations() {
    if (_new.length >= _maxSize) {
      _old = _new;
      _new = {};
    }
  }

  @override
  Future<T> get(String key) async {
    if (_isClosed) {
      throw CacheProviderClosedException();
    }
    // Lookup in the new generation
    var entry = _new[key];
    if (entry != null) {
      if (!entry.isExpired) {
        return entry.value;
      }
      // Remove, if expired
      _new.remove(key);
    }
    // Lookup in the old generation
    entry = _old[key];
    if (entry != null) {
      if (!entry.isExpired) {
        // If not expired, we insert the entry into the new generation
        _new[key] = entry;
        _maintainGenerations();
        return entry.value;
      }
      // Remove, if expired
      _old.remove(key);
    }
    return null;
  }

  @override
  Future<void> set(String key, T value, [Duration ttl]) async {
    if (_isClosed) {
      throw CacheProviderClosedException();
    }
    if (ttl == null) {
      _new[key] = _InMemoryEntry(value);
    } else {
      _new[key] = _InMemoryEntry(value, DateTime.now().add(ttl));
    }
    // Always remove key from old generation to avoid risks of looking up there
    // if it's overwritten by an entry with a shorter ttl
    _old.remove(key);
    _maintainGenerations();
  }

  @override
  Future<void> purge(String key) async {
    if (_isClosed) {
      throw CacheProviderClosedException();
    }
    _new.remove(key);
    _old.remove(key);
  }

  @override
  Future<void> close() async {
    _isClosed = true;
    _old = null;
    _new = null;
  }
}
