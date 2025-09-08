// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';

extension LoggerExt on Logger {
  /// Log a `[pub-notice:${code}` as warning.
  ///
  /// A custom log based metric will track how frequently each [code] happens.
  /// This is useful for logging non-critical errors that we can tolerate, but want to
  /// detect and remedy, should they occur frequently.
  ///
  /// [code] should be a hardcoded string to keep dimensionality manageable.
  void pubNoticeWarning(
    String code,
    String message, [
    Object? error,
    StackTrace? st,
  ]) {
    warning('[pub-notice:$code] $message', error, st);
  }

  /// Log a `[pub-notice:${code}` with severity shout.
  ///
  /// A custom log based metric will track how frequently each [code] happens.
  /// This is useful for logging non-critical errors that we can tolerate, but want to
  /// detect and remedy, should they occur frequently.
  ///
  /// [code] should be a hardcoded string to keep dimensionality manageable.
  void pubNoticeShout(
    String code,
    String message, [
    Object? error,
    StackTrace? st,
  ]) {
    shout('[pub-notice:$code] $message', error, st);
  }
}
