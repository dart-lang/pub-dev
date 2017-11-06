// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// TODO(lrn): This should be in package:async?
/// Helper functions for working with errors.
///
/// The [MultiError] class combines multiple errors into one object,
/// and the [MultiError.wait] function works like [Future.wait] except
/// that it returns all the errors.
library isolate.errors;

import 'dart:async';

class MultiError extends Error {
  // Limits the number of lines included from each error's error message.
  // A best-effort attempt is made at keeping below this number of lines
  // in the output.
  // If there are too many errors, they will all get at least one line.
  static const int _MAX_LINES = 55;
  // Minimum number of lines in the toString for each error.
  static const int _MIN_LINES_PER_ERROR = 1;

  /// The actual errors.
  final List errors;

  /// Create a `MultiError` based on a list of errors.
  ///
  /// The errors represent errors of a number of individual operations.
  ///
  /// The list may contain `null` values, if the index of the error in the
  /// list is useful.
  MultiError(this.errors);

  /// Waits for all [futures] to complete, like [Future.wait].
  ///
  /// Where `Future.wait` only reports one error, even if multiple
  /// futures complete with errors, this function will complete
  /// with a [MultiError] if more than one future completes with an error.
  ///
  /// The order of values is not preserved (if that is needed, use
  /// [wait]).
  static Future<List> waitUnordered(Iterable<Future> futures,
      {cleanUp(successResult)}) {
    Completer completer;
    int count = 0;
    int errors = 0;
    int values = 0;
    // Initialized to `new List(count)` when count is known.
    // Filled up with values on the left, errors on the right.
    // Order is not preserved.
    List results;
    void checkDone() {
      if (errors + values < count) return;
      if (errors == 0) {
        completer.complete(results);
        return;
      }
      var errorList = results.sublist(results.length - errors);
      completer.completeError(new MultiError(errorList));
    }

    var handleValue = (v) {
      // If this fails because [results] is null, there is a future
      // which breaks the Future API by completing immediately when
      // calling Future.then, probably by misusing a synchronous completer.
      results[values++] = v;
      if (errors > 0 && cleanUp != null) {
        new Future.sync(() => cleanUp(v));
      }
      checkDone();
    };
    var handleError = (e, s) {
      if (errors == 0 && cleanUp != null) {
        for (int i = 0; i < values; i++) {
          var value = results[i];
          if (value != null) new Future.sync(() => cleanUp(value));
        }
      }
      results[results.length - ++errors] = e;
      checkDone();
    };
    for (Future future in futures) {
      count++;
      future.then(handleValue, onError: handleError);
    }
    if (count == 0) return new Future.value(new List(0));
    results = new List(count);
    completer = new Completer();
    return completer.future;
  }

  /// Waits for all [futures] to complete, like [Future.wait].
  ///
  /// Where `Future.wait` only reports one error, even if multiple
  /// futures complete with errors, this function will complete
  /// with a [MultiError] if more than one future completes with an error.
  ///
  /// The order of values is preserved, and if any error occurs, the
  /// [MultiError.errors] list will have errors in the corresponding slots,
  /// and `null` for non-errors.
  Future<List> wait(Iterable<Future> futures, {cleanUp(successResult)}) {
    Completer completer;
    int count = 0;
    bool hasError = false;
    int completed = 0;
    // Initialized to `new List(count)` when count is known.
    // Filled with values until the first error, then cleared
    // and filled with errors.
    List results;
    void checkDone() {
      completed++;
      if (completed < count) return;
      if (!hasError) {
        completer.complete(results);
        return;
      }
      completer.completeError(new MultiError(results));
    }

    for (Future future in futures) {
      int i = count;
      count++;
      future.then((v) {
        if (!hasError) {
          results[i] = v;
        } else if (cleanUp != null) {
          new Future.sync(() => cleanUp(v));
        }
        checkDone();
      }, onError: (e, s) {
        if (!hasError) {
          if (cleanUp != null) {
            for (int i = 0; i < results.length; i++) {
              var result = results[i];
              if (result != null) new Future.sync(() => cleanUp(result));
            }
          }
          results.fillRange(0, results.length, null);
          hasError = true;
        }
        results[i] = e;
        checkDone();
      });
    }
    if (count == 0) return new Future.value(new List(0));
    results = new List(count);
    completer = new Completer();
    return completer.future;
  }

  String toString() {
    StringBuffer buffer = new StringBuffer();
    buffer.write("Multiple Errors:\n");
    int linesPerError = _MAX_LINES ~/ errors.length;
    if (linesPerError < _MIN_LINES_PER_ERROR) {
      linesPerError = _MIN_LINES_PER_ERROR;
    }

    for (int index = 0; index < errors.length; index++) {
      var error = errors[index];
      if (error == null) continue;
      String errorString = error.toString();
      int end = 0;
      for (int i = 0; i < linesPerError; i++) {
        end = errorString.indexOf('\n', end) + 1;
        if (end == 0) {
          end = errorString.length;
          break;
        }
      }
      buffer.write("#$index: ");
      buffer.write(errorString.substring(0, end));
      if (end < errorString.length) {
        buffer.write("...\n");
      }
    }
    return buffer.toString();
  }
}
