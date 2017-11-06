// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library memcache.raw;

import "dart:async";

import 'src/dialer.dart' show Dialer;
import 'src/memcache_native_connection.dart' as api;

class Status {
  final int _status;
  final String _name;
  static Status NO_ERROR = const Status._(0x0000, 'NO_ERROR');
  static Status KEY_NOT_FOUND = const Status._(0x0001, 'KEY_NOT_FOUND');
  static Status KEY_EXISTS = const Status._(0x0002, 'KEY_EXISTS');
  static Status NOT_STORED = const Status._(0x0005, 'NOT_STORED');
  static Status ERROR = const Status._(0x0084, 'ERROR');

  const Status._(this._status, this._name);

  int get hashCode => _status.hashCode;

  String toString() => 'Status($_name)';
}

/**
 * Low level memcache interface providing access to all details.
 */
abstract class RawMemcache {
  Future<List<GetResult>> get(List<GetOperation> batch);
  Future<List<SetResult>> set(List<SetOperation> batch);
  Future<List<RemoveResult>> remove(List<RemoveOperation> batch);
  Future<List<IncrementResult>> increment(List<IncrementOperation> batch);
  Future clear();
}

class GetOperation {
  final List<int> key;

  GetOperation(this.key);

  String toString() => 'GetOperation(key: $key)';
}

class GetResult {
  final Status status;
  final String message;
  final int flags;
  final int cas;
  final List<int> value;

  GetResult(this.status, this.message, this.flags, this.cas, this.value);

  String toString() =>
      'GetResult(status: $status, message: $message, flags: $flags, '
      'cas: $cas, value: $value)';
}

class SetOperation {
  static const int SET = 0;
  static const int ADD = 1;
  static const int REPLACE = 2;
  static const int CAS = 3;

  final int operation;
  final List<int> key;
  final int flags;
  final int cas;
  final List<int> value;
  // Expiration time in seconds. If this value is less than the number of
  // seconds in 30 days (60 * 60 * 24 * 30) the expiration is relative to the
  // current time. If the value is higher than the number of seconds in 30 days
  // the expiration is absolute as seconds since the epoc.
  //
  // See https://github.com/memcached/memcached/blob/master/doc/protocol.txt.
  final int expiration;

  SetOperation(this.operation, this.key, this.flags, this.cas, this.value,
      this.expiration);

  String toString() =>
      'SetOperation(operation: $operation, key: $key, flags: $flags, '
      'cas: $cas, value: $value, expiration: $expiration)';
}

class SetResult {
  final Status status;
  final String message;

  SetResult(this.status, this.message);

  String toString() => 'SetResult(status: $status, message: $message)';
}

class RemoveOperation {
  final List<int> key;

  RemoveOperation(this.key);

  String toString() => 'RemoveOperation(key: $key)';
}

class RemoveResult {
  final Status status;
  final String message;

  RemoveResult(this.status, this.message);

  String toString() => 'RemoveResult(status: $status, message: $message)';
}

class IncrementOperation {
  static const int INCREMENT = 0;
  static const int DECREMENT = 1;

  final List<int> key;
  final int delta;
  final int direction;
  final int initialFlags;
  final int initialValue;

  IncrementOperation(this.key, this.delta, this.direction, this.initialFlags,
      this.initialValue);

  String toString() =>
      'IncrementOperation(key: $key, delta: $delta, direction: $direction, '
      'initialFlags: $initialFlags, initialValue: $initialValue)';
}

class IncrementResult {
  final Status status;
  final String message;
  final int value;

  IncrementResult(this.status, this.message, this.value);

  String toString() => 'IncrementResult(status: $status, message: $message)';
}

/// Implements the binary memcached protocol and uses a [Dialer] to (re)connect
/// to the server.
class BinaryMemcacheProtocol implements RawMemcache {
  final Dialer _dialer;
  api.MemCacheNativeConnection _connection;

  BinaryMemcacheProtocol._(this._dialer);

  factory BinaryMemcacheProtocol(String host, int port) {
    return new BinaryMemcacheProtocol._(new Dialer(host, port));
  }

  Future<List<GetResult>> get(List<GetOperation> batch) async {
    if (_connection == null || _connection.isClosed) {
      _connection = await _dialer.dial();
    }
    final List<Future> futures = batch.map((GetOperation op) {
      final request = new api.Request.get(op.key);
      return _connection.sendRequest(request);
    }).toList(growable: false);

    final List<api.Response> responses = await Future.wait(futures);
    return responses.map((api.Response response) {
      switch (response.status) {
        case api.ResponseStatus.KEY_NOT_FOUND:
          return new GetResult(Status.KEY_NOT_FOUND, response.statusMessage,
              0 /*response.flags*/, response.cas, response.value);
        case api.ResponseStatus.NO_ERROR:
          return new GetResult(Status.NO_ERROR, null, 0 /*response.flags*/,
              response.cas, response.value);
        default:
          return new GetResult(Status.ERROR, response.statusMessage,
              0 /*response.flags*/, response.cas, response.value);
      }
    }).toList(growable: false);
  }

