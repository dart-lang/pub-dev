// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:test/test.dart';

import 'package:pub_dev/account/consent_backend.dart';
import 'package:pub_dev/account/models.dart';

import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('Uploader invite', () {
    testWithServices('Uploader invite', () async {
      registerAuthenticatedUser(hansUser);
      final status = await consentBackend.invitePackageUploader(
        uploaderUserId: joeUser.userId,
        uploaderEmail: joeUser.email,
        packageName: hydrogen.package.name,
      );
      expect(status.emailSent, isTrue);

      final consentRow = await dbService.query<Consent>().run().single;
      final consent =
          await consentBackend.getConsent(consentRow.consentId, joeUser);
      expect(consent.descriptionHtml, contains('/packages/hydrogen'));
      expect(consent.descriptionHtml, contains('publish new versions'));
    });

    testWithServices('Publisher contact', () async {
      registerAuthenticatedUser(hansUser);
      final status = await consentBackend.invitePublisherContact(
        publisherId: exampleComPublisher.publisherId,
        contactEmail: joeUser.email,
      );
      expect(status.emailSent, isTrue);

      final consentRow = await dbService.query<Consent>().run().single;
      final consent =
          await consentBackend.getConsent(consentRow.consentId, joeUser);
      expect(consent.descriptionHtml, contains('/publishers/example.com'));
      expect(consent.descriptionHtml, contains('contact email means'));
    });

    testWithServices('Publisher member', () async {
      registerAuthenticatedUser(hansUser);
      final status = await consentBackend.invitePublisherMember(
        publisherId: exampleComPublisher.publisherId,
        invitedUserId: joeUser.userId,
        invitedUserEmail: joeUser.email,
      );
      expect(status.emailSent, isTrue);

      final consentRow = await dbService.query<Consent>().run().single;
      final consent =
          await consentBackend.getConsent(consentRow.consentId, joeUser);
      expect(consent.descriptionHtml, contains('/publishers/example.com'));
      expect(
          consent.descriptionHtml, contains('perform administrative actions'));
    });
  });
}
