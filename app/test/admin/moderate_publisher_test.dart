// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/account_api.dart';
import 'package:_pub_shared/data/admin_api.dart';
import 'package:_pub_shared/data/publisher_api.dart';
import 'package:clock/clock.dart';
import 'package:pub_dev/admin/models.dart';
import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/publisher/backend.dart';
import 'package:pub_dev/search/backend.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:test/test.dart';

import '../frontend/handlers/_utils.dart';
import '../package/backend_test_utils.dart';
import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('Moderate Publisher', () {
    Future<ModerationCase> _report(String publisherId) async {
      await withHttpPubApiClient(
        experimental: {'report'},
        fn: (client) async {
          await client.postReport(ReportForm(
            email: 'user@pub.dev',
            subject: 'publisher:$publisherId',
            message: 'Huston, we have a problem.',
          ));
        },
      );
      final list = await dbService.query<ModerationCase>().run().toList();
      return list.reduce((a, b) => a.opened.isAfter(b.opened) ? a : b);
    }

    Future<AdminInvokeActionResponse> _moderate(
      String publisher, {
      required String caseId,
      bool? state,
    }) async {
      final api = createPubApiClient(authToken: siteAdminToken);
      return await api.adminInvokeAction(
        'moderate-publisher',
        AdminInvokeActionArguments(arguments: {
          'publisher': publisher,
          'case': caseId,
          if (state != null) 'state': state.toString(),
        }),
      );
    }

    testWithProfile('update state and clearing it', fn: () async {
      final mc = await _report('example.com');

      final r1 = await _moderate('example.com', caseId: mc.caseId);
      expect(r1.output, {
        'publisherId': 'example.com',
        'before': {'isModerated': false, 'moderatedAt': null},
      });

      final r2 = await _moderate('example.com', caseId: mc.caseId, state: true);
      expect(r2.output, {
        'publisherId': 'example.com',
        'before': {'isModerated': false, 'moderatedAt': null},
        'after': {'isModerated': true, 'moderatedAt': isNotEmpty},
      });
      final p2 = await publisherBackend.getPublisher('example.com');
      expect(p2!.isModerated, isTrue);

      final r3 =
          await _moderate('example.com', caseId: mc.caseId, state: false);
      expect(r3.output, {
        'publisherId': 'example.com',
        'before': {'isModerated': true, 'moderatedAt': isNotEmpty},
        'after': {'isModerated': false, 'moderatedAt': isNull},
      });
      final p3 = await publisherBackend.getPublisher('example.com');
      expect(p3!.isModerated, isFalse);
    });

    testWithProfile('not able to publish', fn: () async {
      final mc = await _report('example.com');
      await _moderate('example.com', caseId: mc.caseId, state: true);
      final pubspecContent = generatePubspecYaml('neon', '2.0.0');
      final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);

      await expectApiException(
        createPubApiClient(authToken: adminClientToken)
            .uploadPackageBytes(bytes),
        code: 'InsufficientPermissions',
        status: 403,
        message: 'insufficient permissions to upload new versions',
      );

      await _moderate('example.com', caseId: mc.caseId, state: false);
      final message = await createPubApiClient(authToken: adminClientToken)
          .uploadPackageBytes(bytes);
      expect(message.success.message, contains('Successfully uploaded'));
    });

    testWithProfile('not able to update publisher options', fn: () async {
      final mc = await _report('example.com');
      await _moderate('example.com', caseId: mc.caseId, state: true);
      final client = await createFakeAuthPubApiClient(email: 'admin@pub.dev');
      await expectApiException(
        client.updatePublisher(
            'example.com', UpdatePublisherRequest(description: 'update')),
        status: 404,
        code: 'NotFound',
        message: 'Publisher "example.com" has been moderated.',
      );

      await _moderate('example.com', caseId: mc.caseId, state: false);
      final rs = await client.updatePublisher(
          'example.com', UpdatePublisherRequest(description: 'update'));
      expect(rs.description, 'update');
    });

    testWithProfile('publisher pages show it is moderated', fn: () async {
      final htmlUrls = [
        '/publishers/example.com/packages',
        '/publishers/example.com/unlisted-packages',
      ];
      Future<void> expectAvailable() async {
        for (final url in htmlUrls) {
          await expectHtmlResponse(
            await issueGet(url),
            absent: ['moderated'],
            present: ['/publishers/example.com/'],
          );
        }
      }

      await expectAvailable();

      final mc = await _report('example.com');
      await _moderate('example.com', caseId: mc.caseId, state: true);
      for (final url in htmlUrls) {
        await expectHtmlResponse(
          await issueGet(url),
          status: 404,
          absent: ['/publishers/example.com/'],
          present: ['moderated'],
        );
      }

      await _moderate('example.com', caseId: mc.caseId, state: false);
      await expectAvailable();
    });

    testWithProfile('not included in search', fn: () async {
      await searchBackend.doCreateAndUpdateSnapshot(
        FakeGlobalLockClaim(clock.now().add(Duration(seconds: 3))),
        concurrency: 2,
        sleepDuration: Duration(milliseconds: 300),
      );
      final docs = await searchBackend.fetchSnapshotDocuments();
      expect(docs!.where((d) => d.package == 'neon'), isNotEmpty);

      final mc = await _report('example.com');
      await _moderate('example.com', caseId: mc.caseId, state: true);

      final minimumIndex =
          await searchBackend.loadMinimumPackageIndex().toList();
      expect(minimumIndex.where((e) => e.package == 'neon'), isEmpty);

      await searchBackend.doCreateAndUpdateSnapshot(
        FakeGlobalLockClaim(clock.now().add(Duration(seconds: 3))),
        concurrency: 2,
        sleepDuration: Duration(milliseconds: 300),
      );
      final docs2 = await searchBackend.fetchSnapshotDocuments();
      expect(docs2!.where((d) => d.package == 'neon'), isEmpty);

      await _moderate('example.com', caseId: mc.caseId, state: false);

      final minimumIndex2 =
          await searchBackend.loadMinimumPackageIndex().toList();
      expect(minimumIndex2.where((e) => e.package == 'neon'), isNotEmpty);

      await searchBackend.doCreateAndUpdateSnapshot(
        FakeGlobalLockClaim(clock.now().add(Duration(seconds: 3))),
        concurrency: 2,
        sleepDuration: Duration(milliseconds: 300),
      );
      final docs3 = await searchBackend.fetchSnapshotDocuments();
      expect(docs3!.where((d) => d.package == 'neon'), isNotEmpty);
    });

    testWithProfile('status already closed', fn: () async {
      final mc = await _report('example.com');
      await dbService.commit(inserts: [mc..status = ModerationStatus.noAction]);

      await expectApiException(
        _moderate('example.com', state: true, caseId: mc.caseId),
        code: 'InvalidInput',
        status: 400,
        message: 'ModerationCase.status ("no-action") != "pending".',
      );
    });
  });
}
