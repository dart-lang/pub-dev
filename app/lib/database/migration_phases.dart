// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:typed_sql/typed_sql.dart';

final _logger = Logger('migration_phases');

/// Entities whose Datastore-to-SQL migration phase is tracked in
/// `migration_phases`.
enum MigrationEntity {
  users('users'),
  securityAdvisories('security_advisories'),
  publishers('publishers'),
  packages('packages'),
  packageVersionAssets('package_version_assets'),
  packageLikes('package_likes'),
  moderationCases('moderation_cases');

  /// The primary key stored in `migration_phases.entity`, matching the primary
  /// SQL table name.
  final String key;

  const MigrationEntity(this.key);

  /// Parses [value] into a [MigrationEntity], or returns `null` if unknown.
  static MigrationEntity? tryParse(String value) {
    for (final entity in values) {
      if (entity.key == value) return entity;
    }
    return null;
  }
}

/// Active Datastore-to-SQL migration phase for a [MigrationEntity].
enum MigrationPhase {
  /// Datastore is the source of truth; Datastore-to-SQL mirrors and
  /// reconcilers are active.
  datastorePrimary('datastore-primary'),

  /// SQL is the source of truth; Datastore-to-SQL reconcilers must not modify
  /// or delete SQL rows.
  sqlPrimary('sql-primary');

  /// The string stored in `migration_phases.phase`.
  final String key;

  const MigrationPhase(this.key);

  /// Parses [value] into a [MigrationPhase], or returns `null` if unknown.
  static MigrationPhase? tryParse(String value) {
    for (final phase in values) {
      if (phase.key == value) return phase;
    }
    return null;
  }
}

/// Effective migration phase status for one entity in `migration_phases`.
typedef MigrationPhaseEntry = ({
  String entity,
  String phase,
  DateTime? updatedAt,
});

/// Helpers for reading `migration_phases` inside an active [Database] scope.
extension MigrationPhaseDatabaseExt on Database<PrimarySchema> {
  /// Returns whether [entity] is currently in
  /// [MigrationPhase.datastorePrimary].
  ///
  /// When no row exists in `migration_phases` for [entity], defaults to `true`
  /// (`datastore-primary`). Any stored value other than `datastore-primary` —
  /// including unrecognized phases written by newer releases — returns `false`
  /// (fail-closed) so older versions never re-enable Datastore-to-SQL
  /// reconciliation after a cutover.
  Future<bool> isDatastorePrimary(MigrationEntity entity) async {
    final row = await migrationPhases.byKey(entity.key).fetch();
    if (row == null) {
      return true;
    }
    if (row.phase == MigrationPhase.datastorePrimary.key) {
      return true;
    }
    if (MigrationPhase.tryParse(row.phase) == null) {
      _logger.warning(
        'Unknown migration phase "${row.phase}" for "${entity.key}"; '
        'treating as non-datastore-primary.',
      );
    }
    return false;
  }
}

/// Returns whether [entity] is currently in [MigrationPhase.datastorePrimary].
///
/// See [MigrationPhaseDatabaseExt.isDatastorePrimary] for default and
/// fail-closed semantics.
Future<bool> isDatastorePrimary(MigrationEntity entity) {
  return primaryDatabase.withRetry((db) => db.isDatastorePrimary(entity));
}

/// Lists the effective migration phase of every known [MigrationEntity],
/// followed by any extra rows present in `migration_phases`.
Future<List<MigrationPhaseEntry>> listMigrationPhases() async {
  final rows = await primaryDatabase.withRetry(
    (db) => db.migrationPhases.fetch(),
  );
  final byEntity = {for (final row in rows) row.entity: row};
  final result = <MigrationPhaseEntry>[];
  for (final entity in MigrationEntity.values) {
    final row = byEntity.remove(entity.key);
    result.add((
      entity: entity.key,
      phase: row?.phase ?? MigrationPhase.datastorePrimary.key,
      updatedAt: row?.updatedAt,
    ));
  }
  final extraKeys = byEntity.keys.toList()..sort();
  for (final key in extraKeys) {
    final row = byEntity[key]!;
    result.add((
      entity: row.entity,
      phase: row.phase,
      updatedAt: row.updatedAt,
    ));
  }
  return result;
}

/// Updates the migration phase of [entity] to [phase], returning the previous
/// effective phase, the new phase, and the update timestamp.
Future<({String previousPhase, String phase, DateTime updatedAt})>
setMigrationPhase(MigrationEntity entity, MigrationPhase phase) {
  return primaryDatabase.transactWithRetry((db) async {
    final existing = await db.migrationPhases.byKey(entity.key).fetch();
    final previousPhase =
        existing?.phase ?? MigrationPhase.datastorePrimary.key;
    final now = clock.now().toUtc();
    await db.migrationPhases
        .upsertValue(entity: entity.key, phase: phase.key, updatedAt: now)
        .execute();
    return (previousPhase: previousPhase, phase: phase.key, updatedAt: now);
  });
}
