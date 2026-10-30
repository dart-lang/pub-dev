// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/admin/actions/actions.dart';
import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:typed_sql/typed_sql.dart';

/// Row counters for each table in the primary schema, keyed by SQL table name.
final _tableCounters = <String, Future<int?> Function(Database<PrimarySchema>)>{
  'audit_log_associations': (db) => db.auditLogAssociations.count().fetch(),
  'audit_log_records': (db) => db.auditLogRecords.count().fetch(),
  'consents': (db) => db.consents.count().fetch(),
  'download_counts': (db) => db.downloadCounts.count().fetch(),
  'global_lock_states': (db) => db.globalLockStates.count().fetch(),
  'moderation_action_logs': (db) => db.moderationActionLogs.count().fetch(),
  'moderation_cases': (db) => db.moderationCases.count().fetch(),
  'neat_task_statuses': (db) => db.neatTaskStatuses.count().fetch(),
  'outgoing_emails': (db) => db.outgoingEmails.count().fetch(),
  'package_likes': (db) => db.packageLikes.count().fetch(),
  'package_tombstones': (db) => db.packageTombstones.count().fetch(),
  'package_uploaders': (db) => db.packageUploaders.count().fetch(),
  'package_version_assets': (db) => db.packageVersionAssets.count().fetch(),
  'package_versions': (db) => db.packageVersions.count().fetch(),
  'packages': (db) => db.packages.count().fetch(),
  'publisher_members': (db) => db.publisherMembers.count().fetch(),
  'publishers': (db) => db.publishers.count().fetch(),
  'reserved_packages': (db) => db.reservedPackages.count().fetch(),
  'security_advisories': (db) => db.securityAdvisories.count().fetch(),
  'security_advisory_packages': (db) =>
      db.securityAdvisoryPackages.count().fetch(),
  'task_aborted_tokens': (db) => db.taskAbortedTokens.count().fetch(),
  'task_dependencies': (db) => db.taskDependencies.count().fetch(),
  'task_versions': (db) => db.taskVersions.count().fetch(),
  'tasks': (db) => db.tasks.count().fetch(),
  'user_sessions': (db) => db.userSessions.count().fetch(),
  'users': (db) => db.users.count().fetch(),
};

final sqlTableSizes = AdminAction(
  name: 'sql-table-sizes',
  summary: 'Queries the row count of the SQL tables.',
  description:
      '''
Returns the exact row count (`SELECT COUNT(*)`) of the selected SQL tables.

Options:
- `table`: the name of one table (required). A trailing `*` matches all tables
  that start with the given prefix (e.g. `package*`, or `*` for all of them).

Available tables: ${_tableCounters.keys.map((k) => '`$k`').join(', ')}.

Exact counts require a full scan, which may be slow on large tables.
''',
  options: {
    'table': 'Name of the table, or a prefix ending with `*` (required).',
  },
  invoke: (options) async {
    final name = options['table'];
    InvalidInputException.check(
      name != null && name.isNotEmpty,
      '`table` is required.',
    );
    final List<String> names;
    if (name!.endsWith('*')) {
      final prefix = name.substring(0, name.length - 1);
      names = _tableCounters.keys.where((k) => k.startsWith(prefix)).toList();
    } else {
      names = _tableCounters.containsKey(name) ? [name] : [];
    }
    if (names.isEmpty) {
      throw NotFoundException.resource(name);
    }
    final sizes = <String, int>{};
    for (final n in names) {
      final count = await primaryDatabase.withRetry(_tableCounters[n]!);
      sizes[n] = count ?? 0;
    }
    return {'table': name, 'sizes': sizes};
  },
);
