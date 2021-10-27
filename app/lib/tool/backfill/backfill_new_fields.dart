// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../package/backend.dart';
import '../../package/models.dart';
import '../../shared/datastore.dart';

/// Backfills new fields that are introduced in a release.
///
/// Fields should be added here as they are added to the models.
/// CHANGELOG.md must be updated with the new fields, and the next
/// release could remove the backfill from here.
Future<void> backfillNewFields() async {
  await _backfillPackages();
  await _backfillPackageVersions();
}

Future<void> _backfillPackageVersions() async {
  final query = dbService.query<PackageVersion>();
  await for (final pv in query.run()) {
    await _backfillPackageVersion(pv);
  }
}

Future<void> _backfillPackageVersion(PackageVersion pv) async {
  if (pv.isRetracted != null) return;
  await withRetryTransaction(dbService, (tx) async {
    final v = await tx.lookupValue<PackageVersion>(pv.key);
    v.isRetracted ??= false;
    tx.insert(v);
  });
}

Future<void> _backfillPackages() async {
  // Backfilling the version count may take several second for each package,
  // during which a new version could be published. To prevent bad updates,
  // the count is not used in such cases, and backfill is re-run every time
  // a race has been detected.
  var updating = true;
  while (updating) {
    updating = false;
    final query = dbService.query<Package>();
    await for (final p in query.run()) {
      final race = await _backfillPackage(p);
      if (race) updating = true;
    }
  }
}

/// Returns true if a race has been detected.
Future<bool> _backfillPackage(Package p) async {
  if (p.versionCount != null) return false;
  final count =
      await packageBackend.getPackageVersionsCount(p.name!, skipCache: true);
  return await withRetryTransaction(dbService, (tx) async {
    final v = await tx.lookupValue<Package>(p.key);
    // sanity checks for parallel updates during the version count
    if (v.versionCount == null &&
        p.updated == v.updated &&
        p.lastVersionPublished == v.lastVersionPublished &&
        p.likes == v.likes) {
      v.versionCount = count;
      v.updated = DateTime.now().toUtc();
      tx.insert(v);
      return false;
    } else {
      return true;
    }
  });
}
