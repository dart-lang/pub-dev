// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/account_api.dart' as account_api;
import 'package:_pub_shared/data/admin_api.dart';
import 'package:clock/clock.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/admin/backend.dart';
import 'package:pub_dev/admin/models.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:test/test.dart';

import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('moderation transparency metrics', () {
    Future<ModerationCase> _report(
      String package, {
      String? email,
      String? caseId,
    }) async {
      await withHttpPubApiClient(
        fn: (client) async {
          await client.postReport(account_api.ReportForm(
            email: email ?? 'user@pub.dev',
            subject: 'package:$package',
            caseId: caseId,
            message: 'Huston, we have a problem.',
          ));
        },
      );
      final list = await dbService.query<ModerationCase>().run().toList();
      return list.reduce((a, b) => a.opened.isAfter(b.opened) ? a : b);
    }

    Future<AdminInvokeActionResponse> _moderatePkg(
      String package, {
      required String caseId,
      bool? state,
    }) async {
      final api = createPubApiClient(authToken: siteAdminToken);
      return await api.adminInvokeAction(
        'moderate-package',
        AdminInvokeActionArguments(arguments: {
          'case': caseId,
          'package': package,
          if (state != null) 'state': state.toString(),
        }),
      );
    }

    Future<AdminInvokeActionResponse> _moderateUser(
      String email, {
      required String caseId,
      bool? state,
      String? reason,
    }) async {
      final api = createPubApiClient(authToken: siteAdminToken);
      return await api.adminInvokeAction(
        'moderate-user',
        AdminInvokeActionArguments(arguments: {
          'case': caseId,
          'user': email,
          if (reason != null) 'reason': reason,
          if (state != null) 'state': state.toString(),
        }),
      );
    }

    Future<String> _resolve(
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

    testWithProfile('nothing to report', fn: () async {
      final api = createPubApiClient(authToken: siteAdminToken);
      final rs = await api.adminInvokeAction(
        'moderation-transparency-metrics',
        AdminInvokeActionArguments(arguments: {
          'start': '2000-01-01',
          'end': '2000-01-01',
        }),
      );
      expect(rs.output, {
        'text': isNotEmpty,
        'moderations': {
          'total': 0,
          'violations': {},
          'sources': {},
          'restrictions': {},
        },
        'appeals': {
          'total': 0,
          'contentOwner': 0,
          'outcomes': {},
          'medianTimeToActionDays': 0,
        },
        'users': {
          'suspensions': {},
        },
      });
      final text = rs.output['text'] as String;
      expect(text, contains('Total number of actions taken,0\r\n'));
    });

    testWithProfile('moderated package', expectedLogMessages: [
      'SHOUT Deleting object from public bucket: "packages/oxygen-1.0.0.tar.gz".',
      'SHOUT Deleting object from public bucket: "packages/oxygen-1.2.0.tar.gz".',
      'SHOUT Deleting object from public bucket: "packages/oxygen-2.0.0-dev.tar.gz".',
    ], fn: () async {
      final mc = await _report('oxygen');
      await _moderatePkg('oxygen', caseId: mc.caseId, state: true);
      await _resolve(
        mc.caseId,
        grounds: ModerationGrounds.policy,
        violation: ModerationViolation.scamsAndFraud,
        reason: 'package contains scam',
      );

      final api = createPubApiClient(authToken: siteAdminToken);
      final rs = await api.adminInvokeAction(
        'moderation-transparency-metrics',
        AdminInvokeActionArguments(arguments: {
          'start': clock.daysAgo(30).toIso8601String().split('T').first,
          'end': clock.now().toIso8601String().split('T').first,
        }),
      );
      expect(rs.output, {
        'text': isNotEmpty,
        'moderations': {
          'total': 1,
          'violations': {'scams_and_fraud': 1},
          'sources': {'external-notification': 1},
          'restrictions': {'visibility': 1}
        },
        'appeals': {
          'total': 0,
          'contentOwner': 0,
          'outcomes': {},
          'medianTimeToActionDays': 0
        },
        'users': {
          'suspensions': {},
        },
      });
      final text = rs.output['text'] as String;
      expect(text, contains('Total number of actions taken,1\r\n'));
      expect(
          text, contains('VIOLATION_CATEGORY_SCOPE_OF_PLATFORM_SERVICE,0\r\n'));
      expect(text, contains('VIOLATION_CATEGORY_SCAMS_AND_FRAUD,1\r\n'));
    });

    testWithProfile('moderated user', fn: () async {
      final mc = await _report('oxygen');
      await _moderateUser(
        'user@pub.dev',
        caseId: mc.caseId,
        state: true,
        reason: UserModeratedReason.illegalContent,
      );
      await _resolve(
        mc.caseId,
        grounds: ModerationGrounds.illegal,
        violation: ModerationViolation.unsafeAndIllegalProducts,
        reason: 'controlled substances',
      );

      final api = createPubApiClient(authToken: siteAdminToken);
      final rs = await api.adminInvokeAction(
        'moderation-transparency-metrics',
        AdminInvokeActionArguments(arguments: {
          'start': clock.daysAgo(30).toIso8601String().split('T').first,
          'end': clock.now().toIso8601String().split('T').first,
        }),
      );
      expect(rs.output, {
        'text': isNotEmpty,
        'moderations': {
          'total': 1,
          'violations': {'unsafe_and_illegal_products': 1},
          'sources': {'external-notification': 1},
          'restrictions': {'provision': 1}
        },
        'appeals': {
          'total': 0,
          'contentOwner': 0,
          'outcomes': {},
          'medianTimeToActionDays': 0
        },
        'users': {
          'suspensions': {'illegal-content': 1},
        },
      });
      final text = rs.output['text'] as String;
      expect(
          text,
          allOf([
            contains('Total number of actions taken,1\r\n'),
            contains('Automated detection,0\r\n'),
            contains('Non-automated detection,1\r\n'),
            contains('VIOLATION_CATEGORY_UNSAFE_AND_ILLEGAL_PRODUCTS,1\r\n'),
            contains('VIOLATION_CATEGORY_SCOPE_OF_PLATFORM_SERVICE,0\r\n'),
            contains('Restrictions of Provision of the Service,1\r\n'),
          ]));
    });

    testWithProfile('appeal', expectedLogMessages: [
      'SHOUT Deleting object from public bucket: "packages/oxygen-1.0.0.tar.gz".',
      'SHOUT Deleting object from public bucket: "packages/oxygen-1.2.0.tar.gz".',
      'SHOUT Deleting object from public bucket: "packages/oxygen-2.0.0-dev.tar.gz".',
    ], fn: () async {
      final mc = await _report('oxygen');
      await _moderatePkg('oxygen', caseId: mc.caseId, state: true);
      await _resolve(
        mc.caseId,
        grounds: ModerationGrounds.policy,
        violation: ModerationViolation.animalWelfare,
        reason: 'abused pet photos',
      );

      final appeal = await _report(
        'oxygen',
        caseId: mc.caseId,
        email: 'admin@pub.dev',
      );
      await _moderatePkg('oxygen', caseId: appeal.caseId, state: false);
      await _resolve(appeal.caseId);

      final api = createPubApiClient(authToken: siteAdminToken);
      final rs = await api.adminInvokeAction(
        'moderation-transparency-metrics',
        AdminInvokeActionArguments(arguments: {
          'start': clock.daysAgo(30).toIso8601String().split('T').first,
          'end': clock.now().toIso8601String().split('T').first,
        }),
      );
      expect(rs.output, {
        'text': isNotEmpty,
        'moderations': {
          'total': 1,
          'violations': {'animal_welfare': 1},
          'sources': {'external-notification': 1},
          'restrictions': {'visibility': 1}
        },
        'appeals': {
          'total': 1,
          'contentOwner': 0,
          'outcomes': {'reverted': 1},
          'medianTimeToActionDays': 1,
        },
        'users': {
          'suspensions': {},
        },
      });
      final text = rs.output['text'] as String;
      expect(
          text,
          allOf([
            contains('Total number of actions taken,1\r\n'),
            contains('REPORTER_APPEAL,1\r\n'),
            contains('Initial decision reversed,1\r\n'),
            contains('Median time to action a complaint (days),1\r\n'),
          ]));
    });
  });
}
