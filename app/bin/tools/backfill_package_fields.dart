// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:appengine/appengine.dart';
import 'package:args/args.dart';
import 'package:gcloud/db.dart';
import 'package:pool/pool.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';

final _argParser = ArgParser()
  ..addOption('concurrency',
      abbr: 'c', defaultsTo: '10', help: 'Number of concurrent processing.')
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.');

Future main(List<String> args) async {
  final argv = _argParser.parse(args);
  if (argv['help'] as bool == true) {
    print('Usage: dart backfill_package_fields.dart');
    print('Ensures Package.likes is set to an integer.');
    print('Ensures Package.doNotAdvertise is set to a bool.');
    print('Ensures Package.isDiscontinued is set to a bool.');
    print('Ensures Package.assignedTags is a list.');
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
      p.doNotAdvertise != null &&
      p.isDiscontinued != null &&
      p.assignedTags != null) {
    return;
  }
  print('Backfilling properties on package ${p.name}');
  try {
    await dbService.withTransaction((Transaction tx) async {
      final package = await tx.lookupValue<Package>(p.key, orElse: () => null);
      if (package == null) {
        return;
      }
      package.likes ??= 0;
      package.doNotAdvertise ??= false;
      package.isDiscontinued ??= false;
      package.assignedTags ??= [];
      tx.queueMutations(inserts: [package]);
      await tx.commit();
      print('Updated properties on package ${package.name}.');
    });
  } catch (e) {
    print('Failed to update properties on package ${p.name}, error $e');
  }
}
