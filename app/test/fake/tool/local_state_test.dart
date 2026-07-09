// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:pub_dev/fake/server/local_server_state.dart';
import 'package:pub_dev/shared/versions.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:test/test.dart';
import 'package:typed_sql/typed_sql.dart';

import '../../shared/test_services.dart';

void main() {
  group('LocalServerState save and restore', () {
    testWithProfile(
      'database rows survive save and restore',
      testProfile: TestProfile(
        defaultUser: 'dev@example.com',
        generatedPackages: [GeneratedTestPackage(name: 'sample')],
      ),
      processJobsWithFakeRunners: true,
      fn: () async {
        // Read current task from the database.
        final taskBefore = await primaryDatabase.withRetry(
          (db) => db.tasks.byKey(runtimeVersion, 'sample').fetch(),
        );
        expect(taskBefore, isNotNull);

        // Save the state to a temporary file.
        final tempDir = await Directory.systemTemp.createTemp('local_state_');
        final dataFile = '${tempDir.path}/state.jsonl';
        try {
          final state1 = LocalServerState(database: primaryDatabase);
          await state1.save(dataFile);

          // Verify the file was created and is non-empty.
          final file = File(dataFile);
          expect(await file.exists(), isTrue);
          expect(await file.length(), greaterThan(0));

          // Load the state into a new LocalServerState and restore it into
          // a fresh database.
          final db2 = await PrimaryDatabase.createAndInit();
          try {
            final noTask = await db2.withRetry(
              (db) => db.tasks.byKey(runtimeVersion, 'sample').fetch(),
            );
            expect(noTask, isNull);

            final state2 = LocalServerState(database: db2);
            await state2.loadIfExists(dataFile);

            final taskAfter = await db2.withRetry(
              (db) => db.tasks.byKey(runtimeVersion, 'sample').fetch(),
            );

            // Verify the task was restored.
            expect(taskAfter, isNotNull);
            expect(taskAfter!.package, taskBefore!.package);
            expect(
              taskAfter.finished.toIso8601String(),
              taskBefore.finished.toIso8601String(),
            );
          } finally {
            await db2.close();
          }
        } finally {
          await tempDir.delete(recursive: true);
        }
      },
    );
  });
}
