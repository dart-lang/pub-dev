// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:googleapis/compute/v1.dart' hide Duration;
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart' show Logger;
import 'package:meta/meta.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/utils.dart' show createUuid;
import 'package:pub_dev/task/cloudcompute/cloudcompute.dart';
import 'package:retry/retry.dart';
import 'package:ulid/ulid.dart';

final _log = Logger('pub.googlecloudcompute');

/// Register an [http.Client] for talking to GCE.
///
/// This should be a client not wrapped in a `RetryClient`.
void registerCloudComputeClient(http.Client client) =>
    ss.register(#_cloudComputeClient, client);

/// Get the active [http.Client] for talking to GCE.
///
/// This client does NOT do retries. Retries of requests should be managed by
/// the caller invoking the GCE APIs.
http.Client get cloudComputeClient =>
    ss.lookup(#_cloudComputeClient) as http.Client;

/// Hardcoded list of GCE zones to consider for provisioning.
///
/// See [list of regions and zones][regions-zones].
///
/// [regions-zones]: https://cloud.google.com/compute/docs/regions-zones
const _googleCloudZones = [
  'us-central1-a',
  'us-central1-b',
  'us-central1-c',
  'us-central1-f',
];

/// Hardcoded machine type to use for provisioning instances.
///
/// Note. it is important that this _machine type_ is available in the
/// [_googleCloudZones] listed.
///
/// See [predefined machine-types][machines-types].
///
/// [machine-types]: https://cloud.google.com/compute/docs/machine-types
const _googleCloudMachineType = 'e2-standard-2'; // 2 vCPUs 8GB ram

/// OAuth scope needed for the [http.Client] passed to
/// [createGoogleCloudCompute].
const googleCloudComputeScope = ComputeApi.cloudPlatformScope;

/// Create a [CloudCompute] abstraction wrapping Google Compute Engine.
///
/// The [CloudCompute] abstraction created will manage instance in the given
/// GCP cloud [project] with labels:
///  * `owner = 'pub-dev'`, and,
///  * `pool = poolLabel`.
///
/// Similarly, all instances created by this abstraction will be labelled with
/// `owner` as `'pub-dev'` and `pool` as [poolLabel]. This allows for multiple
/// pools of machines that don't interfere with eachother. By using a
/// [poolLabel] such as `'<runtimeVersion>_worker'` we can ensure that the
/// [CloudCompute] object for pana-tasks doesn't interfere with the other
/// _runtime versions_ in production.
///
/// Instances will allocated a private IP address in the VPC specified using
/// [network]. This VPC should have [Cloud Nat] enabled.
///
/// Instances will use [Container-Optimized OS][c-o-s] to run the docker-image
/// specified at instance creation.
///
/// [c-o-s]: https://cloud.google.com/container-optimized-os/docs
/// [Cloud Nat]: https://cloud.google.com/nat
CloudCompute createGoogleCloudCompute({
  required String project,
  required String network,
  required String poolLabel,
}) {
  if (poolLabel.isEmpty) {
    throw ArgumentError.value(poolLabel, 'poolLabel', 'must not be empty');
  }
  if (poolLabel.length > 63) {
    throw ArgumentError.value(
      poolLabel,
      'poolLabel',
      'must be < 63 characters long',
    );
  }
  if (!RegExp(r'^[a-z0-9_-]+$').hasMatch(poolLabel)) {
    throw ArgumentError.value(
      poolLabel,
      'poolLabel',
      'must only contain [a-z0-9_-]',
    );
  }

  return _GoogleCloudCompute(
    ComputeApi(cloudComputeClient),
    project,
    network,
    _googleCloudZones,
    _googleCloudMachineType,
    poolLabel,
  );
}

/// Delete instances created by a [CloudCompute] instance return from
/// [createGoogleCloudCompute], when the instance has been created more than
/// 72 hours ago.
///
/// This ignores the `poolLabel` and deletes all instances that has labels
/// indicating they were part of such a pool. This should cleanup any old
/// instances that were left behind by an old pool.
Future<void> deleteAbandonedInstances({
  required String project,
}) async {
  final api = ComputeApi(cloudComputeClient);

  // Beware filters documented in the GCE API reference are not necessarily
  // supported, nor can filtering be combined with ordering of results.
  //
  // This filters to instances that have specified "owner" label and has some
  // "pool" label.
  final filter = [
    'labels.owner = "pub-dev"',
    'labels.pool : *',
  ].join(' AND ');

  // Remark: We could have more concurrency here, but listing all instances
  //         shouldn't take too long, and very few of the instances should be
  //         so old that we need to delete them.
  for (final zone in _googleCloudZones) {
    String? nextPageToken;
    do {
      final response = await _retry(() => api.instances.list(
            project,
            zone,
            maxResults: 500,
            filter: filter,
            pageToken: nextPageToken,
          ));
      nextPageToken = response.nextPageToken;

      // For each instance, delete it if it's older than 3 days
      for (final instance in response.items ?? <Instance>[]) {
        final created = _parseInstanceCreationTimestamp(
          instance.creationTimestamp,
        );
        if (created.isAfter(clock.now().subtract(Duration(days: 3)))) {
          continue;
        }
        try {
          _log.warning('Deleting abandoned instance: ${instance.name} '
              'created at ${instance.creationTimestamp}.');
          await _retryWithRequestId((rId) => api.instances.delete(
                project,
                zone,
                instance.name!,
                requestId: rId,
              ));
          // Note. that instances.delete() technically returns a custom long-running
          // operation, we have no reasonable action to take if deletion fails.
          // Presumably, the instance would show up in listings again and eventually
          // be deleted once more (with a new operation, with a new requestId).
          // TODO: Await the delete operation...
        } on DetailedApiRequestError catch (e) {
          if (e.status == 404) {
            // If we get a 404, then we shall assume that instance has been deleted.
            // Worst case the instance will eventually show up in listings again and
            // then be deleted once more.
            return;
          }
          rethrow;
        }
      }
    } while (nextPageToken != null);
  }
}

class _GoogleCloudInstance extends CloudInstance {
  /// GCP zone this instance exists inside.
  @override
  final String zone;

  @override
  final String instanceName;

  @override
  final DateTime created;

  @override
  final InstanceState state;

  _GoogleCloudInstance(
    this.zone,
    this.instanceName,
    this.created,
    this.state,
  );

  @override
  String toString() {
    return 'GoogleCloudInstance($instanceName, zone: $zone, created: $created, state: $state)';
  }
}

class _PendingGoogleCloudInstance extends CloudInstance {
  /// GCP zone this instance exists inside.
  @override
  final String zone;

  @override
  final String instanceName;

  @override
  DateTime get created => clock.now();

  @override
  InstanceState get state => InstanceState.pending;

  _PendingGoogleCloudInstance(this.zone, this.instanceName);

  @override
  String toString() {
    return 'GoogleCloudInstance($instanceName, zone: $zone, created: $created, state: $state)';
  }
}

Future<T> _retryWithRequestId<T>(Future<T> Function(String rId) fn) async {
  // As long as we use the same requestId we can call multiple times without
  // duplicating side-effects on the server (at-least this seems plausible).
  final requestId = createUuid();

  return await _retry(() => fn(requestId));
}

Future<T> _retry<T>(Future<T> Function() fn) async {
  return await retry(
    fn,
    retryIf: (e) =>
        // Guessing the API might honor: https://google.aip.dev/194
        // So only retry 'UNAVAILABLE' errors, which is 503 according to:
        // https://github.com/googleapis/api-common-protos/blob/master/google/rpc/code.proto
        (e is DetailedApiRequestError && e.status == 503) ||
        // In addition we retry undocumented errors and malformed responses.
        (e is ApiRequestError && e is! DetailedApiRequestError) ||
        // If there is a timeout, we also retry.
        e is TimeoutException ||
        // Finally, we retry all I/O issues.
        e is IOException,
  );
}

/// Pattern for valid GCE instance names.
final _validInstanceNamePattern = RegExp(r'^[a-z]([-a-z0-9]*[a-z0-9])?$');

String _shellSingleQuote(String string) =>
    "'${string.replaceAll("'", "'\\''")}'";

@sealed
class _GoogleCloudCompute extends CloudCompute {
  final ComputeApi _api;

  /// GCP project this instance is managing VMs inside.
  final String _project;

  /// VPC network instances should be attached to.
  final String _network;

  /// GCP zones this instance is managing VMs inside.
  final List<String> _zones;

  /// GCP machine type, see:
  /// https://cloud.google.com/compute/docs/machine-types
  final String _machineType;

  /// Value of the `pool` label for VMs managed by this instance.
  ///
  /// Instances created must have this `pool` label, same goes for instances
  /// listed (luckily we can filter in labels in the API).
  final String _poolLabel;

  /// Instances where a [Future] from the [createInstance] operation is still
  /// waiting to be resolved.
  ///
  /// We shall show such instances in [listInstances] until the [Future]
  /// returned frm [createInstance] has been resolved.
  final Set<_PendingGoogleCloudInstance> _pendingInstances = {};

  _GoogleCloudCompute(
    this._api,
    this._project,
    this._network,
    this._zones,
    this._machineType,
    this._poolLabel,
  );

  @override
  List<String> get zones => List.from(_zones);

  @override
  String generateInstanceName() => 'worker-${Ulid()}';

  @override
  Future<CloudInstance> createInstance({
    required String zone,
    required String instanceName,
    required String dockerImage,
    required List<String> arguments,
    required String description,
  }) async {
    if (!_zones.contains(zone)) {
      throw ArgumentError.value(
        zone,
        'zone',
        'must be one of CloudCompute.zones',
      );
    }
    if (instanceName.isEmpty || instanceName.length > 63) {
      throw ArgumentError.value(
          instanceName, 'instanceName', 'must have a length between 1 and 63');
    }
    if (!_validInstanceNamePattern.hasMatch(instanceName)) {
      throw ArgumentError.value(instanceName, 'instanceName',
          'must match pattern: $_validInstanceNamePattern');
    }
    // Max argument string size on Linux is MAX_ARG_STRLEN = 131072
    // In addition the maximum meta-data size supported by GCE is 256KiB
    // We need a few extra bits, so we shall enforce a max size of 100KiB.
    final argumentsLengthInBytes = arguments
        .map(utf8.encode)
        .map((s) => s.length)
        .fold<int>(0, (a, b) => a + b);
    if (argumentsLengthInBytes > 100 * 1024) {
      throw ArgumentError.value(
        arguments,
        'arguments',
        'must be less than 100KiB',
      );
    }

    // The following cloud-init starts the docker image with [arguments] after
    // gcr-online, docker and stackdriver-logging is available.
    //
    // We need GCR and docker socket to be available, but we don't need logging,
    // thus, logging is not **wanted** by this unit. But if loaded, we would
    // like to start after logging.
    //
    // We tweak the environment to have `HOME=/home/worker` because credentials
    // for docker is configured using a dot-file in `$HOME`. And on `/root` is
    // not writable on Container-Optimized OS, see:
    // https://cloud.google.com/container-optimized-os/docs/concepts/disks-and-filesystem
    //
    // Once the `worker.service` is done, the `ExecStartPost` command is
    // configured to terminate the instance. This should terminate regardless of
    // the exit-code.
    //
    // As `/etc` is stateless we need to reproduce any changes we make to it in
    // cloud-init configuration. Hence, why we do `systemctl start..` rather
    // than `systemctl enable..`.
    //
    // See: https://cloudinit.readthedocs.io/en/latest/
    final cloudConfig = '''
#cloud-config
users:
- name: worker
  uid: 2000
write_files:
- path: /etc/systemd/system/worker.service
  permissions: 0644
  owner: root
  content: |
    [Unit]
    Description=Start worker
    Wants=gcr-online.target
    Wants=docker.socket
    After=gcr-online.target
    After=docker.socket
    After=stackdriver-logging.service

    [Service]
    Type=oneshot
    Environment="HOME=/home/worker"
    ExecStartPre=/usr/bin/docker-credential-gcr configure-docker
    ExecStart=/usr/bin/docker run --rm -u worker:2000 --name=worker $dockerImage ${arguments.map(_shellSingleQuote).join(' ')}
    ExecStartPost=/sbin/shutdown now
    StandardOutput=journal+console
    StandardError=journal+console
runcmd:
- systemctl daemon-reload
- systemctl start worker.service
''';

    final instance = Instance()
      ..name = instanceName
      ..description = description
      ..machineType = 'zones/$zone/machineTypes/$_machineType'
      ..scheduling = (Scheduling()
        ..preemptible = true
        ..automaticRestart = false
        ..onHostMaintenance = 'TERMINATE'
        ..instanceTerminationAction = 'DELETE'
        ..provisioningModel = 'SPOT')
      ..labels = {
        // Labels that allows us to filter instances when listing instances.
        'owner': 'pub-dev',
        'pool': _poolLabel,
      }
      ..metadata = (Metadata()
        ..items = [
          MetadataItems()
            ..key = 'user-data'
            ..value = cloudConfig,
          // Enable logging with Google Cloud Logging, see:
          // https://cloud.google.com/container-optimized-os/docs/how-to/logging
          MetadataItems()
            ..key = 'google-logging-enabled'
            ..value = 'true',
          // These VMs are intended to be short-lived, we should update the
          // image, hence, automatic updates shouldn't be necessary.
          // https://cloud.google.com/container-optimized-os/docs/concepts/auto-update#disabling_automatic_updates
          MetadataItems()
            ..key = 'cos-update-strategy'
            ..value = 'update_disabled',
        ])
      ..serviceAccounts = [
        ServiceAccount()
          ..email = activeConfiguration.taskWorkerServiceAccount
          ..scopes = [ComputeApi.cloudPlatformScope]
      ]
      ..networkInterfaces = [
        // This attaches the VM to the given network, but doesn't assign any
        // public IP address. So the ability to make outbound connections depend
        // on Cloud Nat configuration for the network.
        NetworkInterface()
          ..network = 'projects/$_project/global/networks/$_network',
      ]
      ..disks = [
        AttachedDisk()
          ..type = 'PERSISTENT'
          ..boot = true
          ..autoDelete = true
          ..initializeParams = (AttachedDiskInitializeParams()
            ..diskSizeGb = '10'
            ..labels = {
              // Labels allows to track disks, in practice they should always
              // be auto-deleted with instance, but if this fails it's nice to
              // have a label.
              'owner': 'pub-dev',
              'pool': _poolLabel,
            }
            ..sourceImage = activeConfiguration.cosImage),
      ];

    _log.info('Creating instance: ${instance.name}');
    final pendingInstancePlaceHolder =
        _PendingGoogleCloudInstance(zone, instanceName);
    _pendingInstances.add(pendingInstancePlaceHolder);
    try {
      // https://cloud.google.com/container-optimized-os/docs/how-to/create-configure-instance#creating_an_instance
      var op = await _retryWithRequestId((rId) => _api.instances
          .insert(
            instance,
            _project,
            zone,
            requestId: rId,
          )
          .timeout(Duration(minutes: 5)));

      void logWarningsThrowErrors() {
        // Log warnings if there is any
        final warnings = op.warnings;
        if (warnings != null) {
          for (final w in warnings) {
            _log.warning(
              'Warning while creating instance, '
              'api.instances.insert(name=${instance.name}) '
              '${w.code}: ${w.message}',
            );
          }
        }

        // Throw first error.
        final opError = op.error;
        if (opError != null) {
          final opErrors = opError.errors;
          if (opErrors != null && opErrors.isNotEmpty) {
            throw ApiRequestError(
              'Error creating instance, '
              'api.instances.insert(name=${instance.name}), '
              '${opErrors.first.code}: ${opErrors.first.message}',
            );
          }
        }
      }

      // Check if we got any errors
      logWarningsThrowErrors();

      while (op.status != 'DONE') {
        final start = clock.now();
        op = await _retry(() => _api.zoneOperations
            .wait(
              _project,
              zone,
              op.name!,
            )
            .timeout(Duration(minutes: 3)));
        logWarningsThrowErrors();

        if (op.status != 'DONE') {
          // Ensure at-least two minutes between api.zoneOperations.wait() calls
          final elapsed = clock.now().difference(start);
          final remainder = Duration(minutes: 2) - elapsed;
          if (!remainder.isNegative) {
            await Future.delayed(remainder);
          }
        }
      }
      _log.info('Created instance: ${instance.name}');

      return _wrapInstanceWithState(
        instance,
        zone,
        DateTime.tryParse(op.creationTimestamp ?? '') ?? DateTime(0),
        InstanceState.pending,
      );
    } finally {
      _pendingInstances.remove(pendingInstancePlaceHolder);
    }
  }

  @override
  Future<void> delete(String zone, String instanceName) async {
    try {
      await _retryWithRequestId((rId) => _api.instances.delete(
            _project,
            zone,
            instanceName,
            requestId: rId,
          ));
      // Note. that instances.delete() technically returns a custom long-running
      // operation, we have no reasonable action to take if deletion fails.
      // Presumably, the instance would show up in listings again and eventually
      // be deleted once more (with a new operation, with a new requestId).
      // TODO: Await the delete operation...
    } on DetailedApiRequestError catch (e) {
      if (e.status == 404) {
        // If we get a 404, then we shall assume that instance has been deleted.
        // Worst case the instance will eventually show up in listings again and
        // then be deleted once more.
        return;
      }
      rethrow;
    }
  }

  @override
  Stream<CloudInstance> listInstances() {
    final filter = [
      'labels.owner = "pub-dev"',
      'labels.pool = "$_poolLabel"',
    ].join(' AND ');

    final c = StreamController<CloudInstance>();

    scheduleMicrotask(() async {
      try {
        await Future.wait(_zones.map((zone) async {
          var response = await _retry(() => _api.instances.list(
                _project,
                zone,
                maxResults: 500,
                filter: filter,
              ));

          final wrap = (Instance item) => _wrapInstance(item, zone);
          final pendingInZone = _pendingInstances
              .where((instance) => instance.zone == zone)
              .toSet();

          for (final instance in (response.items ?? []).map(wrap)) {
            c.add(instance);
            pendingInZone
                .removeWhere((i) => i.instanceName == instance.instanceName);
          }

          while ((response.nextPageToken ?? '').isNotEmpty) {
            response = await _retry(() => _api.instances.list(
                  _project,
                  zone,
                  maxResults: 500,
                  filter: filter,
                  pageToken: response.nextPageToken,
                ));
            for (final instance in (response.items ?? []).map(wrap)) {
              c.add(instance);
              pendingInZone
                  .removeWhere((i) => i.instanceName == instance.instanceName);
            }
          }

          // For each of the pending instances in current zone, where name has
          // not been reported, return the fake pending instance.
          pendingInZone.forEach(c.add);
        }));
      } catch (e, st) {
        c.addError(e, st);
      } finally {
        await c.close();
      }
    });

    return c.stream;
  }

  CloudInstance _wrapInstance(Instance instance, String zone) {
    final created = _parseInstanceCreationTimestamp(instance.creationTimestamp);

    InstanceState state;
    switch (instance.status) {
      // See: https://cloud.google.com/compute/docs/instances/instance-life-cycle
      // Note that the API specifies that it may return 'SUSPENDING' and
      // 'SUSPENDED' even though these are undocumented by the life-cycle docs.
      case 'PROVISIONING':
      case 'STAGING':
        state = InstanceState.pending;
        break;
      case 'RUNNING':
        state = InstanceState.running;
        break;
      case 'REPAIRING':
      case 'STOPPING':
      case 'STOPPED':
      case 'SUSPENDING': // Undocumented state
      case 'SUSPENDED': // Undocumented state
      case 'TERMINATED':
        state = InstanceState.terminated;
        break;
      default:
        // Unless this happens frequently, it's probably not so bad to always
        // just treat the instance as dead, and wait for clean-up process to
        // kill it.
        _log.severe('Unhandled instance.status="${instance.status}", '
            'reason: ${instance.statusMessage}');
        state = InstanceState.terminated;
    }
    return _wrapInstanceWithState(instance, zone, created, state);
  }

  CloudInstance _wrapInstanceWithState(
    Instance instance,
    String zone,
    DateTime created,
    InstanceState state,
  ) =>
      _GoogleCloudInstance(
        zone,
        instance.name ?? '',
        created,
        state,
      );
}

/// Utility method for parsing `instance.creationTimestamp`.
///
/// This creates a particularly serious log message if it fails, because the
/// creation timestamp is used for cleaning up instances. So ability to parse
/// it correctly is rather important.
DateTime _parseInstanceCreationTimestamp(String? timestamp) {
  try {
    return DateTime.parse(timestamp ?? '');
  } on FormatException {
    // Print error and instance to log..
    _log.severe(
      'Failed to parse instance.creationTimestamp: '
      '"$timestamp"',
    );
    // Fallback to year zero that way instances will be killed.
    return DateTime(0);
  }
}
