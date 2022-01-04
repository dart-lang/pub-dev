// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

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
///   The `updateFn` function should do have it's own retry logic.
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
  Timer? _timer;
  T? _value;
  Completer? _ongoingCompleter;
  bool _closing = false;

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
  bool get isAvailable => _value != null && age <= _maxAge;

  /// The cached value, may be null.
  T? get value => _value;

  @visibleForTesting
  void setValue(T v) {
    _value = v;
    _lastUpdated = clock.now();
  }

  /// Updates the cached value.
  @visibleForTesting
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

  /// Starts a periodic Timer to update the cached value.
  ///
  /// If this is the first call of [start], and initial value
  /// was not set, this will also call [update].
  Future<void> start() async {
    if (_closing) {
      throw StateError('Cache `$_name` is already closed.');
    }
    if (!isAvailable && _timer == null) {
      await _update();
      // ignore: invariant_booleans
      if (_closing) return;
    }
    _timer ??= Timer.periodic(_interval, (timer) {
      _update();
    });
  }

  Future<void> close() async {
    _closing = true;
    _timer?.cancel();
    _timer = null;
    if (_ongoingCompleter != null) {
      await _ongoingCompleter!.future;
    }
  }
}
