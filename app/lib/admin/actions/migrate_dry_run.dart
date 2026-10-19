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
  // Fails if notification_count is negative.
  'consents-chk-count': '''
ALTER TABLE "consents"
  ADD CONSTRAINT "consents_chk_count"
  CHECK (notification_count >= 0);
''',
  // Fails if two consents share the same dedup_id.
  'consents-unique-dedup-id': '''
ALTER TABLE "consents"
  ADD CONSTRAINT "consents_unique_dedup_id" UNIQUE ("dedup_id");
''',
  // Fails if any download_counts.package has no matching packages row.
  'download-counts-fk-package': '''
ALTER TABLE "download_counts"
  ADD CONSTRAINT "download_counts_fk_package"
  FOREIGN KEY ("package") REFERENCES "packages" ("name")
  ON UPDATE CASCADE ON DELETE CASCADE;
''',
  // Fails if a case was resolved before it was opened.
  'moderation-cases-chk-resolved': '''
ALTER TABLE "moderation_cases"
  ADD CONSTRAINT "moderation_cases_chk_resolved"
  CHECK (resolved_at IS NULL OR resolved_at >= opened_at);
''',
  // Fails if any appealed_case_id has no matching moderation_cases row.
  'moderation-cases-fk-appealed': '''
ALTER TABLE "moderation_cases"
  ADD CONSTRAINT "moderation_cases_fk_appealed"
  FOREIGN KEY ("appealed_case_id") REFERENCES "moderation_cases" ("case_id");
''',
  // Fails if any package_version_assets.package has no matching packages row.
  'package-version-assets-fk-package': '''
ALTER TABLE "package_version_assets"
  ADD CONSTRAINT "package_version_assets_fk_package"
  FOREIGN KEY ("package") REFERENCES "packages" ("name")
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
  // Fails if a moderated / admin-deleted / retracted version lacks its
  // timestamp.
  'package-versions-chk-flags': '''
ALTER TABLE "package_versions"
  ADD CONSTRAINT "package_versions_chk_flags"
  CHECK ((NOT is_moderated OR moderated_at IS NOT NULL)
     AND (NOT is_admin_deleted OR admin_deleted_at IS NOT NULL)
     AND (NOT is_retracted OR retracted_at IS NOT NULL));
''',
  // Fails if any sha256 is not a 32-byte digest.
  'package-versions-chk-sha256': '''
ALTER TABLE "package_versions"
  ADD CONSTRAINT "package_versions_chk_sha256"
  CHECK (sha256 IS NULL OR octet_length(sha256) = 32);
''',
  // Fails if a moderated / admin-deleted package lacks its timestamp, or if
  // a counter is negative.
  'packages-chk-flags': '''
ALTER TABLE "packages"
  ADD CONSTRAINT "packages_chk_flags"
  CHECK ((NOT is_moderated OR moderated_at IS NOT NULL)
     AND (NOT is_admin_deleted OR admin_deleted_at IS NOT NULL)
     AND versions_count >= 0 AND likes_count >= 0);
''',
  // Fails if packages.latest_version has no matching package_versions row.
  'packages-fk-latest-version': '''
ALTER TABLE "packages"
  ADD CONSTRAINT "packages_fk_latest_version"
  FOREIGN KEY ("name", "latest_version")
  REFERENCES "package_versions" ("package", "version");
''',
  // Fails if any packages.publisher_id has no matching publishers row.
  'packages-fk-publisher': '''
ALTER TABLE "packages"
  ADD CONSTRAINT "packages_fk_publisher"
  FOREIGN KEY ("publisher_id") REFERENCES "publishers" ("publisher_id")
  ON UPDATE CASCADE ON DELETE SET NULL;
''',
  // Fails if any packages.replaced_by has no matching packages row.
  'packages-fk-replaced-by': '''
ALTER TABLE "packages"
  ADD CONSTRAINT "packages_fk_replaced_by"
  FOREIGN KEY ("replaced_by") REFERENCES "packages" ("name")
  ON UPDATE CASCADE ON DELETE SET NULL;
''',
  // Fails if an abandoned publisher still has a contact email.
  'publishers-chk-abandoned': '''
ALTER TABLE "publishers"
  ADD CONSTRAINT "publishers_chk_abandoned"
  CHECK (NOT is_abandoned OR contact_email IS NULL);
