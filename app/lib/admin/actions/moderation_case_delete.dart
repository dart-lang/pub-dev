// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/admin/models.dart';
import 'package:pub_dev/shared/datastore.dart';

import 'actions.dart';

final moderationCaseDelete = AdminAction(
  name: 'moderation-case-delete',
  summary: 'Deletes a moderation case.',
  description: '''
Deletes a moderation case.
''',
  options: {
    'case': 'The caseId to be deleted.',
  },
  invoke: (options) async {
    final caseId = options['case'];
    InvalidInputException.check(
      caseId != null && caseId.isNotEmpty,
      'case must be given',
    );

    await withRetryTransaction(dbService, (tx) async {
      final mc = await tx.lookupOrNull<ModerationCase>(
          dbService.emptyKey.append(ModerationCase, id: caseId));
      if (mc != null) {
        tx.delete(mc.key);
      } else {
        throw NotFoundException.resource(caseId!);
      }
    });

    return {
      'deleted': true,
    };
  },
);
