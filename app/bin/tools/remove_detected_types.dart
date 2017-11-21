// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';

import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/service_utils.dart';

Future main(List<String> args) async {
  await withProdServices(() async {
    int count = 0;
    await for (PackageVersion pv in dbService.query(PackageVersion).run()) {
      if (count % 100 == 0) {
        print('Count: $count, current: ${pv.package} ${pv.version}');
      }
      if (pv.additionalProperties.containsKey('detectedTypes')) {
        print('Update: ${pv.package} ${pv.version}');
        await _updatePackageVersion(pv.key);
      }
      count++;
    }
    count = 0;
    await for (Package p in dbService.query(Package).run()) {
      if (count % 100 == 0) {
        print('Count: $count, current: ${p.name}');
      }
      if (p.additionalProperties.containsKey('detectedTypes')) {
        print('Update: ${p.name}');
        await _updatePackage(p.key);
      }
      count++;
    }
  });
}

Future _updatePackageVersion(Key pvKey) async {
  await dbService.withTransaction((Transaction t) async {
    final PackageVersion pv = (await t.lookup([pvKey])).single;
    pv.additionalProperties.remove('detectedTypes');
    t.queueMutations(inserts: [pv]);
    await t.commit();
  });
}

Future _updatePackage(Key pKey) async {
  await dbService.withTransaction((Transaction t) async {
    final Package p = (await t.lookup([pKey])).single;
    p.additionalProperties.remove('detectedTypes');
    t.queueMutations(inserts: [p]);
    await t.commit();
  });
}
