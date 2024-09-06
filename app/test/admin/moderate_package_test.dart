// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:typed_data';

import 'package:_pub_shared/data/account_api.dart';
import 'package:_pub_shared/data/admin_api.dart';
import 'package:_pub_shared/data/package_api.dart';
import 'package:clock/clock.dart';
import 'package:http/http.dart' as http;
import 'package:pub_dev/admin/actions/actions.dart';
import 'package:pub_dev/admin/models.dart';
import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/fake/backend/fake_pub_worker.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/scorecard/backend.dart';
import 'package:pub_dev/search/backend.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/tool/maintenance/update_public_bucket.dart';
import 'package:test/test.dart';

import '../admin/models_test.dart';
import '../frontend/handlers/_utils.dart';
import '../package/backend_test_utils.dart';
import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('Moderate package', () {
    Future<ModerationCase> _report(String package) async {
      await withHttpPubApiClient(
        fn: (client) async {
          await client.postReport(ReportForm(
            email: 'user@pub.dev',
            subject: 'package:$package',
            message: 'Huston, we have a problem.',
          ));
        },
      );
      final list = await dbService.query<ModerationCase>().run().toList();
      return list.reduce((a, b) => a.opened.isAfter(b.opened) ? a : b);
    }

    Future<AdminInvokeActionResponse> _moderate(
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

    testWithProfile('update state', fn: () async {
      final mc = await _report('neon');

      await expectModerationActions(mc.caseId, actions: []);
      final r1 = await _moderate('oxygen', caseId: mc.caseId);
      expect(r1.output, {
        'package': 'oxygen',
        'before': {'isModerated': false, 'moderatedAt': null},
      });
      await expectModerationActions(mc.caseId, actions: []);

      final r2 = await _moderate('oxygen', state: true, caseId: mc.caseId);
      expect(r2.output, {
        'package': 'oxygen',
        'before': {'isModerated': false, 'moderatedAt': null},
        'after': {'isModerated': true, 'moderatedAt': isNotEmpty},
      });
      final p2 = await packageBackend.lookupPackage('oxygen');
      expect(p2!.isModerated, isTrue);
      await expectModerationActions(mc.caseId,
          actions: [ModerationAction.apply]);

      final pubspecContent = generatePubspecYaml('oxygen', '3.0.0');
      final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);
      await expectApiException(
        createPubApiClient(authToken: adminClientToken)
            .uploadPackageBytes(bytes),
        code: 'PackageRejected',
        status: 400,
        message: 'Package has been blocked.',
      );

      await expectApiException(
        (await createFakeAuthPubApiClient(email: adminAtPubDevEmail))
            .setPackageOptions('oxygen', PkgOptions(isUnlisted: true)),
        code: 'InsufficientPermissions',
        status: 403,
        message:
            'Insufficient permissions to perform administrative actions on package `oxygen`.',
      );
    });

    testWithProfile('clear moderation flag', fn: () async {
      final mc = await _report('oxygen');
      await expectModerationActions(mc.caseId, actions: []);
      final r1 = await _moderate('oxygen', caseId: mc.caseId);
      expect(r1.output, {
        'package': 'oxygen',
        'before': {'isModerated': false, 'moderatedAt': null},
      });
      await expectModerationActions(mc.caseId, actions: []);

      final r2 = await _moderate('oxygen', state: true, caseId: mc.caseId);
      expect(r2.output, {
        'package': 'oxygen',
        'before': {'isModerated': false, 'moderatedAt': null},
        'after': {'isModerated': true, 'moderatedAt': isNotEmpty},
      });
      final p2 = await packageBackend.lookupPackage('oxygen');
      expect(p2!.isModerated, isTrue);
      await expectModerationActions(mc.caseId,
          actions: [ModerationAction.apply]);

      // clear flag
      final r3 = await _moderate('oxygen', state: false, caseId: mc.caseId);
      expect(r3.output, {
        'package': 'oxygen',
        'before': {'isModerated': true, 'moderatedAt': isNotEmpty},
        'after': {'isModerated': false, 'moderatedAt': null},
      });
      final p3 = await packageBackend.lookupPackage('oxygen');
      expect(p3!.isModerated, isFalse);
      await expectModerationActions(mc.caseId,
          actions: [ModerationAction.apply, ModerationAction.revert]);

      final pubspecContent = generatePubspecYaml('oxygen', '3.0.0');
      final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);
      final message = await createPubApiClient(authToken: adminClientToken)
          .uploadPackageBytes(bytes);
      expect(message.success.message, contains('Successfully uploaded'));

      final optionsUpdates =
          await (await createFakeAuthPubApiClient(email: adminAtPubDevEmail))
              .setPackageOptions('oxygen', PkgOptions(isUnlisted: true));
      expect(optionsUpdates.isUnlisted, true);

      final api = createPubApiClient(authToken: siteAdminToken);
      final info = await api.adminInvokeAction(
        'moderation-case-info',
        AdminInvokeActionArguments(arguments: {
          'case': mc.caseId,
        }),
      );
      expect(info.toJson(), {
        'output': {
          'caseId': isNotEmpty,
          'reporterEmail': 'user@pub.dev',
          'kind': 'notification',
          'opened': isNotEmpty,
          'resolved': null,
          'source': 'external-notification',
          'subject': 'package:oxygen',
          'isSubjectOwner': false,
          'url': null,
          'status': 'pending',
          'grounds': null,
          'violation': null,
          'reason': null,
          'appealedCaseId': null,
          'actionLog': {
            'entries': [
              {
                'timestamp': isNotEmpty,
                'subject': 'package:oxygen',
                'moderationAction': 'apply'
              },
              {
                'timestamp': isNotEmpty,
                'subject': 'package:oxygen',
                'moderationAction': 'revert'
              }
            ]
          }
        }
      });
    });

    testWithProfile('API endpoints return not found', fn: () async {
      final jsonUrls = [
        '/api/packages/oxygen',
        '/api/packages/oxygen/versions/1.0.0',
      ];
      Future<void> expectAvailable() async {
        for (final url in jsonUrls) {
          await expectJsonMapResponse(await issueGet(url));
        }
      }

      await expectAvailable();

      final mc = await _report('oxygen');
      await _moderate('oxygen', state: true, caseId: mc.caseId);
      for (final url in jsonUrls) {
        await expectJsonMapResponse(await issueGet(url), status: 404);
      }

      await _moderate('oxygen', state: false, caseId: mc.caseId);
      await expectAvailable();
      await expectModerationActions(mc.caseId,
          actions: [ModerationAction.apply, ModerationAction.revert]);
    });

    testWithProfile('public pages are displaying moderation notice',
        fn: () async {
      final htmlUrls = [
        '/packages/oxygen',
        '/packages/oxygen/changelog',
        '/packages/oxygen/install',
        '/packages/oxygen/score',
        '/packages/oxygen/versions',
        '/packages/oxygen/versions/1.0.0',
        '/packages/oxygen/versions/1.0.0/changelog',
        '/packages/oxygen/versions/1.0.0/install',
        '/packages/oxygen/versions/1.0.0/score',
      ];
      Future<void> expectAvailable() async {
        for (final url in htmlUrls) {
          await expectHtmlResponse(
            await issueGet(url),
            absent: ['moderated'],
            present: ['/packages/oxygen'],
          );
        }
      }

      await expectAvailable();

      final mc = await _report('oxygen');
      await _moderate('oxygen', state: true, caseId: mc.caseId);
      for (final url in htmlUrls) {
        await expectHtmlResponse(
          await issueGet(url),
          status: 404,
          absent: ['/packages/oxygen'],
          present: ['moderated'],
        );
      }

      await _moderate('oxygen', state: false, caseId: mc.caseId);
      await expectAvailable();
      await expectModerationActions(mc.caseId,
          actions: [ModerationAction.apply, ModerationAction.revert]);
    });

    testWithProfile('not included in search', fn: () async {
      await searchBackend.doCreateAndUpdateSnapshot(
        FakeGlobalLockClaim(clock.now().add(Duration(seconds: 3))),
        concurrency: 2,
        sleepDuration: Duration(milliseconds: 300),
      );
      final docs = await searchBackend.fetchSnapshotDocuments();
      expect(docs!.where((d) => d.package == 'oxygen'), isNotEmpty);

      final mc = await _report('oxygen');
      await _moderate('oxygen', state: true, caseId: mc.caseId);

      final minimumIndex =
          await searchBackend.loadMinimumPackageIndex().toList();
      expect(minimumIndex.where((e) => e.package == 'oxygen'), isEmpty);

      await searchBackend.doCreateAndUpdateSnapshot(
        FakeGlobalLockClaim(clock.now().add(Duration(seconds: 3))),
        concurrency: 2,
        sleepDuration: Duration(milliseconds: 300),
      );
      final docs2 = await searchBackend.fetchSnapshotDocuments();
      expect(docs2!.where((d) => d.package == 'oxygen'), isEmpty);

      await _moderate('oxygen', state: false, caseId: mc.caseId);

      final minimumIndex2 =
          await searchBackend.loadMinimumPackageIndex().toList();
      expect(minimumIndex2.where((e) => e.package == 'oxygen'), isNotEmpty);

      await searchBackend.doCreateAndUpdateSnapshot(
        FakeGlobalLockClaim(clock.now().add(Duration(seconds: 3))),
        concurrency: 2,
        sleepDuration: Duration(milliseconds: 300),
      );
      final docs3 = await searchBackend.fetchSnapshotDocuments();
      expect(docs3!.where((d) => d.package == 'oxygen'), isNotEmpty);
    });

    testWithProfile('archives are removed from public bucket', fn: () async {
      final publicUri = Uri.parse('${activeConfiguration.storageBaseUrl}'
          '/${activeConfiguration.publicPackagesBucketName}'
          '/packages/oxygen-1.0.0.tar.gz');

      Future<Uint8List?> expectStatusCode(int statusCode) async {
        final rs1 = await http.get(publicUri);
        expect(rs1.statusCode, statusCode);
        return rs1.bodyBytes;
      }

      final bytes = await expectStatusCode(200);

      final mc = await _report('oxygen');
      await _moderate('oxygen', state: true, caseId: mc.caseId);
      await expectStatusCode(404);

      // another check after background tasks are running
      await updatePublicArchiveBucket();
      await expectStatusCode(404);

      await _moderate('oxygen', state: false, caseId: mc.caseId);
      await expectStatusCode(200);
      // another check after background tasks are running
      await updatePublicArchiveBucket();
      final restoredBytes = await expectStatusCode(200);
      expect(restoredBytes, bytes);
    });

    testWithProfile(
      'analysis results are cleared',
      processJobsWithFakeRunners: true,
      fn: () async {
        final score1 =
            await scoreCardBackend.getScoreCardData('oxygen', '1.2.0');
        expect(score1.grantedPubPoints, greaterThan(40));

        final mc = await _report('oxygen');
        await _moderate('oxygen', state: true, caseId: mc.caseId);
        // score is not accessible
        await expectLater(
          () => scoreCardBackend.getScoreCardData('oxygen', '1.2.0'),
          throwsA(isA<ModeratedException>()),
        );
        // search snapshot does not break
        await searchBackend.doCreateAndUpdateSnapshot(
          FakeGlobalLockClaim(clock.now().add(Duration(seconds: 3))),
          concurrency: 2,
          sleepDuration: Duration(milliseconds: 300),
        );

        // restore state
        await _moderate('oxygen', state: false, caseId: mc.caseId);
        await processTasksWithFakePanaAndDartdoc();

        final score3 =
            await scoreCardBackend.getScoreCardData('oxygen', '1.2.0');
        expect(score3.grantedPubPoints, greaterThan(40));
      },
    );

    testWithProfile('status already closed', fn: () async {
      final mc = await _report('oxygen');
      await dbService.commit(inserts: [
        mc
          ..resolved = clock.now()
          ..status = ModerationStatus.noAction
      ]);

      await expectApiException(
        _moderate('oxygen', state: true, caseId: mc.caseId),
        code: 'InvalidInput',
        status: 400,
        message: 'ModerationCase.status ("no-action") != "pending".',
      );
    });
  });
}
