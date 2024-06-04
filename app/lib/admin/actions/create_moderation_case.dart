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
    'status': 'The status of the moderation case. (default value: `pending`)',
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

    final source = options['source'] ?? ModerationSource.internalNotification;
    InvalidInputException.check(
        ModerationSource.isValidSource(source), 'invalid source');

    final status = options['status'] ?? ModerationStatus.pending;
    InvalidInputException.check(
        ModerationStatus.isValidStatus(status), 'invalid status');

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
        status: status,
        subject: subject,
        isSubjectOwner: false,
        url: url,
        appealedCaseId: null,
      );

      tx.insert(mc);
      return mc;
    });

    return {
      'caseId': mc.caseId,
      'reporterEmail': mc.reporterEmail,
      'kind': mc.kind,
      'opened': mc.opened.toIso8601String(),
      if (mc.resolved != null) 'resolved': mc.resolved!.toIso8601String(),
      'source': mc.source,
      'status': mc.status,
      'subject': mc.subject,
      'url': mc.url,
      if (mc.appealedCaseId != null) 'appealedCaseId': mc.appealedCaseId,
      'actionLog': mc.getActionLog().toJson(),
    };
  },
);
