// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta.dart';

/// Interface describing an instance.
abstract class CloudInstance {
  /// Unique instance name.
  String get instanceName;

  /// Zone this instance lives in.
  String get zone;

  /// [DateTime] of when the instance was created.
  ///
  /// This is "now" until a creation time is reflected in the cloud APIs.
  DateTime get created;

  /// State of the instance.
  InstanceState get state;

  /// Representation for debugging purposes.
  @override
  String toString() => 'CloudInstance(${[
        'name: $instanceName',
        'zone: $zone',
        'created: $created',
        'state: $state',
      ].join(',')})';
}

/// Simplified instance state.
///
/// In practice we often don't care if an instance is _provisioning_ or _staging_.
/// If an instance is stuck in the [pending] state it's probably because it's
/// not going to startup.
///
/// Similarly, we don't care if an instance is _booting_, _running_, or if the
/// process running on the instance crashed without terminating the instance.
/// In all these cases we want to delete the instance if it gets stuck long
/// enough to exhaust the allowed execution time.
///
/// We also don't care if the instance is _suspending_, _suspended_, _stopping_,
/// _stopped_ or _terminated_. In these the cases the instance should be
/// deleted.
enum InstanceState {
  /// Instance is pending provisioning or in the process of being provisioned.
  pending,

  /// Instance is believed to be running (or booting).
  running,

  /// Instance has been terminated.
  terminated,
}

/// Interface for controlling a pool of cloud compute instances.
abstract class CloudCompute {
  /// List of zones available.
  List<String> get zones;

  /// Generate an instance name.
  String generateInstanceName();

  /// Create an instance running [dockerImage] with given [arguments].
  ///
  /// The instance will be running in the given [zone] under the given
  /// [instanceName].
  /// Notice that [instanceName] must be unique and will have implementation
  /// specific limitations, using [generateInstanceName] is advised.
  ///
  /// The _human readable_ [description] will be attached to the instance in
  /// Cloud Console and intended to assist humans inspecting the system.
  ///
  /// The [Future] returned may take a long time to resolve (several minutes).
  /// Throws [ZoneExhaustedException] if resources in the given zone are
  /// exhausted, and usage of [zone] should be avoided for a while.
  /// Throws [QuotaExhaustedException] if quota allocated with the cloud vendor
  /// have been exhausted, and creation of VMs should be backoff for a while.
  /// Any [Exception] thrown by this method should be considered a reason to
  /// reduce the request rate on the given zone [zone].
  // TODO: Consider changing the contract around "any exception"!
  Future<CloudInstance> createInstance({
    required String zone,
    required String instanceName,
    required String dockerImage,
    required List<String> arguments,
    required String description,
  });

  /// List instances.
  Stream<CloudInstance> listInstances();

  /// Delete the instance with [instanceName] from [zone].
  ///
  /// If this operation fails, it may throw an [Exception] or discard the error.
  /// Systems should assume deletion is best-effort and periodically list
  /// instances to delete instances that are no longer needed.
  Future<void> delete(String zone, String instanceName);
}

/// Exception thrown by [CloudCompute.createInstance] if resources in a cloud
/// zone have been exhausted.
///
/// The caller is expected to back-off using the zone for a while before trying
/// to create new VMs in the zone again.
@sealed
class ZoneExhaustedException implements Exception {
  final String zone;

  final String message;
  ZoneExhaustedException(this.zone, this.message);

  @override
  String toString() => 'ZoneExhaustedException: $message';
}

/// Exception thrown by [CloudCompute.createInstance] if allocated quota
/// allocated with the cloud vendor has been exhausted.
///
/// The caller is expected to back-off for a while before trying to create
/// new VMs.
@sealed
class QuotaExhaustedException implements Exception {
  final String message;
  QuotaExhaustedException(this.message);

  @override
  String toString() => 'QuotaExhaustedException: $message';
}
