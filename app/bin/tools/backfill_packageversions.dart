// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:appengine/appengine.dart';
import 'package:args/args.dart';
import 'package:gcloud/db.dart';

import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/service_utils.dart';

final _argParser = new ArgParser()
  ..addOption('package', abbr: 'p', help: 'The package to backfill.');

Future main(List<String> args) async {
  final argv = _argParser.parse(args);
  final package = argv['package'] as String;

  useLoggingPackageAdaptor();
  await withProdServices(() async {
    if (package != null) {
      await _backfillPackage(package);
    } else {
      await for (Package p in dbService.query<Package>().run()) {
        await _backfillPackage(p.name);
      }
    }
  });
}

Future _backfillPackage(String package) async {
  print('Backfill PackageVersion[Pubspec|Info] in: $package');

  final packageKey = dbService.emptyKey.append(Package, id: package);
  final query = dbService.query<PackageVersion>(ancestorKey: packageKey);
  await for (PackageVersion pv in query.run()) {
    final qualifiedKey = QualifiedVersionKey(
        namespace: null, package: pv.package, version: pv.version);

    final pvPubspecKey = dbService.emptyKey
        .append(PackageVersionPubspec, id: qualifiedKey.qualifiedVersion);
    final pvInfoKey = dbService.emptyKey
        .append(PackageVersionInfo, id: qualifiedKey.qualifiedVersion);

    final items = await dbService.lookup([pvPubspecKey, pvInfoKey]);
    final inserts = <Model>[];
    if (items[0] == null) {
      inserts.add(PackageVersionPubspec()
        ..initFromKey(qualifiedKey)
        ..pubspec = pv.pubspec
        ..updated = pv.created);
    }
    if (items[1] == null) {
      inserts.add(PackageVersionInfo()
        ..initFromKey(qualifiedKey)
        ..readmeFilename = pv.readmeFilename
        ..readmeContent = pv.readmeContent
        ..changelogFilename = pv.changelogFilename
        ..changelogContent = pv.changelogContent
        ..exampleFilename = pv.exampleFilename
        ..exampleContent = pv.exampleContent
        ..libraries = pv.libraries
        ..libraryCount = pv.libraries.length
        ..updated = pv.created);
    }
    if (inserts.isNotEmpty) {
      await dbService.commit(inserts: inserts);
    }
  }
}
