// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:args/args.dart';

import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';
import 'package:pub_dev/shared/datastore.dart';

final _argParser = ArgParser()
  ..addFlag('dry-run',
      abbr: 'n', defaultsTo: false, help: 'Do not change Datastore.')
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.');

/// Deletes all PackageVersionPubspec entities.
Future main(List<String> args) async {
  final argv = _argParser.parse(args);
  if (argv['help'] as bool == true) {
    print('Usage: dart remove_packageversionpubspec.dart');
    print('Deletes PackageVersionPubspec entities.');
    print(_argParser.usage);
    return;
  }

  final dryRun = argv['dry-run'] as bool;

  await withToolRuntime(() async {
    // ignore: deprecated_member_use_from_same_package
    await _deleteWithQuery<PackageVersionPubspec>(
      // ignore: deprecated_member_use_from_same_package
      dbService.query<PackageVersionPubspec>(),
      dryRun: dryRun,
    );
  });
}

Future<void> _deleteWithQuery<T>(Query query, {bool dryRun}) async {
  print('Running query for $T...');
  final deletes = <Key>[];
  await for (Model m in query.run()) {
    deletes.add(m.key);
    if (deletes.length >= 500) {
      deletes.clear();
      await _commit(deletes, dryRun);
    }
  }
  if (deletes.isNotEmpty) {
    await _commit(deletes, dryRun);
  }
}

Future<void> _commit(List<Key> deletes, bool dryRun) async {
  if (dryRun) {
    for (final key in deletes) {
      print('Deleting: ${key.type} ${key.id}');
    }
  } else {
    await dbService.commit(deletes: deletes);
  }
}
