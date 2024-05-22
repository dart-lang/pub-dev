// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/account_api.dart' as account_api;
import 'package:_pub_shared/data/admin_api.dart';
import 'package:_pub_shared/data/package_api.dart';
import 'package:_pub_shared/data/publisher_api.dart';
import 'package:pub_dev/account/auth_provider.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/admin/backend.dart';
import 'package:pub_dev/admin/models.dart';
import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:test/test.dart';

import '../frontend/handlers/_utils.dart';
import '../package/backend_test_utils.dart';
import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('Moderate User', () {
    Future<ModerationCase> _report(String package) async {
      await withHttpPubApiClient(
        experimental: {'report'},
        fn: (client) async {
          await client.postReport(account_api.ReportForm(
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
      String email, {
      bool? state,
      String caseId = 'none',
    }) async {
      final api = createPubApiClient(authToken: siteAdminToken);
      return await api.adminInvokeAction(
        'moderate-user',
        AdminInvokeActionArguments(arguments: {
          'case': caseId,
          'user': email,
          if (state != null) 'state': state.toString(),
        }),
      );
    }

    testWithProfile('update state and clearing it', fn: () async {
      final mc = await _report('oxygen');

      final r1 = await _moderate('user@pub.dev');
      expect(r1.output, {
        'userId': isNotEmpty,
        'before': {'isModerated': false, 'moderatedAt': null},
      });

      final r2 =
          await _moderate('user@pub.dev', caseId: mc.caseId, state: true);
      expect(r2.output, {
        'userId': isNotEmpty,
        'before': {'isModerated': false, 'moderatedAt': null},
        'after': {'isModerated': true, 'moderatedAt': isNotEmpty},
      });
      final u2 = await accountBackend.lookupUserByEmail('user@pub.dev');
      expect(u2.isModerated, isTrue);
      expect(u2.isVisible, false);

      final r3 =
          await _moderate('user@pub.dev', caseId: mc.caseId, state: false);
      expect(r3.output, {
        'userId': isNotEmpty,
        'before': {'isModerated': true, 'moderatedAt': isNotEmpty},
        'after': {'isModerated': false, 'moderatedAt': isNull},
      });
      final u3 = await accountBackend.lookupUserByEmail('user@pub.dev');
      expect(u3.isModerated, isFalse);
      expect(u3.isVisible, true);

      final mc2 = await adminBackend.lookupModerationCase(mc.caseId);
      expect(mc2!.getActionLog().entries, hasLength(2));
    });

    testWithProfile('sign-in disabled', fn: () async {
      await _moderate('user@pub.dev', state: true);
      await expectLater(
          acquireSessionCookies('user@pub.dev'), throwsA(isA<Exception>()));
      await _moderate('user@pub.dev', state: false);
      await acquireSessionCookies('user@pub.dev');
    });

    testWithProfile('expire existing session', fn: () async {
      final cookies = await acquireSessionCookies('user@pub.dev');
      await expectHtmlResponse(
        await issueGet(
          '/my-packages',
          headers: {'cookie': cookies},
          host: activeConfiguration.primaryApiUri!.host,
        ),
      );
      await _moderate('user@pub.dev', state: true);
      await expectHtmlResponse(
        await issueGet(
          '/my-packages',
          headers: {'cookie': cookies},
          host: activeConfiguration.primaryApiUri!.host,
        ),
        status: 401,
      );
    });

    testWithProfile('not able to publish', fn: () async {
      await _moderate('user@pub.dev', state: true);
      final pubspecContent = generatePubspecYaml('foo', '1.0.0');
      final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);

      await expectApiException(
        createPubApiClient(authToken: userClientToken)
            .uploadPackageBytes(bytes),
        code: 'InsufficientPermissions',
        status: 403,
        message: 'User is blocked.',
      );

      await _moderate('user@pub.dev', state: false);
      final message = await createPubApiClient(authToken: userClientToken)
          .uploadPackageBytes(bytes);
      expect(message.success.message, contains('Successfully uploaded'));
    });

    testWithProfile('not able to update package options', fn: () async {
      // add as a second uploader to package
      await createPubApiClient(authToken: siteAdminToken)
          .adminAddPackageUploader('oxygen', 'user@pub.dev');
      final consentRow = await dbService.query<Consent>().run().single;
      await (await createFakeAuthPubApiClient(email: 'user@pub.dev'))
          .resolveConsent(
        consentRow.consentId,
        account_api.ConsentResult(granted: true),
      );

      final client = await createFakeAuthPubApiClient(email: 'user@pub.dev');
      await _moderate('user@pub.dev', state: true);
      await expectApiException(
        client.setPackageOptions('oxygen', PkgOptions(isUnlisted: true)),
        status: 401,
        code: 'MissingAuthentication',
      );
      await expectLater(createFakeAuthPubApiClient(email: 'user@pub.dev'),
          throwsA(isA<Exception>()));

      await _moderate('user@pub.dev', state: false);
      final client2 = await createFakeAuthPubApiClient(email: 'user@pub.dev');
      final rs = await client2.setPackageOptions(
          'oxygen', PkgOptions(isUnlisted: true));
      expect(rs.isDiscontinued, false);
      expect(rs.isUnlisted, true);
    });

    testWithProfile('not able to update publisher options', fn: () async {
      final client = await createFakeAuthPubApiClient(
          email: 'user@pub.dev', scopes: [webmasterScope]);
      final rs1 = await client.createPublisher('verified.com');
      expect(rs1.websiteUrl, 'https://verified.com/');

      await _moderate('user@pub.dev', state: true);
      await expectApiException(
        client.updatePublisher('verified.com',
            UpdatePublisherRequest(websiteUrl: 'https://other.com/')),
        status: 401,
        code: 'MissingAuthentication',
      );
      await expectLater(createFakeAuthPubApiClient(email: 'user@pub.dev'),
          throwsA(isA<Exception>()));

      await _moderate('user@pub.dev', state: false);
      final client2 = await createFakeAuthPubApiClient(email: 'user@pub.dev');
      final rs = await client2.updatePublisher('verified.com',
          UpdatePublisherRequest(websiteUrl: 'https://other.com/'));
      expect(rs.websiteUrl, 'https://other.com/');
    });

    testWithProfile('single packages marked discontinued', fn: () async {
      final pubspecContent = generatePubspecYaml('foo', '1.0.0');
      final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);
      await createPubApiClient(authToken: userClientToken)
          .uploadPackageBytes(bytes);

      await _moderate('user@pub.dev', state: true);
      final p1 = await packageBackend.lookupPackage('foo');
      expect(p1!.isDiscontinued, true);

      await _moderate('user@pub.dev', state: false);
      final p2 = await packageBackend.lookupPackage('foo');
      expect(p2!.isDiscontinued, true);
    });

    testWithProfile('publisher packages marked discontinued', fn: () async {
      final client = await createFakeAuthPubApiClient(
          email: 'user@pub.dev', scopes: [webmasterScope]);
      await client.createPublisher('verified.com');

      final pubspecContent = generatePubspecYaml('foo', '1.0.0');
      final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);
      await createPubApiClient(authToken: userClientToken)
          .uploadPackageBytes(bytes);
      await (await createFakeAuthPubApiClient(email: 'user@pub.dev'))
          .setPackagePublisher(
              'foo', PackagePublisherInfo(publisherId: 'verified.com'));

      await _moderate('user@pub.dev', state: true);
      final p1 = await packageBackend.lookupPackage('foo');
      expect(p1!.publisherId, isNotEmpty);
      expect(p1.isDiscontinued, true);

      await _moderate('user@pub.dev', state: false);
      final p2 = await packageBackend.lookupPackage('foo');
      expect(p2!.publisherId, isNotEmpty);
      expect(p2.isDiscontinued, true);
    });
  });
}
