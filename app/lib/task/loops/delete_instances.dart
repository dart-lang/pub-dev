// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:basics/basics.dart';
import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:pub_dev/task/clock_control.dart';
import 'package:pub_dev/task/cloudcompute/cloudcompute.dart';

final _log = Logger('pub.task.scan_instances');

/// The internal state for scanning and deleting instances.
class DeleteInstancesState {
  // Maps the `CloudInstance.instanceName` to the deletion
  // progress after we started to delete the instance.
  final Map<String, DeletionInProgress> deletions;

  DeleteInstancesState({required this.deletions});

  factory DeleteInstancesState.init() => DeleteInstancesState(deletions: {});

  // An arbitrary wait to attempt an async cleanup for our tests, since otherwise we
  // keep the progress entry for 5 minutes, and ignore the completer status.
  Future<void> waitSomeSeconds(int seconds) async {
    final futures = deletions.values
        .map((v) => v.completer)
        .where((c) => !c.isCompleted)
        .map(
          (c) => c.future
              .timeoutWithClock(Duration(seconds: seconds))
              .whenComplete(() {}),
        )
        .toList();
    if (futures.isEmpty) {
      return;
    }
    await Future.wait(futures);
  }
}

/// The result of the scan and delete instances operation.
class DeleteInstancesNextState {
  /// The next state of the data.
  final DeleteInstancesState state;

  /// The number of currently running instances.
  final int instances;

  DeleteInstancesNextState({required this.state, required this.instances});
}

/// Tracks the latest instance-specific deletion's start timestamp
/// and progress [completer].
class DeletionInProgress {
  final DateTime started;
  final Completer completer;

  DeletionInProgress({required this.started, required this.completer});

  // Wait at-least 5 minutes from start of deletion until we remove the
  // progress tracking, to give the Cloud API some time to reconcile the state.
  bool isRecent() => started.isAfter(clock.ago(minutes: 5));
}

/// Calculates the next state of delete instances loop by processing
/// the input [stream].
Future<DeleteInstancesNextState> scanAndDeleteInstances(
  DeleteInstancesState state,
  Stream<CloudInstance> stream,
  Future<void> Function(String zone, String instanceName) deleteInstanceFn,
  bool Function() isAbortedFn, {
  required int maxTaskRunHours,
}) async {
  var instances = 0;
  final deletionInProgress = {
    ...state.deletions.whereValue((v) => v.isRecent()),
  };

  await for (final instance in stream) {
    if (isAbortedFn()) {
      break;
    }
    instances++;

    // Prevent multiple calls to delete the same instance.
    if (deletionInProgress.containsKey(instance.instanceName)) {
      continue;
    }

    // If terminated or older than maxInstanceAge, delete the instance...
    final isTerminated = instance.state == InstanceState.terminated;
    final isTooOld = instance.created
        .add(Duration(hours: maxTaskRunHours))
        .isBefore(clock.now());

    if (isTooOld) {
      // This indicates that something is wrong the with the instance,
      // ideally it should have detected its own deadline being violated
      // and terminated on its own. Of course, this can fail for arbitrary
      // reasons in a distributed system.
      _log.warning('terminating $instance for being too old!');
    } else if (isTerminated) {
      _log.info('deleting $instance as it has terminated.');
    } else {
      // Do not delete this instance
      continue;
    }

    final completer = Completer();
    deletionInProgress[instance.instanceName] = DeletionInProgress(
      started: clock.now(),
      completer: completer,
    );

    scheduleMicrotask(() async {
      try {
        await deleteInstanceFn(instance.zone, instance.instanceName);
      } catch (e, st) {
        _log.severe('Failed to delete $instance', e, st);
      } finally {
        completer.complete();
      }
    });
  }

  return DeleteInstancesNextState(
    state: DeleteInstancesState(deletions: deletionInProgress),
    instances: instances,
  );
}
