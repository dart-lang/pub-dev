// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of 'model.dart';

@PrimaryKey(['runtimeVersion', 'package'])
abstract final class Task extends Row {
  /// Runtime version this [Task] belongs to.
  String get runtimeVersion;
  String get package;

  TaskState get state;

  /// Next [DateTime] at which point some package version becomes pending.
  DateTime get pendingAt;

  /// Last [DateTime] a dependency was updated.
  DateTime get lastDependencyChanged;

  /// The last time the a worker completed with a failure or success.
  DateTime get finished;
}

@PrimaryKey(['runtimeVersion', 'package', 'dependency'])
@ForeignKey(
  ['runtimeVersion', 'package'],
  table: 'tasks',
  fields: ['runtimeVersion', 'package'],
  name: 'task',
  as: 'dependencies',
)
abstract final class TaskDependency extends Row {
  String get runtimeVersion;
  String get package;

  /// Name of a package that is either a direct or transitive dependency of
  /// [package].
  String get dependency;
}

@immutable
@JsonSerializable()
final class TaskState implements CustomDataType<String> {
  /// Scheduling state for all versions of this package.
  final Map<String, PackageVersionStateInfo> versions;

  /// The list of tokens that were removed from this [versions].
  /// When a worker reports back using one of these tokens, they will
  /// recieve a [TaskAbortedException].
  final List<AbortedTokenInfo> abortedTokens;

  TaskState({
    required this.versions,
    required this.abortedTokens,
  });

  factory TaskState.fromJson(Map<String, dynamic> m) => _$TaskStateFromJson(m);
  Map<String, dynamic> toJson() => _$TaskStateToJson(this);

  factory TaskState.fromDatabase(String value) =>
      TaskState.fromJson(json.decode(value) as Map<String, dynamic>);
  @override
  String toDatabase() => json.encode(toJson());
}
