// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// TODO: This library is a decent proposal for addition to `dart:async` or
//       other similar utility package. It's extremely useful when processing
//       a stream of objects, where I/O is required for each object.

import 'dart:async';

/// A [Notifier] allows micro-tasks to [wait] for other micro-tasks to
/// [notify].
///
/// [Notifier] is a concurrency primitive that allows one micro-task to
/// wait for notification from another micro-task. The [Future] return from
/// [wait] will be completed the next time [notify] is called.
///
/// ```dart
/// var weather = 'rain';
/// final notifier = Notifier();
///
/// // Create a micro task to fetch the weather
/// scheduleMicrotask(() async {
///   // Infinitely loop that just keeps the weather up-to-date
///   while (true) {
///     weather = await getWeather();
///     notifier.notify();
///
///     // Sleep 5s before updating the weather again
///     await Future.delayed(Duration(seconds: 5));
///   }
/// });
///
/// // Wait for sunny weather
/// while (weather != 'sunny') {
///   await notifier.wait;
/// }
/// ```
final class Notifier {
  var _completer = Completer<void>();

  /// Notify everybody waiting for notification.
  ///
  /// This will complete all futures previously returned by [wait].
  /// Calls to [wait] after this call, will not be resolved, until the
  /// next time [notify] is called.
  void notify() {
    if (!_completer.isCompleted) {
      _completer.complete();
    }
  }

  /// Wait for notification.
  ///
  /// Returns a [Future] that will complete the next time [notify] is called.
  ///
  /// The [Future] returned will always be unresolved, and it will never throw.
  /// Once [notify] is called the future will be completed, and any new calls
  /// to [wait] will return a new future. This new future will also be
  /// unresolved, until [notify] is called.
  Future<void> get wait {
    if (_completer.isCompleted) {
      _completer = Completer();
    }
    return _completer.future;
  }
}

/// Utility extensions on [Stream].
extension StreamExtensions<T> on Stream<T> {
  /// Call [each] for each item in this stream with [maxParallel] invocations.
  ///
  /// This method will invoke [each] for each item in this stream, and wait for
  /// all futures from [each] to be resolved. [parallelForEach] will call [each]
  /// in parallel, but never more then [maxParallel].
  ///
  /// If [each] throws and [onError] rethrows (default behavior), then
  /// [parallelForEach] will wait for ongoing [each] invocations to finish,
  /// before throw the first error.
  ///
  /// If [onError] does not throw, then iteration will not be interrupted and
  /// errors from [each] will be ignored.
  ///
  /// ```dart
  /// // Count size of all files in the current folder
  /// var folderSize = 0;
  /// // Use parallelForEach to read at-most 5 files at the same time.
  /// await Directory.current.list().parallelForEach(5, (item) async {
  ///   if (item is File) {
  ///     final bytes = await item.readAsBytes();
  ///     folderSize += bytes.length;
  ///   }
  /// });
  /// print('Folder size: $folderSize');
  /// ```
  Future<void> parallelForEach(
    int maxParallel,
    FutureOr<void> Function(T item) each, {
    FutureOr<void> Function(Object e, StackTrace? st) onError = Future.error,
  }) async {
    // Track the first error, so we rethrow when we're done.
    Object? firstError;
    StackTrace? firstStackTrace;

    // Track number of running items.
    var running = 0;
    final itemDone = Notifier();

    try {
      var doBreak = false;
      await for (final item in this) {
        // For each item we increment [running] and call [each]
        running += 1;
        unawaited(() async {
          try {
            await each(item);
          } catch (e, st) {
            try {
              // If [onError] doesn't throw, we'll just continue.
              await onError(e, st);
            } catch (e, st) {
              doBreak = true;
              if (firstError == null) {
                firstError = e;
                firstStackTrace = st;
              }
            }
          } finally {
            // When [each] is done, we decrement [running] and notify
            running -= 1;
            itemDone.notify();
          }
        }());

        if (running >= maxParallel) {
          await itemDone.wait;
        }
        if (doBreak) {
          break;
        }
      }
    } finally {
      // Wait for all items to be finished
      while (running > 0) {
        await itemDone.wait;
      }
    }

    // If an error happened, then we rethrow the first one.
    final firstError_ = firstError;
    final firstStackTrace_ = firstStackTrace;
    if (firstError_ != null && firstStackTrace_ != null) {
      Error.throwWithStackTrace(firstError_, firstStackTrace_);
    }
  }
}
