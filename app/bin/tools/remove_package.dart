// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:gcloud/db.dart';
import 'package:gcloud/storage.dart';
import 'package:pub_semver/pub_semver.dart';

import 'package:pub_dartlang_org/shared/configuration.dart';
import 'package:pub_dartlang_org/shared/storage.dart';

import 'package:pub_dartlang_org/dartdoc/backend.dart';
import 'package:pub_dartlang_org/frontend/backend.dart';
import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/service_utils.dart';
import 'package:pub_dartlang_org/history/models.dart';
import 'package:pub_dartlang_org/job/model.dart';
import 'package:pub_dartlang_org/scorecard/models.dart';

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
      final Bucket storageBucket = await getOrCreateBucket(
          storageService, activeConfiguration.dartdocStorageBucketName);
      registerDartdocBackend(new DartdocBackend(dbService, storageBucket));
      if (version == null) {
        await removePackage(package);
      } else {
        await removePackageVersion(package, version);
      }
    } else {
      throw new Exception('unexpected command $command');
    }
  });

  // TODO(kustermann): Remove this after Issue 61 is fixed.
  exit(0);
}

Future listPackage(String packageName) async {
  final Key packageKey = dbService.emptyKey.append(Package, id: packageName);
  final package = (await dbService.lookup([packageKey])).first as Package;
  if (package == null) {
    throw new Exception('Package $packageName does not exist.');
  }

  final versionsQuery =
      dbService.query<PackageVersion>(ancestorKey: packageKey);
  final versions = await versionsQuery.run().toList();

  print('Package "$packageName" has the following versions:');
  for (var version in versions) {
    print('  * ${version.version}');
  }
}

Future _deleteWithQuery<T>(Query query, {bool where(T item)}) async {
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
  await dbService.withTransaction((Transaction T) async {
    final deletes = <Key>[];
    final Key packageKey = dbService.emptyKey.append(Package, id: packageName);
    final package = (await T.lookup([packageKey])).first as Package;
    if (package == null) {
      print('Package $packageName does not exists.');
    } else {
      deletes.add(packageKey);
    }

    final versionsQuery = T.query<PackageVersion>(packageKey);
    final versions = await versionsQuery.run().toList();
    final List<Version> versionNames =
        versions.map((v) => v.semanticVersion).toList();
    deletes.addAll(versions.map((v) => v.key));

    final bucket = storageService.bucket(activeConfiguration.packageBucketName);
    final storage = new TarballStorage(storageService, bucket, '');
    print('Removing GCS objects ...');
    await Future.wait(versionNames
        .map((version) => storage.remove(packageName, version.toString())));

    print('Committing changes to DB ...');
    T.queueMutations(deletes: deletes);
    await T.commit();
  });

  await dartdocBackend.removeAll(packageName);

  await _deleteWithQuery(
      dbService.query<Job>()..filter('packageName =', packageName));

  await _deleteWithQuery(
      dbService.query<History>()..filter('packageName =', packageName));

  await _deleteWithQuery(
      dbService.query<ScoreCardReport>()..filter('packageName =', packageName));

  await _deleteWithQuery(
      dbService.query<ScoreCard>()..filter('packageName =', packageName));

  print('Package "$packageName" got successfully removed.');
  print('WARNING: Please remember to clear the AppEngine memcache!');
}

Future removePackageVersion(String packageName, String version) async {
  await dbService.withTransaction((Transaction T) async {
    final Key packageKey = dbService.emptyKey.append(Package, id: packageName);
    final package = (await T.lookup([packageKey])).first as Package;
    if (package == null) {
      throw new Exception('Package $packageName does not exist.');
    }

    final versionsQuery = T.query<PackageVersion>(packageKey);
    final versions = await versionsQuery.run().toList();
    final versionNames = versions.map((v) => '${v.semanticVersion}').toList();
    if (!versionNames.contains(version)) {
      print('Package $packageName does not have a version $version.');
    }

    if ('${package.latestSemanticVersion}' == version) {
      throw new Exception('Cannot delete the latest version of $packageName.');
    }

    final deletes = [packageKey.append(PackageVersion, id: version)];
    T.queueMutations(deletes: deletes);

    print('Committing changes to DB ...');
    await T.commit();

    final bucket = storageService.bucket(activeConfiguration.packageBucketName);
    final storage = new TarballStorage(storageService, bucket, '');
    print('Removing GCS objects ...');
    await storage.remove(packageName, version);
  });

  await dartdocBackend.removeAll(packageName, version: version);

  await _deleteWithQuery(
    dbService.query<Job>()..filter('packageName =', packageName),
    where: (Job job) => job.packageVersion == version,
  );

  await _deleteWithQuery(
    dbService.query<History>()..filter('packageName =', packageName),
    where: (History history) => history.packageVersion == version,
  );

  print('Version "$version" of "$packageName" got successfully removed.');
  print('WARNING: Please remember to clear the AppEngine memcache!');
}
