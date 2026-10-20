// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:crypto/crypto.dart';

/// Adds `IF [NOT] EXISTS` clauses to the statements where PostgreSQL supports
/// them, so the migration scripts can be re-run safely.
///
/// Statements without such support (e.g. `ADD CONSTRAINT`) are left as-is.
/// TODO: consider how `CONCURRENTLY` can be added, since it is outside of the transaction.
String addIfExistsClauses(String sql) {
  const rules = <(String, String)>[
    (r'^CREATE TABLE "', 'CREATE TABLE IF NOT EXISTS "'),
    (r'^CREATE INDEX "', 'CREATE INDEX IF NOT EXISTS "'),
    (r'^CREATE UNIQUE INDEX "', 'CREATE UNIQUE INDEX IF NOT EXISTS "'),
    (r'^DROP TABLE "', 'DROP TABLE IF EXISTS "'),
    (r'^DROP INDEX "', 'DROP INDEX IF EXISTS "'),
    (r'\bADD COLUMN "', 'ADD COLUMN IF NOT EXISTS "'),
    (r'\bDROP COLUMN "', 'DROP COLUMN IF EXISTS "'),
    (r'\bDROP CONSTRAINT "', 'DROP CONSTRAINT IF EXISTS "'),
  ];
  var result = sql;
  for (final (pattern, replacement) in rules) {
    result = result.replaceAll(RegExp(pattern, multiLine: true), replacement);
  }
  return result;
}

/// Returns the content of `sha256sum.txt` for the migration [files]
/// (file name and content), sorted by name.
String buildSha256sum(Iterable<({String name, List<int> bytes})> files) {
  final sorted = files.toList()..sort((a, b) => a.name.compareTo(b.name));
  final sb = StringBuffer();
  for (final file in sorted) {
    sb.writeln('${sha256.convert(file.bytes)}  ${file.name}');
  }
  return sb.toString();
}
