// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// NOTE: We want this tool to be part of the typed_sql package, do not depend
//       on libraries that typed_sql itself wouldn't depend.

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:typed_sql/typed_sql.dart';

part 'migration.g.dart';

@SqlOverride.schema(naming: .snake_case)
abstract final class SchemaMigrationSchema extends Schema {
  Table<SchemaMigration> get schemaMigrations;
}

@PrimaryKey(['schemaName', 'scriptName'])
abstract final class SchemaMigration extends Row {
  /// The name of the schema (major group, e.g. `main`, `accounts`...).
  String get schemaName;

  /// The name of the script.
  String get scriptName;

  /// The SHA-256 of the script at the time of execution.
  String get scriptSha256;

  /// The timestamp of the execution.
  DateTime get executedAt;
}

/// Executes migrations [scripts] in alphabetical order into
/// the [target] database, tracking the updates in the schema
/// migrations [table].
///
/// If all migrations in [scripts] have already been applied to [table] and
/// [table] contains additional migrations with names alphabetically after the
/// last script in [scripts] (for example, when running an older application
/// version against a database migrated by a newer version), no new migrations
/// are executed.
///
/// It is an error if:
/// * [scripts] contains duplicate script names.
/// * Any existing migration in [table] has a different SHA-256 hash than the
///   corresponding script in [scripts].
/// * [table] contains unknown migrations that precede the last script in
///   [scripts], or unknown migrations exist while one or more scripts in
///   [scripts] have not yet been applied.
Future<void> migrateScripts({
  required DatabaseAdapter target,
  required Table<SchemaMigration> table,
  required String schemaName,
  required List<({String name, String content})> scripts,
}) async {
  scripts.sort((a, b) => a.name.compareTo(b.name));

  // sanity check on the table, no update attempts
  final existingRows = await table
      .where((m) => m.schemaName.equalsValue(schemaName))
      .fetch();

  final hashes = <String, String>{};
  for (final script in scripts) {
    if (hashes.containsKey(script.name)) {
      throw ArgumentError('Repeated script name: `${script.name}`.');
    }
    // calculate and store hash
    final hash = sha256
        .convert(utf8.encode(script.content))
        .toString()
        .toLowerCase();
    hashes[script.name] = hash;

    // check existing row
    final existingRow = existingRows
        .where((r) => r.scriptName == script.name)
        .firstOrNull;
    if (existingRow != null && existingRow.scriptSha256 != hash) {
      throw ArgumentError('Script hash difference detected: `${script.name}`.');
    }
  }

  final existingNames = existingRows.map((r) => r.scriptName).toSet();
  final allLocalScriptsApplied = hashes.keys.every(existingNames.contains);

  // Check if all the rows have corresponding scripts.
  // If all local scripts are already applied, allow extra rows in the database
  // only if they are alphabetically after all local scripts (e.g. when running
  // an older version alongside or rolling back from a newer version).
  final lastScriptName = scripts.lastOrNull?.name;
  final rowsWithoutScript = existingRows
      .where((row) => !hashes.containsKey(row.scriptName))
      .toList();
  if (rowsWithoutScript.isNotEmpty) {
    final isForwardCompatible =
        allLocalScriptsApplied &&
        lastScriptName != null &&
        rowsWithoutScript.every(
          (row) => row.scriptName.compareTo(lastScriptName) > 0,
        );
    if (!isForwardCompatible) {
      throw ArgumentError(
        'Existing history without local files (${rowsWithoutScript.length} items): '
        '${rowsWithoutScript.take(5).map((row) => '`${row.scriptName}`').join(', ')}',
      );
    }
  }

  // early exit if all local scripts are already applied
  if (allLocalScriptsApplied) {
    return;
  }

  // update attempts
  for (var i = 0; i < scripts.length; i++) {
    final script = scripts[i];
    final hash = hashes[script.name]!;
    final previousName = i == 0 ? '' : scripts[i - 1].name;

    await _executeScript(target, schemaName, script, hash, previousName);
  }
}

Future<void> _executeScript(
  DatabaseAdapter target,
  String schemaName,
  ({String name, String content}) script,
  String hash,
  String previousName,
) async {
  await target.transact((tx) async {
    // Concurrent migrators block here until the lock holder commits or rolls back.
    await tx.execute('LOCK TABLE "schema_migrations" IN EXCLUSIVE MODE', []);

    // Verify in-transaction that no unexpected script exists.
    final unexpectedRows = await tx
        .query(
          'SELECT "script_name", "script_sha256" FROM "schema_migrations" '
          'WHERE "schema_name" = \$1 AND "script_name" > \$2 '
          'ORDER BY "script_name" ASC LIMIT 1',
          [schemaName, previousName],
        )
        .map((r) => (name: r.readString()!, sha256: r.readString()!))
        .toList();

    if (unexpectedRows.isNotEmpty) {
      final first = unexpectedRows.first;
      // check race + idempotency, continue migrations with the next script if matching
      if (first.name == script.name && first.sha256 == hash) {
        return;
      }
      // otherwise abort migrations
      if (first.name == script.name) {
        throw ArgumentError(
          'Script hash difference detected: `${script.name}` '
          '(recorded `${first.sha256}`, expected `$hash`).',
        );
      }
      throw ArgumentError(
        'Incompatible existing history: `${first.name}` is recorded after '
        '`${previousName.isEmpty ? '<start>' : previousName}`, but is not the '
        'expected next script `${script.name}`.',
      );
    }

    // Execute migration and log execution.
    await tx.script(script.content);

    await tx.execute(
      'INSERT INTO "schema_migrations" '
      '("schema_name", "script_name", "script_sha256", "executed_at") '
      'VALUES (\$1, \$2, \$3, CURRENT_TIMESTAMP)',
      [schemaName, script.name, hash],
    );
  });
}
