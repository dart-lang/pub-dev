import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:_pub_shared/data/task_payload.dart';
import 'package:clock/clock.dart';
import 'package:logging/logging.dart' show Logger;
import 'package:meta/meta.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/utils.dart';
import 'package:pub_dev/task/backend.dart';
import 'package:pub_dev/task/clock_control.dart';
import 'package:pub_dev/task/cloudcompute/cloudcompute.dart';
import 'package:pub_dev/task/cloudcompute/zone_tracker.dart';
import 'package:pub_dev/task/global_lock.dart';
import 'package:pub_dev/task/models.dart';

final _log = Logger('pub.task.schedule');

const _maxInstancesPerIteration = 50; // Later consider something like: 50;

/// Schedule tasks from [PackageState] while [claim] is valid, and [abort] have
/// not been resolved.
Future<void> schedule(
  GlobalLockClaim claim,
  CloudCompute compute,
  DatastoreDB db, {
  required Completer<void> abort,
}) async {
  /// Sleep [delay] time [since] timestamp, or now if not given.
  Future<void> sleepOrAborted(Duration delay, {DateTime? since}) async {
    ArgumentError.checkNotNull(delay, 'delay');
    final now = clock.now();
    since ??= now;

    delay = delay - now.difference(since);
    if (delay.isNegative) {
      // Await a micro task to ensure consistent behavior
      await Future.microtask(() {});
    } else {
      await abort.future.timeoutWithClock(delay, onTimeout: () => null);
    }
  }

  final zoneTracker = ComputeZoneTracker(compute.zones);

  // Set of `CloudInstance.instanceName`s currently being deleted.
  // This to avoid deleting instances where the deletion process is still
  // running.
  final deletionInProgress = <String>{};

  // Run scheduling iterations, so long as we have a valid claim
  while (claim.valid && !abort.isCompleted) {
    final iterationStart = clock.now();
    _log.info('Starting scheduling cycle');

    // Count number of instances, and delete old instances
    var instances = 0;
    await for (final instance in compute.listInstances()) {
      instances += 1; // count the instance

      // If terminated or older than maxInstanceAge, delete the instance...
      final isTerminated = instance.state == InstanceState.terminated;
      final isTooOld = instance.created
          .add(Duration(hours: activeConfiguration.maxTaskRunHours))
          .isBefore(clock.now());
      // Also check deletionInProgress to prevent multiple calls to delete the
      // same instance
      final isBeingDeleted = deletionInProgress.contains(instance.instanceName);
      if ((isTerminated || isTooOld) && !isBeingDeleted) {
        if (isTooOld) {
          // This indicates that something is wrong the with the instance,
          // ideally it should have detected its own deadline being violated
          // and terminated on its own. Of course, this can fail for arbitrary
          // reasons in a distributed system.
          _log.warning('terminating $instance for being too old!');
        } else if (isTerminated) {
          _log.info('deleting $instance as it has terminated.');
        }

        deletionInProgress.add(instance.instanceName);
        scheduleMicrotask(() async {
          final deletionStart = clock.now();
          try {
            await compute.delete(instance.zone, instance.instanceName);
          } catch (e, st) {
            _log.severe('Failed to delete $instance', e, st);
          } finally {
            // Wait at-least 5 minutes from start of deletion until we remove
            // it from [deletionInProgress] that way we give the API some time
            // reconcile state.
            await sleepOrAborted(Duration(minutes: 5), since: deletionStart);
            deletionInProgress.remove(instance.instanceName);
          }
        });
      }
    }
    _log.info('Found $instances instances');

    // If we are not allowed to create new instances within the allowed quota,
    if (activeConfiguration.maxTaskInstances <= instances) {
      _log.info('Reached instance limit, trying again in 30s');
      // Wait 30 seconds then list instances again, so that we can count them
      await sleepOrAborted(Duration(seconds: 30), since: iterationStart);
      continue; // skip the rest of the iteration
    }

    // If no zones are available, we sleep and try again later.
    if (!zoneTracker.hasAvailableZone()) {
      _log.info('All compute-engine zones are banned, trying again in 30s');
      await sleepOrAborted(Duration(seconds: 30), since: iterationStart);
      continue;
    }

    // Schedule analysis for some packages
    var pendingPackagesReviewed = 0;
    final selectLimit = min(
      _maxInstancesPerIteration,
      max(0, activeConfiguration.maxTaskInstances - instances),
    );

    Future<void> scheduleInstance(({String package}) selected) async {
      pendingPackagesReviewed += 1;

      final instanceName = compute.generateInstanceName();
      final zone = zoneTracker.tryPickZone();
      if (zone == null) {
        return;
      }

      final updated = await updatePackageStateWithPendingVersions(
        db,
        selected.package,
        zone,
        instanceName,
      );
      final payload = updated?.$1;
      if (payload == null) {
        return;
      }
      // Create human readable description for GCP console.
      final description =
          'package:${payload.package} analysis of ${payload.versions.length} '
          'versions.';

      await Future.microtask(() async {
        var rollbackPackageState = true;
        await zoneTracker.withZoneAndInstance(zone, instanceName, () async {
          // Purging cache is important for the edge case, where the new upload happens
          // on a different runtime version, and the current one's cache is still stale
          // and does not have the version yet.
          // TODO(https://github.com/dart-lang/pub-dev/issues/7268) remove after it gets fixed.
          await purgePackageCache(payload.package);
          _log.info(
            'creating instance $instanceName in $zone for '
            'package:${selected.package}',
          );
          await compute.createInstance(
            zone: zone,
            instanceName: instanceName,
            dockerImage: activeConfiguration.taskWorkerImage!,
            arguments: [json.encode(payload)],
            description: description,
          );
          rollbackPackageState = false;
        });
        if (rollbackPackageState) {
          final oldVersionsMap = updated?.$2 ?? const {};
          // Restore the state of the PackageState for versions that were
          // suppose to run on the instance we just failed to create.
          // If this doesn't work, we'll eventually retry. Hence, correctness
          // does not hinge on this transaction being successful.
          await db.tasks.restorePreviousVersionsState(
            selected.package,
            instanceName,
            oldVersionsMap,
          );
        }
      });
    }

    // Creating an instance can be slow, we want to schedule them concurrently.
    await Future.wait(
      (await db.tasks.selectSomePending(selectLimit).toList()).map(
        scheduleInstance,
      ),
    );

    // If there was no pending packages reviewed, and no instances currently
    // running, then we can easily sleep 5 minutes before we poll again.
    if (instances == 0 && pendingPackagesReviewed == 0) {
      await sleepOrAborted(Duration(minutes: 5));
      continue;
    }

    // If more tasks is available and quota wasn't used up, we only sleep 10s
    if (pendingPackagesReviewed >= _maxInstancesPerIteration &&
        activeConfiguration.maxTaskInstances > instances) {
      await sleepOrAborted(Duration(seconds: 10), since: iterationStart);
      continue;
    }

    // If we are waiting for quota, then we sleep a minute before checking again
    await sleepOrAborted(Duration(minutes: 1), since: iterationStart);
  }
}

