// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/account_api.dart' as account_api;
import 'package:gcloud/db.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/consent_backend.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/audit/backend.dart';
import 'package:pub_dev/audit/models.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:test/test.dart';

import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('Uploader invite', () {
    Future<String?> inviteUploader() async {
      await accountBackend.withBearerToken(adminClientToken, () async {
        final authenticatedUser = await requireAuthenticatedUser(
            expectedAudience: activeConfiguration.pubClientAudience);
        final status = await consentBackend.invitePackageUploader(
          activeUser: authenticatedUser.user,
          uploaderEmail: 'user@pub.dev',
          packageName: 'oxygen',
        );
        expect(status.emailSent, isTrue);
      });

      String? consentId;
      await accountBackend.withBearerToken(userAtPubDevAuthToken, () async {
        final authenticatedUser = await requireAuthenticatedUser();
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
          '`admin@pub.dev` invited `user@pub.dev` to be an uploader for package `oxygen`.');

      return consentId;
    }

    testWithProfile('Uploader invite accepted', fn: () async {
      final consentId = await inviteUploader();
      final client = createPubApiClient(authToken: userAtPubDevAuthToken);
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
      final client = createPubApiClient(authToken: userAtPubDevAuthToken);
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
  });

  group('Publisher contact', () {
    Future<String?> inviteContact() async {
      await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
        final status = await consentBackend.invitePublisherContact(
          publisherId: 'example.com',
          contactEmail: 'info@example.com',
        );
        expect(status.emailSent, isTrue);
      });

      String? consentId;
      await accountBackend.withBearerToken(userAtPubDevAuthToken, () async {
        final authenticatedUser = await requireAuthenticatedUser();
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
          '`admin@pub.dev` invited `info@example.com` to be contact email for publisher `example.com`.');
      return consentId;
    }

    testWithProfile('Publisher contact accepted', fn: () async {
      final consentId = await inviteContact();

      final client = createPubApiClient(authToken: userAtPubDevAuthToken);
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

      final client = createPubApiClient(authToken: userAtPubDevAuthToken);
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
  });

  group('Publisher member', () {
    Future<String?> inviteMember() async {
      await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
        final status = await consentBackend.invitePublisherMember(
          publisherId: 'example.com',
          invitedUserEmail: 'user@pub.dev',
        );
        expect(status.emailSent, isTrue);
      });

      String? consentId;
      await accountBackend.withBearerToken(userAtPubDevAuthToken, () async {
        final authenticatedUser = await requireAuthenticatedUser();
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
          '`admin@pub.dev` invited `user@pub.dev` to be a member for publisher `example.com`.');

      return consentId;
    }

    testWithProfile('Publisher member accepted', fn: () async {
      final consentId = await inviteMember();

      final client = createPubApiClient(authToken: userAtPubDevAuthToken);
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

      final client = createPubApiClient(authToken: userAtPubDevAuthToken);
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
  });
}

Future<void> _expireConsent(String? consentId) async {
  final consent = await dbService
      .lookupValue<Consent>(dbService.emptyKey.append(Consent, id: consentId));
  consent.expires = consent.created;
  await dbService.commit(inserts: [consent]);
  await consentBackend.deleteObsoleteConsents();
}
