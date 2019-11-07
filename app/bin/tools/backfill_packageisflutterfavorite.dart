// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:appengine/appengine.dart';
import 'package:args/args.dart';
import 'package:gcloud/db.dart';
import 'package:pool/pool.dart';
import 'package:pub_dartlang_org/package/models.dart';
import 'package:pub_dartlang_org/service/entrypoint/tools.dart';
import 'package:pub_dartlang_org/shared/datastore_helper.dart';

final _argParser = ArgParser()
  ..addOption('concurrency',
      abbr: 'c', defaultsTo: '10', help: 'Number of concurrent processing.')
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.');

Future main(List<String> args) async {
  final argv = _argParser.parse(args);
  if (argv['help'] as bool == true) {
    print('Usage: dart backfill_packageisflutterfavorite.dart');
    print('Ensures Package.isFlutterFavorite is set to a boolean.');
    print(_argParser.usage);
    return;
  }

  final concurrency = int.parse(argv['concurrency'] as String);

  await withProdServices(() async {
    final pool = Pool(concurrency);
    final futures = <Future>[];

    useLoggingPackageAdaptor();
    await for (Package p in dbService.query<Package>().run()) {
      final f = pool.withResource(() => _backfillPackageIsFlutterFavorite(p));
      futures.add(f);
    }

    await Future.wait(futures);
    await pool.close();
  });
}

Future<void> _backfillPackageIsFlutterFavorite(Package p) async {
  if (p.isFlutterFavorite != null) return;
  print('Backfilling isFlutterFavorite property on package ${p.name}');
  try {
    await withTransaction(dbService, (tx) async {
      final package = await tx.lookupValue<Package>(p.key, orElse: () => null);
      if (package == null) {
        return;
      }
      if (package.isFlutterFavorite != null) {
        return;
      }
      package.isFlutterFavorite = false;
      tx.insert(package);
      print('Updated isFlutterFavorite property on package ${package.name}.');
    });
  } catch (e) {
    print('Failed to update isFlutterFavorite on package ${p.name}, error $e');
  }
}
