// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pub_dev/service/async_queue/async_queue.dart';

import 'monitoring.dart';

final _logger = Logger('cached_value');

typedef UpdateFn<T> = Future<T?> Function();

/// Wraps a locally cached value that is periodically updated, and can be accessed synchronously.
///
/// - The `updateFn` function should throw an exception if the there
///   was an issue getting the value. Such exceptions are caught and
///   reported in the logs.
///
///   The `updateFn` function may return `null`, and it is not considered
///   a failure, and won't be logged. However, `isAvailable` will return
///   true only if the value is non-null.
///
///   The `updateFn` function should do have its own retry logic.
///
/// - The default `timeout` value is half of the `interval`.
///
/// - `maxAge` is used to affect `isAvailable` and also to raise the
///   level of logging if the updates happen to fail longer than the
///   specified age.
///
/// `CacheValue` will eventually retry the `update` function when the next scheduled update happens.
class CachedValue<T> {
  final String _name;
  final UpdateFn<T> _updateFn;
  final Duration _maxAge;
  final Duration _interval;
  final Duration _timeout;
  DateTime _lastUpdated = clock.now();
  T? _value;
  Completer? _ongoingCompleter;
  bool _closing = false;
  bool _scheduled = false;

  CachedValue({
    required String name,
    required Duration maxAge,
    required Duration interval,
    required UpdateFn<T> updateFn,
    Duration? timeout,
  })  : _name = name,
        _maxAge = maxAge,
        _interval = interval,
        _updateFn = updateFn,
        _timeout = timeout ?? interval ~/ 2;

  DateTime get lastUpdated => _lastUpdated;
  Duration get age => clock.now().difference(_lastUpdated);

  bool get isAvailable {
    _scheduleIfNeeded();
    return _value != null && age <= _maxAge;
  }

  /// The cached value, may be null.
  T? get value {
    _scheduleIfNeeded();
    return _value;
  }

  void _scheduleIfNeeded() {
    if (!_scheduled && !_closing && (_value == null || age > _interval)) {
      _scheduled = true;
      asyncQueue.addAsyncFn(() async {
        try {
          await _update();
        } finally {
          _scheduled = false;
        }
      });
    }
  }

  @visibleForTesting
  void setValue(T v) {
    _value = v;
    _lastUpdated = clock.now();
  }

  /// Updates the cached value.
  Future<void> update() async {
    if (_closing) {
      throw StateError('Cache `$_name` is already closed.');
    }
    await _update();
  }

  Future<void> _update() async {
    if (_ongoingCompleter != null) {
      await _ongoingCompleter!.future;
      return;
    }
    if (_closing) return;
    _ongoingCompleter = Completer();
    try {
      _value = await _updateFn().timeout(_timeout);
      if (_value != null) {
        _lastUpdated = clock.now();
      }
    } catch (e, st) {
      if (age <= _maxAge) {
        _logger.pubNoticeWarning(
            'cached_value', 'Updating cached `$_name` value failed.', e, st);
      } else {
        _logger.pubNoticeShout(
            'cached_value', 'Updating cached `$_name` value failed.', e, st);
      }
    } finally {
      final c = _ongoingCompleter;
      _ongoingCompleter = null;
      c?.complete();
    }
  }

  Future<void> close() async {
    _closing = true;
    if (_ongoingCompleter != null) {
      await _ongoingCompleter!.future;
    }
  }
}
