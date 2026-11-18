// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:typed_sql/typed_sql.dart';

/// The full content of an audit log record, as stored in SQL.
class AuditLogRecordDetails {
  final DateTime created;
  final DateTime expires;
  final String kind;
  final String agent;
  final String summary;
  final Map<String, dynamic>? data;
  final List<String> users;
  final List<String> packages;
  final List<String> packageVersions;
  final List<String> publishers;

  AuditLogRecordDetails({
    required this.created,
    required this.expires,
    required this.kind,
    required this.agent,
    required this.summary,
    required this.data,
    required this.users,
    required this.packages,
    required this.packageVersions,
    required this.publishers,
  });
}

/// Looks up the full content of the audit log record for [recordId] from SQL.
Future<AuditLogRecordDetails> lookupAuditRecordById(String recordId) async {
  return await primaryDatabase.transactWithRetry((db) async {
    final row = await db.auditLogRecords.byKey(recordId).fetch();
    if (row == null) {
      throw NotFoundException.resource(recordId);
    }
    final assocs = await db.auditLogAssociations
        .where((a) => a.recordId.equalsValue(recordId))
        .select((a) => (a.kind, a.value))
        .fetch();
    List<String> valuesOf(String kind) => ([
      for (final a in assocs)
        if (a.$1 == kind) a.$2,
    ]..sort());
    return AuditLogRecordDetails(
      created: row.createdAt,
      expires: row.expiresAt,
      kind: row.kind,
      agent: row.agent,
      summary: row.summary,
      data: row.dataJson == null
          ? null
          : (row.dataJson!.value as Map).cast<String, dynamic>(),
      users: valuesOf(AuditLogAssociationKind.user),
      packages: valuesOf(AuditLogAssociationKind.package),
      packageVersions: valuesOf(AuditLogAssociationKind.packageVersion),
      publishers: valuesOf(AuditLogAssociationKind.publisher),
    );
  });
}
