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
  var wasRace = true;
  while (wasRace) {
    wasRace = false;

    await for (final p in dbService.query<Package>().run()) {
      if (await _packageVersionCount(p)) {
        wasRace = true;
      }
    }

    await for (final p in dbService.query<Package>().run()) {
      if (await _packagePublishedTimestamps(p)) {
        wasRace = true;
      }
    }
  }
}

/// Corrects the Package's published timestamps.
/// Returns true if a race has been detected while the entity was updated.
Future<bool> _packagePublishedTimestamps(Package p) async {
  final versions = await packageBackend.listVersionsCached(p.name!);
  final stable = versions.versions
      .firstWhere((v) => v.version == p.latestVersion)
      .published;
  final prerelease = versions.versions
      .firstWhere((v) => v.version == p.latestPrereleaseVersion)
      .published;
  final preview = versions.versions
      .firstWhere((v) => v.version == p.latestPreviewVersion)
      .published;
  final last = versions.versions
      .map((e) => e.published!)
      .reduce((a, b) => a.isBefore(b) ? b : a);

  // check if any update is needed
  if (p.latestPublished == stable &&
      p.latestPrereleasePublished == prerelease &&
      p.latestPreviewPublished == preview &&
      !p.lastVersionPublished!.isBefore(last)) {
    return false;
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
      return true;
    }

    v.latestPublished = stable;
    v.latestPrereleasePublished = prerelease;
    v.latestPreviewPublished = preview;
    if (v.lastVersionPublished!.isBefore(last)) {
      v.lastVersionPublished = last;
    }
    v.updated = DateTime.now().toUtc();
    return false;
  });
}

/// Backfills the Package's `versionCount` field.
/// Returns true if a race has been detected while the entity was updated.
Future<bool> _packageVersionCount(Package p) async {
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
