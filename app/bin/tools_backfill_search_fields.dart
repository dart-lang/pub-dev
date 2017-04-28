// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:pub_dartlang_org/models.dart';
import 'package:pub_dartlang_org/backend.dart' show detectTypes;

import 'tools_common.dart';

Future main(List<String> args) async {
  int updatedCount = 0;
  await withProdServices(() async {
    await for (PackageVersion pv in dbService.query(PackageVersion).run()) {
      final List<String> detectedTypes = detectTypes(pv.pubspec);
      if (!isSameDetectedType(pv.detectedTypes, detectedTypes)) {
        try {
          await _updatePackageVersion(pv.key);
          updatedCount++;
        } catch (e) {
          print(
              'Failed to update package ${pv.package} / ${pv.version}, error: $e');
        }
      }
    }
  });
  print('Updated: $updatedCount package versions.');
}

Future _updatePackageVersion(Key pvKey) async {
  await dbService.withTransaction((Transaction t) async {
    final list = (await t.lookup([pvKey.parent, pvKey]));
    final Package p = list[0];
    final PackageVersion pv = list[1];
    pv.detectedTypes = detectTypes(pv.pubspec);
    final List<Model> updated = [pv];
    // Package will be updated only if there is a change.
    if (p.updateSearchFields(pv)) {
      updated.add(p);
    }
    t.queueMutations(inserts: updated);
    await t.commit();
  });
}
