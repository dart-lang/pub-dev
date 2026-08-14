// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:test/test.dart';

/// Columns that don't follow the `_at` suffix convention for `timestamptz`
/// columns, but can't be renamed because the migration that created them has
/// already been applied, or they were exempted from the rule.
const _exemptedTimestampColumns = {
  '000001_task.sql': {'last_dependency_changed', 'finished'},
  '000003_user_session.sql': {'created', 'expires'},
};

final _timestamptzColumnPattern = RegExp(r'"(\w+)"\s+timestamptz');

void main() {
  final migrationsDir = Directory(
    path.join(Directory.current.path, 'migrations'),
  );

  final sqlFiles =
      migrationsDir
          .listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.sql'))
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));

  test('found migration files', () {
    expect(sqlFiles, isNotEmpty);
  });

  // Test that all DateTime fields in the database have a name ending in "At"
  // This is a nice naming convention, enforced by this semi-ugly test.
  // If we decide to abandon this convention, then delete this file.
  test('timestamptz columns end with `_at`', () {
  // NOTE: If this test breaks because of SQL parsing
  //       issues, feel free to delete it.
  //       We shall only maintain this test to the extend
  //       that doing so is easy.
    for (final file in sqlFiles) {
      final basename = path.basename(file.path);
      final excluded = _exemptedTimestampColumns[basename] ?? const {};
      for (final line in file.readAsLinesSync()) {
        final match = _timestamptzColumnPattern.firstMatch(line);
        if (match == null) continue;
        final columnName = match.group(1)!;
        if (excluded.contains(columnName)) continue;
        expect(
          columnName.endsWith('_at'),
          isTrue,
          reason:
              'timestamptz column "$columnName" in $basename should end with `_at`.',
        );
      }
    }
  });
}
