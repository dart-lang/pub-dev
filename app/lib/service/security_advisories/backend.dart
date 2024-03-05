// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:_pub_shared/data/advisories_api.dart' show OSV;
import 'package:basics/basics.dart';
import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:pub_dev/service/entrypoint/analyzer.dart';
import 'package:pub_dev/service/security_advisories/models.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/redis_cache.dart';
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

  Future<List<SecurityAdvisory>> listAdvisories() async {
    final query = _db.query<SecurityAdvisory>();
    return query.run().toList();
  }

  Future<List<SecurityAdvisoryData>> lookupSecurityAdvisories(
    String package,
  ) async {
    return (await cache.securityAdvisories(package).get(() async {
      final query = _db.query<SecurityAdvisory>()
        ..filter('affectedPackages =', package);
      return query
          .run()
          .map((SecurityAdvisory adv) => SecurityAdvisoryData.fromModel(adv))
          .toList();
    }))!;
  }

  Future<SecurityAdvisory?> lookupById(String id) async {
    final key = _db.emptyKey.append(SecurityAdvisory, id: id);
    return _db.lookupOrNull<SecurityAdvisory>(key);
  }

  bool _isValidAdvisory(OSV osv) {
    final errors = sanityCheckOSV(osv);
    errors.forEach(
        (error) => _logger.shout('[advisory-malformed] ID: ${osv.id}: $error'));
    return errors.isEmpty;
  }

  /// Overwrites existing advisory with the same id, if [osv] is newer or
  /// unconditionally if [resync] is set.
  ///
  /// If id is already listed as `alias` for another advisory, no action will be
  /// taken to resolve this. Instead both advisories will be stored and served.
  /// It's assumed that security advisory database owners take care to keep the
  /// security advisories sound, and that inconsistencies are intentional.
  Future<SecurityAdvisory?> ingestSecurityAdvisory(OSV osv, DateTime syncTime,
      {bool resync = false}) async {
    return await withRetryTransaction(_db, (tx) async {
      DateTime modified;
      try {
        modified = DateTime.parse(osv.modified);
      } on FormatException {
        logger.severe('Failed to parse osv.modified: "${osv.modified}".');
        return null;
      }

      final oldAdvisory = await lookupById(osv.id);

      if (!resync &&
          oldAdvisory != null &&
          oldAdvisory.modified!.isAtOrAfter(modified)) {
        return oldAdvisory;
      }

      if (!_isValidAdvisory(osv)) return null;

      final idAndAliases = [osv.id, ...osv.aliases];

      osv.databaseSpecific ??= <String, dynamic>{};
      osv.databaseSpecific?['pub_display_url'] =
          _computeDisplayUrl(idAndAliases);

      final newAdvisory = SecurityAdvisory()
        ..id = osv.id
        ..modified = modified
        ..parentKey = _db.emptyKey
        ..osv = osv
        ..aliases = idAndAliases
        ..affectedPackages =
            (osv.affected ?? []).map((a) => a.package.name).toList()
        ..published =
            osv.published != null ? DateTime.parse(osv.published!) : modified
        ..syncTime = syncTime;

      if (newAdvisory.affectedPackages!.length > 50) {
        // This is very unlikly to happen, since a security advisory typically
        // affects one or a few packages. We log this to keep an eye out. If
        // it turns out that this becomes a problem we need to consider other
        // solutions with eventual consistency.
        _logger.shout(
            'Failed to update `latestAdvisory` field for packages affected by'
            ' `${newAdvisory.name}`. Too many (>50) affected packages.');
        tx.queueMutations(
          // This is an upsert
          inserts: [newAdvisory],
        );
      } else {
        final packages = await _lookupAffectedPackages(newAdvisory, tx);
        packages.forEach((pkg) => pkg.latestAdvisory = syncTime);
        tx.queueMutations(
          // This is an upsert
          inserts: [newAdvisory, ...packages],
        );
      }

      return newAdvisory;
    });
  }

  String _computeDisplayUrl(List<String> idAndAliases) {
    final githubId =
        idAndAliases.firstWhereOrNull((id) => id.startsWith('GHSA'));
    if (githubId != null) {
      return 'https://github.com/advisories/$githubId';
    }

    final cveId = idAndAliases.firstWhereOrNull((id) => id.startsWith('CVE'));
    if (cveId != null) {
      return 'https://osv.dev/vulnerability/$cveId';
    }

    return 'https://osv.dev/vulnerability/${idAndAliases.first}';
  }

  Future<void> deleteAdvisory(
      SecurityAdvisory advisory, DateTime syncTime) async {
    return await withRetryTransaction(_db, (tx) async {
      final key = _db.emptyKey.append(SecurityAdvisory, id: advisory.id);

      if (advisory.affectedPackages!.length > 50) {
        // This is very unlikly to happen, since a security advisory typically
        // affects one or a few packages. We log this to keep an eye out. If
        // it turns out that this becomes a problem we need to consider other
        // solutions with eventual consistency.
        _logger.shout(
            'Failed to update `latestAdvisory` field for packages affected by'
            ' `${advisory.name}`. Too many (>50) affected packages.');

        // If necessary this can be optimized by deleting up to 500 at once.
        // At this point we don't expect many deletes so we keep it simple.
        // await _db.commit(deletes: [key]);
        tx.queueMutations(deletes: [key]);
      } else {
        final packages = await _lookupAffectedPackages(advisory, tx);
        packages.forEach((pkg) => pkg.latestAdvisory = syncTime);
        tx.queueMutations(inserts: packages, deletes: [key]);
      }
    });
  }

  Future<List<Package>> _lookupAffectedPackages(
      SecurityAdvisory advisory, TransactionWrapper tx) async {
    final packages = <Package>[];
    for (final packageName in advisory.affectedPackages!) {
      final packageKey = _db.emptyKey.append(Package, id: packageName);
      final package = await tx.lookupOrNull<Package>(packageKey);
      if (package == null) {
        _logger
            .shout('Package $packageName not found, while ingesting advisory '
                '${advisory.id}.');
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

  if (DateTime.parse(osv.modified)
      .isAfter(clock.now().add(Duration(hours: 1)))) {
    errors.add('Invalid modified date, cannot be a future date.');
  }

  if (osv.id.length > 255) {
    errors.add('Invalid id, id too long (over 255 characters).');
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
