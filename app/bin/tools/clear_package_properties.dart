// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:args/args.dart';
import 'package:gcloud/db.dart';
import 'package:pool/pool.dart';

import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';

final _argParser = ArgParser()
  ..addOption('concurrency',
      abbr: 'c', defaultsTo: '1', help: 'Number of concurrent processing.')
  ..addOption('package', abbr: 'p', help: 'The package to process.')
  ..addFlag('dry-run',
      abbr: 'n', help: 'Print changes but do not update entities.')
  ..addFlag('verbose', abbr: 'v', help: 'Print all changes.')
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.');

bool _isDryRun = false;
bool _isVerbose = false;
final _removedCount = <String, int>{};

Future main(List<String> args) async {
  final argv = _argParser.parse(args);
  if (argv['help'] as bool == true) {
    print('Usage: dart clear_package_properties.dart');
    print('Deletes unmapped properties from the following entry types: '
        'Package, PackageVersion.');
    print(_argParser.usage);
    return;
  }

  _isDryRun = argv['dry-run'] as bool;
  _isVerbose = argv['verbose'] as bool;
  final concurrency = int.parse(argv['concurrency'] as String);
  final package = argv['package'] as String;
  await withProdServices(() async {
    if (package != null) {
      final p = (await dbService.lookup<Package>(
              [dbService.emptyKey.append(Package, id: package)]))
          .single;
      await _processPackage(p);
    } else {
      final pool = Pool(concurrency);
      final futures = <Future>[];

      await for (Package p in dbService.query<Package>().run()) {
        final f = pool.withResource(() => _processPackage(p));
        futures.add(f);
      }

      await Future.wait(futures);
      await pool.close();
    }
  });

  print(JsonEncoder.withIndent('  ').convert(_removedCount));
}

Future _processWithQuery<T extends ExpandoModel>(Query<T> query) async {
  await for (T m in query.run()) {
    await _clearAdditionalProperties(m);
  }
}

Future _processPackage(Package package) async {
  print('Processing package: ${package.name}');

  final versionQuery =
      dbService.query<PackageVersion>(ancestorKey: package.key);
  await _processWithQuery(versionQuery);

  final pubspecQuery = dbService.query<PackageVersionPubspec>()
    ..filter('package =', package.name);
  await _processWithQuery(pubspecQuery);

  final infoQuery = dbService.query<PackageVersionInfo>()
    ..filter('package =', package.name);
  await _processWithQuery(infoQuery);

  await _clearAdditionalProperties(package);
}

Future _clearAdditionalProperties<T extends ExpandoModel>(T model) async {
  if (model.additionalProperties.isEmpty) {
    return;
  }
  final props = model.additionalProperties.keys.toList();
  props.sort();
  if (_isVerbose) {
    print('Clearing ${_key(model.key)} of ${props.join(', ')}');
  }

  for (String prop in props) {
    final statKey = '${model.key.type.toString()}.$prop';
    _removedCount[statKey] = (_removedCount[statKey] ?? 0) + 1;
  }

  if (_isDryRun) return;
  await dbService.withTransaction((tx) async {
    final entry = (await tx.lookup<T>([model.key])).single;
    entry.additionalProperties.clear();
    tx.queueMutations(inserts: [entry]);
    await tx.commit();
  });
}

String _key(Key key) {
  final sb = StringBuffer();
  if (key.parent != null && key.parent.id != null) {
    sb.write(_key(key.parent));
    sb.write('/');
  }
  sb.write(key.type);
  sb.write('(');
  sb.write(key.id);
  sb.write(')');
  return sb.toString();
}
