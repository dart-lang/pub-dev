// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';

import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/service_utils.dart';

Future main(List<String> args) async {
  int okCount = 0;
  int updatedCount = 0;
  await withProdServices(() async {
    await for (PackageVersion pv in dbService.query<PackageVersion>().run()) {
      if (pv.version == pv.key.id) {
        okCount++;
        if (okCount % 500 == 0) {
          print('OK count: $okCount');
        }
        continue;
      }
      print('Updating ${pv.package}: ${pv.version} -> ${pv.key.id}');
      updatedCount++;
      await _updatePackageVersion(pv.key);
    }
  });
  print('Updated: $updatedCount package versions.');
}

Future _updatePackageVersion(Key pvKey) async {
  await dbService.withTransaction((Transaction t) async {
    final list = (await t.lookup([pvKey]));
    final PackageVersion pv = list[0];
    pv.version = pv.key.id as String;
    t.queueMutations(inserts: [pv]);
    await t.commit();
  });
}
