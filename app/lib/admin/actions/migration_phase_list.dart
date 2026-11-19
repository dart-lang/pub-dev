// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/admin/actions/actions.dart';
import 'package:pub_dev/database/migration_phases.dart';

final migrationPhaseList = AdminAction(
  name: 'migration-phase-list',
  summary: 'Lists the Datastore-to-SQL migration phases for tracked entities.',
  description: '''
Lists the active migration phase for every entity tracked in `migration_phases`.

Entities without an explicit row in `migration_phases` default to
`datastore-primary` and have `updatedAt: null`.

Use `migration-phase-set` to change an entity's phase.
''',
  invoke: (options) async {
    final entries = await listMigrationPhases();
    return {
      'phases': [
        for (final entry in entries)
          {
            'entity': entry.entity,
            'phase': entry.phase,
            'updatedAt': entry.updatedAt?.toIso8601String(),
          },
      ],
    };
  },
);
