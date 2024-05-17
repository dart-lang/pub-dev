// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';

import '../../account/agent.dart';
import '../../account/backend.dart';
import '../../package/backend.dart';
import '../../publisher/backend.dart';
import '../../service/email/backend.dart';
import '../../shared/datastore.dart';
import '../../shared/email.dart';

import '../models.dart';
import 'actions.dart';

final sendEmail = AdminAction(
  name: 'send-email',
  summary: 'Send email(s) to the specified recipients.',
  description: '''
Looks up the specified subject's admin emails and/or uses the provided list of
emails to send out messages. Uses the provided `email-subject` and `email-body`
without changing anything in it.
''',
  options: {
    'to':
        'A comma separated list of email addresses or subjects (where the admins will get the emails).',
    'from': 'The email address to impersonate (`support@pub.dev` by default).',
    'subject': 'The subject of the email message.',
    'body': 'The text content of the email body.',
  },
  invoke: (options) async {
    final emailSubject = options['subject'];
    InvalidInputException.check(
      emailSubject != null && emailSubject.isNotEmpty,
      'subject must be given',
    );

    final emailBody = options['body'];
    InvalidInputException.check(
      emailBody != null && emailBody.isNotEmpty,
      'body must be given',
    );

    final from = options['from'] ?? KnownAgents.pubSupport;

    final to = options['to'];
    InvalidInputException.check(
      to != null && to.isNotEmpty,
      'to must be given',
    );

    final emails = <String>{};
    for (final value in to!.split(',')) {
      if (isValidEmail(value)) {
        emails.add(value);
        continue;
      }
      final ms = ModerationSubject.tryParse(value);
      InvalidInputException.check(ms != null, 'Invalid subject: $value');

      switch (ms!.kind) {
        case ModerationSubjectKind.package:
        case ModerationSubjectKind.packageVersion:
          final pkg = await packageBackend.lookupPackage(ms.package!);
          if (pkg!.publisherId != null) {
            final list =
                await publisherBackend.getAdminMemberEmails(ms.publisherId!);
            emails.addAll(list.whereNotNull());
          } else {
            final list = await accountBackend
                .lookupUsersById(pkg.uploaders ?? const <String>[]);
            emails.addAll(list.map((e) => e?.email).whereNotNull());
          }
          break;
        case ModerationSubjectKind.publisher:
          final list =
              await publisherBackend.getAdminMemberEmails(ms.publisherId!);
          emails.addAll(list.whereNotNull());
          break;
        case ModerationSubjectKind.user:
          emails.add(ms.email!);
          break;
        default:
          throw InvalidInputException('Unknown subject kind: ${ms.kind}');
      }
    }

    final emailList = emails.toList()..sort();
    final entity = emailBackend.prepareEntity(EmailMessage(
        EmailAddress(from),
        emailList.map((v) => EmailAddress(v)).toList(),
        emailSubject!,
        emailBody!));
    await withRetryTransaction(dbService, (tx) async {
      tx.insert(entity);
    });
    final sent = await emailBackend.trySendOutgoingEmail(entity);

    return {
      'uuid': entity.uuid,
      'emails': emailList,
      'sent': sent,
    };
  },
);
