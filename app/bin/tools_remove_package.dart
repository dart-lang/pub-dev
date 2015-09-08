// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:gcloud/db.dart';
import 'package:pub_dartlang_org/models.dart';
import 'package:pub_dartlang_org/backend.dart';

import 'tools_common.dart';

void main(List<String> arguments) {
  if (arguments.length != 3) {
    print('Usage: ${Platform.script} <json-key> (list|remove) <package>');
    exit(1);
  }

  String jsonKeyfile = arguments[0];
  String command = arguments[1];
  String package = arguments[2];

  withProdServices(jsonKeyfile, () async {
    if (command == 'list') {
      await listPackage(package);
    } else if (command == 'remove') {
      await removePackage(package);
    }
  }, namespace: '');
}

Future listPackage(String packageName) async {
  var packageKey = dbService.emptyKey.append(Package, id: packageName);
  Package package = (await dbService.lookup([packageKey])).first;
  if (package == null) {
    throw new Exception("Package $packageName does not exist.");
  }

  var versionsQuery = dbService.query(PackageVersion, ancestorKey: packageKey);
  List<PackageVersion> versions = await versionsQuery.run().toList();

  print('Package "$packageName" has the following versions:');
  for (var version in versions) {
    print('  * ${version.version}');
  }
}

Future removePackage(String packageName) async {
  return dbService.withTransaction((Transaction T) async {
    var packageKey = dbService.emptyKey.append(Package, id: packageName);
    Package package = (await T.lookup([packageKey])).first;
    if (package == null) {
      throw new Exception("Package $packageName does not exist.");
    }

    var versionsQuery = T.query(PackageVersion, packageKey);
    var versions = await versionsQuery.run().toList();
    var versionNames = versions.map((v) => v.semanticVersion).toList();

    var deletes = versions.map((v) => v.key).toList();
    deletes.add(packageKey);
    T.queueMutations(deletes: deletes);

    print('Committing changes to DB ...');
    await T.commit();

    var storage = backend.repository.storage;
    print('Removing GCS objects ...');
    await Future.wait(
        versionNames.map((version) => storage.remove(packageName, version)));

    print('Package "$packageName" got successfully removed.');
    print('WARNING: Please remember to clear the AppEngine memcache!');
  });
}

