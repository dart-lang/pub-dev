// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/admin/models.dart';
import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:test/test.dart';
import 'package:typed_sql/typed_sql.dart';

/// Expects that the SQL moderation cases and their action logs match the
/// [ModerationCase] entities.
Future<void> expectModerationCasesInSqlMatchDatastore() async {
  final expectedCases = <String, Map<String, Object?>>{};
  final expectedLogs = <String, List<Map<String, Object?>>>{};
  await for (final mc in dbService.query<ModerationCase>().run()) {
    expectedCases[mc.caseId] = {
      'reporterEmail': mc.reporterEmail,
      'openedAt': mc.opened.microsecondsSinceEpoch,
      'resolvedAt': mc.resolved?.microsecondsSinceEpoch,
      'source': mc.source,
      'kind': mc.kind,
      'subject': mc.subject,
      'url': mc.url,
      'appealedCaseId': mc.appealedCaseId,
      'isSubjectOwner': mc.isSubjectOwner,
      'status': mc.status,
      'grounds': mc.grounds,
      'violation': mc.violation,
      'reason': mc.reason,
    };
    expectedLogs[mc.caseId] = [
      for (final e in mc.getActionLog().entries)
        {
          'createdAt': e.timestamp.microsecondsSinceEpoch,
          'subject': e.subject,
          'action': e.moderationAction.name,
          'note': e.note,
        },
    ];
  }

  final rows = await primaryDatabase.withRetry(
    (db) => db.moderationCases.fetch(),
  );
  expect({
    for (final r in rows)
      r.caseId: {
        'reporterEmail': r.reporterEmail,
        'openedAt': r.openedAt.microsecondsSinceEpoch,
        'resolvedAt': r.resolvedAt?.microsecondsSinceEpoch,
        'source': r.source,
        'kind': r.kind,
        'subject': r.subject,
        'url': r.url,
        'appealedCaseId': r.appealedCaseId,
        'isSubjectOwner': r.isSubjectOwner,
        'status': r.status,
        'grounds': r.grounds,
        'violation': r.violation,
        'reason': r.reason,
      },
  }, expectedCases);

  final logs = await primaryDatabase.withRetry(
    (db) => db.moderationActionLogs
        .orderBy(
          (l) => [(l.caseId, Order.ascending), (l.logId, Order.ascending)],
        )
        .fetch(),
  );
  final actualLogs = <String, List<Map<String, Object?>>>{
    for (final caseId in expectedCases.keys) caseId: [],
  };
  for (final l in logs) {
    actualLogs[l.caseId]!.add({
      'createdAt': l.createdAt.microsecondsSinceEpoch,
      'subject': l.subject,
      'action': l.action,
      'note': l.note,
    });
  }
  expect(actualLogs, expectedLogs);
}
