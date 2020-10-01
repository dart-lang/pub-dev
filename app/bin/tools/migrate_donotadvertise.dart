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
    print('Usage: dart migrate_donotadvertise.dart');
    print('Sets Package.isUnlisted when Package.doNotAdvertise is set.');
    print(_argParser.usage);
    return;
  }

  final concurrency = int.parse(argv['concurrency'] as String);

  await withProdServices(() async {
    final pool = Pool(concurrency);
    final futures = <Future>[];

    useLoggingPackageAdaptor();
    final query = dbService.query<Package>()..filter('doNotAdvertise =', true);
    await for (final p in query.run()) {
      final f = pool.withResource(() => _migrate(p));
      futures.add(f);
    }

    await Future.wait(futures);
    await pool.close();
  });
}

Future<void> _migrate(Package p) async {
  if (!p.doNotAdvertise) return;
  if (p.isUnlisted) return;
  print('Migrating doNotAdvertise on package ${p.name}');
  try {
    await withRetryTransaction(dbService, (tx) async {
      final package = await tx.lookupValue<Package>(p.key, orElse: () => null);
      if (package == null) {
        return;
      }
      if (package.doNotAdvertise && !package.isUnlisted) {
        package.isUnlisted = true;
        tx.insert(package);
      }
    });
    print('Updated isUnlisted on package ${p.name}.');
  } catch (e) {
    print('Failed to update isUnlisted on package ${p.name}, error $e');
  }
}
