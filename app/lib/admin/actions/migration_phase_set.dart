// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/admin/actions/actions.dart';
import 'package:pub_dev/database/migration_phases.dart';

final _validEntities = MigrationEntity.values.map((e) => e.key).join(', ');
final _validPhases = MigrationPhase.values.map((p) => p.key).join(', ');

final migrationPhaseSet = AdminAction(
  name: 'migration-phase-set',
  summary: 'Sets the Datastore-to-SQL migration phase for a tracked entity.',
  description:
      '''
Sets the active migration phase for an entity in `migration_phases`.

Setting an entity to `sql-primary` stops Datastore-to-SQL reconcilers for that
entity on all running application versions (including older `N-1` versions
serving during a `--no-promote` canary, traffic migration, or rollback).

Set an entity to `sql-primary` before deploying a release that switches writes
for that entity to SQL-primary. A single in-flight write straddling the instant
of the phase flip can briefly drift counters (such as `packages.likes_count`),
which the SQL-primary maintenance tasks reconcile. Do **not** revert an entity
back to `datastore-primary` once a release has stopped dual-writing to
Datastore, as re-enabling Datastore-to-SQL reconcilers would delete SQL-only
rows.

Options:
- `entity`: one of $_validEntities (required).
- `phase`: one of $_validPhases (required).

Use `migration-phase-list` to inspect current phases.
''',
  options: {
    'entity': 'Entity name (one of: $_validEntities).',
    'phase': 'Target migration phase (one of: $_validPhases).',
  },
  invoke: (options) async {
    final entityArg = options['entity'];
    InvalidInputException.check(
      entityArg != null && entityArg.isNotEmpty,
      '`entity` is required.',
    );
    final entity = MigrationEntity.tryParse(entityArg!);
    if (entity == null) {
      throw InvalidInputException(
        'Unknown entity `$entityArg`. Must be one of: $_validEntities.',
      );
    }

    final phaseArg = options['phase'];
    InvalidInputException.check(
      phaseArg != null && phaseArg.isNotEmpty,
      '`phase` is required.',
    );
    final phase = MigrationPhase.tryParse(phaseArg!);
    if (phase == null) {
      throw InvalidInputException(
        'Unknown phase `$phaseArg`. Must be one of: $_validPhases.',
      );
    }

    final result = await setMigrationPhase(entity, phase);
    return {
      'entity': entity.key,
      'before': result.previousPhase,
      'after': result.phase,
      'updatedAt': result.updatedAt.toIso8601String(),
    };
  },
);
