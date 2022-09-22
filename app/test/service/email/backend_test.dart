// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:pub_dev/fake/backend/fake_email_sender.dart';
import 'package:pub_dev/service/email/backend.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/email.dart';
import 'package:test/test.dart';

import '../../shared/test_services.dart';

void main() {
  group('EmailBackend', () {
    testWithProfile('one immediate success + one success on second attempt',
        fn: () async {
      fakeEmailSender.failNextMessageCount = 1;
      final entries = emailBackend.prepareEntities(
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
      await dbService.commit(inserts: entries);
      await emailBackend.trySendOutgoingEmails(entries);
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
      final entries = emailBackend.prepareEntities(
        EmailMessage(
          EmailAddress('from@pub.dev'),
          [EmailAddress('to@pub.dev')],
          'subj',
          'body',
        ),
      );
      await dbService.commit(inserts: entries);

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
  });
}
