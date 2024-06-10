// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/account/agent.dart';
import 'package:pub_dev/admin/models.dart';
import 'package:pub_dev/frontend/handlers/report.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/email.dart';

import 'actions.dart';

final createModerationCase = AdminAction(
  name: 'create-moderation-case',
  summary: 'Creates a new moderation case with the specified fields.',
  description: '''
Creates a new moderation case with the provided field values.
Returns the fields on the newly created moderation case.
''',
  options: {
    'reporter-email':
        'The email of the reporter. (default value: `support@pub.dev`)',
    'kind': 'The kind of the moderation case. (default value: `notification`)',
    'source':
        'The source of the moderation case. (default value: `internal-notification`)',
    'subject': 'The subject of the moderation case.',
    'url': 'The url of the moderation case (optional).'
  },
  invoke: (options) async {
    final reporterEmail = options['reporter-email'] ?? KnownAgents.pubSupport;
    InvalidInputException.check(
      isValidEmail(reporterEmail),
      'invalid reporter email',
    );

    final kind = options['kind'] ?? ModerationKind.notification;
    InvalidInputException.check(
        ModerationKind.isValidKind(kind), 'invalid kind');

    final source = options['source'] ?? ModerationSource.notification;
    InvalidInputException.check(
        ModerationSource.isValidSource(source), 'invalid source');

    final subject = options['subject'];
    InvalidInputException.check(
      subject != null && subject.isNotEmpty,
      'invalid subject',
    );
    final parsedSubject = ModerationSubject.tryParse(subject!);
    InvalidInputException.check(parsedSubject != null, 'invalid subject');
    await verifyModerationSubjectExists(parsedSubject!);

    final url = options['url'];

    final mc = await withRetryTransaction(dbService, (tx) async {
      final mc = ModerationCase.init(
        caseId: ModerationCase.generateCaseId(),
        reporterEmail: reporterEmail,
        source: source,
        kind: kind,
        status: ModerationStatus.pending,
        subject: subject,
        isSubjectOwner: false,
        url: url,
        appealedCaseId: null,
      );

      tx.insert(mc);
      return mc;
    });

    return mc.toDebugInfo();
  },
);
