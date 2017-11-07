// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library memcache.dialer;

import 'dart:async';

import '../memcache.dart' show NetworkException;
import 'memcache_native_connection.dart' show MemCacheNativeConnection;

/// Used for dialing the memcached server.
///
/// If several callers attempt to dial at the same point in time, only the first
/// one will trigger a connection attempt and all of them will receive the same
/// connection (or an error).
///
/// The number of dialing attempts will be rate-limited in order to not flood
/// the server and avoid busy loops where callers constantly attempt to dial a
/// nonexistent/down peer.
class Dialer {
  static const Duration _MinimumTimeBetweenConnects =
      const Duration(seconds: 2);

  final String host;
  final int port;

  Completer _completer;
  DateTime _lastDial;

  Dialer(this.host, this.port);

  /// Dials the server and returns the [MemCacheNativeConnection] or results
  /// in a [NetworkException].
  ///
  /// Concurrent dialing attempts will result in the same connection (or error).
  ///
  /// The number of dials a second is rate-limited.
  Future<MemCacheNativeConnection> dial() {
    if (_completer != null) return _completer.future;
    _completer = new Completer<MemCacheNativeConnection>();
    _performSingleDial();
    return _completer.future;
  }

  _performSingleDial() async {
    // We rate-limit the number of dials to `1/_MinimumTimeBetweenConnects`.
    if (_lastDial != null) {
      final now = new DateTime.now();
      final duration = now.difference(_lastDial);
      if (duration < _MinimumTimeBetweenConnects) {
        await new Future.delayed(_MinimumTimeBetweenConnects - duration);
      }
    }
    _lastDial = new DateTime.now();

    try {
      final connection = await MemCacheNativeConnection.connect(host, port);
      _completer.complete(connection);
      _completer = null;
    } catch (error) {
      _completer.completeError(new NetworkException(error));
      _completer = null;
    }
  }
}
