// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.9

import 'dart:async';

import 'package:args/args.dart';

import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';
import 'package:pub_dev/shared/utils.dart';
import 'package:pub_dev/shared/datastore.dart';

final _argParser = ArgParser()
  ..addFlag('dry-run',
      abbr: 'n', defaultsTo: false, help: 'Do not change Datastore.')
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.');

/// Deletes PackageVersionPubspec and PackageVersionInfo using old IDs, see CHANGELOG.md
/// For when to run this.
Future main(List<String> args) async {
  final argv = _argParser.parse(args);
  if (argv['help'] as bool == true) {
    print('Usage: dart remove_noncanonical_entities.dart');
    print('Deletes PackageVersionAsset entities with non-canonical versions.');
    print('Deletes PackageVersionInfo entities with non-canonical versions.');
    print(
        'Deletes PackageVersionPubspec entities with non-canonical versions.');
    print(_argParser.usage);
    return;
  }

  final dryRun = argv['dry-run'] as bool;

  await withToolRuntime(() async {
    await _deleteWithQuery<PackageVersionAsset>(
      dbService.query<PackageVersionAsset>(),
      where: (a) => canonicalizeVersion(a.version) != a.version,
      dryRun: dryRun,
    );

    await _deleteWithQuery<PackageVersionInfo>(
      dbService.query<PackageVersionInfo>(),
      where: (a) => canonicalizeVersion(a.version) != a.version,
      dryRun: dryRun,
    );
  });
}

Future<void> _deleteWithQuery<T>(Query query,
    {bool Function(T item) where, bool dryRun}) async {
  print('Running query for $T...');
  final deletes = <Key>[];
  await for (Model m in query.run()) {
    final shouldDelete = where == null || where(m as T);
    if (shouldDelete) {
      deletes.add(m.key);
      if (deletes.length >= 500) {
        await _commit(deletes, dryRun);
        deletes.clear();
      }
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
