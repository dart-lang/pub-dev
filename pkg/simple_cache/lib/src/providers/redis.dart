// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io' show SocketException;
import 'package:dartis/dartis.dart';
import 'package:retry/retry.dart';
import '../../cache_provider.dart';

class _RedisContext {
  final Connection connection;
  final Client client;
  final Commands<String, List<int>> commands;
  _RedisContext({this.connection, this.client, this.commands});
}

typedef _Op<T> = Future<T> Function(Commands<String, List<int>>);

class RedisCacheProvider extends CacheProvider<List<int>> {
  final String _connectionString;
  final RetryOptions _connectRetryOptions;
  final RetryOptions _cmdRetryOptions;
  final Duration _connectTimeLimit;
  final Duration _commandTimeLimit;

  Future<_RedisContext> _context;
  bool _isClosed = false;

  RedisCacheProvider(
    this._connectionString, {
    RetryOptions connectRetryOptions = const RetryOptions(),
    RetryOptions commandRetryOptions = const RetryOptions(
      delayFactor: Duration(milliseconds: 50),
      maxDelay: Duration(milliseconds: 200),
      maxAttempts: 2,
    ),
    Duration connectTimeLimit = const Duration(seconds: 30),
    Duration commandTimeLimit = const Duration(milliseconds: 200),
  })  : _connectRetryOptions = connectRetryOptions,
        _cmdRetryOptions = commandRetryOptions,
        _connectTimeLimit = connectTimeLimit,
        _commandTimeLimit = commandTimeLimit {
    assert(_connectRetryOptions != null, 'connectRetryOptions must be given');
    assert(_cmdRetryOptions != null, 'commandRetryOptions must be given');
    assert(_connectionString.isNotEmpty, 'connectionString must be given');
    assert(!_connectTimeLimit.isNegative, 'connectTimeLimit is negative');
    assert(!_commandTimeLimit.isNegative, 'commandTimeLimit is negative');
  }

  Future<_RedisContext> _connect() {
    try {
      return _connectRetryOptions.retry(() async {
        // Attempt to make a connection, timeout after _connectTimeLimit
        final connection = await Connection.connect(_connectionString)
            .timeout(_connectTimeLimit);
        // When connection is closed, error or somehow we reset _context.
        // Any errors have already been returned if any commands were affect
        // otherwise the error is just a broken TCP connection and we ignore it.
        connection.done
          ..then((_) => _context = null)
          ..catchError((e) => _context = null);
        // Create context
        final client = Client(connection);
        return _RedisContext(
          connection: connection,
          client: client,
          commands: client.asCommands(),
        );
      }, retryIf: (e) => e is TimeoutException || e is SocketException);
    } on Exception {
      // if we failed to connect, discard the context after 30 seconds, so
      // future requests can retry again.
      Future.delayed(Duration(seconds: 30), () => _context = null);
      rethrow;
    }
  }

  Future<T> _withRedis<T>(_Op<T> fn) async => _cmdRetryOptions.retry(() async {
        if (_isClosed) {
          throw CacheProviderClosedException();
        }
        final context = (_context ?? (_context = _connect()));
        final ctx = await context.timeout(_commandTimeLimit);
        try {
          return await fn(ctx.commands).timeout(_commandTimeLimit);
        } on TimeoutException {
          // If we had a timeout, doing the command we forcibly disconnect
          // from the server, such that next retry will use a new connection.
          await ctx.connection.disconnect().catchError((e) {/* ignore */});
          rethrow;
        }
      },
          retryIf: (e) =>
              e is TimeoutException ||
              e is SocketException ||
              e is RedisConnectionClosedException);

  @override
  Future<void> close() async {
    _isClosed = true;
    if (_context != null) {
      final ctx = await _context.catchError((e) {/* ignore */});
      if (ctx != null) {
        await ctx.connection.disconnect().catchError((e) {/* ignore */});
      }
    }
  }

  @override
  Future<List<int>> get(String key) => _withRedis((redis) => redis.get(key));

  @override
  Future<void> set(String key, List<int> value, [Duration ttl]) =>
      _withRedis((redis) => redis.set(key, value, seconds: ttl?.inSeconds));

  @override
  Future<void> purge(String key) => _withRedis((redis) => redis.del(key: key));
}