''',
  // Fails if a moderated publisher lacks moderated_at.
  'publishers-chk-moderated': '''
ALTER TABLE "publishers"
  ADD CONSTRAINT "publishers_chk_moderated"
  CHECK (NOT is_moderated OR moderated_at IS NOT NULL);
''',
  // Fails if the worker columns are only partially set, or attempts is
  // negative.
  'task-versions-chk-worker': '''
ALTER TABLE "task_versions"
  ADD CONSTRAINT "task_versions_chk_worker"
  CHECK ((worker_zone IS NULL) = (worker_instance IS NULL)
     AND (worker_instance IS NULL) = (worker_token IS NULL)
     AND attempts >= 0);
''',
  // Fails if any tasks.package has no matching packages row.
  'tasks-fk-package': '''
ALTER TABLE "tasks"
  ADD CONSTRAINT "tasks_fk_package"
  FOREIGN KEY ("package") REFERENCES "packages" ("name")
  ON UPDATE CASCADE ON DELETE CASCADE;
''',
  // Fails if any user_sessions.user_id has no matching users.user_id row.
  // NULL user_id values are allowed (anonymous sessions).
  'user-sessions-fk-user': '''
ALTER TABLE "user_sessions"
  ADD CONSTRAINT "user_sessions_fk_user"
  FOREIGN KEY ("user_id") REFERENCES "users" ("user_id")
  ON UPDATE CASCADE ON DELETE CASCADE;
''',
  // Fails if a moderated user lacks moderated_at.
  'users-chk-moderated': '''
ALTER TABLE "users"
  ADD CONSTRAINT "users_chk_moderated"
  CHECK (NOT is_moderated OR moderated_at IS NOT NULL);
''',
  // Fails if two non-deleted users share an email (case-insensitive).
  'users-unique-active-email': '''
CREATE UNIQUE INDEX "users_unique_active_email"
  ON "users" (lower("email"))
  WHERE "email" IS NOT NULL AND NOT "is_deleted";
''',
  // Fails if two users share the same oAuthId. NULLs are allowed
  // (never-logged-in or deleted users) and don't conflict in Postgres.
  'users-unique-oauth-user-id': '''
ALTER TABLE "users"
  ADD CONSTRAINT "users_unique_oauth_user_id" UNIQUE ("oauth_user_id");
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
- `script`: the name of one predefined script (required). A trailing `*`
  matches all scripts that start with the given prefix (e.g. `packages-*`, or
  `*` for all of them), each running in its own transaction.

Available scripts: ${migrateDryRunScripts.keys.map((k) => '`$k`').join(', ')}.

DDL takes table locks that are held until the rollback. The transaction uses a
3s `lock_timeout` and a 30s `statement_timeout`, so a busy table makes the
script fail fast (and report the timeout) instead of blocking other queries.
A lock timeout is not a problem with the script itself: retry at a different time.
''',
  options: {
    'script':
        'Name of the script to test, or a prefix ending with `*` (required).',
  },
  invoke: (options) async {
    final name = options['script'];
    InvalidInputException.check(
      name != null && name.isNotEmpty,
      '`script` is required.',
    );
    if (name!.endsWith('*')) {
      final prefix = name.substring(0, name.length - 1);
      final names = migrateDryRunScripts.keys
          .where((k) => k.startsWith(prefix))
          .toList();
      if (names.isEmpty) {
        throw NotFoundException.resource(name);
      }
      final sw = Stopwatch()..start();
      final results = [for (final n in names) await _run(n)];
      return {
        'rolledBack': true,
        'script': name,
        'ok': results.every((r) => r['ok'] == true),
        'results': results,
        'durationMs': sw.elapsedMilliseconds,
      };
    }
    if (!migrateDryRunScripts.containsKey(name)) {
      throw NotFoundException.resource(name);
    }
    return {'rolledBack': true, ...await _run(name)};
  },
);

Future<Map<String, dynamic>> _run(String name) async {
  final sw = Stopwatch()..start();
  final error = await primaryDatabase.migrateDryRun(
    migrateDryRunScripts[name]!,
  );
  return {
    'script': name,
    'ok': error == null,
    'error': ?error,
    'durationMs': sw.elapsedMilliseconds,
  };
}
