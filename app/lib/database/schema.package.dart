// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of 'schema.dart';

/// Entity representing a package that has been removed (moderated).
@PrimaryKey(['name'])
abstract final class PackageTombstone extends Row {
  String get name;

  DateTime get moderatedAt;

  /// The previous publisher id (null, if the package did not have a publisher).
  String? get publisherId;

  /// List of `User.userId` of previous uploaders.
  JsonValue get uploadersJson;

  /// List of previous versions.
  JsonValue get versionsJson;
}

/// Entity representing a reserved package: the name is available only for a
/// subset of the users (`@google.com` + a list of emails).
///
/// TODO: rename to `ReservedPackage` after fully migrated to SQL.
@PrimaryKey(['name'])
abstract final class ReservedPackageRow extends Row {
  String get name;

  DateTime get createdAt;

  /// List of email addresses that are allowed to claim this package name,
  /// on top of the `@google.com` addresses.
  JsonValue get emailsJson;
}

/// The per-package rolling download counts (`CountData`).
@PrimaryKey(['package'])
abstract final class DownloadCount extends Row {
  String get package;

  /// The timestamp when the row was last updated.
  DateTime get updatedAt;

  /// JSON-encoded `CountData` (total + major/minor/patch range counts).
  JsonValue get countDataJson;
}
