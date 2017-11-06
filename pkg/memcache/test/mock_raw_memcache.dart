// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import '../lib/memcache_raw.dart';

class MockRawMemcache implements RawMemcache {
  Function _handleGet;
  Function _handleSet;
  Function _handleRemove;
  Function _handleIncrement;
  Function _handleClear;

  // Create a raw memcache mock with the given map as content.
  MockRawMemcache();

  void registerGet(Function handler) {
    _handleGet = handler;
  }

  void registerSet(Function handler) {
    _handleSet = handler;
  }

  void registerRemove(Function handler) {
    _handleRemove = handler;
  }

  void registerClear(Function handler) {
    _handleClear = handler;
  }

  void registerIncrement(Function handler) {
    _handleIncrement = handler;
  }

  Future<List<GetResult>> get(List<GetOperation> batch) {
    if (_handleGet != null) {
      return _handleGet(batch);
    }
    throw 'Unexpected memcache get';
  }

  Future<List<SetResult>> set(List<SetOperation> batch) {
    if (_handleSet != null) {
      return _handleSet(batch);
    }
    throw 'Unexpected memcache set';
  }

  Future<List<RemoveResult>> remove(List<RemoveOperation> batch) {
    if (_handleRemove != null) {
      return _handleRemove(batch);
    }
    throw 'Unexpected memcache remove';
  }

  Future<List<IncrementResult>> increment(List<IncrementOperation> batch) {
    if (_handleIncrement != null) {
      return _handleIncrement(batch);
    }
    throw 'Unexpected memcache remove';
  }

  Future clear() {
    if (_handleClear != null) {
      return _handleClear();
    }
    throw 'Unexpected memcache clear';
  }
}
