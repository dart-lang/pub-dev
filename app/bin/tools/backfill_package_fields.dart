// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:appengine/appengine.dart';
import 'package:args/args.dart';
import 'package:pool/pool.dart';

import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';
import 'package:pub_dev/shared/datastore.dart';

final _argParser = ArgParser()
  ..addOption('concurrency',
      abbr: 'c', defaultsTo: '10', help: 'Number of concurrent processing.')
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.');

Future main(List<String> args) async {
  final argv = _argParser.parse(args);
  if (argv['help'] as bool == true) {
    print('Usage: dart backfill_package_fields.dart');
    print('Ensures Package.likes is set to an integer.');
    print('Ensures Package.isDiscontinued is set to a bool.');
    print('Ensures Package.isUnlisted is set to a bool.');
    print('Ensures Package.isWithheld is set to a bool.');
    print('Ensures Package.assignedTags is a list.');
    print('Ensures Package.latestPublished is a DateTime.');
    print('Ensures Package.latestPrereleasePublished is a DateTime.');
    print(_argParser.usage);
    return;
  }

  final concurrency = int.parse(argv['concurrency'] as String);

  await withProdServices(() async {
    final pool = Pool(concurrency);
    final futures = <Future>[];

    useLoggingPackageAdaptor();
    await for (Package p in dbService.query<Package>().run()) {
      final f = pool.withResource(() => _backfillPackageFields(p));
      futures.add(f);
    }

    await Future.wait(futures);
    await pool.close();
  });
}

Future<void> _backfillPackageFields(Package p) async {
  if (p.likes != null &&
      p.isDiscontinued != null &&
      p.isUnlisted != null &&
      p.isWithheld != null &&
      p.assignedTags != null &&
      p.latestPublished != null &&
      p.latestPrereleasePublished != null) {
    return;
  }
  print('Backfilling properties on package ${p.name}');
  final latestVersion =
      await dbService.lookupValue<PackageVersion>(p.latestVersionKey);
  final latestPrereleaseVersion =
      await dbService.lookupValue<PackageVersion>(p.latestPrereleaseVersionKey);
  try {
    await withRetryTransaction(dbService, (tx) async {
      final package = await tx.lookupValue<Package>(p.key, orElse: () => null);
      if (package == null) {
        return;
      }
      package.likes ??= 0;
      package.isDiscontinued ??= false;
      package.isUnlisted ??= false;
      package.isWithheld ??= false;
      package.assignedTags ??= [];
      package.latestPublished = latestVersion.created;
      package.latestPrereleasePublished = latestPrereleaseVersion.created;
      tx.insert(package);
    });
    print('Updated properties on package ${p.name}.');
  } catch (e) {
    print('Failed to update properties on package ${p.name}, error $e');
  }
}
