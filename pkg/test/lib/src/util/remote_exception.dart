// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:isolate';

import 'package:stack_trace/stack_trace.dart';

import '../frontend/expect.dart';

/// An exception that was thrown remotely.
///
/// This could be an exception thrown in a different isolate, a different
/// process, or on an entirely different computer.
class RemoteException implements Exception {
  /// The original exception's message, if it had one.
  ///
  /// If the original exception was a plain string, this will contain that
  /// string.
  final String message;

  /// The value of the original exception's `runtimeType.toString()`.
  final String type;

  /// The value of the original exception's `toString()`.
  final String _toString;

  /// Serializes [error] and [stackTrace] into a JSON-safe object.
  ///
  /// Other than JSON- and isolate-safety, no guarantees are made about the
  /// serialized format.
  static serialize(error, StackTrace stackTrace) {
    var message;
    if (error is String) {
      message = error;
    } else {
      try {
        message = error.message.toString();
      } on NoSuchMethodError catch (_) {
        // Do nothing.
      }
    }

    // It's possible (although unlikely) for a user-defined class to have
    // multiple of these supertypes. That's fine, though, since we only care
    // about core-library-raised IsolateSpawnExceptions anyway.
    var supertype;
    if (error is TestFailure) {
      supertype = 'TestFailure';
    } else if (error is IsolateSpawnException) {
      supertype = 'IsolateSpawnException';
    }

    return {
      'message': message,
      'type': error.runtimeType.toString(),
      'supertype': supertype,
      'toString': error.toString(),
      'stackChain': new Chain.forTrace(stackTrace).toString()
    };
  }

  /// Deserializes an exception serialized with [RemoteException.serialize].
  ///
  /// The returned [AsyncError] is guaranteed to have a [RemoteException] as its
  /// error and a [Chain] as its stack trace.
  static AsyncError deserialize(serialized) {
    return new AsyncError(_deserializeException(serialized),
        new Chain.parse(serialized['stackChain']));
  }

  /// Deserializes the exception portion of [serialized].
  static RemoteException _deserializeException(serialized) {
    var message = serialized['message'];
    var type = serialized['type'];
    var toString = serialized['toString'];

    switch (serialized['supertype']) {
      case 'TestFailure':
        return new _RemoteTestFailure(message, type, toString);
      case 'IsolateSpawnException':
        return new _RemoteIsolateSpawnException(message, type, toString);
      default:
        return new RemoteException._(message, type, toString);
    }
  }

  RemoteException._(this.message, this.type, this._toString);

  String toString() => _toString;
}

/// A subclass of [RemoteException] that implements [TestFailure].
///
/// It's important to preserve [TestFailure]-ness, because tests have different
/// results depending on whether an exception was a failure or an error.
class _RemoteTestFailure extends RemoteException implements TestFailure {
  _RemoteTestFailure(String message, String type, String toString)
      : super._(message, type, toString);
}

/// A subclass of [RemoteException] that implements [IsolateSpawnException].
class _RemoteIsolateSpawnException extends RemoteException
    implements IsolateSpawnException {
  _RemoteIsolateSpawnException(String message, String type, String toString)
      : super._(message, type, toString);
}
