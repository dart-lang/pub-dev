// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/account_api.dart';
import 'package:_pub_shared/data/admin_api.dart';
import 'package:pub_dev/admin/backend.dart';
import 'package:pub_dev/admin/models.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:test/test.dart';

import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('resolve moderation case', () {
    Future<ModerationCase> _prepare({
      String? appealCaseId,
      required bool? apply,
    }) async {
      await withHttpPubApiClient(
        fn: (client) async {
          await client.postReport(ReportForm(
            email: 'user@pub.dev',
            caseId: appealCaseId,
            subject: 'package:oxygen',
            message: 'Huston, we have a problem.',
          ));
        },
      );
      final list = await dbService.query<ModerationCase>().run().toList();
      final mc = list.reduce((a, b) => a.opened.isAfter(b.opened) ? a : b);

      if (apply != null) {
        final api = createPubApiClient(authToken: siteAdminToken);
        await api.adminInvokeAction(
          'moderate-package',
          AdminInvokeActionArguments(arguments: {
            'case': mc.caseId,
            'package': 'oxygen',
            'state': apply.toString(),
          }),
        );
      }

      return (await adminBackend.lookupModerationCase(mc.caseId))!;
    }

    Future<String> _close(
      String caseId, {
      String? grounds,
      String? violation,
      String? reason,
    }) async {
      // infer grounds and violation for test purposes
      if (reason != null) {
        grounds ??= ModerationGrounds.policy;
        violation ??= 'scope_of_platform_service';
      }
      final api = createPubApiClient(authToken: siteAdminToken);
      await api.adminInvokeAction(
        'moderation-case-resolve',
        AdminInvokeActionArguments(arguments: {
          'case': caseId,
          if (grounds != null) 'grounds': grounds,
          if (violation != null) 'violation': violation,
          if (reason != null) 'reason': reason,
        }),
      );
      final mc = await adminBackend.lookupModerationCase(caseId);
      return mc!.status!;
    }

    testWithProfile('notification: no action', fn: () async {
      final mc = await _prepare(apply: null);
      expect(await _close(mc.caseId), 'no-action');
    });

    testWithProfile('notification: apply moderation', fn: () async {
      final mc = await _prepare(apply: true);
      expect(
        await _close(
          mc.caseId,
          reason: 'The package violated our policy.',
        ),
        'moderation-applied',
      );
    });

    testWithProfile('appeal no action: revert', fn: () async {
      final mc1 = await _prepare(apply: null);
      await _close(mc1.caseId);

      final mc = await _prepare(apply: true, appealCaseId: mc1.caseId);
      expect(
          await _close(
            mc.caseId,
            reason: 'The package violated our policy.',
          ),
          'no-action-reverted');
    });

    testWithProfile('appeal no action: upheld', fn: () async {
      final mc1 = await _prepare(apply: null);
      await _close(mc1.caseId);

      final mc = await _prepare(apply: null, appealCaseId: mc1.caseId);
      expect(await _close(mc.caseId), 'no-action-upheld');
    });

    testWithProfile('appeal moderation: revert', fn: () async {
      final mc1 = await _prepare(apply: true);
      await _close(
        mc1.caseId,
        reason: 'The package violated our policy.',
      );

      final mc = await _prepare(apply: true, appealCaseId: mc1.caseId);
      expect(await _close(mc.caseId), 'moderation-reverted');
    });

    testWithProfile('appeal moderation: upheld', fn: () async {
      final mc1 = await _prepare(apply: true);
      await _close(
        mc1.caseId,
        reason: 'The package violated our policy.',
      );

      final mc = await _prepare(apply: null, appealCaseId: mc1.caseId);
      expect(
        await _close(mc.caseId),
        'moderation-upheld',
      );
    });
  });
}
