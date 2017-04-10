// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart';
import 'package:pub_dartlang_org/models.dart';

import 'server_common.dart';
import 'tools_common.dart';

Future main(List<String> args) async {
  int updatedPackages = 0;
  await withProdServices(() async {
    await fork(() async {
      if (Platform.isMacOS) {
        await initializeApiaryDatastore();
      }
      await for (Package p in dbService.query(Package).run()) {
        if (p.latestDevVersionKey == null) {
          try {
            await _updateDevVersionKey(p.key);
            updatedPackages++;
          } catch (e) {
            print('Failed to update package ${p.name}, error: $e');
          }
        }
      }
    });
  });
  print('Updated: $updatedPackages packages.');
}

Future _updateDevVersionKey(Key packageKey) async {
  await dbService.withTransaction((Transaction t) async {
    final Package package = (await t.lookup([packageKey])).first;
    final List<PackageVersion> versions = await dbService
        .query(PackageVersion, ancestorKey: packageKey)
        .run()
        .toList();
    for (PackageVersion pv in versions) {
      package.updateVersion(pv);
    }
    t.queueMutations(inserts: [package]);
    await t.commit();
  });
}
