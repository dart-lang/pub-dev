// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/search/search_form.dart';
import 'package:clock/clock.dart';
import 'package:pub_dev/admin/backend.dart';
import 'package:pub_dev/admin/models.dart' hide ModerationActionLog;
import 'package:pub_dev/database/schema.dart';
import 'package:typed_sql/typed_sql.dart';

import 'actions.dart';

final moderationCaseList = AdminAction(
  name: 'moderation-case-list',
  summary: 'List ModerationCase entities.',
  description: '''
List ModerationCase entities with filter options.
''',
  options: {
    'sort': 'Sort by the given attribute: `opened` (default), `resolved`.',
    'status':
        '`pending` | `resolved` | '
        '${ModerationStatus.resolveValues.map((v) => '`$v`').join(' | ')}',
    'kind': '`appeal` | `notification`',
    'subject': 'The (substring of) the subject on the moderation case.',
    'density': '`caseIds` (default) | `compact` | `expanded`',
    'past':
        'Limit the results opened (or resolved depending on `sort`) using "2w" or other time ranges.',
  },
  invoke: (options) async {
    final sort = options['sort'] ?? 'opened';
    final status = options['status'];
    final kind = options['kind'];
    final subject = options['subject'];
    final density = options['density'] ?? 'caseIds';
    final past = options['past'];
    final pastDuration = past == null ? null : parseTime(past);

    InvalidInputException.check(
      sort == 'opened' || sort == 'resolved',
      'invalid sort value',
    );
    final rows = await adminBackend.fetchModerationCasesWithLogs(
      orderBy: (c) => [
        if (sort == 'resolved') (c.resolvedAt, Order.descending),
        (c.openedAt, Order.descending),
      ],
    );
    final logsByCase = {for (final (c, l) in rows) c.caseId: l};

    final list = rows.map((r) => r.$1).where((mc) {
      if (status == 'resolved' && mc.status == ModerationStatus.pending) {
        return false;
      }
      if (status != null && status != 'resolved' && mc.status != status) {
        return false;
      }
      if (kind != null && mc.kind != kind) {
        return false;
      }
      if (subject != null && !mc.subject.contains(subject)) {
        return false;
      }
      final now = clock.now();
      if (pastDuration != null) {
        if (sort == 'opened' && now.difference(mc.openedAt) > pastDuration) {
          return false;
        }
        if (sort == 'resolved' &&
            (mc.resolvedAt == null ||
                now.difference(mc.resolvedAt!) > pastDuration)) {
          return false;
        }
      }
      return true;
    }).toList();

    switch (density) {
      case 'caseIds':
        return {'caseIds': list.map((e) => e.caseId).toList()};
      case 'compact':
        return {'cases': list.map((e) => e.toCompactInfo()).toList()};
      case 'expanded':
        return {
          'cases': [for (final e in list) e.toDebugInfo(logsByCase[e.caseId]!)],
        };
      default:
        throw InvalidInputException('invalid density value');
    }
  },
);
