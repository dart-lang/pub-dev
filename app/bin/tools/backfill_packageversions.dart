// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:appengine/appengine.dart';
import 'package:args/args.dart';
import 'package:gcloud/db.dart';
import 'package:pool/pool.dart';

import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';

final _argParser = ArgParser()
  ..addOption('concurrency',
      abbr: 'c', defaultsTo: '1', help: 'Number of concurrent processing.')
  ..addOption('package', abbr: 'p', help: 'The package to backfill.')
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.');

Future main(List<String> args) async {
  final argv = _argParser.parse(args);
  if (argv['help'] as bool == true) {
    print('Usage: dart backfill_packageversions.dart');
    print(
        'Ensures a matching PackageVersionPubspec entity exists for each PackageVersion.');
    print(
        'Ensures a matching PackageVersionInfo entity exists for each PackageVersion.');
    print(_argParser.usage);
    return;
  }

  final concurrency = int.parse(argv['concurrency'] as String);
  final package = argv['package'] as String;

  useLoggingPackageAdaptor();
  await withProdServices(() async {
    if (package != null) {
      await _backfillPackage(package);
    } else {
      final pool = Pool(concurrency);
      final futures = <Future>[];

      await for (Package p in dbService.query<Package>().run()) {
        final f = pool.withResource(() => _backfillPackage(p.name));
        futures.add(f);
      }

      await Future.wait(futures);
      await pool.close();
    }
  });
}

Future _backfillPackage(String package) async {
  print('Backfill PackageVersion[Pubspec|Info] in: $package');

  final packageKey = dbService.emptyKey.append(Package, id: package);
  final query = dbService.query<PackageVersion>(ancestorKey: packageKey);
  await for (PackageVersion pv in query.run()) {
    final qualifiedKey =
        QualifiedVersionKey(package: pv.package, version: pv.version);

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
        ..libraries = pv.libraries
        ..libraryCount = pv.libraries.length
        ..updated = pv.created);
    }
    if (inserts.isNotEmpty) {
      await dbService.commit(inserts: inserts);
    }
  }
}
