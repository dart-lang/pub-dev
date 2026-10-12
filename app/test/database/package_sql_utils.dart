// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:test/test.dart';
import 'package:typed_sql/typed_sql.dart';

/// Expects that the SQL rows of [package] (and its versions) match the
/// Datastore entities, or that none of them exist when the package is gone.
Future<void> expectPackageInSqlMatchesDatastore(String package) async {
  final p = await packageBackend.lookupPackage(package);
  final versions = p == null
      ? const <PackageVersion>[]
      : await packageBackend.versionsOfPackage(package);
  final row = await primaryDatabase.withRetry(
    (db) => db.packages.byKey(package).fetch(),
  );
  final versionRows = await primaryDatabase.withRetry(
    (db) =>
        db.packageVersions.where((v) => v.package.equalsValue(package)).fetch(),
  );

  final uploaderRows = await primaryDatabase.withRetry(
    (db) => db.packageUploaders
        .where((u) => u.package.equalsValue(package))
        .fetch(),
  );

  if (p == null) {
    expect(row, isNull, reason: 'package $package');
    expect(versionRows, isEmpty, reason: 'versions of $package');
    expect(uploaderRows, isEmpty, reason: 'uploaders of $package');
    return;
  }
  expect(row, isNotNull, reason: 'package $package');
  expect(
    {
      'createdAt': _micros(row!.createdAt),
      'updatedAt': _micros(row.updatedAt),
      'lastVersionPublishedAt': _micros(row.lastVersionPublishedAt),
      'latestVersion': row.latestVersion,
      'latestPublishedAt': _micros(row.latestPublishedAt),
      'latestPrereleaseVersion': row.latestPrereleaseVersion,
      'latestPrereleasePublishedAt': _micros(row.latestPrereleasePublishedAt),
      'latestPreviewVersion': row.latestPreviewVersion,
      'latestPreviewPublishedAt': _micros(row.latestPreviewPublishedAt),
      'publisherId': row.publisherId,
      'uploaders': uploaderRows.map((u) => u.userId).toSet(),
      'versionCount': row.versionCount,
      'isDiscontinued': row.isDiscontinued,
      'replacedBy': row.replacedBy,
      'isUnlisted': row.isUnlisted,
      'isModerated': row.isModerated,
      'moderatedAt': _micros(row.moderatedAt),
      'isAdminDeleted': row.isAdminDeleted,
      'adminDeletedAt': _micros(row.adminDeletedAt),
      'assignedTags': row.assignedTagsJson.value,
      'deletedVersions': row.deletedVersionsJson.value,
      'publishingConfig': row.publishingConfigJson?.value,
      'latestAdvisoryAt': _micros(row.latestAdvisoryAt),
    },
    {
      'createdAt': _micros(p.created),
      'updatedAt': _micros(p.updated),
      'lastVersionPublishedAt': _micros(p.lastVersionPublished),
      'latestVersion': p.latestVersion,
      'latestPublishedAt': _micros(p.latestPublished),
      'latestPrereleaseVersion': p.latestPrereleaseVersion,
      'latestPrereleasePublishedAt': _micros(p.latestPrereleasePublished),
      'latestPreviewVersion': p.latestPreviewVersion,
      'latestPreviewPublishedAt': _micros(p.latestPreviewPublished),
      'publisherId': p.publisherId,
      'uploaders': (p.uploaders ?? <String>[]).toSet(),
      'versionCount': p.versionCount,
      'isDiscontinued': p.isDiscontinued,
      'replacedBy': p.replacedBy,
      'isUnlisted': p.isUnlisted,
      'isModerated': p.isModerated,
      'moderatedAt': _micros(p.moderatedAt),
      'isAdminDeleted': p.isAdminDeleted,
      'adminDeletedAt': _micros(p.adminDeletedAt),
      'assignedTags': p.assignedTags ?? [],
      'deletedVersions': p.deletedVersions ?? [],
      'publishingConfig': p.publishingConfig == null
          ? null
          : json.decode(json.encode(p.publishingConfig)),
      'latestAdvisoryAt': _micros(p.latestAdvisory),
    },
    reason: 'package $package',
  );

  expect(
    {
      for (final v in versionRows)
        v.version: {
          'createdAt': _micros(v.createdAt),
          'sha256': v.sha256?.toList(),
          'pubspec': v.pubspecJson.value,
          'libraries': v.librariesJson.value,
          'uploader': v.uploader,
          'publisherId': v.publisherId,
          'isRetracted': v.isRetracted,
          'retractedAt': _micros(v.retractedAt),
          'isModerated': v.isModerated,
          'moderatedAt': _micros(v.moderatedAt),
          'isAdminDeleted': v.isAdminDeleted,
          'adminDeletedAt': _micros(v.adminDeletedAt),
        },
    },
    {
      for (final v in versions)
        v.version!: {
          'createdAt': _micros(v.created),
          'sha256': v.sha256,
          'pubspec': json.decode(v.pubspec!.jsonString),
          'libraries': v.libraries ?? [],
          'uploader': v.uploader,
          'publisherId': v.publisherId,
          'isRetracted': v.isRetracted,
          'retractedAt': _micros(v.retracted),
          'isModerated': v.isModerated,
          'moderatedAt': _micros(v.moderatedAt),
          'isAdminDeleted': v.isAdminDeleted,
          'adminDeletedAt': _micros(v.adminDeletedAt),
        },
    },
    reason: 'versions of $package',
  );
}

int? _micros(DateTime? value) => value?.microsecondsSinceEpoch;
