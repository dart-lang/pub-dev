// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:pub_dev/fake/backend/fake_email_sender.dart';
import 'package:pub_dev/service/email/backend.dart';
import 'package:pub_dev/service/email/email_templates.dart';
import 'package:pub_dev/service/email/models.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:test/test.dart';

import '../../shared/test_services.dart';

void main() {
  group('EmailBackend', () {
    testWithProfile('one immediate success + one success on second attempt',
        fn: () async {
      fakeEmailSender.failNextMessageCount = 1;
      final entry = emailBackend.prepareEntity(
        EmailMessage(
          EmailAddress('from@pub.dev'),
          [
            EmailAddress('to1@pub.dev'),
            EmailAddress('to2@pub.dev'),
          ],
          'subj',
          'body',
        ),
      );
      await dbService.commit(inserts: [entry]);
      await emailBackend.trySendOutgoingEmail(entry);
      expect(fakeEmailSender.sentMessages, hasLength(1));
      final email = fakeEmailSender.sentMessages.single;
      expect(email.from.email, 'from@pub.dev');
      expect(email.subject, 'subj');
      expect(email.bodyText, 'body');

      await withClock(Clock.fixed(clock.now().add(Duration(hours: 8))),
          () async {
        expect(await emailBackend.trySendAllOutgoingEmails(), 1);
        expect(fakeEmailSender.sentMessages, hasLength(2));
      });
      expect(await emailBackend.trySendAllOutgoingEmails(), 0);
      expect(fakeEmailSender.sentMessages, hasLength(2));
      expect(
        fakeEmailSender.sentMessages
            .expand((e) => e.recipients.map((a) => a.email))
            .toSet(),
        {
          'to1@pub.dev',
          'to2@pub.dev',
        },
      );
    });

    testWithProfile('only failed attempts', fn: () async {
      fakeEmailSender.failNextMessageCount = 2;
      final entry = emailBackend.prepareEntity(
        EmailMessage(
          EmailAddress('from@pub.dev'),
          [EmailAddress('to@pub.dev')],
          'subj',
          'body',
        ),
      );
      await dbService.commit(inserts: [entry]);

      for (var i = 0; i < 2; i++) {
        await withClock(Clock.fixed(clock.now().add(Duration(hours: i * 8))),
            () async {
          expect(await emailBackend.deleteDeadOutgoingEmails(), 0);
          expect(await emailBackend.trySendAllOutgoingEmails(), 0);
          expect(fakeEmailSender.sentMessages, isEmpty);
        });
      }

      await withClock(Clock.fixed(clock.now().add(Duration(days: 7))),
          () async {
        expect(await emailBackend.trySendAllOutgoingEmails(), 0);
        expect(fakeEmailSender.sentMessages, isEmpty);
        expect(await emailBackend.deleteDeadOutgoingEmails(), 1);
      });
    });

    testWithProfile('pending claim prevents sending', fn: () async {
      final entry = emailBackend.prepareEntity(
        EmailMessage(
          EmailAddress('from@pub.dev'),
          [
            EmailAddress('to1@pub.dev'),
            EmailAddress('to2@pub.dev'),
          ],
          'subj',
          'body',
        ),
      );
      expect(entry.recipientEmails?.toSet(), {'to1@pub.dev', 'to2@pub.dev'});
      await dbService.commit(inserts: [entry]);

      OutgoingEmail? pending;
      fakeEmailSender.failNextMessageCount = 1;
      await withClock(Clock.fixed(clock.now().add(Duration(hours: 1))),
          () async {
        expect(await emailBackend.trySendAllOutgoingEmails(), 1);
        expect(await emailBackend.deleteDeadOutgoingEmails(), 0);
        pending = await dbService.lookupValue<OutgoingEmail>(entry.key);
        expect(pending!.recipientEmails, hasLength(1));
      });

      // emails on a claimed entry won't be sent out
      await withClock(Clock.fixed(clock.now().add(Duration(hours: 3))),
          () async {
        pending!.claimId = 'claim-uuid';
        await dbService.commit(inserts: [pending!]);
        expect(await emailBackend.trySendAllOutgoingEmails(), 0);
        expect(await emailBackend.deleteDeadOutgoingEmails(), 0);
      });

      // eventually it gets deleted
      await withClock(Clock.fixed(clock.now().add(Duration(hours: 12))),
          () async {
        expect(await emailBackend.trySendAllOutgoingEmails(), 0);
        expect(await emailBackend.deleteDeadOutgoingEmails(), 1);
      });
    });
  });
}
