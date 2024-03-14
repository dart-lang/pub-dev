// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:typed_data';

import 'package:_pub_shared/data/admin_api.dart';
import 'package:_pub_shared/data/package_api.dart';
import 'package:clock/clock.dart';
import 'package:http/http.dart' as http;
import 'package:pub_dev/admin/actions/actions.dart';
import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/fake/backend/fake_pub_worker.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/scorecard/backend.dart';
import 'package:pub_dev/search/backend.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/tool/maintenance/update_public_bucket.dart';
import 'package:test/test.dart';

import '../frontend/handlers/_utils.dart';
import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';
import 'backend_test_utils.dart';

void main() {
  group('Moderate package', () {
    testWithProfile('update state', fn: () async {
      final api = createPubApiClient(authToken: siteAdminToken);
      final r1 = await api.adminInvokeAction(
        'moderate-package',
        AdminInvokeActionArguments(arguments: {'package': 'oxygen'}),
      );
      expect(r1.output, {
        'package': 'oxygen',
        'before': {'isModerated': false, 'moderatedAt': null},
      });

      final r2 = await api.adminInvokeAction(
        'moderate-package',
        AdminInvokeActionArguments(
            arguments: {'package': 'oxygen', 'state': 'true'}),
      );
      expect(r2.output, {
        'package': 'oxygen',
        'before': {'isModerated': false, 'moderatedAt': null},
        'after': {'isModerated': true, 'moderatedAt': isNotEmpty},
      });
      final p2 = await packageBackend.lookupPackage('oxygen');
      expect(p2!.isModerated, isTrue);

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
      final api = createPubApiClient(authToken: siteAdminToken);
      final r1 = await api.adminInvokeAction(
        'moderate-package',
        AdminInvokeActionArguments(arguments: {'package': 'oxygen'}),
      );
      expect(r1.output, {
        'package': 'oxygen',
        'before': {'isModerated': false, 'moderatedAt': null},
      });

      final r2 = await api.adminInvokeAction(
        'moderate-package',
        AdminInvokeActionArguments(
            arguments: {'package': 'oxygen', 'state': 'true'}),
      );
      expect(r2.output, {
        'package': 'oxygen',
        'before': {'isModerated': false, 'moderatedAt': null},
        'after': {'isModerated': true, 'moderatedAt': isNotEmpty},
      });
      final p2 = await packageBackend.lookupPackage('oxygen');
      expect(p2!.isModerated, isTrue);

      // clear flag
      final r3 = await api.adminInvokeAction(
        'moderate-package',
        AdminInvokeActionArguments(
            arguments: {'package': 'oxygen', 'state': 'false'}),
      );
      expect(r3.output, {
        'package': 'oxygen',
        'before': {'isModerated': true, 'moderatedAt': isNotEmpty},
        'after': {'isModerated': false, 'moderatedAt': null},
      });
      final p3 = await packageBackend.lookupPackage('oxygen');
      expect(p3!.isModerated, isFalse);

      final pubspecContent = generatePubspecYaml('oxygen', '3.0.0');
      final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);
      final message = await createPubApiClient(authToken: adminClientToken)
          .uploadPackageBytes(bytes);
      expect(message.success.message, contains('Successfully uploaded'));

      final optionsUpdates =
          await (await createFakeAuthPubApiClient(email: adminAtPubDevEmail))
              .setPackageOptions('oxygen', PkgOptions(isUnlisted: true));
      expect(optionsUpdates.isUnlisted, true);
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

      final api = createPubApiClient(authToken: siteAdminToken);
      await api.adminInvokeAction(
        'moderate-package',
        AdminInvokeActionArguments(
            arguments: {'package': 'oxygen', 'state': 'true'}),
      );
      for (final url in jsonUrls) {
        await expectJsonMapResponse(await issueGet(url), status: 404);
      }

      await api.adminInvokeAction(
        'moderate-package',
        AdminInvokeActionArguments(
            arguments: {'package': 'oxygen', 'state': 'false'}),
      );
      await expectAvailable();
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

      final api = createPubApiClient(authToken: siteAdminToken);
      await api.adminInvokeAction(
        'moderate-package',
        AdminInvokeActionArguments(
            arguments: {'package': 'oxygen', 'state': 'true'}),
      );
      for (final url in htmlUrls) {
        await expectHtmlResponse(
          await issueGet(url),
          status: 404,
          absent: ['/packages/oxygen'],
          present: ['moderated'],
        );
      }

      await api.adminInvokeAction(
        'moderate-package',
        AdminInvokeActionArguments(
            arguments: {'package': 'oxygen', 'state': 'false'}),
      );
      await expectAvailable();
    });

    testWithProfile('not included in search', fn: () async {
      await searchBackend.doCreateAndUpdateSnapshot(
        FakeGlobalLockClaim(clock.now().add(Duration(seconds: 3))),
        concurrency: 2,
        sleepDuration: Duration(milliseconds: 300),
      );
      final docs = await searchBackend.fetchSnapshotDocuments();
      expect(docs!.where((d) => d.package == 'oxygen'), isNotEmpty);

      final api = createPubApiClient(authToken: siteAdminToken);
      await api.adminInvokeAction(
        'moderate-package',
        AdminInvokeActionArguments(
            arguments: {'package': 'oxygen', 'state': 'true'}),
      );

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

      await api.adminInvokeAction(
        'moderate-package',
        AdminInvokeActionArguments(
            arguments: {'package': 'oxygen', 'state': 'false'}),
      );

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

      final api = createPubApiClient(authToken: siteAdminToken);
      await api.adminInvokeAction(
        'moderate-package',
        AdminInvokeActionArguments(
            arguments: {'package': 'oxygen', 'state': 'true'}),
      );

      await expectStatusCode(404);

      // another check after background tasks are running
      await updatePublicArchiveBucket();
      await expectStatusCode(404);

      await api.adminInvokeAction(
        'moderate-package',
        AdminInvokeActionArguments(
            arguments: {'package': 'oxygen', 'state': 'false'}),
      );
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

        final api = createPubApiClient(authToken: siteAdminToken);
        await api.adminInvokeAction(
          'moderate-package',
          AdminInvokeActionArguments(
              arguments: {'package': 'oxygen', 'state': 'true'}),
        );

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
        await api.adminInvokeAction(
          'moderate-package',
          AdminInvokeActionArguments(
              arguments: {'package': 'oxygen', 'state': 'false'}),
        );
        await processTasksWithFakePanaAndDartdoc();

        final score3 =
            await scoreCardBackend.getScoreCardData('oxygen', '1.2.0');
        expect(score3.grantedPubPoints, greaterThan(40));
      },
    );
  });
}
