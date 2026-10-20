// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:pub_dev/src/database/migration_tools.dart';
import 'package:test/test.dart';

void main() {
  group('addIfExistsClauses', () {
    test('CREATE TABLE and indexes', () {
      expect(
        addIfExistsClauses(
          'CREATE TABLE "a" (\n  "x" text\n);\n'
          'CREATE INDEX "i" ON "a" ("x");\n'
          'CREATE UNIQUE INDEX "u" ON "a" ("x");\n',
        ),
        'CREATE TABLE IF NOT EXISTS "a" (\n  "x" text\n);\n'
        'CREATE INDEX IF NOT EXISTS "i" ON "a" ("x");\n'
        'CREATE UNIQUE INDEX IF NOT EXISTS "u" ON "a" ("x");\n',
      );
    });

    test('DROP TABLE and INDEX', () {
      expect(
        addIfExistsClauses('DROP TABLE "a";\nDROP INDEX "i";\n'),
        'DROP TABLE IF EXISTS "a";\nDROP INDEX IF EXISTS "i";\n',
      );
    });

    test('ALTER TABLE column and constraint actions', () {
      expect(
        addIfExistsClauses(
          'ALTER TABLE "a" ADD COLUMN "c" text NULL, '
          'ADD COLUMN "d" text NULL, DROP COLUMN "e";\n'
          'ALTER TABLE "a"\n  DROP CONSTRAINT "k",\n  ADD COLUMN "f" int;\n',
        ),
        'ALTER TABLE "a" ADD COLUMN IF NOT EXISTS "c" text NULL, '
        'ADD COLUMN IF NOT EXISTS "d" text NULL, DROP COLUMN IF EXISTS "e";\n'
        'ALTER TABLE "a"\n  DROP CONSTRAINT IF EXISTS "k",\n'
        '  ADD COLUMN IF NOT EXISTS "f" int;\n',
      );
    });

    test('statements without IF [NOT] EXISTS support are unchanged', () {
      const sql =
          'ALTER TABLE "a" ADD CONSTRAINT "k" CHECK (true);\n'
          'ALTER TABLE "a" ALTER COLUMN "x" DROP NOT NULL;\n';
      expect(addIfExistsClauses(sql), sql);
    });

    test('CONCURRENTLY is not added or removed', () {
      const sql =
          'CREATE INDEX CONCURRENTLY "i" ON "a" ("x");\n'
          'DROP INDEX CONCURRENTLY "o";\n';
      expect(addIfExistsClauses(sql), sql);
    });

    test('is idempotent', () {
      const sql =
          'CREATE TABLE "a" (\n  "x" text\n);\n'
          'CREATE UNIQUE INDEX "u" ON "a" ("x");\n'
          'DROP INDEX "o";\n'
          'ALTER TABLE "a" ADD COLUMN "c" text NULL, DROP COLUMN "e";\n'
          'ALTER TABLE "a" DROP CONSTRAINT "k";\n';
      final once = addIfExistsClauses(sql);
      expect(once, isNot(sql));
      expect(addIfExistsClauses(once), once);
    });

    test('statement keywords are matched only at the line start', () {
      const sql = '-- CREATE TABLE "a" and DROP INDEX "i" in a comment\n';
      expect(addIfExistsClauses(sql), sql);
    });
  });

  group('buildSha256sum', () {
    test('sorts by name and uses two spaces as separator', () {
      final a = utf8.encode('a');
      final b = utf8.encode('b');
      expect(
        buildSha256sum([
          (name: '000002_b.sql', bytes: b),
          (name: '000001_a.sql', bytes: a),
        ]),
        '${sha256.convert(a)}  000001_a.sql\n'
        '${sha256.convert(b)}  000002_b.sql\n',
      );
    });

    test('matches the checked-in migrations/sha256sum.txt', () {
      final files = [
        for (final f in Directory('migrations').listSync().whereType<File>())
          if (f.path.endsWith('.sql'))
            (name: f.uri.pathSegments.last, bytes: f.readAsBytesSync()),
      ];
      expect(
        buildSha256sum(files),
        File('migrations/sha256sum.txt').readAsStringSync(),
      );
    });
  });
}
