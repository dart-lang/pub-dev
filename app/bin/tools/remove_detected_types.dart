// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';

import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/service_utils.dart';

Future main(List<String> args) async {
  await withProdServices(() async {
    await for (PackageVersion pv in dbService.query(PackageVersion).run()) {
      print('Updating ${pv.package} ${pv.version}...');
      await _updatePackageVersion(pv.key);
    }
    await for (Package p in dbService.query(Package).run()) {
      print('Updating ${p.name}...');
      await _updatePackage(p.key);
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
