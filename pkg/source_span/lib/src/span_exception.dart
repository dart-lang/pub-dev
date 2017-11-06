// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'span.dart';

/// A class for exceptions that have source span information attached.
class SourceSpanException implements Exception {
  // This is a getter so that subclasses can override it.
  /// A message describing the exception.
  String get message => _message;
  final String _message;

  // This is a getter so that subclasses can override it.
  /// The span associated with this exception.
  ///
  /// This may be `null` if the source location can't be determined.
  SourceSpan get span => _span;
  final SourceSpan _span;

  SourceSpanException(this._message, this._span);

  /// Returns a string representation of [this].
  ///
  /// [color] may either be a [String], a [bool], or `null`. If it's a string,
  /// it indicates an ANSII terminal color escape that should be used to
  /// highlight the span's text. If it's `true`, it indicates that the text
  /// should be highlighted using the default color. If it's `false` or `null`,
  /// it indicates that the text shouldn't be highlighted.
  String toString({color}) {
    if (span == null) return message;
    return "Error on " + span.message(message, color: color);
  }
}

/// A [SourceSpanException] that's also a [FormatException].
class SourceSpanFormatException extends SourceSpanException
    implements FormatException {
  // This is a getter so that subclasses can override it.
  dynamic get source => _source;
  final _source;

  int get offset => span == null ? null : span.start.offset;

  SourceSpanFormatException(String message, SourceSpan span, [this._source])
      : super(message, span);
}