/// Updates the package state with versions that are already pending or
/// will be pending soon.
///
/// Returns the payload and the old status of the state info version map
@visibleForTesting
Future<(Payload, Map<String, PackageVersionStateInfo>)?>
updatePackageStateWithPendingVersions(
  DatastoreDB db,
  String package,
  String zone,
  String instanceName,
) async {
  return await withRetryTransaction(db, (tx) async {
    final s = await tx.tasks.lookupOrNull(package);
    if (s == null) {
      // presumably the package was deleted.
      return null;
    }
    final oldVersionsMap = {...?s.versions};

    final now = clock.now();
    final pendingVersions = derivePendingVersions(
      versions: s.versions!,
      lastDependencyChanged: s.lastDependencyChanged!,
      at: now,
    ).toList();
    if (pendingVersions.isEmpty) {
      // do not schedule anything
      return null;
    }

    // Update PackageState
    s.versions!.addAll({
      for (final v in pendingVersions.map((v) => v.toString()))
        v: PackageVersionStateInfo(
          scheduled: now,
          attempts: s.versions![v]!.attempts + 1,
          zone: zone,
          instance: instanceName,
          secretToken: createUuid(),
          finished: s.versions![v]!.finished,
        ),
    });
    s.pendingAt = derivePendingAt(
      versions: s.versions!,
      lastDependencyChanged: s.lastDependencyChanged!,
    );
    await tx.tasks.update(s);

    // Create payload
    final payload = Payload(
      package: s.package,
      pubHostedUrl: activeConfiguration.defaultServiceBaseUrl,
      versions: pendingVersions.map(
        (v) => VersionTokenPair(
          version: v.toString(),
          token: s.versions![v.toString()]!.secretToken!,
        ),
      ),
    );
    return (payload, oldVersionsMap);
  });
}
