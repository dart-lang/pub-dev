// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/service_scope.dart' as ss;

import 'package:pub_dev/service/async_queue/async_queue.dart';

/// Sets the [ChangeEventAggregator] service in the scope.
void registerChangeEventAggregator(ChangeEventAggregator service) =>
    ss.register(#_changeEventAggregator, service);

/// The active [ChangeEventAggregator] service.
ChangeEventAggregator get changeEventAggregator =>
    ss.lookup(#_changeEventAggregator) as ChangeEventAggregator;

/// Creates events that need to be run after given [change].
typedef ChangeProcessorFn = Iterable<TriggeredEvent> Function(
    CapturedChange change);

/// Processes entity changes that could trigger further events (e.g. cache invalidation
/// or re-running export to CDN bucket).
///
/// The events are aggregated (duplicates are filtered) and run in batches, off-request.
class ChangeEventAggregator {
  final List<ChangeProcessorFn> _changeProcessorFns;
  final _events = <String, TriggeredEvent>{};
  bool _scheduled = false;

  ChangeEventAggregator(this._changeProcessorFns);

  /// Digests the [change] and may trigger new event(s).
  ///
  /// The events are scheduled via [AsyncQueue], off-request.
  void addChange(CapturedChange change) {
    for (final fn in _changeProcessorFns) {
      for (final event in fn(change)) {
        if (_events.containsKey(event.deduplicateKey)) {
          continue;
        }
        _events[event.deduplicateKey] = event;
      }
    }
    _scheduleProcessing();
  }

  void _scheduleProcessing() {
    if (_scheduled) return;
    _scheduled = true;
    asyncQueue.addAsyncFn(() async {
      _scheduled = false;
      await executeEvents();
      if (_events.isNotEmpty) {
        _scheduleProcessing();
      }
    });
  }

  /// Executes the scheduled events.
  Future<void> executeEvents() async {
    if (_events.isEmpty) {
      return;
    }
    // Clears event map to prevent concurrent updates while the events are processed.
    final fns = _events.values.map((e) => e.fn).toList();
    _events.clear();

    // Processing the events without any batching.
    // TODO: consider concurrency for events that are cheap (e.g. cache invalidation).
    for (final fn in fns) {
      await fn();
    }
  }
}

/// Describes the entity being changed with [keys] and other relevant [fields].
class CapturedChange {
  final ChangeAction action;
  final Type entity;
  final List<Object> keys;
  final Map<String, Object?>? fields;

  CapturedChange(this.action, this.entity, this.keys, [this.fields]);

  TriggeredEvent toTriggeredEvent(Iterable<Object>? parameters, AsyncFn fn) =>
      TriggeredEvent([entity, action, ...keys, ...?parameters], fn);
}

enum ChangeAction {
  create,
  update,
  delete,
}

/// Describes the event that was triggered.
class TriggeredEvent {
  final List<Object?> parameters;
  final AsyncFn fn;

  TriggeredEvent(this.parameters, this.fn);

  late final deduplicateKey =
      Uri(pathSegments: parameters.map((p) => p.toString())).toString();
}
