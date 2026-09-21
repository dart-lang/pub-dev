// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of 'schema.dart';

/// Mirrors `AuditLogRecord` into SQL.
///
/// Datastore remains the source of truth and the only read path for now.
/// This table is populated on write (and by backfill), in preparation for a
/// future migration to SQL-first reads.
@PrimaryKey(['id'])
abstract final class AuditLogRecordRow extends Row {
  /// Matches `AuditLogRecord.id`.
  String get id;

  DateTime get created;

  @Index.field()
  DateTime get expires;

  String get kind;
  String get agent;
  String get summary;

  /// Free-form data, mirrors `AuditLogRecord.data` as a JSONB column.
  JsonValue? get dataJson;
}

/// A single (record, kind, value) association, mirroring one entry of
/// `AuditLogRecord.users` / `.packages` / `.packageVersions` / `.publishers`
/// (with [kind] singularized, see [AuditLogAssociationKind]), to allow
/// indexed lookup by kind and value.
@PrimaryKey(['recordId', 'kind', 'value'])
@ForeignKey(
  ['recordId'],
  table: 'auditLogRecords',
  fields: ['id'],
  name: 'record',
  as: 'associations',
  onDelete: .cascade,
  onUpdate: .cascade,
)
@Index(name: 'kindValue', fields: ['kind', 'value'])
abstract final class AuditLogAssociation extends Row {
  String get recordId;

  /// One of [AuditLogAssociationKind]'s values - matching the corresponding
  /// `AuditLogRecord` field name.
  String get kind;

  /// The associated id: userId, package name, `package/version`, or
  /// publisherId - depending on [kind].
  String get value;
}

/// The `kind` values used in the `auditLogAssociation` SQL table, matching
/// the corresponding (singularized) `AuditLogRecord` field names.
abstract class AuditLogAssociationKind {
  static const user = 'user';
  static const package = 'package';
  static const packageVersion = 'packageVersion';
  static const publisher = 'publisher';
}

extension AuditLogAssociationIterableExt on Iterable<AuditLogAssociation> {
  /// Returns the entries whose [AuditLogAssociation.kind] is [kind].
  Iterable<AuditLogAssociation> whereKind(String kind) =>
      where((a) => a.kind == kind);
}
