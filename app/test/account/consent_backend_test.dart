// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/account_api.dart' as account_api;
import 'package:_pub_shared/data/package_api.dart';
import 'package:_pub_shared/data/publisher_api.dart';
import 'package:gcloud/db.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/consent_backend.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/audit/backend.dart';
import 'package:pub_dev/audit/models.dart';
import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/frontend/static_files.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/publisher/backend.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:test/test.dart';

import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  setUpAll(() => updateLocalBuiltFilesIfNeeded());

  group('Uploader invite', () {
    Future<String?> inviteUploader(
        {String adminEmail = 'admin@pub.dev'}) async {
      await withFakeAuthHttpPubApiClient(
        email: adminEmail,
        pubHostedUrl: activeConfiguration.primarySiteUri.toString(),
        fn: (client) async {
          await client.invitePackageUploader(
              'oxygen', InviteUploaderRequest(email: userAtPubDevEmail));
        },
      );

      String? consentId;
      await withFakeAuthRequestContext(userAtPubDevEmail, () async {
        final authenticatedUser = await requireAuthenticatedWebUser();
        final user = authenticatedUser.user;
        final consentRow = await dbService.query<Consent>().run().single;
        final consent =
            await consentBackend.getConsent(consentRow.consentId, user);
        expect(consent.descriptionHtml, contains('/packages/oxygen'));
        expect(consent.descriptionHtml, contains('publish new versions'));
        consentId = consentRow.consentId;
      });

      final page = await auditBackend.listRecordsForPackage('oxygen');
      final r = page.records
          .firstWhere((e) => e.kind == AuditLogRecordKind.uploaderInvited);
      expect(r.summary,
          '`$adminEmail` invited `user@pub.dev` to be an uploader for package `oxygen`.');

      return consentId;
    }

    testWithProfile('Non-admin cannot invite', fn: () async {
      final rs = inviteUploader(adminEmail: 'other@pub.dev');
      await expectApiException(rs,
          status: 403, code: 'InsufficientPermissions');
    });

    testWithProfile('Uploader invite accepted', fn: () async {
      final consentId = await inviteUploader();
      final client = await createFakeAuthPubApiClient(email: userAtPubDevEmail);
      final rs = await client.resolveConsent(
          consentId!, account_api.ConsentResult(granted: true));
      expect(rs.granted, true);

      final page = await auditBackend.listRecordsForPackage('oxygen');
      final r = page.records.firstWhere(
          (e) => e.kind == AuditLogRecordKind.uploaderInviteAccepted);
      expect(r.summary,
          '`user@pub.dev` accepted uploader invite for package `oxygen`.');
    });

    testWithProfile('Uploader invite rejected', fn: () async {
      final consentId = await inviteUploader();
      final client = await createFakeAuthPubApiClient(email: userAtPubDevEmail);
      final rs = await client.resolveConsent(
          consentId!, account_api.ConsentResult(granted: false));
      expect(rs.granted, false);

      final page = await auditBackend.listRecordsForPackage('oxygen');
      final r = page.records.firstWhere(
          (e) => e.kind == AuditLogRecordKind.uploaderInviteRejected);
      expect(r.summary,
          '`user@pub.dev` rejected uploader invite for package `oxygen`.');
    });

    testWithProfile('Uploader invite expired', fn: () async {
      final consentId = await inviteUploader();
      await _expireConsent(consentId);

      final page = await auditBackend.listRecordsForPackage('oxygen');
      final r = page.records.firstWhere(
          (e) => e.kind == AuditLogRecordKind.uploaderInviteExpired);
      expect(r.summary,
          'Uploader invite for package `oxygen` expired, `user@pub.dev` did not respond.');
    });

    testWithProfile(
      'Uploader invite denied - original user is no longer admin',
      fn: () async {
        final consentId = await inviteUploader();

        // remove original admin
        final package = await packageBackend.lookupPackage('oxygen');
        await withFakeAuthRequestContext('other@pub.dev', () async {
          final agent = await requireAuthenticatedWebUser();
          package!.uploaders = [agent.userId];
        });
        await dbService.commit(inserts: [package!]);

        final client =
            await createFakeAuthPubApiClient(email: userAtPubDevEmail);
        final rs = client.resolveConsent(
            consentId!, account_api.ConsentResult(granted: true));
        await expectApiException(rs,
            status: 403, code: 'InsufficientPermissions');
      },
    );
  });

  group('Publisher contact', () {
    Future<String?> inviteContact({
      String adminEmail = 'admin@pub.dev',
    }) async {
      final adminClient = await createFakeAuthPubApiClient(email: adminEmail);
      await adminClient.updatePublisher('example.com',
          UpdatePublisherRequest(contactEmail: 'info@example.com'));

      String? consentId;
      await withFakeAuthRequestContext(userAtPubDevEmail, () async {
        final authenticatedUser = await requireAuthenticatedWebUser();
        final user = authenticatedUser.user;
        final consentRow = await dbService.query<Consent>().run().single;
        final consent =
            await consentBackend.getConsent(consentRow.consentId, user);
        expect(consent.descriptionHtml, contains('/publishers/example.com'));
        expect(consent.descriptionHtml, contains('contact email means'));
        consentId = consentRow.consentId;
      });

      final page = await auditBackend.listRecordsForPublisher('example.com');
      final r = page.records.firstWhere(
          (e) => e.kind == AuditLogRecordKind.publisherContactInvited);
      expect(r.summary,
          '`$adminEmail` invited `info@example.com` to be contact email for publisher `example.com`.');
      return consentId;
    }

    testWithProfile('Non-admin cannot invite', fn: () async {
      final rs = inviteContact(adminEmail: 'other@pub.dev');
      await expectApiException(rs,
          status: 403, code: 'InsufficientPermissions');
    });

    testWithProfile('Publisher contact accepted', fn: () async {
      final consentId = await inviteContact();

      final client = await createFakeAuthPubApiClient(email: userAtPubDevEmail);
      final rs = await client.resolveConsent(
          consentId!, account_api.ConsentResult(granted: true));
      expect(rs.granted, true);

      final page = await auditBackend.listRecordsForPublisher('example.com');
      final r = page.records.firstWhere(
          (e) => e.kind == AuditLogRecordKind.publisherContactInviteAccepted);
      expect(r.summary,
          '`user@pub.dev` accepted `info@example.com` to be contact email for publisher `example.com`.');
    });

    testWithProfile('Publisher contact rejected', fn: () async {
      final consentId = await inviteContact();

      final client = await createFakeAuthPubApiClient(email: userAtPubDevEmail);
      final rs = await client.resolveConsent(
          consentId!, account_api.ConsentResult(granted: false));
      expect(rs.granted, false);

      final page = await auditBackend.listRecordsForPublisher('example.com');
      final r = page.records.firstWhere(
          (e) => e.kind == AuditLogRecordKind.publisherContactInviteRejected);
      expect(r.summary,
          '`user@pub.dev` rejected contact invite of `info@example.com` for publisher `example.com`.');
    });

    testWithProfile('Publisher contact expired', fn: () async {
      final consentId = await inviteContact();
      await _expireConsent(consentId);

      final page = await auditBackend.listRecordsForPublisher('example.com');
      final r = page.records.firstWhere(
          (e) => e.kind == AuditLogRecordKind.publisherContactInviteExpired);
      expect(r.summary,
          'Contact invite for publisher `example.com` expired, `info@example.com` did not respond.');
    });

    testWithProfile(
      'Publisher contact denied - original user is no longer admin',
      fn: () async {
        final consentId = await inviteContact();
        await _removeAdminRole('example.com', 'admin@pub.dev');

        final client =
            await createFakeAuthPubApiClient(email: userAtPubDevEmail);
        final rs = client.resolveConsent(
            consentId!, account_api.ConsentResult(granted: true));
        await expectApiException(rs,
            status: 403, code: 'InsufficientPermissions');
      },
    );
  });

  group('Publisher member', () {
    Future<String?> inviteMember({
      String adminEmail = 'admin@pub.dev',
    }) async {
      final adminClient = await createFakeAuthPubApiClient(email: adminEmail);
      await adminClient.invitePublisherMember(
          'example.com', InviteMemberRequest(email: 'user@pub.dev'));

      String? consentId;
      await withFakeAuthRequestContext(userAtPubDevEmail, () async {
        final authenticatedUser = await requireAuthenticatedWebUser();
        final user = authenticatedUser.user;
        final consentRow = await dbService.query<Consent>().run().single;
        final consent =
            await consentBackend.getConsent(consentRow.consentId, user);
        expect(consent.descriptionHtml, contains('/publishers/example.com'));
        expect(consent.descriptionHtml,
            contains('perform administrative actions'));
        consentId = consentRow.consentId;
      });

      final page = await auditBackend.listRecordsForPublisher('example.com');
      final r = page.records.firstWhere(
          (e) => e.kind == AuditLogRecordKind.publisherMemberInvited);
      expect(r.summary,
          '`$adminEmail` invited `user@pub.dev` to be a member for publisher `example.com`.');

      return consentId;
    }

    testWithProfile('Non-admin cannot invite', fn: () async {
      final rs = inviteMember(adminEmail: 'other@pub.dev');
      await expectApiException(rs,
          status: 403, code: 'InsufficientPermissions');
    });

    testWithProfile('Publisher member accepted', fn: () async {
      final consentId = await inviteMember();

      final client = await createFakeAuthPubApiClient(email: userAtPubDevEmail);
      final rs = await client.resolveConsent(
          consentId!, account_api.ConsentResult(granted: true));
      expect(rs.granted, true);

      final page = await auditBackend.listRecordsForPublisher('example.com');
      final r = page.records.firstWhere(
          (e) => e.kind == AuditLogRecordKind.publisherMemberInviteAccepted);
      expect(r.summary,
          '`user@pub.dev` accepted member invite for publisher `example.com`.');
    });

    testWithProfile('Publisher member rejected', fn: () async {
      final consentId = await inviteMember();

      final client = await createFakeAuthPubApiClient(email: userAtPubDevEmail);
      final rs = await client.resolveConsent(
          consentId!, account_api.ConsentResult(granted: false));
      expect(rs.granted, false);

      final page = await auditBackend.listRecordsForPublisher('example.com');
      final r = page.records.firstWhere(
          (e) => e.kind == AuditLogRecordKind.publisherMemberInviteRejected);
      expect(r.summary,
          '`user@pub.dev` rejected member invite for publisher `example.com`.');
    });

    testWithProfile('Publisher member expired', fn: () async {
      final consentId = await inviteMember();
      await _expireConsent(consentId);

      final page = await auditBackend.listRecordsForPublisher('example.com');
      final r = page.records.firstWhere(
          (e) => e.kind == AuditLogRecordKind.publisherMemberInviteExpired);
      expect(r.summary,
          'Member invite for publisher `example.com` expired, `user@pub.dev` did not respond.');
    });

    testWithProfile(
      'Publisher member denied - original user is no longer admin',
      fn: () async {
        final consentId = await inviteMember();
        await _removeAdminRole('example.com', 'admin@pub.dev');

        final client =
            await createFakeAuthPubApiClient(email: userAtPubDevEmail);
        final rs = client.resolveConsent(
            consentId!, account_api.ConsentResult(granted: true));
        await expectApiException(rs,
            status: 403, code: 'InsufficientPermissions');
      },
    );
  });
}

Future<void> _expireConsent(String? consentId) async {
  final consent = await dbService
      .lookupValue<Consent>(dbService.emptyKey.append(Consent, id: consentId));
  consent.expires = consent.created;
  await dbService.commit(inserts: [consent]);
  await consentBackend.deleteObsoleteConsents();
}

Future<void> _removeAdminRole(String publisherId, String email) async {
  await withFakeAuthRequestContext(email, () async {
    final agent = await requireAuthenticatedWebUser();
    final publisher = await publisherBackend.getPublisher(publisherId);
    final member =
        await publisherBackend.getPublisherMember(publisher!, agent.userId);
    member!.role = 'non-admin';
    await dbService.commit(inserts: [member]);
  });
}
