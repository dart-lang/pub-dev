// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:pub_dev/admin/models.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/utils.dart';

import 'actions.dart';

final moderationCaseResolve = AdminAction(
  name: 'moderation-case-resolve',
  summary: 'Closes the moderation case and resolves a final status.',
  description: '''
Closes the moderation case and updates the status based on the actions logged on the case.
''',
  options: {
    'case': 'The caseId to be closed.',
    'status': 'The resolved status of the case '
        '(optional, will be automatically inferred if absent). '
        'One of: ${ModerationStatus.resolveValues.join(', ')}.',
    'grounds': 'The grounds for the moderation actions '
        '(if moderation action was taken). '
        'One of: ${ModerationGrounds.resolveValues.join(', ')}.',
    'violation': 'The high-level category of the violation reason '
        '(if moderation action was taken). '
        'One of: ${ModerationViolation.violationValues.join(', ')}.',
    'reason': 'The text from SOR statement sent to the user '
        '(if moderation action was taken).',
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

    final grounds = options['grounds']?.trimToNull() ?? ModerationGrounds.none;
    final violation =
        options['violation']?.trimToNull() ?? ModerationViolation.none;
    final reason = options['reason']?.trimToNull();

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

      final hasModeratedAction = mc.getActionLog().isNotEmpty;

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
              appealedCase.getActionLog().isNotEmpty;
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

      if (ModerationStatus.wasModerationApplied(status!)) {
        InvalidInputException.checkNotNull(grounds, 'grounds');
        InvalidInputException.checkAnyOf(
          grounds,
          'grounds',
          ModerationGrounds.resolveValues,
        );

        InvalidInputException.checkNotNull(violation, 'violation');
        InvalidInputException.checkAnyOf(
          violation,
          'violation',
          ModerationViolation.violationValues,
        );

        InvalidInputException.checkNotNull(reason, 'reason');
        InvalidInputException.checkStringLength(reason, 'reason', minimum: 10);
      } else {
        InvalidInputException.check(
            grounds == ModerationGrounds.none, '"grounds" must be `none`');
        InvalidInputException.check(violation == ModerationViolation.none,
            '"violation" must be `none`');
        InvalidInputException.checkNull(reason, 'reason');
      }

      mc.status = status!;
      mc.violation = violation;
      mc.reason = reason;
      tx.insert(mc);
      return mc;
    });

    return mc.toDebugInfo();
  },
);
