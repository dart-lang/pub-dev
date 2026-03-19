// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// NOTE: We want this tool to be part of the typed_sql package, do not depend
//       on libraries that typed_sql itself wouldn't depend.

// TODO(https://github.com/google/dart-neats/issues/347): remove this after typed_sql supports automatic snake_case convention
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:typed_sql/typed_sql.dart';

part 'migration.g.dart';

abstract final class SchemaMigrationSchema extends Schema {
  Table<SchemaMigration> get schema_migrations;
}

@PrimaryKey(['migrations_name', 'script_name'])
abstract final class SchemaMigration extends Row {
  /// The name of the migrations (or the identifier of a module).
  String get migrations_name;

  /// The name of the script.
  String get script_name;

  /// The SSH-256 of the script at the time of execution.
  String get script_sha256;

  /// The timestamp of the execution.
  DateTime get executed;
}

/// Executes migrations [scripts] in order into the [target] database,
/// tracking the updates in the schema migrations [table].
Future<void> migrateScripts({
  required DatabaseAdapter target,
  required Table<SchemaMigration> table,
  required String migrationsName,
  required List<({String name, String content})> scripts,
}) async {
  scripts.sort((a, b) => a.name.compareTo(b.name));

  // sanity check on the table, no update attempts
  final existingRows = await table
      .where((m) => m.migrations_name.equalsValue(migrationsName))
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
        .where((r) => r.script_name == script.name)
        .firstOrNull;
    if (existingRow != null && existingRow.script_sha256 != hash) {
      throw ArgumentError('Script hash difference detected: `${script.name}`.');
    }
  }

  // early exit if everything matches
  if (scripts.length == existingRows.length &&
      existingRows.every((row) => hashes.containsKey(row.script_name))) {
    return;
  }

  // check if all the rows have corresponding scripts
  final rowsWithoutScript = existingRows
      .where((row) => !hashes.containsKey(row.script_name))
      .toList();
  if (rowsWithoutScript.isNotEmpty) {
    throw ArgumentError(
      'Existing history without local files (${rowsWithoutScript.length} items): '
      '${rowsWithoutScript.take(5).map((row) => '`${row.script_name}`').join(', ')}',
    );
  }

  // update attempts
  for (var i = 0; i < scripts.length; i++) {
    final script = scripts[i];
    final hash = hashes[script.name]!;
    await target.transact((tx) async {
      // Verify in-transaction that no unexpected script exists
      // QUESTION: can we scope this with schema prefix so that it is part of the same transaction?
      final unexpectedRows = await table
          .where((m) {
            final mn = m.migrations_name.equalsValue(migrationsName);
            if (i == 0) {
              return mn;
            }
            return mn.and(
              m.script_name.greaterThan(scripts[i - 1].name.asExpr),
            );
          })
          .orderBy((m) => [(m.script_name, Order.ascending)])
          .fetch();

      if (unexpectedRows.isNotEmpty) {
        final first = unexpectedRows.first;
        // check race + idempotency, continue migrations with the next script if matching
        if (first.script_name == script.name && first.script_sha256 == hash) {
          return;
        }
        // otherwise abort migrations
        throw ArgumentError(
          'Incompatible existing history: `${first.script_name}` preceeds `${script.name}`.',
        );
      }

      // Execute migration and log exection.
      await tx.script(script.content);

      // QUESTION: can we scope this with schema prefix so that it is part of the same transaction?
      await table
          .insert(
            migrations_name: migrationsName.asExpr,
            script_name: script.name.asExpr,
            script_sha256: hash.asExpr,
            executed: Expr.currentTimestamp,
          )
          .execute();
    });
  }
}
