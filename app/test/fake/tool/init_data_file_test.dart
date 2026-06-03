// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:gcloud/db.dart';
import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:pub_dev/fake/server/local_server_state.dart';
import 'package:pub_dev/fake/tool/init_data_file.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/service/services.dart';
import 'package:pub_dev/shared/versions.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:test/test.dart';
import 'package:typed_sql/typed_sql.dart';

import '../../shared/utils.dart';

void main() {
  group('FakeInitDataFile', () {
    scopedTest('init, save, and restore data file', () async {
      final tempDir = await Directory.systemTemp.createTemp('init_data_');
      final dataFile = '${tempDir.path}/state.jsonl';
      try {
        await initDataFile(
          profile: TestProfile(
            defaultUser: 'dev@example.com',
            generatedPackages: [GeneratedTestPackage(name: 'sample')],
          ),
          dataFile: dataFile,
          analysis: 'fake',
        );

        expect(await File(dataFile).exists(), isTrue);

        // Load the saved state into a fresh database and verify contents.
        final db2 = await PrimaryDatabase.createAndInit();
        try {
          final state2 = LocalServerState(database: db2);
          await state2.loadIfExists(dataFile);

          // Verify datastore has package data.
          await withFakeServices(
            datastore: state2.datastore,
            storage: state2.storage,
            primaryDatabase: db2,
            fn: () async {
              final packages = await dbService.query<Package>().run().toList();
              expect(packages.map((p) => p.name), contains('sample'));

              final versions = await dbService
                  .query<PackageVersion>()
                  .run()
                  .toList();
              expect(versions.map((v) => v.package), everyElement('sample'));
            },
          );

          // Verify Postgres database has task data.
          final task = await db2.withRetry(
            (db) => db.tasks.byKey(runtimeVersion, 'sample').fetch(),
          );
          expect(task, isNotNull);
          expect(task!.package, 'sample');
        } finally {
          await db2.close();
        }
      } finally {
        await tempDir.delete(recursive: true);
      }
    });
  });
}
