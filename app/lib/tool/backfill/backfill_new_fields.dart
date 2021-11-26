// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:retry/retry.dart';

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
  await for (final p in dbService.query<Package>().run()) {
    // Backfilling the version count may take several second for each package,
    // during which a new version could be published.
    // To prevent bad updates, the backfill is running with retry.
    await retry(() => _packageVersionCount(p.name!));
  }

  await for (final p in dbService.query<Package>().run()) {
    // Correcting the timestamp may take several second for each package,
    // during which a new version could be published.
    // To prevent bad updates, the backfill is running with retry.
    await retry(() => _packagePublishedTimestamps(p.name!));
  }
}

/// Corrects the Package's published timestamps.
/// Throws if a race has been detected while the entity was updated.
Future<void> _packagePublishedTimestamps(String name) async {
  final p = (await packageBackend.lookupPackage(name))!;
  final versions = await packageBackend.versionsOfPackage(name);
  final stable =
      versions.firstWhere((v) => v.version == p.latestVersion).created;
  final prerelease = versions
      .firstWhere((v) => v.version == p.latestPrereleaseVersion)
      .created;
  final preview =
      versions.firstWhere((v) => v.version == p.latestPreviewVersion).created;
  final last =
      versions.map((e) => e.created!).reduce((a, b) => a.isBefore(b) ? b : a);

  // check if any update is needed
  if (p.latestPublished == stable &&
      p.latestPrereleasePublished == prerelease &&
      p.latestPreviewPublished == preview &&
      !p.lastVersionPublished!.isBefore(last)) {
    return;
  }

  return await withRetryTransaction(dbService, (tx) async {
    final v = await tx.lookupValue<Package>(p.key);

    // sanity checks for parallel updates during the version count
    if (v.versionCount != p.versionCount ||
        p.updated != v.updated ||
        p.lastVersionPublished != v.lastVersionPublished ||
        p.likes != v.likes ||
        p.latestPublished != v.latestPublished ||
        p.latestPrereleasePublished != v.latestPrereleasePublished ||
        p.latestPreviewPublished != v.latestPreviewPublished ||
        p.lastVersionPublished != v.lastVersionPublished) {
      _logger.info('[backfill-published-timestamps-race] "${v.name}"');
      throw Exception('Race condition detected.');
    }

    v.latestPublished = stable;
    v.latestPrereleasePublished = prerelease;
    v.latestPreviewPublished = preview;
    if (v.lastVersionPublished!.isBefore(last)) {
      v.lastVersionPublished = last;
    }
    v.updated = DateTime.now().toUtc();
  });
}

/// Backfills the Package's `versionCount` field.
/// Throws if a race has been detected while the entity was updated.
Future<void> _packageVersionCount(String name) async {
  final p = (await packageBackend.lookupPackage(name))!;
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
    return;
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
      throw Exception('Race condition detected.');
    }
    if (v.versionCount != count) {
      _logger.info(
          '[backfill-version-count-update] "${v.name}" ${v.versionCount} -> $count');
      v.versionCount = count;
      v.updated = DateTime.now().toUtc();
      tx.insert(v);
    }
  });
}
