// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:gcloud/db.dart';
import 'package:gcloud/storage.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_semver/pub_semver.dart';

import 'package:pub_dev/dartdoc/backend.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/history/models.dart';
import 'package:pub_dev/job/model.dart';
import 'package:pub_dev/scorecard/models.dart';
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
        await removePackage(package);
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
        await dbService.commit(deletes: deletes);
        deletes.clear();
      }
    }
  }
  if (deletes.isNotEmpty) {
    await dbService.commit(deletes: deletes);
  }
}

Future removePackage(String packageName) async {
  await withRetryTransaction(dbService, (tx) async {
    final deletes = <Key>[];
    final Key packageKey = dbService.emptyKey.append(Package, id: packageName);
    final package = (await tx.lookup([packageKey])).first as Package;
    if (package == null) {
      print('Package $packageName does not exists.');
    } else {
      deletes.add(packageKey);
    }

    final versionsQuery = tx.query<PackageVersion>(packageKey);
    final versions = await versionsQuery.run().toList();
    final List<Version> versionNames =
        versions.map((v) => v.semanticVersion).toList();
    deletes.addAll(versions.map((v) => v.key));

    final bucket = storageService.bucket(activeConfiguration.packageBucketName);
    final storage = TarballStorage(storageService, bucket, '');
    print('Removing GCS objects ...');
    await Future.wait(versionNames
        .map((version) => storage.remove(packageName, version.toString())));

    print('Committing changes to DB ...');
    tx.queueMutations(deletes: deletes);
  });

  print('Removing package from dartdoc backend ...');
  await dartdocBackend.removeAll(packageName, concurrency: 32);

  print('Removing package from PackageVersionPubspec ...');
  await _deleteWithQuery(dbService.query<PackageVersionPubspec>()
    ..filter('package =', packageName));

  print('Removing package from PackageVersionInfo ...');
  await _deleteWithQuery(
      dbService.query<PackageVersionInfo>()..filter('package =', packageName));

  print('Removing package from Jobs ...');
  await _deleteWithQuery(
      dbService.query<Job>()..filter('packageName =', packageName));

  print('Removing package from History ...');
  await _deleteWithQuery(
      dbService.query<History>()..filter('packageName =', packageName));

  print('Removing package from ScoreCardReport ...');
  await _deleteWithQuery(
      dbService.query<ScoreCardReport>()..filter('packageName =', packageName));

  print('Removing package from ScoreCard ...');
  await _deleteWithQuery(
      dbService.query<ScoreCard>()..filter('packageName =', packageName));

  print('Removing package from Like ...');
  await _deleteWithQuery(
      dbService.query<Like>()..filter('package =', packageName));

  print('Package "$packageName" got successfully removed.');
  print('NOTICE: Redis caches referencing the package will expire given time.');
}

Future removePackageVersion(String packageName, String version) async {
  await withRetryTransaction(dbService, (tx) async {
    final Key packageKey = dbService.emptyKey.append(Package, id: packageName);
    final package = (await tx.lookup([packageKey])).first as Package;
    if (package == null) {
      print('Package $packageName does not exist.');
    }

    final versionsQuery = tx.query<PackageVersion>(packageKey);
    final versions = await versionsQuery.run().toList();
    final versionNames = versions.map((v) => v.version).toList();
    if (versionNames.contains(version)) {
      final deletes = [packageKey.append(PackageVersion, id: version)];
      tx.queueMutations(deletes: deletes);
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
    if (package != null && package.latestDevVersion == version) {
      package.latestDevVersionKey = null;
      updatePackage = true;
    }
    if (updatePackage) {
      versions
          .where((v) => v.version != version)
          .forEach(package.updateVersion);
      tx.queueMutations(inserts: [package]);
    }

    print('Committing changes to DB ...');
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
