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
import 'package:pub_dev/task/cloudcompute/cloudcompute.dart';
import 'package:pub_dev/task/models.dart';

final _log = Logger('pub.task.schedule');

const _maxInstancesPerIteration = 50; // Later consider something like: 50;

/// The internal state for creating new instances.
final class CreateInstancesState {
  final Map<String, DateTime> zoneBannedUntil;

  CreateInstancesState({required this.zoneBannedUntil});

  factory CreateInstancesState.init() =>
      CreateInstancesState(zoneBannedUntil: {});
}

/// Schedule tasks from [PackageState].
Future<(CreateInstancesState, Duration)> schedule(
  CloudCompute compute,
  DatastoreDB db, {
  required CreateInstancesState state,
}) async {
  // Map from zone to DateTime when zone is allowed again
  final zoneBannedUntil = <String, DateTime>{
    for (final zone in compute.zones) zone: DateTime(0),
    ...state.zoneBannedUntil,
  };
  void banZone(String zone, {int minutes = 0, int hours = 0, int days = 0}) {
    if (!zoneBannedUntil.containsKey(zone)) {
      throw ArgumentError.value(zone, 'zone');
    }

    final until = clock.now().add(
      Duration(minutes: minutes, hours: hours, days: days),
    );
    if (zoneBannedUntil[zone]!.isBefore(until)) {
      zoneBannedUntil[zone] = until;
    }
  }

  // Create a fast RNG with random seed for picking zones.
  final rng = Random(Random.secure().nextInt(2 << 31));

  // Run scheduling iterations, so long as we have a valid claim
  _log.info('Starting scheduling cycle');

  final instances = await compute.listInstances().toList();
  _log.info('Found $instances instances');

  // If we are not allowed to create new instances within the allowed quota,
  if (activeConfiguration.maxTaskInstances <= instances.length) {
    _log.info('Reached instance limit, trying again in 30s');
    return (
      CreateInstancesState(zoneBannedUntil: zoneBannedUntil),
      Duration(seconds: 30),
    );
  }

  // Determine which zones are not banned
  final allowedZones =
      zoneBannedUntil.entries
          .where((e) => e.value.isBefore(clock.now()))
          .map((e) => e.key)
          .toList()
        ..shuffle(rng);
  var nextZoneIndex = 0;
  String pickZone() => allowedZones[nextZoneIndex++ % allowedZones.length];

  // If no zones are available, we sleep and try again later.
  if (allowedZones.isEmpty) {
    _log.info('All compute-engine zones are banned, trying again in 30s');
    return (
      CreateInstancesState(zoneBannedUntil: zoneBannedUntil),
      Duration(seconds: 30),
    );
  }

  // Schedule analysis for some packages
  var pendingPackagesReviewed = 0;
  final selectLimit = min(
    _maxInstancesPerIteration,
    max(0, activeConfiguration.maxTaskInstances - instances.length),
  );

  Future<void> scheduleInstance(({String package}) selected) async {
    pendingPackagesReviewed += 1;

    final instanceName = compute.generateInstanceName();
    final zone = pickZone();

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

    var rollbackPackageState = true;
    try {
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
    } on ZoneExhaustedException catch (e, st) {
      // A zone being exhausted is normal operations, we just use another
      // zone for 15 minutes.
      _log.info(
        'zone resources exhausted, banning ${e.zone} for 30 minutes',
        e,
        st,
      );
      // Ban usage of zone for 30 minutes
      banZone(e.zone, minutes: 30);
    } on QuotaExhaustedException catch (e, st) {
      // Quota exhausted, this can happen, but it shouldn't. We'll just stop
      // doing anything for 10 minutes. Hopefully that'll resolve the issue.
      // We log severe, because this is a reason to adjust the quota or
      // instance limits.
      _log.severe(
        'Quota exhausted trying to create $instanceName, banning all zones '
        'for 10 minutes',
        e,
        st,
      );

      // Ban all zones for 10 minutes
      for (final zone in compute.zones) {
        banZone(zone, minutes: 10);
      }
    } on Exception catch (e, st) {
      // No idea what happened, but for robustness we'll stop using the zone
      // and shout into the logs
      _log.shout(
        'Failed to create instance $instanceName, banning zone "$zone" for '
        '15 minutes',
        e,
        st,
      );
      // Ban usage of zone for 15 minutes
      banZone(zone, minutes: 15);
    }
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
  }

  // Creating an instance can be slow, we want to schedule them concurrently.
  await Future.wait(
    (await db.tasks.selectSomePending(selectLimit).toList()).map(
      scheduleInstance,
    ),
  );

  // If there was no pending packages reviewed, and no instances currently
  // running, then we can easily sleep 5 minutes before we poll again.
  if (instances.isEmpty && pendingPackagesReviewed == 0) {
    return (
      CreateInstancesState(zoneBannedUntil: zoneBannedUntil),
      Duration(minutes: 5),
    );
  }

  // If more tasks is available and quota wasn't used up, we only sleep 10s
  if (pendingPackagesReviewed >= _maxInstancesPerIteration &&
      activeConfiguration.maxTaskInstances > instances.length) {
    return (
      CreateInstancesState(zoneBannedUntil: zoneBannedUntil),
      Duration(seconds: 10),
    );
  }

  // If we are waiting for quota, then we sleep a minute before checking again
  return (
    CreateInstancesState(zoneBannedUntil: zoneBannedUntil),
    Duration(minutes: 1),
  );
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
