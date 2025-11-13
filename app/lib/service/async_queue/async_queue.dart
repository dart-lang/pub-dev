// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:stack_trace/stack_trace.dart';

final _logger = Logger('async_queue');

/// Sets the [AsyncQueue] service in the scope.
void registerAsyncQueue(AsyncQueue service) =>
    ss.register(#_asyncQueue, service);

/// The active [AsyncQueue] service.
AsyncQueue get asyncQueue => ss.lookup(#_asyncQueue) as AsyncQueue;

typedef AsyncFn = Future<void> Function();

/// Handles off-request asynchronous task processing, potentially including:
/// - post-upload tasks
/// - local cache updates
/// - deferred cache invalidations
///
/// **Motivation behind this service**
///
/// Appengine logging won't send log messages after the request was completed,
/// therefore we can't defer microtasks on the same zone as the request is doing.
/// It may not be worth to wait and block request processing on such asynchronous
/// tasks, better to offload them into this processing queue.
class AsyncQueue {
  final Zone _zone;
  final _queue = Queue<_Task>();
  bool _closed = false;
  Future? _nextProcessing;

  @visibleForTesting
  Future get ongoingProcessing => _nextProcessing ?? Future.value(null);

  AsyncQueue() : _zone = Zone.current;

  ({Future future}) addAsyncFn(AsyncFn fn) {
    if (_closed) {
      // If we have ongoing processing, we want to accept the task,
      // as the queue will pick it up as part of the `close()` call.
      // This way the tests are covering all of the triggered events
      // and don't leave the system in an inconsistent state.
      if (_nextProcessing == null) {
        throw StateError('AsyncQueue is closed, task was not accepted.');
      }
    }
    final task = _Task(fn, StackTrace.current);
    _queue.add(task);
    _triggerProcessing();
    return (future: task.completer.future);
  }

  void _triggerProcessing() {
    _nextProcessing ??= _zone.run(() => Future.microtask(_process));
  }

  Future<void> _process() async {
    while (_queue.isNotEmpty) {
      final first = _queue.removeFirst();
      try {
        await first.fn();
        first.completer.complete();
      } catch (e, st) {
        final trace = Chain([Trace.from(st), Trace.from(first.origin)]).terse;
        stderr.writeln('Error executing off-request function: $e\n$trace');
        _logger.severe('Error executing off-request function.', e, trace);
        first.completer.completeError(e, st);
      }
    }

    _nextProcessing = null;
  }

  Future close() async {
    _closed = true;
    await ongoingProcessing;
  }
}

class _Task {
  final AsyncFn fn;
  final StackTrace origin;
  final completer = Completer();

  _Task(this.fn, this.origin);
}
