import 'package:clock/clock.dart';
import 'package:meta/meta.dart';

import 'cloudcompute.dart';

@sealed
class FakeCloudCompute extends CloudCompute {
  var _nextInstanceId = 1;
  final _instances = <FakeCloudInstance>{};

  @override
  final List<String> zones = List.unmodifiable(['zone-a', 'zone-b']);

  @override
  String generateInstanceName() => 'instance-${_nextInstanceId++}';

  @override
  Future<FakeCloudInstance> createInstance({
    required String zone,
    required String name,
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
    if (_instances.any((i) => i.name == name)) {
      throw StateError('instance "$name" have already been used once!');
    }

    final instance = FakeCloudInstance._(
      name: name,
      zone: zone,
      created: clock.now().toUtc(),
      state: InstanceState.pending,
      dockerImage: dockerImage,
      arguments: arguments,
      description: description,
    );
    _instances.add(instance);
    return instance;
  }

  @override
  Stream<FakeCloudInstance> listInstances() => Stream.fromIterable(_instances);

  @override
  Future<void> delete(String zone, String name) async {
    if (!_instances.any((i) => i.name == name && i.zone == zone)) {
      // This is not really a problem, GoogleCloudCompute should might throw
      // some exception about the instance not being found. Exact behavior of
      // the API is not specified.
      throw Exception('instance "$name" does not exist');
    }

    // Let's make the operation take a minute, and then remove the instance!
    await Future.delayed(Duration(minutes: 1));
    _instances.removeWhere((i) => i.name == name && i.zone == zone);
  }

  /// Change state of instance with [name] to [InstanceState.running].
  void fakeStartInstance(String name) {
    if (!_instances.any((i) => i.name == name)) {
      throw StateError('instance "$name" does not exist');
    }

    final instance = _instances.firstWhere((i) => i.name == name);
    _instances.removeWhere((i) => i.name == name);
    _instances.add(instance._copyWith(state: InstanceState.running));
  }

  /// Change state of instance with [name] to [InstanceState.terminated].
  void fakeTerminateInstance(String name) {
    if (!_instances.any((i) => i.name == name)) {
      throw StateError('instance "$name" does not exist');
    }

    final instance = _instances.firstWhere((i) => i.name == name);
    _instances.removeWhere((i) => i.name == name);
    _instances.add(instance._copyWith(state: InstanceState.terminated));
  }
}

@sealed
class FakeCloudInstance extends CloudInstance {
  @override
  final String name;

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
    String? name,
    String? zone,
    DateTime? created,
    InstanceState? state,
    String? dockerImage,
    List<String>? arguments,
    String? description,
  }) =>
      FakeCloudInstance._(
        name: name ?? this.name,
        zone: zone ?? this.zone,
        created: created ?? this.created,
        state: state ?? this.state,
        dockerImage: dockerImage ?? this.dockerImage,
        arguments: arguments ?? this.arguments,
        description: description ?? this.description,
      );

  FakeCloudInstance._({
    required this.name,
    required this.zone,
    required this.created,
    required this.state,
    required this.dockerImage,
    required this.arguments,
    required this.description,
  });
}
