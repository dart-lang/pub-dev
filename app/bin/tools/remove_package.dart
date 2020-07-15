// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:gcloud/db.dart';
import 'package:gcloud/storage.dart';
import 'package:meta/meta.dart';

import 'package:pub_dev/admin/backend.dart';
import 'package:pub_dev/dartdoc/backend.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/history/models.dart';
import 'package:pub_dev/job/model.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/datastore_helper.dart';

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
        await removePackageVersion(package, version);
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

Future _deleteWithQuery<T>(Query query, {bool Function(T item) where}) async {
  final deletes = <Key>[];
  await for (Model m in query.run()) {
    final shouldDelete = where == null || where(m as T);
    if (shouldDelete) {
      deletes.add(m.key);
      if (deletes.length >= 500) {
        await _commit(action: 'Deleting $T', deletes: deletes);
        deletes.clear();
      }
    }
  }
  if (deletes.isNotEmpty) {
    await _commit(action: 'Deleting $T', deletes: deletes);
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

Future removePackageVersion(String packageName, String version) async {
  print('This script will delete the single version of $packageName $version.');
  print('Are you sure you want to do that? Type `y` or `yes`:');
  final confirm = stdin.readLineSync();
  if (confirm != 'y' && confirm != 'yes') {
    print('Aborted.');
    return;
  }
  await withRetryTransaction(dbService, (tx) async {
    final Key packageKey = dbService.emptyKey.append(Package, id: packageName);
    final package = (await tx.lookup([packageKey])).first as Package;
    if (package == null) {
      print('Package $packageName does not exist.');
    }

    final deletes = <Key>[];
    final versionsQuery = tx.query<PackageVersion>(packageKey);
    final versions = await versionsQuery.run().toList();
    final versionNames = versions.map((v) => v.version).toList();
    if (versionNames.contains(version)) {
      deletes.add(packageKey.append(PackageVersion, id: version));
    } else {
      print('Package $packageName does not have a version $version.');
    }

    if (versionNames.length == 1 && versionNames.single == version) {
      throw Exception(
          'Last version detected. Use full package removal without the version qualifier.');
    }

    bool updatePackage = false;
    if (package != null && package.latestVersion == version) {
      package.latestVersionKey = null;
      updatePackage = true;
    }
    if (package != null && package.latestPrereleaseVersion == version) {
      package.latestPrereleaseVersionKey = null;
      updatePackage = true;
    }
    final inserts = <Model>[];
    if (updatePackage) {
      versions
          .where((v) => v.version != version)
          .forEach(package.updateVersion);
      inserts.add(package);
    }

    await _commit(
      action: 'Committing changes to DB ...',
      tx: tx,
      inserts: inserts,
      deletes: deletes,
    );
  });

  final bucket = storageService.bucket(activeConfiguration.packageBucketName);
  final storage = TarballStorage(storageService, bucket, '');
  print('Removing GCS objects ...');
  await storage.remove(packageName, version);

  await dartdocBackend.removeAll(packageName, version: version);

  await _deleteWithQuery(
    dbService.query<PackageVersionPubspec>()..filter('package =', packageName),
    where: (PackageVersionPubspec info) => info.version == version,
  );

  await _deleteWithQuery(
    dbService.query<PackageVersionInfo>()..filter('package =', packageName),
    where: (PackageVersionInfo info) => info.version == version,
  );

  await _deleteWithQuery(
    dbService.query<PackageVersionAsset>()..filter('package =', packageName),
    where: (PackageVersionAsset asset) => asset.version == version,
  );

  await _deleteWithQuery(
    dbService.query<Job>()..filter('packageName =', packageName),
    where: (Job job) => job.packageVersion == version,
  );

  await _deleteWithQuery(
    dbService.query<History>()..filter('packageName =', packageName),
    where: (History history) => history.packageVersion == version,
  );

  print('Version "$version" of "$packageName" got successfully removed.');
  print('NOTICE: Redis caches referencing the package will expire given time.');
}

Future _commit({
  @required String action,
  TransactionWrapper tx,
  List<Model> inserts,
  List<Key> deletes,
}) async {
  if ((inserts == null || inserts.isEmpty) &&
      (deletes == null || deletes.isEmpty)) {
    return;
  }
  print('');
  print('**** About to commit the following action: $action');
  inserts?.forEach((m) {
    print('- insert/update: ${_debugKey(m.key)}');
  });
  deletes?.forEach((k) {
    print('- delete: ${_debugKey(k)}');
  });
  if (tx != null) {
    tx.queueMutations(inserts: inserts, deletes: deletes);
  } else {
    await dbService.commit(inserts: inserts, deletes: deletes);
  }
}

String _debugKey(Key k) {
  final p = k.parent == null || k.parent.isEmpty ? '' : _debugKey(k.parent);
  return '$p/${k.type}:${k.id}';
}
