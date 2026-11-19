// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of 'schema.dart';

/// Stores the active Datastore-to-SQL migration phase of an entity type.
///
/// When no row exists for an entity, it defaults to `datastore-primary`.
@PrimaryKey(['entity'])
abstract final class MigrationPhaseRow extends Row {
  /// Identifier of the entity, matching its primary SQL table name.
  String get entity;

  /// Active migration phase (e.g. `datastore-primary`, `sql-primary`).
  String get phase;

  /// Timestamp when the phase was last updated.
  DateTime get updatedAt;
}
