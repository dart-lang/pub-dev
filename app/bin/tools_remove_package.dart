// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:gcloud/db.dart';
import 'package:gcloud/storage.dart';
import 'package:pub_dartlang_org/backend.dart';
import 'package:pub_dartlang_org/models.dart';

import 'configuration.dart';
import 'tools_common.dart';

final Configuration configuration = new Configuration.prod();

main(List<String> arguments) async {
  if (arguments.length < 2 || (
      !(arguments[0] == 'list' && arguments.length == 2) &&
      !(arguments[0] == 'remove' &&
        (arguments.length == 2 || arguments.length == 3)))) {
    print('Usage:');
    print('  ${Platform.script} list <package>');
    print('  ${Platform.script} remove <package>');
    print('  ${Platform.script} remove <package> <version>');
    exit(1);
  }

  String command = arguments[0];
  String package = arguments[1];
  String version = null;
  if (arguments.length == 3) version = arguments[2];

  await withProdServices(() async {
    if (command == 'list') {
      await listPackage(package);
    } else if (command == 'remove') {
      if (version == null) {
        await removePackage(package);
     } else {
        await removePackageVersion(package, version);
      }
    } else {
      throw 'unexpected command $command';
    }
  });

  // TODO(kustermann): Remove this after Issue 61 is fixed.
  exit(0);
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

    final bucket = storageService.bucket(configuration.packageBucketName);
    final storage = new TarballStorage(storageService, bucket, '');
    print('Removing GCS objects ...');
    await Future.wait(
        versionNames.map((version) => storage.remove(packageName, version)));

    print('Package "$packageName" got successfully removed.');
    print('WARNING: Please remember to clear the AppEngine memcache!');
  });
}

Future removePackageVersion(String packageName, String version) async {
  return dbService.withTransaction((Transaction T) async {
    var packageKey = dbService.emptyKey.append(Package, id: packageName);
    Package package = (await T.lookup([packageKey])).first;
    if (package == null) {
      throw new Exception("Package $packageName does not exist.");
    }

    var versionsQuery = T.query(PackageVersion, packageKey);
    var versions = await versionsQuery.run().toList();
    var versionNames = versions.map((v) => '${v.semanticVersion}').toList();
    if (!versionNames.contains(version)) {
      throw new Exception(
          "Package $packageName does not have a version $version.");
    }

    if ('${package.latestSemanticVersion}' == version) {
      throw new Exception("Cannot delete the latest version of $packageName.");
    }

    var deletes = [packageKey.append(PackageVersion, id: version)];
    T.queueMutations(deletes: deletes);

    print('Committing changes to DB ...');
    await T.commit();

    var storage = backend.repository.storage;
    print('Removing GCS objects ...');
    await storage.remove(packageName, version);

    print('Version "$version" of "$packageName" got successfully removed.');
    print('WARNING: Please remember to clear the AppEngine memcache!');
  });
}
