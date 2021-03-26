// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:retry/retry.dart';

final _logger = Logger('cached_value');

typedef UpdateFn<T> = Future<T> Function();

/// A locally cached and periodically updated value that can be accessed
/// synchronously.
class CachedValue<T> {
  final UpdateFn<T> _updateFn;
  final RetryOptions _retryOptions;
  Timer _timer;
  T _value;
  Completer _ongoingCompleter;
  bool _initialized = false;

  CachedValue({
    @required UpdateFn<T> fn,
    RetryOptions retryOptions,
  })  : _updateFn = fn,
        _retryOptions = retryOptions ??
            RetryOptions(
              delayFactor: Duration(seconds: 3),
              maxAttempts: 3,
            );

  bool get isInitialized => _initialized;

  T get value => _value;
  set value(T v) {
    _value = v;
    _initialized = true;
  }

  /// Updates the cached value.
  Future<void> update() async {
    if (_ongoingCompleter != null) {
      await _ongoingCompleter.future;
      return;
    }
    _ongoingCompleter = Completer();
    try {
      await _retryOptions.retry(() async {
        _value = await _updateFn();
        _initialized = true;
      });
    } catch (e, st) {
      _logger.warning('Updating cached value failed.', e, st);
    } finally {
      final c = _ongoingCompleter;
      _ongoingCompleter = null;
      c.complete();
    }
  }

  void scheduleUpdates(Duration duration) {
    _timer?.cancel();
    _timer = Timer.periodic(duration, (timer) {
      update();
    });
  }

  Future<void> close() async {
    _timer?.cancel();
    _timer = null;
  }
}
