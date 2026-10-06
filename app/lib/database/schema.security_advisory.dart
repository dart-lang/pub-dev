// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of 'schema.dart';

// Rename to `SecurityAdvisory` after the SQL migration.
@PrimaryKey(['advisoryId'])
abstract final class SecurityAdvisoryRow extends Row {
  /// The OSV advisory id.
  String get advisoryId;

  DateTime get publishedAt;
  DateTime get modifiedAt;

  /// The time this advisory was last synced (ingested) from the upstream
  /// OSV source. Used to drive cache invalidation for packages affected
  /// by this advisory.
  DateTime get syncedAt;

  /// The full OSV advisory record, as JSON.
  JsonValue get osvJson;
}

/// One row per package affected by an advisory, allowing indexed lookup
/// of advisories by affected package.
@PrimaryKey(['advisoryId', 'package'])
@ForeignKey(
  ['advisoryId'],
  table: 'securityAdvisories',
  fields: ['advisoryId'],
  name: 'advisory',
  as: 'affectedPackages',
  onDelete: .cascade,
  onUpdate: .cascade,
)
abstract final class SecurityAdvisoryPackage extends Row {
  String get advisoryId;

  @Index.field()
  String get package;
}

/// One row per alias (e.g. a CVE or GHSA id) of an advisory, allowing
/// indexed lookup of an advisory by any of its known aliases.
@PrimaryKey(['advisoryId', 'alias'])
@ForeignKey(
  ['advisoryId'],
  table: 'securityAdvisories',
  fields: ['advisoryId'],
  name: 'advisory',
  as: 'aliases',
  onDelete: .cascade,
  onUpdate: .cascade,
)
abstract final class SecurityAdvisoryAlias extends Row {
  String get advisoryId;

  @Index.field()
  String get alias;
}
