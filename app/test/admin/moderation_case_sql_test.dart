// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/account_api.dart';
import 'package:_pub_shared/data/admin_api.dart';
import 'package:pub_dev/admin/backend.dart';
import 'package:pub_dev/admin/models.dart';
import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:test/test.dart';
import 'package:typed_sql/typed_sql.dart';

import '../database/moderation_sql_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('moderation case SQL mirror', () {
    testWithProfile(
      'report, moderate, resolve and delete are mirrored',
      expectedLogMessages: [
        RegExp(
          r'SHOUT Deleting object from public bucket: ".*/api/archives/oxygen-.*.tar.gz".',
        ),
      ],
      fn: () async {
        await withRetryPubApiClient((client) async {
          await client.postReport(
            ReportForm(
              email: 'user@pub.dev',
              subject: 'package:oxygen',
              message: 'Huston, we have a problem.',
            ),
          );
        });
        await expectModerationCasesInSqlMatchDatastore();
        final mc = (await dbService.query<ModerationCase>().run().single);

        final api = createPubApiClient(authToken: siteAdminToken);
        for (final state in ['true', 'false', 'true']) {
          await api.adminInvokeAction(
            'moderate-package',
            AdminInvokeActionArguments(
              arguments: {
                'case': mc.caseId,
                'package': 'oxygen',
                'state': state,
                'note': 'state $state',
              },
            ),
          );
        }
        await expectModerationCasesInSqlMatchDatastore();
        final logs = await primaryDatabase.withRetry(
          (db) => db.moderationActionLogs.fetch(),
        );
        expect(logs.map((l) => l.action).toSet(), {'apply', 'revert'});
        expect(logs, hasLength(3));

        await api.adminInvokeAction(
          'moderation-case-resolve',
          AdminInvokeActionArguments(
            arguments: {
              'case': mc.caseId,
              'grounds': 'policy',
              'violation': 'scope_of_platform_service',
              'reason': 'This is a long enough reason.',
            },
          ),
        );
        await expectModerationCasesInSqlMatchDatastore();

        await api.adminInvokeAction(
          'moderation-case-delete',
          AdminInvokeActionArguments(arguments: {'case': mc.caseId}),
        );
        await expectModerationCasesInSqlMatchDatastore();
        expect(
          await primaryDatabase.withRetry(
            (db) => db.moderationActionLogs.fetch(),
          ),
          isEmpty,
        );
      },
    );

    testWithProfile(
      'backfill syncs missing, stale and orphaned rows',
      fn: () async {
        final api = createPubApiClient(authToken: siteAdminToken);
        final rs = await api.adminInvokeAction(
          'moderation-case-create',
          AdminInvokeActionArguments(arguments: {'subject': 'package:oxygen'}),
        );
        final caseId = rs.output['caseId'] as String;
        expect(await adminBackend.backfillModerationCasesSqlFromDatastore(), 0);

        await adminBackend.deleteModerationCaseFromSql(caseId);
        expect(await adminBackend.backfillModerationCasesSqlFromDatastore(), 1);
        await expectModerationCasesInSqlMatchDatastore();

        // stale row
        await primaryDatabase.withRetry(
          (db) => db.moderationCases
              .where((c) => c.caseId.equalsValue(caseId))
              .update((c, set) => set(subject: toExpr('package:other')))
              .execute(),
        );
        expect(await adminBackend.backfillModerationCasesSqlFromDatastore(), 1);
        await expectModerationCasesInSqlMatchDatastore();

        // row without an entity
        await withRetryTransaction(dbService, (tx) async {
          tx.delete(dbService.emptyKey.append(ModerationCase, id: caseId));
        });
        expect(await adminBackend.backfillModerationCasesSqlFromDatastore(), 1);
        expect(await adminBackend.backfillModerationCasesSqlFromDatastore(), 0);
        await expectModerationCasesInSqlMatchDatastore();
      },
    );
  });
}
