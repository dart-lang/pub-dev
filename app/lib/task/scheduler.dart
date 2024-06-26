import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:_pub_shared/data/task_payload.dart';
import 'package:clock/clock.dart';
import 'package:logging/logging.dart' show Logger;
import 'package:meta/meta.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/utils.dart';
import 'package:pub_dev/shared/versions.dart' show runtimeVersion;
import 'package:pub_dev/task/cloudcompute/cloudcompute.dart';
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
      await abort.future.timeout(delay, onTimeout: () => null);
    }
  }

  // Map from zone to DateTime when zone is allowed again
  final zoneBannedUntil = <String, DateTime>{
    for (final zone in compute.zones) zone: DateTime(0),
  };
  void banZone(String zone, {int minutes = 0, int hours = 0, int days = 0}) {
    if (!zoneBannedUntil.containsKey(zone)) {
      throw ArgumentError.value(zone, 'zone');
    }

    final until = clock.now().add(Duration(
          minutes: minutes,
          hours: hours,
          days: days,
        ));
    if (zoneBannedUntil[zone]!.isBefore(until)) {
      zoneBannedUntil[zone] = until;
    }
  }

  // Set of `CloudInstance.instanceName`s currently being deleted.
  // This to avoid deleting instances where the deletion process is still
  // running.
  final deletionInProgress = <String>{};

  // Create a fast RNG with random seed for picking zones.
  final rng = Random(Random.secure().nextInt(2 << 31));

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

    // Determine which zones are not banned
    final allowedZones = zoneBannedUntil.entries
        .where((e) => e.value.isBefore(clock.now()))
        .map((e) => e.key)
        .toList()
      ..shuffle(rng);
    var nextZoneIndex = 0;
    String pickZone() => allowedZones[nextZoneIndex++ % allowedZones.length];

    // If no zones are available, we sleep and try again later.
    if (allowedZones.isEmpty) {
      _log.info('All compute-engine zones are banned, trying again in 30s');
      await sleepOrAborted(Duration(seconds: 30), since: iterationStart);
      continue;
    }

    // Schedule analysis for some packages
    var pendingPackagesReviewed = 0;
    await Future.wait(await (db.query<PackageState>()
          ..filter('runtimeVersion =', runtimeVersion)
          ..filter('pendingAt <=', clock.now())
          ..order('pendingAt')
          ..limit(min(
            _maxInstancesPerIteration,
            max(0, activeConfiguration.maxTaskInstances - instances),
          )))
        .run()
        .map<Future<void>>((state) async {
      pendingPackagesReviewed += 1;

      final instanceName = compute.generateInstanceName();
      final zone = pickZone();

      final payload = await updatePackageStateWithPendingVersions(
          db, state, zone, instanceName);
      if (payload == null) {
        return;
      }
      // Create human readable description for GCP console.
      final description =
          'package:${payload.package} analysis of ${payload.versions.length} '
          'versions.';

      scheduleMicrotask(() async {
        var rollbackPackageState = true;
        try {
          // Purging cache is important for the edge case, where the new upload happens
          // on a different runtime version, and the current one's cache is still stale
          // and does not have the version yet.
          // TODO(https://github.com/dart-lang/pub-dev/issues/7268) remove after it gets fixed.
          await purgePackageCache(payload.package);
          _log.info(
            'creating instance $instanceName in $zone for '
            'package:${state.package}',
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
        } finally {
          if (rollbackPackageState) {
            // Restore the state of the PackageState for versions that were
            // suppose to run on the instance we just failed to create.
            // If this doesn't work, we'll eventually retry. Hence, correctness
            // does not hinge on this transaction being successful.
            await withRetryTransaction(db, (tx) async {
              final s = await tx.lookupOrNull<PackageState>(state.key);
              if (s == null) {
                return; // Presumably, the package was deleted.
              }

              s.versions!.addEntries(
                s.versions!.entries
                    .where((e) => e.value.instance == instanceName)
                    .map((e) => MapEntry(e.key, state.versions![e.key]!)),
              );
              s.derivePendingAt();
              tx.insert(s);
            });
          }
        }
      });
    }).toList());

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
@visibleForTesting
Future<Payload?> updatePackageStateWithPendingVersions(
  DatastoreDB db,
  PackageState state,
  String zone,
  String instanceName,
) async {
  return await withRetryTransaction(db, (tx) async {
    final s = await tx.lookupOrNull<PackageState>(state.key);
    if (s == null) {
      // presumably the package was deleted.
      return null;
    }

    final now = clock.now();
    final pendingVersions = s.pendingVersions(at: now);
    if (pendingVersions.isEmpty) {
      // do not schedule anything
      return null;
    }

    // Update PackageState
    s.versions!.addAll({
      for (final v in pendingVersions)
        v: PackageVersionStateInfo(
          scheduled: now,
          attempts: s.versions![v]!.attempts + 1,
          zone: zone,
          instance: instanceName,
          secretToken: createUuid(),
          finished: s.versions![v]!.finished,
        ),
    });
    s.derivePendingAt();
    tx.insert(s);

    final payloadVersions = pendingVersions
        .map((v) => VersionTokenPair(
              version: v,
              token: s.versions![v]!.secretToken!,
            ))
        .toList();

    // sort pending versions based on version priority
    if (payloadVersions.length > 1) {
      // loading the package entity to prioritize latest versions
      final pkg = await tx.lookupOrNull<Package>(
          db.emptyKey.append(Package, id: state.package));

      payloadVersions.sort((a, b) {
        if (a.version == pkg?.latestVersion) return -1;
        if (b.version == pkg?.latestVersion) return 1;
        if (a.version == pkg?.latestPreviewVersion) return -1;
        if (b.version == pkg?.latestPreviewVersion) return 1;
        if (a.version == pkg?.latestPrereleaseVersion) return -1;
        if (b.version == pkg?.latestPrereleaseVersion) return 1;

        // prioritize stables first, then newer versions
        return compareSemanticVersionsDesc(
            a.semanticVersion, b.semanticVersion, true, true);
      });
    }

    // Create payload
    return Payload(
      package: s.package,
      pubHostedUrl: activeConfiguration.defaultServiceBaseUrl,
      versions: payloadVersions,
    );
  });
}
