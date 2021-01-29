// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';
import 'package:test/test.dart';

import 'package:client_data/account_api.dart' as account_api;
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/consent_backend.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/audit/backend.dart';
import 'package:pub_dev/audit/models.dart';
import 'package:pub_dev/tool/utils/pub_api_client.dart';

import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('Uploader invite', () {
    testWithProfile('Uploader invite', fn: () async {
      await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
        final status = await consentBackend.invitePackageUploader(
          uploaderEmail: 'user@pub.dev',
          packageName: 'oxygen',
        );
        expect(status.emailSent, isTrue);
      });

      String consentId;
      await accountBackend.withBearerToken(userAtPubDevAuthToken, () async {
        final consentRow = await dbService.query<Consent>().run().single;
        final consent = await consentBackend.getConsent(
            consentRow.consentId, await requireAuthenticatedUser());
        expect(consent.descriptionHtml, contains('/packages/oxygen'));
        expect(consent.descriptionHtml, contains('publish new versions'));
        consentId = consentRow.consentId;
      });

      final records1 = await auditBackend.listRecordsForPackage('oxygen');
      final r1 = records1
          .firstWhere((e) => e.kind == AuditLogRecordKind.uploadedInvited);
      expect(r1.summary,
          '`admin@pub.dev` invited `user@pub.dev` to be an uploader for package `oxygen`.');

      await withPubApiClient(
          bearerToken: userAtPubDevAuthToken,
          fn: (client) async {
            final rs = await client.resolveConsent(
                consentId, account_api.ConsentResult(granted: true));
            expect(rs.granted, true);
          });

      final records2 = await auditBackend.listRecordsForPackage('oxygen');
      final r2 = records2.firstWhere(
          (e) => e.kind == AuditLogRecordKind.uploaderInviteAccepted);
      expect(r2.summary,
          '`user@pub.dev` accepted uploader invite for package `oxygen`.');
    });

    testWithProfile('Publisher contact', fn: () async {
      await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
        final status = await consentBackend.invitePublisherContact(
          publisherId: exampleComPublisher.publisherId,
          contactEmail: 'info@example.com',
        );
        expect(status.emailSent, isTrue);
      });

      String consentId;
      await accountBackend.withBearerToken(userAtPubDevAuthToken, () async {
        final consentRow = await dbService.query<Consent>().run().single;
        final consent = await consentBackend.getConsent(
            consentRow.consentId, await requireAuthenticatedUser());
        expect(consent.descriptionHtml, contains('/publishers/example.com'));
        expect(consent.descriptionHtml, contains('contact email means'));
        consentId = consentRow.consentId;
      });

      final records1 =
          await auditBackend.listRecordsForPublisher('example.com');
      final r1 = records1.firstWhere(
          (e) => e.kind == AuditLogRecordKind.publisherContactInvited);
      expect(r1.summary,
          '`admin@pub.dev` invited `info@example.com` to be contact email for publisher `example.com`.');

      await withPubApiClient(
          bearerToken: adminAtPubDevAuthToken,
          fn: (client) async {
            final rs = await client.resolveConsent(
                consentId, account_api.ConsentResult(granted: true));
            expect(rs.granted, true);
          });

      final records2 =
          await auditBackend.listRecordsForPublisher('example.com');
      final r2 = records2.firstWhere(
          (e) => e.kind == AuditLogRecordKind.publisherContactInviteAccepted);
      expect(r2.summary,
          '`admin@pub.dev` accepted `info@example.com` to be contact email for publisher `example.com`.');
    });

    testWithProfile('Publisher member', fn: () async {
      await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
        final status = await consentBackend.invitePublisherMember(
          publisherId: exampleComPublisher.publisherId,
          invitedUserEmail: 'user@pub.dev',
        );
        expect(status.emailSent, isTrue);
      });

      String consentId;
      await accountBackend.withBearerToken(userAtPubDevAuthToken, () async {
        final consentRow = await dbService.query<Consent>().run().single;
        final consent = await consentBackend.getConsent(
            consentRow.consentId, await requireAuthenticatedUser());
        expect(consent.descriptionHtml, contains('/publishers/example.com'));
        expect(consent.descriptionHtml,
            contains('perform administrative actions'));
        consentId = consentRow.consentId;
      });

      final records1 =
          await auditBackend.listRecordsForPublisher('example.com');
      final r1 = records1.firstWhere(
          (e) => e.kind == AuditLogRecordKind.publisherMemberInvited);
      expect(r1.summary,
          '`admin@pub.dev` invited `user@pub.dev` to be a member for publisher `example.com`.');

      await withPubApiClient(
          bearerToken: userAtPubDevAuthToken,
          fn: (client) async {
            final rs = await client.resolveConsent(
                consentId, account_api.ConsentResult(granted: true));
            expect(rs.granted, true);
          });

      final records2 =
          await auditBackend.listRecordsForPublisher('example.com');
      final r2 = records2.firstWhere(
          (e) => e.kind == AuditLogRecordKind.publisherMemberInviteAccepted);
      expect(r2.summary,
          '`user@pub.dev` accepted member invite for publisher `example.com`.');
    });
  });
}
