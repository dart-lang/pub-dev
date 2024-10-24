// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/search/search_form.dart';
import 'package:clock/clock.dart';
import 'package:pub_dev/admin/models.dart';
import 'package:pub_dev/shared/datastore.dart';

import 'actions.dart';

final moderationCaseList = AdminAction(
  name: 'moderation-case-list',
  summary: 'List ModerationCase entities.',
  description: '''
List ModerationCase entities with filter options.
''',
  options: {
    'sort': 'Sort by the given attribute: `opened` (default), `resolved`.',
    'status': '`pending` | `resolved` | '
        '${ModerationStatus.resolveValues.map((v) => '`$v`').join(' | ')}',
    'kind': '`appeal` | `notification`',
    'subject': 'The (substring of) the subject on the moderation case.',
    'density': '`caseIds` (default) | `compact` | `expanded`',
    'past':
        'Limit the results opened (or resolved depending on `sort`) using "2w" or other time ranges.'
  },
  invoke: (options) async {
    final sort = options['sort'] ?? 'opened';
    final status = options['status'];
    final kind = options['kind'];
    final subject = options['subject'];
    final density = options['density'] ?? 'caseIds';
    final past = options['past'];
    final pastDuration = past == null ? null : parseTime(past);

    final query = dbService.query<ModerationCase>();
    switch (sort) {
      case 'opened':
        query.order('-opened');
        break;
      case 'resolved':
        query.order('-resolved');
        break;
      default:
        throw InvalidInputException('invalid sort value');
    }

    final list = await query.run().where((mc) {
      if (status == 'resolved' && mc.status == ModerationStatus.pending) {
        return false;
      }
      if (status != 'resolved' && mc.status != status) {
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
        if (sort == 'opened' && now.difference(mc.opened) > pastDuration) {
          return false;
        }
        if (sort == 'resolved' &&
            (mc.resolved == null ||
                now.difference(mc.resolved!) > pastDuration)) {
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
        return {'cases': list.map((e) => e.toDebugInfo()).toList()};
      default:
        throw InvalidInputException('invalid density value');
    }
  },
);