  Future<List<SetResult>> set(List<SetOperation> batch) async {
    if (_connection == null || _connection.isClosed) {
      _connection = await _dialer.dial();
    }
    final List<Future> futures = batch.map((SetOperation op) {
      switch (op.operation) {
        case SetOperation.SET:
          return _connection.sendRequest(new api.Request.set(op.key, op.value,
              flags: op.flags ?? 0,
              cas: op.cas ?? 0,
              expiration: op.expiration ?? 0));
        case SetOperation.ADD:
          return _connection.sendRequest(new api.Request.add(op.key, op.value,
              flags: op.flags ?? 0, expiration: op.expiration ?? 0));
        case SetOperation.REPLACE:
          return _connection.sendRequest(new api.Request.replace(
              op.key, op.value,
              flags: op.flags ?? 0,
              cas: op.cas ?? 0,
              expiration: op.expiration ?? 0));
        case SetOperation.CAS:
          return _connection.sendRequest(new api.Request.set(op.key, op.value,
              flags: op.flags ?? 0,
              cas: op.cas ?? 0,
              expiration: op.expiration ?? 0));
      }
    }).toList(growable: false);

    final List<api.Response> responses = await Future.wait(futures);
    return responses.map((api.Response response) {

      switch (response.status) {
        case api.ResponseStatus.NO_ERROR:
          return new SetResult(Status.NO_ERROR, null);
        case api.ResponseStatus.ITEM_NOT_STORED:
        case api.ResponseStatus.KEY_NOT_FOUND:
          return new SetResult(Status.NOT_STORED, response.statusMessage);
        case api.ResponseStatus.KEY_EXISTS:
          return new SetResult(Status.NOT_STORED, response.statusMessage);
        default:
          return new SetResult(Status.ERROR, response.statusMessage);
      }
    }).toList(growable: false);
  }

  Future<List<RemoveResult>> remove(List<RemoveOperation> batch) async {
    if (_connection == null || _connection.isClosed) {
      _connection = await _dialer.dial();
    }
    final List<Future> futures = batch.map((RemoveOperation op) {
      final request = new api.Request.delete(op.key);
      return _connection.sendRequest(request);
    }).toList(growable: false);

    final List<api.Response> responses = await Future.wait(futures);
    return responses.map((api.Response response) {
      switch (response.status) {
        case api.ResponseStatus.NO_ERROR:
          return new RemoveResult(Status.NO_ERROR, null);
        case api.ResponseStatus.KEY_NOT_FOUND:
          return new RemoveResult(Status.KEY_NOT_FOUND, null);
        default:
          return new RemoveResult(Status.ERROR, response.statusMessage);
      }
    }).toList(growable: false);
  }

  Future<List<IncrementResult>> increment(
      List<IncrementOperation> batch) async {
    if (_connection == null || _connection.isClosed) {
      _connection = await _dialer.dial();
    }
    final List<Future> futures = batch.map((IncrementOperation op) {
      switch (op.direction) {
        case IncrementOperation.INCREMENT:
          return _connection.sendRequest(
              new api.Request.increment(op.key, op.delta, op.initialValue));
        case IncrementOperation.DECREMENT:
          return _connection.sendRequest(
              new api.Request.decrement(op.key, op.delta, op.initialValue));
        default:
          throw new ArgumentError(
              'The direction must be increment or decrement!');
      }
    }).toList(growable: false);

    final List<api.Response> responses = await Future.wait(futures);
    return responses.map((api.Response response) {
      switch (response.status) {
        case api.ResponseStatus.NO_ERROR:
          return new IncrementResult(
              Status.NO_ERROR, null, response.incrDecrValue);
        case api.ResponseStatus.KEY_NOT_FOUND:
          return new IncrementResult(
              Status.KEY_NOT_FOUND, response.statusMessage, 0);
        default:
          return new IncrementResult(Status.ERROR, response.statusMessage, 0);
      }
    }).toList(growable: false);
  }

  Future clear() async {
    if (_connection == null || _connection.isClosed) {
      _connection = await _dialer.dial();
    }

    final api.Response response =
        await _connection.sendRequest(new api.Request.flush());
    if (response.status != api.ResponseStatus.NO_ERROR) {
      throw new Exception(
          'Failed to clear memcache (which should never happen)');
    }
  }

  Future close() => _connection?.close();
}
