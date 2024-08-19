// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/admin/models.dart';
import 'package:pub_dev/shared/datastore.dart';

import 'actions.dart';

final moderationCasesList = AdminAction(
  name: 'moderation-cases-list',
  summary: 'List the currently active (or resolved) ModerationCase entities.',
  description: '''
List the ModerationCase entities with filter options. 
''',
  options: {
    'sort': 'Sort by the given attribute: `opened` (default), `resolved`.',
  },
  invoke: (options) async {
    final sort = options['sort'] ?? 'opened';
    final query = dbService.query<ModerationCase>()..limit(20);

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

    final list = await query.run().toList();
    return {
      'cases': list.map((e) => e.toDebugInfo()).toList(),
    };
  },
);
