// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/admin/backend.dart';
import 'package:pub_dev/admin/models.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/email.dart';

import 'actions.dart';

final moderationCaseUpdate = AdminAction(
  name: 'moderation-case-update',
  summary: 'Updates the moderation case fields.',
  description: '''
Updates the moderation case fields with the provided values.
Returns the fields of the updated moderation case.
''',
  options: {
    'case': 'The caseId to be updated.',
    'reporter-email': 'The email of the reporter (optional).',
    'kind': 'The kind of the moderation case (optional).',
    'source': 'The source of the moderation case (optional).',
    'status': 'The status of the moderation case (optional).',
  },
  invoke: (options) async {
    final caseId = options['case'];
    InvalidInputException.check(
      caseId != null && caseId.isNotEmpty,
      'case must be given',
    );

    final reporterEmail = options['reporter-email'];
    InvalidInputException.check(
      reporterEmail == null || isValidEmail(reporterEmail),
      'invalid reporter email',
    );

    final kind = options['kind'];
    InvalidInputException.check(
      kind == null || ModerationKind.isValidKind(kind),
      'invalid kind',
    );

    final source = options['source'];
    InvalidInputException.check(
      source == null || ModerationSource.isValidSource(source),
      'invalid source',
    );

    final status = options['status'];
    InvalidInputException.check(
      status == null || ModerationStatus.isValidStatus(status),
      'invalid status',
    );

    final mcase = await adminBackend.lookupModerationCase(caseId!);
    if (mcase == null) {
      throw NotFoundException.resource(caseId);
    }

    await withRetryTransaction(dbService, (tx) async {
      final mc = await tx.lookupValue<ModerationCase>(mcase.key);

      mc.kind = kind ?? mc.kind;
      mc.reporterEmail = reporterEmail ?? mc.reporterEmail;
      mc.source = source ?? mc.source;
      mc.status = status ?? mc.status;

      InvalidInputException.check(
        (mc.resolved != null && mc.status != ModerationStatus.pending) ||
            (mc.resolved == null && mc.status == ModerationStatus.pending),
        'resolved timestamp in conflict with status',
      );

      tx.insert(mc);
    });
    final mc = await adminBackend.lookupModerationCase(caseId);

    return mc!.toDebugInfo();
  },
);
