// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:basics/basics.dart';
import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:pub_dev/task/cloudcompute/cloudcompute.dart';

final _log = Logger('pub.task.scan_instances');

/// The internal state for scanning and deleting instances.
final class DeleteInstancesState {
  // Maps the `CloudInstance.instanceName` to the deletion
  // start timestamp.
  final Map<String, DateTime> deletions;

  DeleteInstancesState({required this.deletions});

  factory DeleteInstancesState.init() => DeleteInstancesState(deletions: {});
}

/// Calculates the next state of delete instances loop by processing
/// the input from [cloudCompute].
Future<DeleteInstancesState> scanAndDeleteInstances(
  DeleteInstancesState state,
  CloudCompute cloudCompute,
  bool Function() isAbortedFn, {
  required int maxTaskRunHours,
}) async {
  // Purge deletionsInProgress after 5 minutes, if instance has not disappeared
  // after 5 minutes we'll try to delete it again.
  final keepTreshold = clock.ago(minutes: 5);
  final deletionInProgress = {
    ...state.deletions.whereValue((v) => v.isAfter(keepTreshold)),
  };

  final futures = <Future>[];
  await for (final instance in cloudCompute.listInstances()) {
    if (isAbortedFn()) {
      break;
    }

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

    deletionInProgress[instance.instanceName] = clock.now();

    final future = Future.microtask(() async {
      try {
        await cloudCompute.delete(instance.zone, instance.instanceName);
      } catch (e, st) {
        _log.severe('Failed to delete $instance', e, st);
      }
    });
    futures.add(future);
  }

  await Future.wait(futures);
  return DeleteInstancesState(deletions: deletionInProgress);
}
