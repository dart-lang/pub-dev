// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:typed_sql/typed_sql.dart';

import '../shared/datastore.dart';
import '../shared/exceptions.dart';

import 'models.dart';

final _log = Logger('pub.audit.backend');

/// The maximum number of entities to be loaded from Datastore in one batch.
const _maxAuditLogBatchSize = 1000;

final _shortBeforeFormat = RegExp(r'^([0-9]{4})-([0-9]{2})-([0-9]{2})$');

/// Sets the audit backend service.
void registerAuditBackend(AuditBackend backend) =>
    ss.register(#_auditBackend, backend);

/// The active audit backend service.
AuditBackend get auditBackend => ss.lookup(#_auditBackend) as AuditBackend;

/// Represents the backend for the audit handling and authentication.
class AuditBackend {
  final DatastoreDB _db;
  var _cachedRecords = _CachedRecords(DateTime(0), []);
  Future<void>? _cacheRecordsUpdateFuture;

  AuditBackend(this._db);

  Future<AuditLogRecordPage> _query(
    String propertyName,
    String value,
    DateTime? before,
  ) async {
    assert(
      propertyName == 'users' ||
          propertyName == 'packages' ||
          propertyName == 'packageVersions' ||
          propertyName == 'publishers',
    );
    final query = _db.query<AuditLogRecord>()
      ..filter('$propertyName =', value)
      ..filter(
        'created <=',
        before ?? clock.now().toUtc().add(Duration(minutes: 5)),
      )
      ..order('-created')
      ..limit(_maxAuditLogBatchSize);
    // TODO: consider using repeated queries to filter already expired records,
    //       while also making sure that at least one record is on this and on
    //       the next page.
    final records = await query.run().toList();
    if (records.length == _maxAuditLogBatchSize) {
      final nextDisplayed = records.last.created!;
      final remainingRecords = records.take(_maxAuditLogBatchSize - 1).toList();
      final lastDisplayed = remainingRecords.last.created!;
      return AuditLogRecordPage(
        remainingRecords,
        nextTimestamp(lastDisplayed, nextDisplayed),
      );
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
      _db.query<AuditLogRecord>()..filter('expires <', clock.now().toUtc()),
      where: (r) => r.isExpired,
    );
    await deleteExpiredSqlRecords();
  }

  /// Mirrors [record] into SQL (best-effort).
  ///
  /// For entity operations that use this method, the Datastore
  /// remains the source of truth, while migrated operations will
  /// use the SQL Database as the source of truth.
  Future<void> mirrorToSql(AuditLogRecord record) async {
    try {
      await primaryDatabase.transactWithRetry(
        (db) => _upsertSqlRecord(db, record),
      );
    } catch (e, st) {
      _log.warning(
        'Failed to mirror AuditLogRecord "${record.id}" to SQL.',
        e,
        st,
      );
    }
  }

  Future<void> _upsertSqlRecord(
    Database<PrimarySchema> db,
    AuditLogRecord record,
  ) async {
    final id = record.id!;
    await db.auditLogRecords
        .insertValue(
          id: id,
          createdAt: record.created!,
          expiresAt: record.expires!,
          kind: record.kind!,
          agent: record.agent!,
          summary: record.summary!,
          dataJson: record.data == null ? null : JsonValue(record.data),
        )
        .onConflict(.primaryKey)
        .update(
          (_, excluded, set) => set(
            createdAt: excluded.createdAt,
            expiresAt: excluded.expiresAt,
            kind: excluded.kind,
            agent: excluded.agent,
            summary: excluded.summary,
            dataJson: excluded.dataJson,
          ),
        )
        .execute();

    await db.auditLogAssociation
        .where((a) => a.recordId.equalsValue(id))
        .delete()
        .execute();

    final associations = <({String kind, String value})>[
      for (final u in record.users ?? const <String>[])
        (kind: AuditLogAssociationKind.user, value: u),
      for (final p in record.packages ?? const <String>[])
        (kind: AuditLogAssociationKind.package, value: p),
      for (final pv in record.packageVersions ?? const <String>[])
        (kind: AuditLogAssociationKind.packageVersion, value: pv),
      for (final pub in record.publishers ?? const <String>[])
        (kind: AuditLogAssociationKind.publisher, value: pub),
    ];
    if (associations.isNotEmpty) {
      await db.auditLogAssociation
          .insertValuesMapped(
            associations,
            recordId: (_) => id,
            kind: (a) => a.kind,
            value: (a) => a.value,
          )
          .onConflict(.primaryKey)
          .doNothing()
          .execute();
    }
  }

  /// Copies audit log records from Datastore into SQL, for records that are
  /// not yet present in SQL.
  Future<int> backfillSqlFromDatastore({int? limit}) async {
    var count = 0;
    await for (final record in _db.query<AuditLogRecord>().run()) {
      if (limit != null && count >= limit) {
        break;
      }
      final existing = await primaryDatabase.withRetry(
        (db) => db.auditLogRecords.byKey(record.id!).fetch(),
      );
      if (existing != null) {
        continue;
      }
      await mirrorToSql(record);
      count++;
    }
    return count;
  }

  /// Copies audit log records from SQL into Datastore, for records that are
  /// not yet present in Datastore.
  Future<int> backfillDatastoreFromSql({int? limit}) async {
    final rows = await primaryDatabase.withRetry(
      (db) => db.auditLogRecords.fetch(),
    );
    var count = 0;
    for (final row in rows) {
      if (limit != null && count >= limit) {
        break;
      }
      final key = _db.emptyKey.append(AuditLogRecord, id: row.id);
      final existing = await _db.lookupOrNull<AuditLogRecord>(key);
      if (existing != null) {
        continue;
      }
      final associations = await primaryDatabase.withRetry(
        (db) => db.auditLogAssociation
            .where((a) => a.recordId.equalsValue(row.id))
            .fetch(),
      );
      final record = AuditLogRecord()
        ..id = row.id
        ..created = row.createdAt
        ..expires = row.expiresAt
        ..kind = row.kind
        ..agent = row.agent
        ..summary = row.summary
        ..data = row.dataJson?.value as Map<String, dynamic>?
        ..users = associations
            .whereKind(AuditLogAssociationKind.user)
            .map((a) => a.value)
            .toList()
        ..packages = associations
            .whereKind(AuditLogAssociationKind.package)
            .map((a) => a.value)
            .toList()
        ..packageVersions = associations
            .whereKind(AuditLogAssociationKind.packageVersion)
            .map((a) => a.value)
            .toList()
        ..publishers = associations
            .whereKind(AuditLogAssociationKind.publisher)
            .map((a) => a.value)
            .toList();
      await _db.commit(inserts: [record]);
      count++;
    }
    return count;
  }

  /// Deletes expired log records from SQL.
  ///
  /// Associated rows in `auditLogAssociation` are removed via
  /// `ON DELETE CASCADE`.
  Future<void> deleteExpiredSqlRecords() async {
    await primaryDatabase.withRetry(
      (db) => db.auditLogRecords
          .where((r) => r.expiresAt.isBeforeValue(clock.now().toUtc()))
          .delete()
          .execute(),
    );
  }

  /// Deletes SQL-mirrored audit log records that reference [package]
  /// (best-effort), mirroring the Datastore deletion performed as part of a
  /// package's hard-delete (see `AdminBackend.removePackage`).
  Future<void> deleteSqlRecordsForPackage(String package) async {
    try {
      await primaryDatabase.transactWithRetry((db) async {
        final recordIds = await db.auditLogAssociation
            .where(
              (a) =>
                  a.kind.equalsValue(AuditLogAssociationKind.package) &
                  a.value.equalsValue(package),
            )
            .select((a) => (a.recordId,))
            .fetch();
        for (final id in recordIds.toSet()) {
          await db.auditLogRecords.delete(id).execute();
        }
      });
    } catch (e, st) {
      _log.warning(
        'Failed to delete SQL AuditLogRecords for package "$package".',
        e,
        st,
      );
    }
  }

  @visibleForTesting
  String nextTimestamp(DateTime last, DateTime next) {
    final nextDayStart = DateTime.utc(
      next.year,
      next.month,
      next.day,
    ).add(Duration(days: 1));
    return nextDayStart.isBefore(last) && nextDayStart.isAfter(next)
        ? nextDayStart.toIso8601String().split('T').first
        : next.toIso8601String();
  }

  /// Parses the `before` query parameter and returns the parsed timestamp.
  ///
  /// Returns a timestamp slightly into the future if the parameter is missing.
  /// Throws [InvalidInputException] if the query parameter is invalid.
  DateTime parseBeforeQueryParameter(String? param) {
    final now = clock.now().toUtc();
    if (param == null) {
      return now.add(const Duration(minutes: 5));
    }
    if (param.length == 10) {
      final m = _shortBeforeFormat.matchAsPrefix(param);
      if (m != null) {
        final parsed = DateTime.utc(
          int.parse(m.group(1)!),
          int.parse(m.group(2)!),
          int.parse(m.group(3)!),
        );
        InvalidInputException.check(
          parsed.year >= 2000,
          '`before` is too far in the past.',
        );
        InvalidInputException.check(
          parsed.isBefore(now),
          '`before` is in the future.',
        );
        return parsed;
      }
    }
    final parsed = DateTime.tryParse(param)?.toUtc();
    InvalidInputException.check(parsed != null, 'Unable to parse `before`.');
    return parsed!;
  }

  /// Returns the entries from the last day.
  ///
  /// Keeps the [_cachedRecords] fields updated, and lists only the entries
  /// up to the last query.
  ///
  /// NOTE: there is no guarantee that the entries are in creation order
  Future<List<AuditLogRecord>> getEntriesFromLastDay() async {
    if (_cacheRecordsUpdateFuture != null) {
      await _cacheRecordsUpdateFuture;
    } else {
      final now = clock.now().toUtc();
      final cachedAge = now.difference(_cachedRecords.updated);
      if (cachedAge.inSeconds < 3) {
        return _cachedRecords.records;
      }

      // we should have only one update running
      _cacheRecordsUpdateFuture = _updateEntriesFromLastDay(
        cachedAge: cachedAge,
        oldRecords: _cachedRecords.records,
      );
      await _cacheRecordsUpdateFuture;
      _cacheRecordsUpdateFuture = null;
    }
    return _cachedRecords.records;
  }

  Future<void> _updateEntriesFromLastDay({
    required Duration cachedAge,
    required Iterable<AuditLogRecord> oldRecords,
  }) async {
    // calculate window to query
    final now = clock.now();
    final day = const Duration(days: 1);
    var window = cachedAge > day ? day : (day - cachedAge);
    if (window < Duration(minutes: 2)) {
      window = Duration(minutes: 2);
    }

    final query = _db.query<AuditLogRecord>()
      ..filter('created >', now.subtract(window));
    final current = await query.run().toList();

    // merge records from cache and current query
    final currentIds = current.map((e) => e.id!).toSet();
    final records = [
      ...oldRecords
          .where((r) => !currentIds.contains(r.id!))
          .where((r) => now.difference(r.created!) < day),
      ...current,
    ];

    _cachedRecords = _CachedRecords(now, records);
  }
}

class _CachedRecords {
  final DateTime updated;
  final List<AuditLogRecord> records;

  _CachedRecords(this.updated, this.records);
}
