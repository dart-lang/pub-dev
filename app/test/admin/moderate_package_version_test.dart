// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:typed_data';

import 'package:_pub_shared/data/account_api.dart';
import 'package:_pub_shared/data/admin_api.dart';
import 'package:_pub_shared/data/package_api.dart';
import 'package:clock/clock.dart';
import 'package:http/http.dart' as http;
import 'package:pub_dev/admin/backend.dart';
import 'package:pub_dev/admin/models.dart';
import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/fake/backend/fake_pub_worker.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/scorecard/backend.dart';
import 'package:pub_dev/search/backend.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:pub_dev/task/backend.dart';
import 'package:pub_dev/tool/maintenance/update_public_bucket.dart';
import 'package:test/test.dart';

import '../frontend/handlers/_utils.dart';
import '../package/backend_test_utils.dart';
import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('Moderate package version', () {
    Future<ModerationCase> _report(String package, String version) async {
      await withHttpPubApiClient(
        experimental: {'report'},
        fn: (client) async {
          await client.postReport(ReportForm(
            email: 'user@pub.dev',
            subject: 'package-version:$package/$version',
            message: 'Huston, we have a problem.',
          ));
        },
      );
      final list = await dbService.query<ModerationCase>().run().toList();
      return list.reduce((a, b) => a.opened.isAfter(b.opened) ? a : b);
    }

    Future<AdminInvokeActionResponse> _moderate(
      String package,
      String version, {
      String caseId = 'none',
      bool? state,
    }) async {
      final api = createPubApiClient(authToken: siteAdminToken);
      return await api.adminInvokeAction(
        'moderate-package-version',
        AdminInvokeActionArguments(arguments: {
          'case': caseId,
          'package': package,
          'version': version,
          if (state != null) 'state': state.toString(),
        }),
      );
    }

    testWithProfile('update state', fn: () async {
      final mc = await _report('oxygen', '1.0.0');
      final r1 = await _moderate('oxygen', '1.0.0');
      expect(r1.output, {
        'package': 'oxygen',
        'version': '1.0.0',
        'before': {'isModerated': false, 'moderatedAt': null},
      });

      final r2 =
          await _moderate('oxygen', '1.0.0', caseId: mc.caseId, state: true);
      expect(r2.output, {
        'package': 'oxygen',
        'version': '1.0.0',
        'before': {'isModerated': false, 'moderatedAt': null},
        'after': {'isModerated': true, 'moderatedAt': isNotEmpty},
      });
      final p1 = await packageBackend.lookupPackage('oxygen');
      expect(p1!.isModerated, isFalse);
      final pv2 = await packageBackend.lookupPackageVersion('oxygen', '1.0.0');
      expect(pv2!.isModerated, isTrue);

      // cannot redact this version
      await expectApiException(
        (await createFakeAuthPubApiClient(email: adminAtPubDevEmail))
            .setVersionOptions(
                'oxygen', '1.0.0', VersionOptions(isRetracted: true)),
        code: 'NotFound',
        status: 404,
        message: 'PackageVersion \"oxygen\" \"1.0.0\" has been moderated.',
      );

      // can redact other version
      final optionsUpdates =
          await (await createFakeAuthPubApiClient(email: adminAtPubDevEmail))
              .setVersionOptions(
                  'oxygen', '1.2.0', VersionOptions(isRetracted: true));
      expect(optionsUpdates.isRetracted, true);
      final p2 = await packageBackend.lookupPackage('oxygen');
      expect(p2!.latestVersion, '2.0.0-dev');

      final mc2 = await adminBackend.lookupModerationCase(mc.caseId);
      expect(mc2!.getActionLog().entries, hasLength(1));
    });

    testWithProfile('clear moderation flag', fn: () async {
      final r1 = await _moderate('oxygen', '1.0.0', state: true);
      expect(r1.output, {
        'package': 'oxygen',
        'version': '1.0.0',
        'before': {'isModerated': false, 'moderatedAt': null},
        'after': {'isModerated': true, 'moderatedAt': isNotEmpty},
      });
      final p1 = await packageBackend.lookupPackage('oxygen');
      expect(p1!.isModerated, isFalse);
      final pv1 = await packageBackend.lookupPackageVersion('oxygen', '1.0.0');
      expect(pv1!.isModerated, isTrue);

      // clear flag
      final r2 = await _moderate('oxygen', '1.0.0', state: false);
      expect(r2.output, {
        'package': 'oxygen',
        'version': '1.0.0',
        'before': {'isModerated': true, 'moderatedAt': isNotEmpty},
        'after': {'isModerated': false, 'moderatedAt': null},
      });
      final p2 = await packageBackend.lookupPackage('oxygen');
      expect(p2!.isModerated, isFalse);
      final pv2 = await packageBackend.lookupPackageVersion('oxygen', '1.0.0');
      expect(pv2!.isModerated, isFalse);

      // can redact this version
      final optionsUpdates =
          await (await createFakeAuthPubApiClient(email: adminAtPubDevEmail))
              .setVersionOptions(
                  'oxygen', '1.0.0', VersionOptions(isRetracted: true));
      expect(optionsUpdates.isRetracted, true);
    });

    testWithProfile('cannot moderated last visible version', fn: () async {
      await _moderate('oxygen', '1.2.0', state: true);
      final p1 = await packageBackend.lookupPackage('oxygen');
      expect(p1!.latestVersion, '1.0.0');
      expect(p1.latestPrereleaseVersion, '2.0.0-dev');
      expect(p1.latestPreviewVersion, '1.0.0');

      await _moderate('oxygen', '2.0.0-dev', state: true);
      final p2 = await packageBackend.lookupPackage('oxygen');
      expect(p2!.latestVersion, '1.0.0');
      expect(p2.latestPrereleaseVersion, '1.0.0');
      expect(p2.latestPreviewVersion, '1.0.0');

      await expectApiException(
        _moderate('oxygen', '1.0.0', state: true),
        code: 'NotAcceptable',
        status: 406,
        message: 'No visible versions left.',
      );
    });

    testWithProfile('can publish new version', fn: () async {
      await _moderate('oxygen', '1.0.0', state: true);

      final pubspecContent = generatePubspecYaml('oxygen', '3.0.0');
      final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);
      final message = await createPubApiClient(authToken: adminClientToken)
          .uploadPackageBytes(bytes);
      expect(message.success.message, contains('Successfully uploaded'));
    });

    testWithProfile('can not re-publish moderated version', fn: () async {
      await _moderate('oxygen', '1.0.0', state: true);

      final pubspecContent = generatePubspecYaml('oxygen', '1.0.0');
      final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);
      await expectApiException(
        createPubApiClient(authToken: adminClientToken)
            .uploadPackageBytes(bytes),
        code: 'PackageRejected',
        status: 400,
        message: 'Version 1.0.0 of package oxygen already exists.',
      );
    });

    testWithProfile('archive file is removed from public bucket', fn: () async {
      Future<Uint8List?> expectStatusCode(int statusCode,
          {String version = '1.0.0'}) async {
        final publicUri = Uri.parse('${activeConfiguration.storageBaseUrl}'
            '/${activeConfiguration.publicPackagesBucketName}'
            '/packages/oxygen-$version.tar.gz');
        final rs1 = await http.get(publicUri);
        expect(rs1.statusCode, statusCode);
        return rs1.bodyBytes;
      }

      final bytes = await expectStatusCode(200);

      await _moderate('oxygen', '1.0.0', state: true);
      await expectStatusCode(404);
      await expectStatusCode(200, version: '1.2.0');

      // another check after background tasks are running
      await updatePublicArchiveBucket();
      await expectStatusCode(404);
      await expectStatusCode(200, version: '1.2.0');

      await _moderate('oxygen', '1.0.0', state: false);
      await expectStatusCode(200);
      await updatePublicArchiveBucket();
      final restoredBytes = await expectStatusCode(200);
      expect(restoredBytes, bytes);
    });

    testWithProfile('search is updated with new version', fn: () async {
      await searchBackend.doCreateAndUpdateSnapshot(
        FakeGlobalLockClaim(clock.now().add(Duration(seconds: 3))),
        concurrency: 2,
        sleepDuration: Duration(milliseconds: 300),
      );
      final docs = await searchBackend.fetchSnapshotDocuments();
      expect(docs!.firstWhere((d) => d.package == 'oxygen').version, '1.2.0');

      await _moderate('oxygen', '1.2.0', state: true);
      final minimumIndex =
          await searchBackend.loadMinimumPackageIndex().toList();
      expect(minimumIndex.firstWhere((d) => d.package == 'oxygen').version,
          '1.0.0');

      await searchBackend.doCreateAndUpdateSnapshot(
        FakeGlobalLockClaim(clock.now().add(Duration(seconds: 3))),
        concurrency: 2,
        sleepDuration: Duration(milliseconds: 300),
      );
      final docs2 = await searchBackend.fetchSnapshotDocuments();
      expect(docs2!.firstWhere((d) => d.package == 'oxygen').version, '1.0.0');

      await _moderate('oxygen', '1.2.0', state: false);

      final minimumIndex2 =
          await searchBackend.loadMinimumPackageIndex().toList();
      expect(minimumIndex2.firstWhere((d) => d.package == 'oxygen').version,
          '1.2.0');

      await searchBackend.doCreateAndUpdateSnapshot(
        FakeGlobalLockClaim(clock.now().add(Duration(seconds: 3))),
        concurrency: 2,
        sleepDuration: Duration(milliseconds: 300),
      );
      final docs3 = await searchBackend.fetchSnapshotDocuments();
      expect(docs3!.firstWhere((d) => d.package == 'oxygen').version, '1.2.0');
    });

    testWithProfile(
        'moderated version is not visible in API (other version is)',
        fn: () async {
      await _moderate('oxygen', '1.0.0', state: true);
      final rs1 = await packageBackend.listVersionsCached('oxygen');
      expect(rs1.latest.version, '1.2.0');
      expect(rs1.versions.where((v) => v.version == '1.0.0'), isEmpty);
      expect(rs1.versions.where((v) => v.version == '1.2.0'), isNotEmpty);

      await _moderate('oxygen', '1.0.0', state: false);
      final rs2 = await packageBackend.listVersionsCached('oxygen');
      expect(rs2.latest.version, '1.2.0');
      expect(rs2.versions.where((v) => v.version == '1.0.0'), isNotEmpty);
      expect(rs2.versions.where((v) => v.version == '1.2.0'), isNotEmpty);

      await _moderate('oxygen', '1.2.0', state: true);
      final rs3 = await packageBackend.listVersionsCached('oxygen');
      expect(rs3.latest.version, '1.0.0');
      expect(rs3.versions.where((v) => v.version == '1.0.0'), isNotEmpty);
      expect(rs3.versions.where((v) => v.version == '1.2.0'), isEmpty);

      await _moderate('oxygen', '1.2.0', state: false);
      final rs4 = await packageBackend.listVersionsCached('oxygen');
      expect(rs4.latest.version, '1.2.0');
      expect(rs4.versions.where((v) => v.version == '1.0.0'), isNotEmpty);
      expect(rs4.versions.where((v) => v.version == '1.2.0'), isNotEmpty);
    });

    testWithProfile('moderated versions are not displayed on versions tab',
        fn: () async {
      await _moderate('oxygen', '1.2.0', state: true);
      await expectHtmlResponse(
        await issueGet('/packages/oxygen/versions'),
        absent: ['1.2.0'],
        present: ['1.0.0'],
      );
      await _moderate('oxygen', '1.2.0', state: false);
      await expectHtmlResponse(
        await issueGet('/packages/oxygen/versions'),
        present: ['1.0.0', '1.2.0'],
      );
    });

    testWithProfile('moderated version pages are not displayed', fn: () async {
      List<String> pagePaths(String version) {
        return [
          '/packages/oxygen/versions/$version',
          '/packages/oxygen/versions/$version/changelog',
          '/packages/oxygen/versions/$version/install',
          '/packages/oxygen/versions/$version/score',
          '/packages/oxygen/versions/$version/pubspec',
          '/packages/oxygen/versions/$version/license',
        ];
      }

      for (final path in pagePaths('1.0.0')) {
        await expectHtmlResponse(
          await issueGet(path),
          absent: ['moderated'],
          present: ['1.2.0'],
        );
      }
      for (final path in pagePaths('1.2.0')) {
        await expectHtmlResponse(
          await issueGet(path),
          absent: ['moderated'],
          present: ['1.2.0'],
        );
      }

      await _moderate('oxygen', '1.2.0', state: true);
      await expectHtmlResponse(
        await issueGet('/packages/oxygen'),
        absent: [
          '1.2.0',
          'moderated',
        ],
        present: ['1.0.0'],
      );
      for (final path in pagePaths('1.0.0')) {
        await expectHtmlResponse(
          await issueGet(path),
          absent: ['moderated', '1.2.0'],
        );
      }
      for (final path in pagePaths('1.2.0')) {
        await expectHtmlResponse(
          await issueGet(path),
          present: ['moderated'],
          status: 404,
        );
      }

      await _moderate('oxygen', '1.2.0', state: false);
      await expectHtmlResponse(
        await issueGet('/packages/oxygen'),
        absent: [
          'moderated',
        ],
        present: ['1.2.0'],
      );
      for (final path in pagePaths('1.0.0')) {
        await expectHtmlResponse(
          await issueGet(path),
          absent: ['moderated'],
          present: ['1.2.0'],
        );
      }
      for (final path in pagePaths('1.2.0')) {
        await expectHtmlResponse(
          await issueGet(path),
          absent: ['moderated'],
        );
      }
    });

    testWithProfile(
      'moderated version trigger new analysis',
      processJobsWithFakeRunners: true,
      fn: () async {
        final score1 =
            await scoreCardBackend.getScoreCardData('oxygen', '1.2.0');
        expect(score1.grantedPubPoints, greaterThan(40));

        await _moderate('oxygen', '1.2.0', state: true);
        final status1 = await taskBackend.packageStatus('oxygen');
        expect(status1.versions.containsKey('1.0.0'), isTrue);
        expect(status1.versions.containsKey('1.2.0'), isFalse);
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

        // re-analysis
        await processTasksWithFakePanaAndDartdoc();
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
        // latest stable has score
        expect(
          (await scoreCardBackend.getScoreCardData('oxygen', '1.0.0'))
              .grantedPubPoints,
          greaterThan(30),
        );

        // restore state
        await _moderate('oxygen', '1.2.0', state: false);
        await processTasksWithFakePanaAndDartdoc();

        final score3 =
            await scoreCardBackend.getScoreCardData('oxygen', '1.2.0');
        expect(score3.grantedPubPoints, greaterThan(40));
      },
    );
  });
}
