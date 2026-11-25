// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:_pub_shared/data/advisories_api.dart'
    show ListAdvisoriesResponse, OSV;
import 'package:basics/basics.dart';
import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/service/entrypoint/analyzer.dart';
import 'package:pub_dev/service/security_advisories/models.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/redis_cache.dart';
import 'package:typed_sql/typed_sql.dart';
import '../../package/models.dart' show Package;

final _logger = Logger('security_advisories.backend');

/// Sets the security advisory backend service.
void registerSecurityAdvisoryBackend(SecurityAdvisoryBackend backend) =>
    ss.register(#_securityAdvisoryBackend, backend);

/// The active security advisory backend service.
SecurityAdvisoryBackend get securityAdvisoryBackend =>
    ss.lookup(#_securityAdvisoryBackend) as SecurityAdvisoryBackend;

class SecurityAdvisoryBackend {
  final DatastoreDB _db;

  SecurityAdvisoryBackend(this._db);

  /// Lists all the advisories, ordered by their id.
  Future<List<SecurityAdvisoryRow>> listAdvisories() async {
    return await primaryDatabase.withRetry(
      (db) => db.securityAdvisories
          .orderBy((a) => [(a.advisoryId, Order.ascending)])
          .fetch(),
    );
  }

  Future<List<SecurityAdvisoryData>> lookupSecurityAdvisories(
    String package, {
    bool skipCache = false,
  }) async {
    final loadAdvisories = () async {
      final rows = await primaryDatabase.withRetry(
        (db) => db.securityAdvisoryPackages
            .where((p) => p.package.equalsValue(package))
            .join(db.securityAdvisories)
            .usingAdvisory()
            .select((p, a) => (a,))
            .fetch(),
      );
      return rows.map(SecurityAdvisoryData.fromRow).toList()
        ..sort((a, b) => a.advisory.id.compareTo(b.advisory.id));
    };
    if (skipCache) {
      return await loadAdvisories();
    }

    return (await cache.securityAdvisories(package).get(loadAdvisories))!;
  }

  /// Create a [ListAdvisoriesResponse] for [package] using advisories from
  /// cache.
  Future<ListAdvisoriesResponse> listAdvisoriesResponse(
    String package, {
    bool skipCache = false,
  }) async {
    final advisories = await lookupSecurityAdvisories(
      package,
      skipCache: skipCache,
    );

    final p = await packageBackend.lookupPackageRow(package);
    final latestAdvisory =
        p?.latestAdvisoryAt ?? DateTime.fromMillisecondsSinceEpoch(0);

    return ListAdvisoriesResponse(
      advisories: advisories.map((a) => a.advisory).toList(),
      advisoriesUpdated: [
        latestAdvisory,
        for (final a in advisories) a.syncTime,
      ].max,
    );
  }

  /// Looks up the advisory with [id].
  Future<SecurityAdvisoryRow?> lookupById(String id) async {
    return await primaryDatabase.withRetry(
      (db) => db.securityAdvisories.byKey(id).fetch(),
    );
  }

  bool _isValidAdvisory(OSV osv) {
    final errors = sanityCheckOSV(osv);
    errors.forEach(
      (error) => _logger.shout('[advisory-malformed] ID: ${osv.id}: $error'),
    );
    return errors.isEmpty;
  }

  /// Overwrites existing advisory with the same id, if [osv] is newer.
  ///
  /// If id is already listed as `alias` for another advisory, no action will be
  /// taken to resolve this. Instead both advisories will be stored and served.
  /// It's assumed that security advisory database owners take care to keep the
  /// security advisories sound, and that inconsistencies are intentional.
  Future<SecurityAdvisoryRow?> ingestSecurityAdvisory(
    OSV osv,
    DateTime syncTime,
  ) async {
    DateTime modified;
    try {
      modified = DateTime.parse(osv.modified);
    } on FormatException {
      logger.severe('Failed to parse osv.modified: "${osv.modified}".');
      return null;
    }

    final oldAdvisory = await lookupById(osv.id);
    if (oldAdvisory != null && oldAdvisory.modifiedAt.isAtOrAfter(modified)) {
      return oldAdvisory;
    }

    if (!_isValidAdvisory(osv)) return null;

    osv.databaseSpecific ??= <String, dynamic>{};
    osv.databaseSpecific?['pub_display_url'] = _computeDisplayUrl([
      osv.id,
      ...osv.aliases,
    ]);

    final affectedPackages = osv.affectedPubPackages;
    final updatedPackages = await _updateLatestAdvisory(
      osv.id,
      affectedPackages,
      syncTime,
    );

    // The packages are updated before the advisory is written: if the SQL write
    // fails, the next sync still sees the old advisory and retries the update.
    final result = await _upsertAdvisory(
      osv,
      affectedPackages,
      published: osv.published != null
          ? DateTime.parse(osv.published!)
          : modified,
      modified: modified,
      syncTime: syncTime,
    );

    // Trigger package post-updates only after the SQL write, so that any
    // cache repopulation doesn't read stale SQL data.
    await _postUpdatePackages(updatedPackages);
    return result;
  }

  /// Upserts the advisory row and syncs its affected packages.
  Future<SecurityAdvisoryRow> _upsertAdvisory(
    OSV osv,
    List<String> affectedPackages, {
    required DateTime published,
    required DateTime modified,
    required DateTime syncTime,
  }) async {
    final id = osv.id;
    return await primaryDatabase.transactWithRetry((db) async {
      await db.securityAdvisories
          .upsertValue(
            advisoryId: id,
            publishedAt: published,
            modifiedAt: modified,
            syncedAt: syncTime,
            osvJson: JsonValue(osv.toJson()),
          )
          .execute();

      final wantedPackages = affectedPackages.toSet();
      final existingPackages =
          (await db.securityAdvisoryPackages
                  .where((p) => p.advisoryId.equalsValue(id))
                  .select((p) => (p.package,))
                  .fetch())
              .toSet();

      final packagesToAdd = wantedPackages.difference(existingPackages);
      if (packagesToAdd.isNotEmpty) {
        await db.securityAdvisoryPackages
            .insertValuesMapped(
              packagesToAdd,
              advisoryId: (_) => id,
              package: (p) => p,
            )
            .execute();
      }

      final packagesToRemove = existingPackages.difference(wantedPackages);
      if (packagesToRemove.isNotEmpty) {
        await db.securityAdvisoryPackages
            .where(
              (p) =>
                  p.advisoryId.equalsValue(id) &
                  packagesToRemove
                      .map((pkg) => p.package.equalsValue(pkg))
                      .reduce((a, b) => a | b),
            )
            .delete()
            .execute();
      }

      return (await db.securityAdvisories.byKey(id).fetch())!;
    });
  }

  /// Sets `latestAdvisory` on the [packageNames] affected by [advisoryId].
  ///
  /// Returns the updated packages by name.
  Future<Map<String, Package>> _updateLatestAdvisory(
    String advisoryId,
    List<String> packageNames,
    DateTime syncTime,
  ) async {
    if (packageNames.length > 50) {
      // This is very unlikely to happen, since a security advisory typically
      // affects one or a few packages. We log this to keep an eye out. If
      // it turns out that this becomes a problem we need to consider other
      // solutions with eventual consistency.
      _logger.shout(
        'Failed to update `latestAdvisory` field for packages affected by'
        ' `$advisoryId`. Too many (>50) affected packages.',
      );
      return const {};
    }
    final updatedPackages = <String, Package>{};
    await withRetryTransaction(_db, (tx) async {
      final packages = await _lookupAffectedPackages(
        advisoryId,
        packageNames,
        tx,
      );
      for (final pkg in packages) {
        pkg.latestAdvisory = syncTime;
        pkg.updated = clock.now().toUtc();
        updatedPackages[pkg.name!] = pkg;
      }
      tx.queueMutations(inserts: packages);
    });
    return updatedPackages;
  }

  Future<void> _postUpdatePackages(Map<String, Package> updatedPackages) async {
    for (final pkg in updatedPackages.values) {
      await packageBackend.mirrorPackageToSql(pkg);
    }
    await Future.wait(
      updatedPackages.keys.map(
        (packageName) => triggerPackagePostUpdates(
          packageName,
          skipReanalysis: true,
          skipArchiveExport: true,
        ).future,
      ),
    );
  }

  String _computeDisplayUrl(List<String> idAndAliases) {
    final githubId = idAndAliases.firstWhereOrNull(
      (id) => id.startsWith('GHSA'),
    );
    if (githubId != null) {
      return 'https://github.com/advisories/$githubId';
    }

    final cveId = idAndAliases.firstWhereOrNull((id) => id.startsWith('CVE'));
    if (cveId != null) {
      return 'https://osv.dev/vulnerability/$cveId';
    }

    return 'https://osv.dev/vulnerability/${idAndAliases.first}';
  }

  /// Deletes the advisory with [id].
  Future<void> deleteAdvisory(String id, DateTime syncTime) async {
    final advisory = await lookupById(id);
    if (advisory == null) {
      return;
    }
    // The packages are updated before the advisory is deleted: if the SQL
    // delete fails, the next sync still sees the advisory and retries.
    final updatedPackages = await _updateLatestAdvisory(
      id,
      advisory.affectedPackages,
      syncTime,
    );
    // The affected packages are removed through the cascading foreign key.
    await primaryDatabase.withRetry(
      (db) => db.securityAdvisories.delete(id).execute(),
    );
    await _postUpdatePackages(updatedPackages);
  }

  Future<List<Package>> _lookupAffectedPackages(
    String advisoryId,
    List<String> packageNames,
    TransactionWrapper tx,
  ) async {
    final packages = <Package>[];
    for (final packageName in packageNames) {
      final package = await tx.packages.lookupOrNull(packageName);
      if (package == null) {
        _logger.shout(
          'Package $packageName not found, while ingesting advisory '
          '$advisoryId.',
        );
        continue;
      }

      packages.add(package);
    }
    return packages;
  }
}

/// Sanity checks to ensure that we can store, lookup and update the advisory.
///
/// We don't validate all fields, instead we aim to simply ensure that the
/// advisory is sufficiently sound that we can store it, look it up and update
/// it in the future.
List<String> sanityCheckOSV(OSV osv) {
  final errors = <String>[];

  if (DateTime.parse(
    osv.modified,
  ).isAfter(clock.now().add(Duration(hours: 1)))) {
    errors.add('Invalid modified date, cannot be a future date.');
  }

  if (osv.id.length > 255) {
    errors.add('Invalid id, id too long (over 255 characters).');
  }

  if (osv.affected == null || osv.affected!.isEmpty) {
    errors.add('No affected packages for advisory ${osv.id}');
  } else {
    bool noAffectedHasVersion = true;
    osv.affected!
        .where((a) => a.package.ecosystem.toLowerCase() == 'pub')
        .forEach((affected) {
          if (affected.versions == null || affected.versions!.isEmpty) {
            logger.warning(
              'No versions specified for affected package '
              '${affected.package.name} in advisory ${osv.id}.',
            );
          } else {
            noAffectedHasVersion = false;
          }
        });

    if (noAffectedHasVersion) {
      errors.add(
        'Non of the affected packages in advisory ${osv.id} has specified '
        'affected versions',
      );
    }
  }

  final invalids = <int>[];
  // Check that [osv.id] consists of printable ASCII.
  osv.id.runes.forEach((element) {
    if (element < 32 || element > 126) {
      invalids.add(element);
    }
  });

  if (invalids.isNotEmpty) {
    errors.add('Invalid id, the "id" property must be printable ASCII.');
  }

  if (json.encode(osv.toJson()).length > 1024 * 500) {
    errors.add('OSV too large (larger than 500 kB)');
  }

  return errors;
}
