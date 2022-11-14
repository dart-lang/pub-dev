// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:pub_dev/frontend/static_files.dart';

import 'cloudcompute.dart';

final _log = Logger('pub.fakecloudcompute');

@sealed
class FakeCloudCompute extends CloudCompute {
  var _nextInstanceId = 1;
  final _instances = <FakeCloudInstance>{};

  @override
  final List<String> zones = const ['zone-a', 'zone-b'];

  @override
  String generateInstanceName() => 'instance-${_nextInstanceId++}';

  @override
  Future<FakeCloudInstance> createInstance({
    required String zone,
    required String instanceName,
    required String dockerImage,
    required List<String> arguments,
    required String description,
  }) async {
    if (!zones.contains(zone)) {
      throw ArgumentError.value(zone, 'zone', 'must be a valid zone');
    }
    // Enforce same limits as GCE
    if (arguments.fold<int>(0, (a, b) => a + b.length) > 100 * 1024) {
      throw ArgumentError.value(
        arguments,
        'arguments',
        'must be less than 100KiB',
      );
    }
    if (_instances.any((i) => i.instanceName == instanceName)) {
      throw StateError('instance "$instanceName" have already been used once!');
    }

    final instance = FakeCloudInstance._(
      instanceName: instanceName,
      zone: zone,
      created: clock.now().toUtc(),
      state: InstanceState.pending,
      dockerImage: dockerImage,
      arguments: arguments,
      description: description,
    );
    _log.info('Creating instance "$instanceName"');
    _instances.add(instance);

    scheduleMicrotask(() => _onCreatedController.add(instance));

    // Start running the next instance
    scheduleMicrotask(() async => await _keepExecutionLoopAlive());

    return instance;
  }

  @override
  Stream<FakeCloudInstance> listInstances() => Stream.fromIterable(_instances);

  @override
  Future<void> delete(String zone, String instanceName) async {
    if (!_instances.any(
      (i) => i.instanceName == instanceName && i.zone == zone,
    )) {
      // This is not really a problem, GoogleCloudCompute should throw
      // some exception about the instance not being found. Exact behavior of
      // the API is not specified.
      throw Exception('instance "$instanceName" does not exist');
    }

    // Let's make the operation take a second, and then remove the instance!
    _log.info('Deleting instance "$instanceName"');
    await Future.delayed(Duration(seconds: 1));
    final removed = _instances
        .where((i) => i.instanceName == instanceName && i.zone == zone)
        .toList();
    _instances
        .removeWhere((i) => i.instanceName == instanceName && i.zone == zone);

    for (final i in removed) {
      scheduleMicrotask(() => _onDeletedController.add(i));
    }
  }

  /// Change state of instance with [instanceName] to [InstanceState.running].
  ///
  /// This does not start any subprocess or run any code. Just changes the state
  /// of the instance as known.
  void fakeStartInstance(String instanceName) {
    if (!_instances.any((i) => i.instanceName == instanceName)) {
      throw StateError('instance "$instanceName" does not exist');
    }

    final instance = _instances.firstWhere(
      (i) => i.instanceName == instanceName,
    );
    _instances.removeWhere((i) => i.instanceName == instanceName);
    _instances.add(instance._copyWith(state: InstanceState.running));
  }

  /// Change state of instance with [instanceName] to [InstanceState.terminated].
  void fakeTerminateInstance(String instanceName) {
    if (!_instances.any((i) => i.instanceName == instanceName)) {
      throw StateError('instance "$instanceName" does not exist');
    }

    final instance = _instances.firstWhere(
      (i) => i.instanceName == instanceName,
    );
    _instances.removeWhere((i) => i.instanceName == instanceName);
    _instances.add(instance._copyWith(state: InstanceState.terminated));
  }

  var _running = false;
  Completer<void> _doneRunningInstance = Completer()..complete();

  /// Start execution of instances.
  void startInstanceExecution() {
    if (_running) {
      throw StateError(
        'FakeCloudCompute.startInstanceExecution() have already been called!',
      );
    }
    _running = true;
    scheduleMicrotask(() async => await _keepExecutionLoopAlive());
  }

  Future<void> _keepExecutionLoopAlive() async {
    final instance = _instances.firstWhereOrNull(
      (i) => i.state == InstanceState.pending,
    );
    // If not running, there are no pending instance, or an instance is already
    // running, then we're done.
    if (!_running || instance == null || !_doneRunningInstance.isCompleted) {
      return;
    }

    fakeStartInstance(instance.instanceName);
    _doneRunningInstance = Completer();

    scheduleMicrotask(() async {
      _log.info('Starting to run ${instance.instanceName}');
      try {
        final proc = await Process.start(
          Platform.resolvedExecutable,
          ['run', 'pub_worker', ...instance.arguments],
          workingDirectory: p.join(resolveAppDir(), '..', 'pkg', 'pub_worker'),
          mode: ProcessStartMode.inheritStdio,
        );
        final exitCode = await proc.exitCode;
        _log.info('pub_worker exit code: $exitCode');
      } finally {
        // Don't terminate the instance if it's already deleted.
        if (_instances.any((i) => i.instanceName == instance.instanceName)) {
          fakeTerminateInstance(instance.instanceName);
        }
        _doneRunningInstance.complete();

        // Start running the next instance
        scheduleMicrotask(() async => await _keepExecutionLoopAlive());
      }
    });
  }

  // ignore: close_sinks
  final _onCreatedController = StreamController<FakeCloudInstance>.broadcast();
  // ignore: close_sinks
  final _onDeletedController = StreamController<FakeCloudInstance>.broadcast();

  /// Events for when an instance is created.
  Stream<FakeCloudInstance> get onCreated => _onCreatedController.stream;

  /// Events for when an instance is deleted.
  Stream<FakeCloudInstance> get onDeleted => _onDeletedController.stream;

  /// Stop execution of instances.
  Future<void> stopInstanceExecution() async {
    if (!_running) {
      throw StateError(
        'FakeCloudCompute.startInstanceExecution() have not been called!',
      );
    }
    _running = false;
    await _doneRunningInstance.future;
  }
}

@sealed
class FakeCloudInstance extends CloudInstance {
  @override
  final String instanceName;

  @override
  final String zone;

  @override
  final DateTime created;

  @override
  final InstanceState state;

  /// Docker image that was given to [FakeCloudCompute.createInstance] when this
  /// instance was created.
  final String dockerImage;

  /// Arguments that was given to [FakeCloudCompute.createInstance] when this
  /// instance was created.
  final List<String> arguments;

  /// Description that was given to [FakeCloudCompute.createInstance] when this
  /// instance was created.
  final String description;

  FakeCloudInstance _copyWith({
    String? instanceName,
    String? zone,
    DateTime? created,
    InstanceState? state,
    String? dockerImage,
    List<String>? arguments,
    String? description,
  }) =>
      FakeCloudInstance._(
        instanceName: instanceName ?? this.instanceName,
        zone: zone ?? this.zone,
        created: created ?? this.created,
        state: state ?? this.state,
        dockerImage: dockerImage ?? this.dockerImage,
        arguments: arguments ?? this.arguments,
        description: description ?? this.description,
      );

  FakeCloudInstance._({
    required this.instanceName,
    required this.zone,
    required this.created,
    required this.state,
    required this.dockerImage,
    required this.arguments,
    required this.description,
  });

  @override
  String toString() => 'FakeCloudInstance(${[
        'name: $instanceName',
        'zone: $zone',
        'created: $created',
        'state: $state',
        'image: $dockerImage',
        'arguments: ${arguments.join(' ')}',
        'description: $description',
      ].join(',')})';
}
