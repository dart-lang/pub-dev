// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of 'schema.dart';

/// Stores the status of a `neat_periodic_task`, keyed by the task's name
/// and (optionally) the `runtimeVersion` it is scoped to.
///
/// TODO: rename to `NeatTaskStatus` after the Datastore migration is completed.
@PrimaryKey(['taskName', 'runtimeVersion'])
abstract final class NeatTaskStatusRow extends Row {
  /// The name of the task.
  String get taskName;

  /// The `runtimeVersion` this status is scoped to, or `-` for tasks that
  /// are not scoped to a specific runtime version.
  String get runtimeVersion;

  /// The serialized `neat_periodic_task` status payload.
  Uint8List get status;

  /// The etag of the entity, generated whenever the status is claimed.
  String get etag;

  /// The time this row was last updated.
  @Index.field()
  DateTime get updatedAt;
}
