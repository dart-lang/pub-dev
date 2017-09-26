// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:collection';

import 'package:logging/logging.dart';

import 'utils.dart';

final Logger _logger = new Logger('pub.scheduler');

/// Interface for task execution.
abstract class TaskRunner {
  /// Whether the task has been run and completed recently, with the results
  /// stored in the database.
  Future<bool> hasCompletedRecently(Task task);

  /// Run the task.
  /// Returns whether a race was detected while the run completed.
  Future<bool> runTask(Task task);
}

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
  final LastNTracker<String> _statusTracker = new LastNTracker();
  final LastNTracker<num> _allLatencyTracker = new LastNTracker();
  final LastNTracker<num> _workLatencyTracker = new LastNTracker();
  int _pendingCount = 0;

  TaskScheduler(this.taskRunner, this.sources);

  Future run() async {
    final PrioritizedStreamIterator<Task> taskIterator =
        new PrioritizedStreamIterator(
      sources.map((TaskSource ts) => ts.startStreaming()).toList(),
      deduplicateWaiting: true,
    );
    while (await taskIterator.moveNext()) {
      final Task task = taskIterator.current;
      _pendingCount = taskIterator.pendingCount;
      final Stopwatch sw = new Stopwatch()..start();
      try {
        if (await taskRunner.hasCompletedRecently(task)) {
          _logger.info('Skipping task: $task');
          _statusTracker.add('skip');
          _allLatencyTracker.add(sw.elapsedMilliseconds);
          continue;
        }
        final bool raceDetected = await taskRunner.runTask(task);
        _statusTracker.add(raceDetected ? 'race' : 'normal');
      } catch (e, st) {
        _logger.severe('Error processing task: $task', e, st);
        _statusTracker.add('error');
      }
      _workLatencyTracker.add(sw.elapsedMilliseconds);
      _allLatencyTracker.add(sw.elapsedMilliseconds);
    }
  }

  Map stats() {
    final Map<String, dynamic> stats = <String, dynamic>{
      'pending': _pendingCount,
      'status': _statusTracker.toCounts(),
    };
    final double avgWorkMillis = _workLatencyTracker.average;
    if (avgWorkMillis > 0.0) {
      final double tph = 60 * 60 * 1000.0 / avgWorkMillis;
      stats['taskPerHour'] = tph;
    }
    final double avgMillis = _allLatencyTracker.average;
    if (avgMillis > 0.0) {
      final remaining =
          new Duration(milliseconds: (_pendingCount * avgMillis).round());
      stats['remaining'] = formatDuration(remaining);
    }
    return stats;
  }
}

/// A task for a given package and version.
class Task {
  final String package;
  final String version;
  final DateTime updated;

  Task(this.package, this.version, this.updated);

  Task.now(this.package, this.version)
      : updated = new DateTime.now().toUtc();

  @override
  String toString() => '$package $version';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task &&
          runtimeType == other.runtimeType &&
          package == other.package &&
          version == other.version &&
          updated == other.updated;

  @override
  int get hashCode =>
      package.hashCode ^ version.hashCode ^ updated.hashCode;
}

/// A pull-based interface for accessing events from multiple streams, in the
/// priority order of the streams provided.
class PrioritizedStreamIterator<T> implements StreamIterator<T> {
  final bool deduplicateWaiting;
  List<Set<T>> _priorityQueues;
  List<StreamSubscription> _subscriptions;
  bool _hasMoved = false;
  bool _isClosed = false;
  T _current;
  Completer<bool> _hasNextCompleter;

  PrioritizedStreamIterator(List<Stream<T>> sources,
      {this.deduplicateWaiting: true}) {
    _priorityQueues =
        new List.generate(sources.length, (_) => new LinkedHashSet());
    _subscriptions = new List(sources.length);

    // Listen on the streams and put items into their own queues.
    for (int i = 0; i < sources.length; i++) {
      final Stream<T> source = sources[i];
      final Set<T> queue = _priorityQueues[i];
      _subscriptions[i] = source.listen(
        (T item) {
          if (!deduplicateWaiting || !queue.contains(item)) {
            queue.add(item);
            _triggerComplete();
          }
        },
        onDone: () {
          _subscriptions[i] = null;
          _cancelWhenAllDone();
        },
        cancelOnError: true,
      );
    }
  }

  /// The number of pending items in the queues.
  int get pendingCount =>
      _priorityQueues.fold(0, (int sum, Set queue) => sum + queue.length);

  /// Moves to the next element.
  /// Returns whether the iterator has another item.
  @override
  Future<bool> moveNext() async {
    if (_hasNextCompleter != null) {
      throw new StateError('Another moveNext() is underway.');
    }
    if (_isClosed) return false;
    final Set<T> queue = _firstQueue();
    if (queue != null) {
      _current = queue.first;
      queue.remove(_current);
      _hasMoved = true;
      return true;
    } else {
      _hasNextCompleter ??= new Completer();
      _cancelWhenAllDone();
      return _hasNextCompleter.future;
    }
  }

  // The current element in the iterator.
  @override
  T get current {
    if (_isClosed) throw new StateError('StreamIterator closed.');
    if (!_hasMoved) throw new StateError('moveNext() has not been called.');
    return _current;
  }

  /// Close the source streams and don't accept new requests.
  @override
  Future cancel() async {
    if (_hasNextCompleter != null) {
      _hasNextCompleter.complete(false);
      _hasNextCompleter = null;
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

  Set<T> _firstQueue() {
    if (_isClosed) {
      throw new StateError('StreamIterator closed');
    }
    return _priorityQueues.firstWhere((q) => q.isNotEmpty, orElse: () => null);
  }

  void _triggerComplete() {
    if (_hasNextCompleter != null) {
      final Set<T> queue = _firstQueue();
      _current = queue.first;
      queue.remove(_current);
      _hasMoved = true;
      _hasNextCompleter.complete(true);
      _hasNextCompleter = null;
    }
    _cancelWhenAllDone();
  }

  void _cancelWhenAllDone() {
    if (_isClosed) return;
    if (_subscriptions.any((s) => s != null)) return;
    if (_firstQueue() != null) return;
    cancel();
  }
}
