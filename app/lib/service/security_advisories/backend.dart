// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:pub_dev/service/security_advisories/models.dart';
import 'package:pub_dev/shared/datastore.dart';

/// Sets the security advisory backend service.
void registerSecurityAdvisoryBackend(SecurityAdvisoryBackend backend) =>
    ss.register(#_securityAdvisoryBackend, backend);

/// The active security advisory backend service.
SecurityAdvisoryBackend get securityAdvisoryBackend =>
    ss.lookup(#_securityAdvisoryBackend) as SecurityAdvisoryBackend;

class SecurityAdvisoryBackend {
  final DatastoreDB _db;

  SecurityAdvisoryBackend(this._db);

  Future<List<SecurityAdvisory?>> lookupSecurityAdvisories(
      String package) async {
    return await withRetryTransaction(_db, (tx) async {
      final query = _db.query<SecurityAdvisory>()
        ..filter('affectedPackages =', package);
      return query.run().toList();
    });
  }

  Future<SecurityAdvisory?> lookupById(String id) async {
    final key = _db.emptyKey.append(SecurityAdvisory, id: id);
    return _db.lookupOrNull<SecurityAdvisory>(key);
  }

  Future<SecurityAdvisory> injestSecurityAdvisory(OSV vulnerability) async {
    return await withRetryTransaction(_db, (tx) async {
      final modified = DateTime.parse(vulnerability.modified);
      final oldAdvisory = await lookupById(vulnerability.id);

      if (oldAdvisory != null && oldAdvisory.modified!.isAfter(modified)) {
        return oldAdvisory;
      }

      final newAdvisory = SecurityAdvisory()
        ..id = vulnerability.id
        ..modified = modified
        ..parentKey = _db.emptyKey
        ..osvJsonBlob = vulnerability;

      newAdvisory.aliases = [vulnerability.id];
      if (vulnerability.aliases != null) {
        newAdvisory.aliases.addAll(vulnerability.aliases!);
      }

      if (vulnerability.published != null) {
        newAdvisory.published = DateTime.parse(vulnerability.published!);
      } else {
        newAdvisory.published = DateTime.now();
      }

      if (vulnerability.affected != null) {
        newAdvisory.affectedPackages =
            vulnerability.affected!.map((a) => a.package.name).toList();
      }

      tx.queueMutations(
        // This is an upsert
        inserts: [newAdvisory],
      );

      return newAdvisory;
    });
  }
}
