// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:meta/meta.dart';
import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:typed_sql/typed_sql.dart';

import '../shared/datastore.dart';
import '../shared/exceptions.dart';

import 'models.dart';

/// The maximum number of entities to be loaded from Datastore in one batch.
const _maxAuditLogBatchSize = 1000;

/// The minimum age a Datastore [AuditLogRecord] entity must have before
/// [AuditBackend.migrateFromDatastore] will pick it up for SQL migration.
const _minBatchMigrationAge = Duration(minutes: 1);

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

  Future<AuditLogRecordPage> _querySql(
    String associationKind,
    String value,
    DateTime? before,
  ) async {
    final cursor = before ?? clock.now().toUtc().add(Duration(minutes: 5));
    // TODO: consider using repeated queries to filter already expired records,
    //       while also making sure that at least one record is on this and on
    //       the next page.
    final rows = await primaryDatabase.withRetry(
      (db) => db.auditLogAssociations
          .where(
            (a) =>
                a.kind.equalsValue(associationKind) &
                a.value.equalsValue(value) &
                (a.recordCreatedAt <= cursor.asExpr),
          )
          .orderBy((a) => [(a.recordCreatedAt, Order.descending)])
          .select((a) => (a.record,))
          .limit(_maxAuditLogBatchSize)
          .fetch(),
    );
    final records = rows.nonNulls
        .map(
          (row) => AuditLogRecordView(
            recordId: row.id,
            createdAt: row.createdAt,
            expiresAt: row.expiresAt,
            summary: row.summary,
          ),
        )
        .toList();
    if (records.length == _maxAuditLogBatchSize) {
      final nextDisplayed = records.last.createdAt;
      final remainingRecords = records.take(_maxAuditLogBatchSize - 1).toList();
      final lastDisplayed = remainingRecords.last.createdAt;
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
    return await _querySql(AuditLogAssociationKind.user, userId, before);
  }

  /// Lists audit log records for [package] in reverse chronological order.
  Future<AuditLogRecordPage> listRecordsForPackage(
    String package, {
    DateTime? before,
  }) async {
    return await _querySql(AuditLogAssociationKind.package, package, before);
  }

  /// Lists audit log records for [package] and [version] in reverse
  /// chronological order.
  Future<AuditLogRecordPage> listRecordsForPackageVersion(
    String package,
    String version, {
    DateTime? before,
  }) async {
    return await _querySql(
      AuditLogAssociationKind.packageVersion,
      '$package/$version',
      before,
    );
  }

  /// Lists audit log records for [publisherId] in reverse chronological order.
  Future<AuditLogRecordPage> listRecordsForPublisher(
    String publisherId, {
    DateTime? before,
  }) async {
    return await _querySql(
      AuditLogAssociationKind.publisher,
      publisherId,
      before,
    );
  }

  Map<String, dynamic>? _dataOf(JsonValue? value) =>
      value == null ? null : (value.value as Map).cast<String, dynamic>();

  /// Replaces [fromUserId] with [toUserId] as agent, user association and
  /// data value in the audit log records stored in SQL.
  Future<void> replaceUserIdInSqlRecords(
    String fromUserId,
    String toUserId,
  ) async {
    final agentIds = await primaryDatabase.withRetry(
      (db) => db.auditLogRecords
          .where((r) => r.agent.equalsValue(fromUserId))
          .select((r) => (r.id,))
          .fetch(),
    );
    final userIds = await primaryDatabase.withRetry(
      (db) => db.auditLogAssociations
          .where(
            (a) =>
                a.kind.equalsValue(AuditLogAssociationKind.user) &
                a.value.equalsValue(fromUserId),
          )
          .select((a) => (a.recordId,))
          .fetch(),
    );
    for (final id in {...agentIds, ...userIds}) {
      await primaryDatabase.transactWithRetry((db) async {
        final row = await db.auditLogRecords.byKey(id).fetch();
        if (row == null) return; // deleted in the meantime
        final data = _dataOf(row.dataJson)?.map(
          (key, value) => MapEntry<String, dynamic>(
            key,
            value == fromUserId ? toUserId : value,
          ),
        );
        if (row.agent == fromUserId) {
          await db.auditLogRecords
              .byKey(id)
              .update((_, set) => set(agent: toUserId.asExpr))
              .execute();
        }
        if (data != null) {
          await db.auditLogRecords
              .byKey(id)
              .update((_, set) => set(dataJson: JsonValue(data).asExpr))
              .execute();
        }
        final hadUser = await db.auditLogAssociations
            .where(
              (a) =>
                  a.recordId.equalsValue(id) &
                  a.kind.equalsValue(AuditLogAssociationKind.user) &
                  a.value.equalsValue(fromUserId),
            )
            .delete()
            .returnDeleted()
            .executeAndFetch();
        if (hadUser.isNotEmpty) {
          await db.auditLogAssociations
              .insertValuesMapped(
                [toUserId],
                recordId: (_) => id,
                recordCreatedAt: (_) => row.createdAt,
                kind: (_) => AuditLogAssociationKind.user,
                value: (u) => u,
              )
              .onConflict(.primaryKey)
              .doNothing()
              .execute();
        }
      });
    }
  }

  /// Deletes expired log records.
  Future<void> deleteExpiredRecords() async {
    await _db.deleteWithQuery<AuditLogRecord>(
      _db.query<AuditLogRecord>()..filter('expires <', clock.now().toUtc()),
      where: (r) => r.isExpired,
    );
    await deleteExpiredSqlRecords();
  }

  /// Migrates [record] into SQL, and deletes the Datastore entity.
  ///
  /// This should be called right after [record] has been (or would have been)
  /// written to Datastore, so that SQL becomes the sole store for it.
  ///
  /// If this fails, the Datastore entity is left behind and will be picked up
  /// by [migrateFromDatastore].
  Future<void> migrateToSql(AuditLogRecord record) async {
    await primaryDatabase.transactWithRetry(
      (db) => _upsertSqlRecord(db, record),
    );
    await withRetryTransaction(_db, (tx) async => tx.delete(record.key));
  }

  Future<void> _upsertSqlRecord(
    Database<PrimarySchema> db,
    AuditLogRecord record,
  ) async {
    final id = record.id!;
    await db.auditLogRecords
        .upsertValue(
          id: id,
          createdAt: record.created!,
          expiresAt: record.expires!,
          kind: record.kind!,
          agent: record.agent!,
          summary: record.summary!,
          dataJson: record.data == null ? null : JsonValue(record.data),
        )
        .execute();

    await db.auditLogAssociations
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
      await db.auditLogAssociations
          .insertValuesMapped(
            associations,
            recordId: (_) => id,
            recordCreatedAt: (_) => record.created!,
            kind: (a) => a.kind,
            value: (a) => a.value,
          )
          .onConflict(.primaryKey)
          .doNothing()
          .execute();
    }
  }

  /// Migrates [AuditLogRecord] entries found in Datastore into SQL, deleting
  /// each Datastore entity after it has been migrated.
  ///
  /// Only entities created more than [_minBatchMigrationAge] ago are considered,
  /// so that this sweep never races with the eager calls made inline with
  /// Datastore transactions.
  ///
  /// This is a best-effort cleanup of stragglers that were not migrated
  /// eagerly (e.g. because the process died between the Datastore commit and
  /// the SQL write), and is expected to be called periodically.
  Future<int> migrateFromDatastore() async {
    final cutoff = clock.now().toUtc().subtract(_minBatchMigrationAge);
    final query = _db.query<AuditLogRecord>()..filter('created <', cutoff);
    var count = 0;
    await for (final record in query.run()) {
      await migrateToSql(record);
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

  /// Deletes SQL audit log records that reference [package], as part of a package's hard-delete.
  Future<void> deleteSqlRecordsForPackage(String package) async {
    await primaryDatabase.transactWithRetry((db) async {
      final recordIds = await db.auditLogAssociations
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
  Future<List<AuditLogRecordCacheEntry>> getEntriesFromLastDay() async {
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
    required Iterable<AuditLogRecordCacheEntry> oldRecords,
  }) async {
    // calculate window to query
    final now = clock.now();
    final day = const Duration(days: 1);
    var window = cachedAge > day ? day : (day - cachedAge);
    if (window < Duration(minutes: 2)) {
      window = Duration(minutes: 2);
    }

    final cutoff = now.subtract(window).toUtc();
    final rows = await primaryDatabase.withRetry(
      (db) => db.auditLogRecords
          .where((r) => r.createdAt > cutoff.asExpr)
          .select((r) => (r.id, r.createdAt, r.kind, r.agent))
          .fetch(),
    );
    final assocRows = await primaryDatabase.withRetry(
      (db) => db.auditLogAssociations
          .where(
            (a) =>
                (a.kind.equalsValue(AuditLogAssociationKind.user) |
                    a.kind.equalsValue(AuditLogAssociationKind.package)) &
                (a.recordCreatedAt > cutoff.asExpr),
          )
          .select((a) => (a.recordId, a.kind, a.value))
          .fetch(),
    );
    final assocByRecordId = assocRows.groupListsBy((a) => a.$1);
    final current = rows.map((row) {
      final (id, createdAt, kind, agent) = row;
      final assocs = assocByRecordId[id] ?? const <(String, String, String)>[];
      return AuditLogRecordCacheEntry(
        id: id,
        created: createdAt,
        kind: kind,
        agent: agent,
        users: assocs
            .where((a) => a.$2 == AuditLogAssociationKind.user)
            .map((a) => a.$3)
            .toList(),
        packages: assocs
            .where((a) => a.$2 == AuditLogAssociationKind.package)
            .map((a) => a.$3)
            .toList(),
      );
    }).toList();

    // merge records from cache and current query
    final currentIds = current.map((e) => e.id).toSet();
    final records = [
      ...oldRecords
          .where((r) => !currentIds.contains(r.id))
          .where((r) => now.difference(r.created) < day),
      ...current,
    ];

    _cachedRecords = _CachedRecords(now, records);
  }
}

class _CachedRecords {
  final DateTime updated;
  final List<AuditLogRecordCacheEntry> records;

  _CachedRecords(this.updated, this.records);
}
