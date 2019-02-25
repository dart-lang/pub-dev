// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:args/args.dart';
import 'package:gcloud/db.dart';
import 'package:pool/pool.dart';

import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/service_utils.dart';

final _argParser = new ArgParser()
  ..addOption('concurrency',
      abbr: 'c', defaultsTo: '1', help: 'Number of concurrent processing.')
  ..addOption('package', abbr: 'p', help: 'The package to process.')
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.');

Future main(List<String> args) async {
  final argv = _argParser.parse(args);
  if (argv['help'] as bool == true) {
    print('Usage: dart clear_package_properties.dart');
    print('Deletes unmapped properties from the following entry types: '
        'Package, PackageVersion.');
    print(_argParser.usage);
    return;
  }

  final concurrency = int.parse(argv['concurrency'] as String);
  final package = argv['package'] as String;
  await withProdServices(() async {
    if (package != null) {
      await _processPackage(package);
    } else {
      final pool = Pool(concurrency);
      final futures = <Future>[];

      await for (Package p in dbService.query<Package>().run()) {
        final f = pool.withResource(() => _processPackage(p.name,
            packageEntityNeedsUpdate: p.additionalProperties.isNotEmpty));
        futures.add(f);
      }

      await Future.wait(futures);
      await pool.close();
    }
  });
}

Future _processPackage(
  String package, {
  bool packageEntityNeedsUpdate = true,
}) async {
  print('Processing package: $package');
  final pkgKey = dbService.emptyKey.append(Package, id: package);

  final versionQuery = dbService.query<PackageVersion>(ancestorKey: pkgKey);
  await for (PackageVersion pv in versionQuery.run()) {
    if (pv.additionalProperties.isNotEmpty) {
      await dbService.withTransaction((tx) async {
        final version = (await tx.lookup<PackageVersion>([pv.key])).single;
        version.additionalProperties.clear();
        tx.queueMutations(inserts: [version]);
        await tx.commit();
      });
    }
  }

  if (packageEntityNeedsUpdate) {
    await dbService.withTransaction((tx) async {
      final p = (await dbService.lookup<Package>([pkgKey])).single;
      if (p.additionalProperties.isEmpty) {
        await tx.rollback();
        return;
      }
      p.additionalProperties.clear();
      tx.queueMutations(inserts: [p]);
      await tx.commit();
    });
  }
}
