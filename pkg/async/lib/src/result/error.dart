// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import '../result.dart';
import 'value.dart';

/// A result representing a thrown error.
class ErrorResult<T> implements Result<T> {
  final error;
  final StackTrace stackTrace;

  bool get isValue => false;
  bool get isError => true;
  ValueResult<T> get asValue => null;
  ErrorResult<T> get asError => this;

  ErrorResult(this.error, this.stackTrace);

  void complete(Completer completer) {
    completer.completeError(error, stackTrace);
  }

  void addTo(EventSink sink) {
    sink.addError(error, stackTrace);
  }

  Future<T> get asFuture => new Future.error(error, stackTrace);

  /// Calls an error handler with the error and stacktrace.
  ///
  /// An async error handler function is either a function expecting two
  /// arguments, which will be called with the error and the stack trace, or it
  /// has to be a function expecting only one argument, which will be called
  /// with only the error.
  void handle(Function errorHandler) {
    if (errorHandler is ZoneBinaryCallback) {
      errorHandler(error, stackTrace);
    } else {
      errorHandler(error);
    }
  }
}
