// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:args/args.dart';
import 'package:gcloud/db.dart';
import 'package:pool/pool.dart';

import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';

final _argParser = ArgParser()
  ..addOption('concurrency',
      abbr: 'c', defaultsTo: '1', help: 'Number of concurrent processing.')
  ..addOption('package', abbr: 'p', help: 'The package to process.')
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.');

/// Deletes PackageVersionPubspec and PackageVersionInfo using old IDs, see CHANGELOG.md
/// For when to run this.
Future main(List<String> args) async {
  final argv = _argParser.parse(args);
  if (argv['help'] as bool == true) {
    print('Usage: dart remove_old_derived_versions.dart');
    print('Deletes PackageVersionPubspec entities with old ids.');
    print('Deletes PackageVersionInfo entities with old ids.');
    print(_argParser.usage);
    return;
  }

  final concurrency = int.parse(argv['concurrency'] as String);
  final package = argv['package'] as String;

  await withToolRuntime(() async {
    if (package == null) {
      final pool = Pool(concurrency);
      final futures = <Future>[];

      await for (final package in dbService.query<Package>().run()) {
        futures.add(_processPackage(package.name));
      }

      await Future.wait(futures);
      await pool.close();
    } else {
      await _processPackage(package);
    }
  });
}

Future<void> _processPackage(String package) async {
  await _deleteWithQuery<PackageVersionPubspec>(
    dbService.query<PackageVersionPubspec>()..filter('package =', package),
    where: (p) => p.id.toString() == p.qualifiedVersionKey.oldQualifiedVersion,
  );

  await _deleteWithQuery<PackageVersionInfo>(
    dbService.query<PackageVersionInfo>()..filter('package =', package),
    where: (p) => p.id.toString() == p.qualifiedVersionKey.oldQualifiedVersion,
  );
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
