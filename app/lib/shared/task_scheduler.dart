// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:collection';

import 'package:logging/logging.dart';

final Logger _logger = new Logger('pub.scheduler');

/// Interface for task execution.
typedef Future TaskRunner(Task task);

// ignore: one_member_abstracts
abstract class TaskSource {
  /// Returns a stream of currently available tasks at the time of the call.
  Stream<Task> startStreaming();
}

/// Tasks coming from through the isolate's receivePort, originating from a
/// HTTP handler that received a ping after a new upload.
class ManualTriggerTaskSource implements TaskSource {
  final Stream _taskReceivePort;
  ManualTriggerTaskSource(this._taskReceivePort);

  @override
  Stream<Task> startStreaming() => _taskReceivePort;
}

/// Schedules and executes package analysis.
class TaskScheduler {
  final TaskRunner taskRunner;
  final List<TaskSource> sources;

  TaskScheduler(this.taskRunner, this.sources);

  Future run() async {
    final PrioritizedAsyncIterator<Task> taskIterator =
        new PrioritizedAsyncIterator(
            sources.map((TaskSource ts) => ts.startStreaming()).toList());
    while (await taskIterator.hasNext) {
      final Task task = await taskIterator.next;
      try {
        await taskRunner(task);
      } catch (e, st) {
        _logger.severe('Error processing task: $task', e, st);
      }
    }
  }
}

/// A task for a given package and version.
class Task {
  final String package;
  final String version;

  Task(this.package, this.version);

  @override
  String toString() => '$package $version';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task &&
          runtimeType == other.runtimeType &&
          version == other.version;

  @override
  int get hashCode => version.hashCode;
}

/// A pull-based interface for accessing events from multiple streams, in the
/// priority order of the streams provided.
///
/// Inspired by Iterator and package:async's StreamQueue.
class PrioritizedAsyncIterator<T> {
  List<Queue<T>> _priorityQueues;
  List<StreamSubscription> _subscriptions;
  bool _isClosed = false;
  Completer<bool> _hasNextCompleter;
  Completer<T> _nextCompleter;

  PrioritizedAsyncIterator(List<Stream<T>> sources) {
    _priorityQueues = new List.generate(sources.length, (_) => new Queue());
    _subscriptions = new List(sources.length);

    // Listen on the streams and put items into their own queues.
    for (int i = 0; i < sources.length; i++) {
      final Stream source = sources[i];
      final Queue<T> queue = _priorityQueues[i];
      _subscriptions[i] = source.listen(
        (T item) {
          queue.add(item);
          _triggerComplete();
        },
        onDone: () {
          _subscriptions[i] = null;
          _closeWhenAllDone();
        },
        cancelOnError: true,
      );
    }
  }

  /// Whether the iterator has any immediately available item.
  bool get hasAvailable {
    final Queue<T> queue = _firstQueue();
    return queue != null;
  }

  /// Whether the iterator has another item.
  Future<bool> get hasNext async {
    if (_hasNextCompleter != null) return _hasNextCompleter.future;
    if (_isClosed) return false;
    final Queue<T> queue = _firstQueue();
    if (queue != null) {
      return true;
    } else {
      _hasNextCompleter ??= new Completer();
      _closeWhenAllDone();
      return _hasNextCompleter.future;
    }
  }

  /// The next item in the iterator.
  Future<T> get next async {
    if (_nextCompleter != null) return _nextCompleter.future;
    final Queue<T> queue = _firstQueue();
    if (queue != null) {
      return queue.removeFirst();
    } else {
      _nextCompleter ??= new Completer();
      _closeWhenAllDone();
      return _nextCompleter.future;
    }
  }

  /// Close the source streams and don't accept new requests.
  Future close() async {
    if (_hasNextCompleter != null) {
      _hasNextCompleter.complete(false);
      _hasNextCompleter = null;
    }
    if (_nextCompleter != null) {
      _nextCompleter.completeError('PrioritizedStreamQueue close() called.');
      _nextCompleter = null;
    }
    for (int i = 0; i < _subscriptions.length; i++) {
      final StreamSubscription s = _subscriptions[i];
      if (s != null) {
        s.cancel();
        _subscriptions[i] = null;
      }
    }
    _isClosed = true;
  }

  Queue<T> _firstQueue() {
    if (_isClosed) {
      throw new Exception('PrioritizedStreamQueue closed');
    }
    return _priorityQueues.firstWhere((q) => q.isNotEmpty, orElse: () => null);
  }

  void _triggerComplete() {
    if (_hasNextCompleter != null) {
      _hasNextCompleter.complete(true);
      _hasNextCompleter = null;
    }
    if (_nextCompleter != null) {
      final Queue<T> queue = _firstQueue();
      if (queue != null) {
        _nextCompleter.complete(queue.removeFirst());
      }
      _nextCompleter = null;
    }
    _closeWhenAllDone();
  }

  void _closeWhenAllDone() {
    if (_isClosed) return;
    if (_subscriptions.any((s) => s != null)) return;
    if (_firstQueue() != null) return;
    close();
  }
}
