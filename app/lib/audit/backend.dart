// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/service_scope.dart' as ss;

import '../shared/datastore.dart';

import 'models.dart';

/// The maximum number of entities to be loaded from Datastore in one batch.
const _maxAuditLogBatchSize = 1000;

/// Sets the audit backend service.
void registerAuditBackend(AuditBackend backend) =>
    ss.register(#_auditBackend, backend);

/// The active audit backend service.
AuditBackend get auditBackend => ss.lookup(#_auditBackend) as AuditBackend;

/// Represents the backend for the audit handling and authentication.
class AuditBackend {
  final DatastoreDB _db;
  AuditBackend(this._db);

  Future<AuditLogRecordPage> _query(
    String propertyName,
    String value,
    DateTime? before,
  ) async {
    assert(propertyName == 'users' ||
        propertyName == 'packages' ||
        propertyName == 'packageVersions' ||
        propertyName == 'publishers');
    final query = _db.query<AuditLogRecord>()
      ..filter('$propertyName =', value)
      ..filter('created <=',
          before ?? DateTime.now().toUtc().add(Duration(minutes: 5)))
      ..order('-created')
      ..limit(_maxAuditLogBatchSize);
    // TODO: consider using repeated queries to filter already expired records,
    //       while also making sure that at least one record is on this and on
    //       the next page.
    final records = await query.run().toList();
    if (records.length == _maxAuditLogBatchSize) {
      return AuditLogRecordPage(
          records.take(_maxAuditLogBatchSize - 1).toList(),
          records.last.created);
    } else {
      return AuditLogRecordPage(records, null);
    }
  }

  /// Lists audit log records for [userId] in reverse chronological order.
  Future<AuditLogRecordPage> listRecordsForUserId(
    String userId, {
    DateTime? before,
  }) async {
    return await _query('users', userId, before);
  }

  /// Lists audit log records for [package] in reverse chronological order.
  Future<AuditLogRecordPage> listRecordsForPackage(
    String package, {
    DateTime? before,
  }) async {
    return await _query('packages', package, before);
  }

  /// Lists audit log records for [package] and [version] in reverse
  /// chronological order.
  Future<AuditLogRecordPage> listRecordsForPackageVersion(
    String package,
    String version, {
    DateTime? before,
  }) async {
    return await _query('packageVersions', '$package/$version', before);
  }

  /// Lists audit log records for [publisherId] in reverse chronological order.
  Future<AuditLogRecordPage> listRecordsForPublisher(
    String publisherId, {
    DateTime? before,
  }) async {
    return await _query('publishers', publisherId, before);
  }

  /// Deletes expired log records.
  Future<void> deleteExpiredRecords() async {
    await _db.deleteWithQuery<AuditLogRecord>(
      _db.query<AuditLogRecord>()..filter('expires <', DateTime.now().toUtc()),
      where: (r) => r.isExpired,
    );
  }

  /// Parses the `before` query parameter and returns the parsed timestamp.
  ///
  /// Returns a timestamp slightly into the future if the parameter is missing.
  /// Returns null if the query parameter is invalid.
  DateTime? parseBeforeQueryParameter(String? param) {
    if (param == null) {
      return DateTime.now().add(const Duration(minutes: 5));
    }
    return DateTime.tryParse(param);
  }
}
