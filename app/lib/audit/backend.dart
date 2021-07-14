// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/service_scope.dart' as ss;

import '../shared/datastore.dart';

import 'models.dart';

/// Sets the audit backend service.
void registerAuditBackend(AuditBackend backend) =>
    ss.register(#_auditBackend, backend);

/// The active audit backend service.
AuditBackend get auditBackend => ss.lookup(#_auditBackend) as AuditBackend;

/// Represents the backend for the audit handling and authentication.
class AuditBackend {
  final DatastoreDB _db;
  AuditBackend(this._db);

  /// Lists audit log records for [userId] in reverse chronological order.
  ///
  /// TODO: implement paging (and log index)
  Future<List<AuditLogRecord>> listRecordsForUserId(String userId) async {
    final query = _db.query<AuditLogRecord>()..filter('users =', userId);
    final records = await query.run().where((r) => r.isNotExpired).toList();
    records.sort((a, b) => -a.created!.compareTo(b.created!));
    return records;
  }

  /// Lists audit log records for [package] in reverse chronological order.
  ///
  /// TODO: implement paging (and log index)
  Future<List<AuditLogRecord>> listRecordsForPackage(String package) async {
    final query = _db.query<AuditLogRecord>()..filter('packages =', package);
    final records = await query.run().where((r) => r.isNotExpired).toList();
    records.sort((a, b) => -a.created!.compareTo(b.created!));
    return records;
  }

  /// Lists audit log records for [package] and [version] in reverse
  /// chronological order.
  ///
  /// TODO: implement paging (and log index)
  Future<List<AuditLogRecord>> listRecordsForPackageVersion(
      String package, String version) async {
    final query = _db.query<AuditLogRecord>()
      ..filter('packageVersions =', '$package/$version');
    final records = await query.run().where((r) => r.isNotExpired).toList();
    records.sort((a, b) => -a.created!.compareTo(b.created!));
    return records;
  }

  /// Lists audit log records for [publisherId] in reverse chronological order.
  ///
  /// TODO: implement paging (and log index)
  Future<List<AuditLogRecord>> listRecordsForPublisher(
      String publisherId) async {
    final query = _db.query<AuditLogRecord>()
      ..filter('publishers =', publisherId);
    final records = await query.run().where((r) => r.isNotExpired).toList();
    records.sort((a, b) => -a.created!.compareTo(b.created!));
    return records;
  }

  /// Deletes expired log records.
  Future<void> deleteExpiredRecords() async {
    await _db.deleteWithQuery<AuditLogRecord>(
      _db.query<AuditLogRecord>()..filter('expires <', DateTime.now().toUtc()),
      where: (r) => r.isExpired,
    );
  }
}
