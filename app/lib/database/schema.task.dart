// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// TODO(https://github.com/google/dart-neats/issues/347): remove this after typed_sql supports automatic snake_case convention
// ignore_for_file: non_constant_identifier_names

part of 'schema.dart';

@PrimaryKey(['runtime_version', 'package'])
abstract final class Task extends Row {
  /// Runtime version this [Task] belongs to.
  String get runtime_version;
  String get package;

  TaskState get state;

  /// Next [DateTime] at which point some package version becomes pending.
  DateTime get pending_at;

  /// Last [DateTime] a dependency was updated.
  DateTime get last_dependency_changed;

  /// The last time the a worker completed with a failure or success.
  DateTime get finished;
}

@PrimaryKey(['runtime_version', 'package', 'dependency'])
@ForeignKey(
  ['runtime_version', 'package'],
  table: 'tasks',
  fields: ['runtime_version', 'package'],
  name: 'task',
  as: 'dependencies',
  onDelete: .cascade,
  onUpdate: .cascade,
)
abstract final class TaskDependency extends Row {
  String get runtime_version;
  String get package;

  /// Name of a package that is either a direct or transitive dependency of
  /// [package].
  String get dependency;
}

@immutable
@JsonSerializable()
final class TaskState implements CustomDataType<JsonValue> {
  /// Scheduling state for all versions of this package.
  final Map<String, PackageVersionStateInfo> versions;

  /// The list of tokens that were removed from this [versions].
  /// When a worker reports back using one of these tokens, they will
  /// recieve a [TaskAbortedException].
  final List<AbortedTokenInfo> abortedTokens;

  TaskState({required this.versions, required this.abortedTokens});

  factory TaskState.fromJson(Map<String, dynamic> m) => _$TaskStateFromJson(m);
  Map<String, dynamic> toJson() => _$TaskStateToJson(this);

  factory TaskState.fromDatabase(JsonValue value) =>
      TaskState.fromJson(value.value as Map<String, dynamic>);

  @override
  JsonValue toDatabase() => JsonValue(toJson());
}
