// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/admin/actions/actions.dart';
import 'package:pub_dev/database/database.dart';

/// Scripts that can be tested with the `migrate-dry-run` action.
///
/// Each script runs in its own transaction that is always rolled back. Do not
/// add statements that cannot run in a transaction (e.g. `CONCURRENTLY`,
/// `VACUUM`), or that control the transaction (`BEGIN`, `COMMIT`...).
const migrateDryRunScripts = <String, String>{
  // Fails if any user_sessions.user_id has no matching users.user_id row.
  // NULL user_id values are allowed (anonymous sessions).
  'user-sessions-fk-user': '''
ALTER TABLE "user_sessions"
  ADD CONSTRAINT "user_sessions_fk_user"
  FOREIGN KEY ("user_id") REFERENCES "users" ("user_id")
  ON UPDATE CASCADE ON DELETE CASCADE;
''',
  // Fails if any package_version_assets row has no matching package_versions
  // row (which also implies a matching packages row).
  'package-version-assets-fk-version': '''
ALTER TABLE "package_version_assets"
  ADD CONSTRAINT "package_version_assets_fk_package_version"
  FOREIGN KEY ("package", "version")
  REFERENCES "package_versions" ("package", "version")
  ON UPDATE CASCADE ON DELETE CASCADE;
''',
  // Fails if any package_version_assets.package has no matching packages row.
  'package-version-assets-fk-package': '''
ALTER TABLE "package_version_assets"
  ADD CONSTRAINT "package_version_assets_fk_package"
  FOREIGN KEY ("package") REFERENCES "packages" ("name")
  ON UPDATE CASCADE ON DELETE CASCADE;
''',
};

final migrateDryRun = AdminAction(
  name: 'migrate-dry-run',
  summary:
      'Tests predefined DDL scripts against the database, then rolls back.',
  description:
      '''
Executes predefined DDL scripts against the SQL database, each in its own
transaction that is **always rolled back**. Nothing is persisted: the action
only reports whether the script would run successfully on the current data.

Options:
- `script`: the name of one predefined script (required).

Available scripts: ${migrateDryRunScripts.keys.map((k) => '`$k`').join(', ')}.

DDL takes table locks that are held until the rollback. The transaction uses a
3s `lock_timeout` and a 30s `statement_timeout`, so a busy table makes the
script fail fast (and report the timeout) instead of blocking other queries.
A lock timeout is not a problem with the script itself: retry at a different time.
''',
  options: {'script': 'Name of the script to test (required).'},
  invoke: (options) async {
    final name = options['script'];
    InvalidInputException.check(
      name != null && name.isNotEmpty,
      '`script` is required.',
    );
    final sql = migrateDryRunScripts[name];
    if (sql == null) {
      throw NotFoundException.resource(name!);
    }

    final sw = Stopwatch()..start();
    final error = await primaryDatabase.migrateDryRun(sql);
    return {
      'rolledBack': true,
      'script': name,
      'ok': error == null,
      'error': ?error,
      'durationMs': sw.elapsedMilliseconds,
    };
  },
);
