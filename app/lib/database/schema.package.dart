// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of 'schema.dart';

/// A package: its ownership, state and pointers to the latest versions.
///
/// TODO: rename to `Package` after the SQL migration.
@PrimaryKey(['name'])
abstract final class PackageRow extends Row {
  String get name;

  DateTime get createdAt;

  /// The last modification of the row, updated on every change.
  DateTime get updatedAt;

  /// The publish time of the most recent version (including retracted ones).
  DateTime get lastVersionPublishedAt;

  /// The latest stable version (pre-release versions are deprioritized).
  String get latestVersion;

  DateTime? get latestPublishedAt;

  /// The latest version by semantic version order, including pre-releases.
  String? get latestPrereleaseVersion;

  DateTime? get latestPrereleasePublishedAt;

  /// The latest version that targets a not yet released SDK.
  String? get latestPreviewVersion;

  DateTime? get latestPreviewPublishedAt;

  /// The owner publisher (null, if the package does not have a publisher).
  String? get publisherId;

  /// The number of visible versions.
  int get versionCount;

  bool get isDiscontinued;

  String? get replacedBy;

  bool get isUnlisted;

  bool get isModerated;

  DateTime? get moderatedAt;

  bool get isAdminDeleted;

  DateTime? get adminDeletedAt;

  /// Tags assigned by the owners or by the administrators.
  JsonValue get assignedTagsJson;

  /// Versions that were removed and must not be re-uploaded.
  JsonValue get deletedVersionsJson;

  /// The configuration for automated and manual publishing.
  JsonValue? get publishingConfigJson;

  /// The last time a security advisory affecting the package was synced.
  DateTime? get latestAdvisoryAt;
}

/// A user that is an uploader of a package.
@PrimaryKey(['package', 'userId'])
@ForeignKey(
  ['package'],
  table: 'packages',
  fields: ['name'],
  name: 'packageRow',
  as: 'uploaders',
  onDelete: .cascade,
  onUpdate: .cascade,
)
@ForeignKey(
  ['userId'],
  table: 'users',
  fields: ['userId'],
  name: 'userRow',
  as: 'uploadedPackages',
  onDelete: .cascade,
  onUpdate: .cascade,
)
@Index(name: 'userPackage', fields: ['userId', 'package'])
abstract final class PackageUploader extends Row {
  String get package;

  String get userId;
}

/// A published version of a package.
///
/// TODO: rename to `PackageVersion` after the SQL migration.
@PrimaryKey(['package', 'version'])
abstract final class PackageVersionRow extends Row {
  String get package;

  String get version;

  DateTime get createdAt;

  /// The SHA-256 hash of the canonical archive file.
  Uint8List? get sha256;

  JsonValue get pubspecJson;

  /// The public libraries of the version.
  JsonValue get librariesJson;

  /// The `User.userId` of the uploader, or a `service:` prefixed agent id.
  String get uploader;

  /// The publisher id at the time of the upload.
  String? get publisherId;

  bool get isRetracted;

  DateTime? get retractedAt;

  bool get isModerated;

  DateTime? get moderatedAt;

  bool get isAdminDeleted;

  DateTime? get adminDeletedAt;
}

/// An extracted asset (pubspec, readme, changelog, example, license) of a
/// package version archive.
///
/// TODO: rename to `PackageVersionAsset` after the SQL migration.
@PrimaryKey(['package', 'version', 'kind'])
abstract final class PackageVersionAssetRow extends Row {
  String get package;

  String get version;

  /// One of the `AssetKind` values.
  String get kind;

  DateTime get updatedAt;

  String get path;

  String get textContent;
}

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
