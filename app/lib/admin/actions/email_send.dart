// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/service/email/email_sender.dart';
import 'package:pub_dev/shared/utils.dart';

import '../../account/agent.dart';
import '../../account/backend.dart';
import '../../package/backend.dart';
import '../../publisher/backend.dart';
import '../../service/email/email_templates.dart';

import '../models.dart';
import 'actions.dart';

final emailSend = AdminAction(
  name: 'email-send',
  summary: 'Send email(s) to the specified recipients.',
  description: '''
Looks up the specified subject's admin emails and/or uses the provided list of
emails to send out messages. Uses the provided `subject` and `body`
without changing anything in it.

The `to` argument is comma separated list of:
 * emails (e.g. `foo@example.com`),
 * packages (e.g. `package:retry` to email uploaders or publisher members with control of the package),
 * package versions (e.g. `package-version:retry/1.0.0`),
 * publishers (e.g. `publisher:example.com` to email members of the publisher),
 * users (e.g. `user:foo@example.com`).

The list of resolved emails will be deduplicated.
''',
  options: {
    'to': 'A comma separated list of email addresses or subjects '
        '(the recipients of the messages).',
    'cc': '(optional) same as "to" with addresses that will be CC-d.',
    'from': 'The email address to impersonate (`support@pub.dev` by default).',
    'subject': 'The subject of the email message.',
    'body': 'The text content of the email body.',
    'in-reply-to':
        '(optional) The local message id of the email that this is a reply to '
            '(e.g. moderation case id). The email sender will the `In-Reply-To` and `References` '
            'headers with the `<local-id>@pub.dev` value, referencing an earlier `Message-Id`.',
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
    final cc = options['cc'];
    final inReplyTo = options['in-reply-to'];

    final emailList = await _resolveEmails(to!);
    final ccEmailList = cc == null ? null : await _resolveEmails(cc);

    try {
      await emailSender.sendMessage(EmailMessage(
        localMessageId: createUuid(),
        EmailAddress(from),
        emailList.map((v) => EmailAddress(v)).toList(),
        emailSubject!,
        emailBody!,
        ccRecipients:
            ccEmailList?.map((v) => EmailAddress(v)).toList() ?? const [],
        inReplyToLocalMessageId: inReplyTo,
      ));
      return {
        'emails': emailList,
        if (ccEmailList != null) 'ccEmails': ccEmailList,
        'sent': true,
      };
    } catch (e, st) {
      return {
        'sent': false,
        'error': e.toString(),
        'stackTrace': st.toString(),
      };
    }
  },
);

Future<List<String>> _resolveEmails(String value) async {
  final emails = <String>{};
  for (final val in value.split(',')) {
    final value = val.trim();
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
          emails.addAll(list.nonNulls);
        } else {
          final list = await accountBackend
              .lookupUsersById(pkg.uploaders ?? const <String>[]);
          emails.addAll(list.map((e) => e?.email).nonNulls);
        }
        break;
      case ModerationSubjectKind.publisher:
        final list =
            await publisherBackend.getAdminMemberEmails(ms.publisherId!);
        emails.addAll(list.nonNulls);
        break;
      case ModerationSubjectKind.user:
        emails.add(ms.email!);
        break;
      default:
        throw InvalidInputException('Unknown subject kind: ${ms.kind}');
    }
  }
  return emails.toList()..sort();
}
