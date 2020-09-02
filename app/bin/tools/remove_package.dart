// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:gcloud/db.dart';

import 'package:pub_dev/admin/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';

Future main(List<String> arguments) async {
  if (arguments.length < 2 ||
      (!(arguments[0] == 'list' && arguments.length == 2) &&
          !(arguments[0] == 'remove' &&
              (arguments.length == 2 || arguments.length == 3)))) {
    print('Usage:');
    print('  ${Platform.script} list <package>');
    print('  ${Platform.script} remove <package>');
    print('  ${Platform.script} remove <package> <version>');
    exit(1);
  }

  final String command = arguments[0];
  final String package = arguments[1];
  String version;
  if (arguments.length == 3) version = arguments[2];

  await withProdServices(() async {
    if (command == 'list') {
      await listPackage(package);
    } else if (command == 'remove') {
      if (version == null) {
        await _removePackage(package);
      } else {
        await _removePackageVersion(package, version);
      }
    } else {
      throw Exception('unexpected command $command');
    }
  });

  // TODO(kustermann): Remove this after Issue 61 is fixed.
  exit(0);
}

Future listPackage(String packageName) async {
  final Key packageKey = dbService.emptyKey.append(Package, id: packageName);
  final package = (await dbService.lookup([packageKey])).first as Package;
  if (package == null) {
    throw Exception('Package $packageName does not exist.');
  }

  final versionsQuery =
      dbService.query<PackageVersion>(ancestorKey: packageKey);
  final versions = await versionsQuery.run().toList();

  print('Package "$packageName" has the following versions:');
  for (var version in versions) {
    print('  * ${version.version}');
  }
}

Future _removePackage(String packageName) async {
  final packageKey = dbService.emptyKey.append(Package, id: packageName);
  final versionsToConfirm = await dbService
      .query<PackageVersion>(ancestorKey: packageKey)
      .run()
      .toList();
  print(
      'This script will delete the ALL ${versionsToConfirm.length} versions of $packageName.');
  print('Versions:');
  versionsToConfirm.forEach((v) => print(' - ${v.version}'));
  print('Are you sure you want to do that? Type `y` or `yes`:');
  final confirm = stdin.readLineSync();
  if (confirm != 'y' && confirm != 'yes') {
    print('Aborted.');
    return;
  }
  await adminBackend.removePackage(packageName);
}

Future _removePackageVersion(String packageName, String version) async {
  print('This script will delete the single version of $packageName $version.');
  print('Are you sure you want to do that? Type `y` or `yes`:');
  final confirm = stdin.readLineSync();
  if (confirm != 'y' && confirm != 'yes') {
    print('Aborted.');
    return;
  }

  await adminBackend.removePackageVersion(packageName, version);

  print('Version "$version" of "$packageName" got successfully removed.');
  print('NOTICE: Redis caches referencing the package will expire given time.');
}
