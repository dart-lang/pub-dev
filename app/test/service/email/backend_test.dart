// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:pub_dev/fake/backend/fake_email_sender.dart';
import 'package:pub_dev/service/email/backend.dart';
import 'package:pub_dev/service/email/email_templates.dart';
import 'package:pub_dev/service/email/models.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:test/test.dart';
import 'package:typed_sql/typed_sql.dart';

import '../../shared/test_services.dart';

OutgoingEmail _testEmail() => emailBackend.prepareEntity(
  createInviteEmail(
    invitedEmail: 'recipient@pub.dev',
    subject: 'subject',
    inviteText: 'invite text',
    consentUrl: 'https://pub.dev/consent',
  ),
);

void main() {
  group('SQL mirror', () {
    testWithProfile(
      'trySendOutgoingEmail mirrors the claim, then deletes the row on success',
      fn: () async {
        final email = _testEmail();
        await dbService.commit(inserts: [email]);

        final sent = await emailBackend.trySendOutgoingEmail(email);
        expect(sent, 1);

        final row = await primaryDatabase.withRetry(
          (db) => db.outgoingEmails.byKey(email.uuid).fetch(),
        );
        expect(row, isNull);
      },
    );

    testWithProfile(
      'trySendOutgoingEmail mirrors the updated row after a failed attempt',
      fn: () async {
        fakeEmailSender.failNextMessageCount = 1;
        final email = _testEmail();
        await dbService.commit(inserts: [email]);

        final sent = await emailBackend.trySendOutgoingEmail(email);
        expect(sent, 0);

        final row = await primaryDatabase.withRetry(
          (db) => db.outgoingEmails.byKey(email.uuid).fetch(),
        );
        expect(row, isNotNull);
        expect(row!.attempts, 1);
        expect(row.claimId, isNull);
        expect(row.fromEmail, email.fromEmail);
      },
    );

    testWithProfile(
      'deleteDeadOutgoingEmails removes dead rows in bulk',
      fn: () async {
        final email = _testEmail()..attempts = outgoingEmailMaxAttempts;
        await dbService.commit(inserts: [email]);
        await emailBackend.mirrorToSql(email);

        expect(
          await primaryDatabase.withRetry(
            (db) => db.outgoingEmails.byKey(email.uuid).fetch(),
          ),
          isNotNull,
        );

        await emailBackend.deleteDeadOutgoingEmails();

        expect(
          await primaryDatabase.withRetry(
            (db) => db.outgoingEmails.byKey(email.uuid).fetch(),
          ),
          isNull,
        );
      },
    );

    testWithProfile(
      'deleteDeadOutgoingEmails removes rows with an expired claim',
      fn: () async {
        final email = _testEmail()
          ..claimId = 'claim'
          ..lastAttempted = clock.now().toUtc().subtract(
            outgoingEmailClaimExpiration + Duration(minutes: 1),
          );
        await dbService.commit(inserts: [email]);
        await emailBackend.mirrorToSql(email);

        await emailBackend.deleteDeadOutgoingEmails();

        expect(
          await primaryDatabase.withRetry(
            (db) => db.outgoingEmails.byKey(email.uuid).fetch(),
          ),
          isNull,
        );
      },
    );

    testWithProfile(
      'backfillSqlFromDatastore copies missing rows',
      fn: () async {
        final email = _testEmail();
        await dbService.commit(inserts: [email]);

        expect(
          await primaryDatabase.withRetry(
            (db) => db.outgoingEmails.byKey(email.uuid).fetch(),
          ),
          isNull,
        );

        final count = await emailBackend.backfillSqlFromDatastore();
        expect(count, greaterThanOrEqualTo(1));

        expect(
          await primaryDatabase.withRetry(
            (db) => db.outgoingEmails.byKey(email.uuid).fetch(),
          ),
          isNotNull,
        );
      },
    );
  });
}
