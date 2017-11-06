// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library nop_memcache_raw_impl;

import 'dart:async';

import 'package:memcache/memcache_raw.dart' as raw;

/// A NOP implementation of the [raw.RawMemcache] interface.
///
/// It will not cache anything and will return "not found" on lookups.
class NopMemcacheRpcImpl implements raw.RawMemcache {
  Future<List<raw.GetResult>> get(List<raw.GetOperation> batch) async {
    final getResult =
        new raw.GetResult(raw.Status.KEY_NOT_FOUND, null, 0, null, null);
    return new List<raw.GetResult>.filled(batch.length, getResult);
  }

  Future<List<raw.SetResult>> set(List<raw.SetOperation> batch) async {
    final result = new raw.SetResult(raw.Status.NO_ERROR, null);
    return new List<raw.SetResult>.filled(batch.length, result);
  }

  Future<List<raw.RemoveResult>> remove(List<raw.RemoveOperation> batch) async {
    final result = new raw.RemoveResult(raw.Status.KEY_NOT_FOUND, null);
    return new List<raw.RemoveResult>.filled(batch.length, result);
  }

  Future<List<raw.IncrementResult>> increment(
      List<raw.IncrementOperation> batch) async {
    return batch.map((raw.IncrementOperation op) {
      return new raw.IncrementResult(
          raw.Status.NO_ERROR, "no support", op.initialValue ?? 0);
    }).toList(growable: false);
  }

  Future clear() async {}
}
