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
  if (argv['help'] as bool) {
    print('Usage: dart set_unlisted_false_for_all_discontinued_packages.dart');
    print('Unsets Package.isUnlisted when Package.isDiscontinued is set.');
    print(_argParser.usage);
    return;
  }

  final concurrency = int.parse(argv['concurrency'] as String);

  await withToolRuntime(() async {
    final pool = Pool(concurrency);
    final futures = <Future>[];

    useLoggingPackageAdaptor();
    final query = dbService.query<Package>()..filter('isDiscontinued =', true);
    await for (final p in query.run()) {
      final f = pool.withResource(() => _migrate(p));
      futures.add(f);
    }

    await Future.wait(futures);
    await pool.close();
  });
}

Future<void> _migrate(Package p) async {
  if (!p.isDiscontinued) return;
  if (!p.isUnlisted) return;
  print('Updating isUnlisted=false on package ${p.name}');
  try {
    await withRetryTransaction(dbService, (tx) async {
      final package = await tx.lookupOrNull<Package>(p.key);
      if (package == null) {
        return;
      }
      if (package.isDiscontinued && package.isUnlisted) {
        package.isUnlisted = false;
        tx.insert(package);
      }
    });
    print('Updated isUnlisted on package ${p.name}.');
  } catch (e) {
    print('Failed to update isUnlisted on package ${p.name}, error $e');
  }
}
