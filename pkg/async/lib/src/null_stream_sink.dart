// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

/// A [StreamSink] that discards all events.
///
/// The sink silently drops events until [close] is called, at which point it
/// throws [StateError]s when events are added. This is the same behavior as a
/// sink whose remote end has closed, such as when a [WebSocket] connection has
/// been closed.
///
/// This can be used when a sink is needed but no events are actually intended
/// to be added. The [new NullStreamSink.error] constructor can be used to
/// represent errors when creating a sink, since [StreamSink.done] exposes sink
/// errors. For example:
///
/// ```dart
/// StreamSink<List<int>> openForWrite(String filename) {
///   try {
///     return new RandomAccessSink(new File(filename).openSync());
///   } on IOException catch (error, stackTrace) {
///     return new NullStreamSink.error(error, stackTrace);
///   }
/// }
/// ```
class NullStreamSink<T> implements StreamSink<T> {
  final Future done;

  /// Whether the sink has been closed.
  var _closed = false;

  /// Whether an [addStream] call is pending.
  ///
  /// We don't actually add any events from streams, but it does return the
  /// [StreamSubscription.cancel] future so to be [StreamSink]-complaint we
  /// reject events until that completes.
  var _addingStream = false;

  /// Creates a null sink.
  ///
  /// If [done] is passed, it's used as the [Sink.done] future. Otherwise, a
  /// completed future is used.
  NullStreamSink({Future done}) : done = done ?? new Future.value();

  /// Creates a null sink whose [done] future emits [error].
  ///
  /// Note that this error will not be considered uncaught.
  NullStreamSink.error(error, [StackTrace stackTrace])
      : done = new Future.error(error, stackTrace)
          // Don't top-level the error. This gives the user a change to call
          // [close] or [done], and matches the behavior of a remote endpoint
          // experiencing an error.
          ..catchError((_) {});

  void add(T data) {
    _checkEventAllowed();
  }

  void addError(error, [StackTrace stackTrace]) {
    _checkEventAllowed();
  }

  Future addStream(Stream<T> stream) {
    _checkEventAllowed();

    _addingStream = true;
    var future = stream.listen(null).cancel() ?? new Future.value();
    return future.whenComplete(() {
      _addingStream = false;
    });
  }

  /// Throws a [StateError] if [close] has been called or an [addStream] call is
  /// pending.
  void _checkEventAllowed() {
    if (_closed) throw new StateError("Cannot add to a closed sink.");
    if (_addingStream) {
      throw new StateError("Cannot add to a sink while adding a stream.");
    }
  }

  Future close() {
    _closed = true;
    return done;
  }
}
