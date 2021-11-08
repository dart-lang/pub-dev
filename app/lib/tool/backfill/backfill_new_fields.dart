// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';

import '../../package/backend.dart';
import '../../package/models.dart';
import '../../shared/datastore.dart';

final _logger = Logger('backfill_new_fields');

/// Backfills new fields that are introduced in a release.
///
/// Fields should be added here as they are added to the models.
/// CHANGELOG.md must be updated with the new fields, and the next
/// release could remove the backfill from here.
Future<void> backfillNewFields() async {
  await _backfillPackages();
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

/// Returns true if a race has been detected while the Package entity
/// was being verified and updated.
Future<bool> _backfillPackage(Package p) async {
  final versions = await packageBackend.versionsOfPackage(p.name!);
  final count = versions.length;
  final countUntilLastPublished = versions
      .where((pv) => !pv.created!.isAfter(p.lastVersionPublished!))
      .length;
  if (count != countUntilLastPublished) {
    _logger.info(
        '[backfill-version-count-investigate] "${p.name}" version count '
        'difference: $count total != $countUntilLastPublished until last published.');
  }
  if (p.versionCount == count) {
    return false;
  }
  return await withRetryTransaction(dbService, (tx) async {
    final v = await tx.lookupValue<Package>(p.key);
    // sanity checks for parallel updates during the version count
    if (v.versionCount != p.versionCount ||
        p.updated != v.updated ||
        p.lastVersionPublished != v.lastVersionPublished ||
        p.likes != v.likes) {
      _logger.info(
          '[backfill-version-count-race] "${v.name}" ${v.versionCount} -> $count');
      return true;
    }
    if (v.versionCount != count) {
      _logger.info(
          '[backfill-version-count-update] "${v.name}" ${v.versionCount} -> $count');
      v.versionCount = count;
      v.updated = DateTime.now().toUtc();
      tx.insert(v);
    }
    return false;
  });
}
