// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';
import 'package:test/test.dart';

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/consent_backend.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/audit/backend.dart';
import 'package:pub_dev/audit/models.dart';

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

      await accountBackend.withBearerToken(userAtPubDevAuthToken, () async {
        final consentRow = await dbService.query<Consent>().run().single;
        final consent = await consentBackend.getConsent(
            consentRow.consentId, await requireAuthenticatedUser());
        expect(consent.descriptionHtml, contains('/packages/oxygen'));
        expect(consent.descriptionHtml, contains('publish new versions'));
      });

      final auditLogRecords =
          await auditBackend.listRecordsForPackage('oxygen');
      final auditLog = auditLogRecords
          .firstWhere((e) => e.kind == AuditLogRecordKind.uploadedInvited);
      expect(auditLog.summary,
          '`admin@pub.dev` invited `user@pub.dev` to be an uploader for package `oxygen`.');
    });

    testWithProfile('Publisher contact', fn: () async {
      await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
        final status = await consentBackend.invitePublisherContact(
          publisherId: exampleComPublisher.publisherId,
          contactEmail: 'info@example.com',
        );
        expect(status.emailSent, isTrue);
      });

      await accountBackend.withBearerToken(userAtPubDevAuthToken, () async {
        final consentRow = await dbService.query<Consent>().run().single;
        final consent = await consentBackend.getConsent(
            consentRow.consentId, await requireAuthenticatedUser());
        expect(consent.descriptionHtml, contains('/publishers/example.com'));
        expect(consent.descriptionHtml, contains('contact email means'));
      });

      final auditLogRecords = await auditBackend
          .listRecordsForPublisher(exampleComPublisher.publisherId);
      final auditLog = auditLogRecords.firstWhere(
          (e) => e.kind == AuditLogRecordKind.publisherContactInvited);
      expect(auditLog.summary,
          '`admin@pub.dev` invited `info@example.com` to be contact email for publisher `example.com`.');
    });

    testWithProfile('Publisher member', fn: () async {
      await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
        final status = await consentBackend.invitePublisherMember(
          publisherId: exampleComPublisher.publisherId,
          invitedUserEmail: 'user@pub.dev',
        );
        expect(status.emailSent, isTrue);
      });

      await accountBackend.withBearerToken(userAtPubDevAuthToken, () async {
        final consentRow = await dbService.query<Consent>().run().single;
        final consent = await consentBackend.getConsent(
            consentRow.consentId, await requireAuthenticatedUser());
        expect(consent.descriptionHtml, contains('/publishers/example.com'));
        expect(consent.descriptionHtml,
            contains('perform administrative actions'));
      });

      final auditLogRecords = await auditBackend
          .listRecordsForPublisher(exampleComPublisher.publisherId);
      final auditLog = auditLogRecords.firstWhere(
          (e) => e.kind == AuditLogRecordKind.publisherMemberInvited);
      expect(auditLog.summary,
          '`admin@pub.dev` invited `user@pub.dev` to be a member for publisher `example.com`.');
    });
  });
}
