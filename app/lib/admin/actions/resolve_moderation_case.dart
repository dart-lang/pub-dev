// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:pub_dev/admin/models.dart';
import 'package:pub_dev/shared/datastore.dart';

import 'actions.dart';

final resolveModerationCase = AdminAction(
  name: 'resolve-moderation-case',
  summary: 'Closes the moderation case and resolves a final status.',
  description: '''
Closes the moderation case and updates the status based on the actions logged on the case.
''',
  options: {
    'case': 'The caseId to be closed.',
    'status':
        'The resolved status of the case. (optional, will be automatically inferred if absent)'
  },
  invoke: (options) async {
    final caseId = options['case'];
    InvalidInputException.check(
      caseId != null && caseId.isNotEmpty,
      'case must be given',
    );

    var status = options['status'];
    InvalidInputException.check(
      status == null ||
          (status != ModerationStatus.pending &&
              ModerationStatus.isValidStatus(status)),
      'invalid status',
    );

    final mc = await withRetryTransaction(dbService, (tx) async {
      final mc = await tx.lookupOrNull<ModerationCase>(
          dbService.emptyKey.append(ModerationCase, id: caseId!));
      if (mc == null) {
        throw NotFoundException.resource(caseId);
      }
      if (mc.status != ModerationStatus.pending) {
        throw InvalidInputException('ModerationCase is already closed.');
      }

      mc.resolved = clock.now().toUtc();

      final hasModeratedAction = mc.getActionLog().hasModeratedAction();

      if (status == null) {
        if (mc.kind == ModerationKind.notification) {
          status = hasModeratedAction
              ? ModerationStatus.moderationApplied
              : ModerationStatus.noAction;
        } else if (mc.kind == ModerationKind.appeal) {
          final appealedCase = await tx.lookupValue<ModerationCase>(dbService
              .emptyKey
              .append(ModerationCase, id: mc.appealedCaseId!));
          final appealHadModeratedAction =
              appealedCase.getActionLog().hasModeratedAction();
          if (appealHadModeratedAction) {
            status = hasModeratedAction
                ? ModerationStatus.moderationReverted
                : ModerationStatus.moderationUpheld;
          } else {
            status = hasModeratedAction
                ? ModerationStatus.noActionReverted
                : ModerationStatus.noActionUpheld;
          }
        } else {
          throw UnimplementedError('Kind "${mc.kind}" is not implemented.');
        }
      }

      mc.status = status!;
      tx.insert(mc);
      return mc;
    });

    return mc.toDebugInfo();
  },
);
