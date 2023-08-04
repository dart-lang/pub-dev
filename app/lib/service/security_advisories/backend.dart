// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:basics/basics.dart';
import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pub_dev/service/entrypoint/analyzer.dart';
import 'package:pub_dev/service/security_advisories/models.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/redis_cache.dart';

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

  Future<List<OSV>> lookupSecurityAdvisories(
    String package,
  ) async {
    return (await cache.securityAdvisories(package).get(() async {
      final query = _db.query<SecurityAdvisory>()
        ..filter('affectedPackages =', package);
      return query.run().map((e) => e.osv!).toList();
    }))!;
  }

  Future<SecurityAdvisory?> lookupById(String id) async {
    final key = _db.emptyKey.append(SecurityAdvisory, id: id);
    return _db.lookupOrNull<SecurityAdvisory>(key);
  }

  @visibleForTesting
  List<String> validateAdvisoryErrors(OSV osv) {
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

  /// Sanity checks to ensure that we can store, lookup and update the advisory.
  ///
  /// We don't validate all fields, instead we aim to simply ensure that the
  /// advisory is sufficiently sound that we can store it, look it up and update
  /// it in the future.
  bool _isValidAdvisory(OSV osv) {
    final errors = validateAdvisoryErrors(osv);
    errors.forEach((error) => _logger.shout('[advisory-malformed]: $error'));
    return errors.isEmpty;
  }

  /// Overwrites existing advisory with the same id, if [osv] is newer.
  ///
  /// If id is already listed as `alias` for another advisory, no action will be
  /// taken to resolve this. Instead both advisories will be stored and served.
  /// It's assumed that security advisory database owners take care to keep the
  /// security advisories sound, and that inconsistencies are intentional.
  Future<SecurityAdvisory?> ingestSecurityAdvisory(OSV osv) async {
    return await withRetryTransaction(_db, (tx) async {
      DateTime modified;
      try {
        modified = DateTime.parse(osv.modified);
      } on FormatException {
        logger.severe('Failed to parse osv.modified: "${osv.modified}".');
        return null;
      }

      final oldAdvisory = await lookupById(osv.id);

      if (oldAdvisory != null && oldAdvisory.modified!.isAtOrAfter(modified)) {
        return oldAdvisory;
      }

      if (!_isValidAdvisory(osv)) return null;

      final newAdvisory = SecurityAdvisory()
        ..id = osv.id
        ..modified = modified
        ..parentKey = _db.emptyKey
        ..osv = osv
        ..aliases = [osv.id, ...osv.aliases]
        ..affectedPackages =
            (osv.affected ?? []).map((a) => a.package.name).toList()
        ..published =
            osv.published != null ? DateTime.parse(osv.published!) : modified;

      tx.queueMutations(
        // This is an upsert
        inserts: [newAdvisory],
      );

      return newAdvisory;
    });
  }
}
