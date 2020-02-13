// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:gcloud/db.dart';

import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';
import 'package:pub_dev/analyzer/analyzer_client.dart';

final _argParser = ArgParser(allowTrailingOptions: true)
  ..addFlag('help',
      abbr: 'h', defaultsTo: false, negatable: false, help: 'show help message')
  ..addOption('discontinued',
      help: 'Set or clear the discontinued flag', allowed: ['set', 'clear'])
  ..addOption('do-not-advertise',
      help: 'Set or clear the do-not-advertise flag',
      allowed: ['set', 'clear']);

void _printUsage() {
  print(_argParser.usage);
}

Future main(List<String> arguments) async {
  final argv = _argParser.parse(arguments);
  if (argv.rest.isEmpty || argv['help'] == true) {
    _printUsage();
    exit(1);
  }

  final String package = argv.rest.single;
  final discontinued = argv['discontinued'] as String;
  final doNotAdvertise = argv['do-not-advertise'] as String;
  final isRead = discontinued == null && doNotAdvertise == null;

  await withProdServices(() async {
    if (isRead) {
      await _read(package);
    } else {
      await _set(
        package,
        discontinued: discontinued,
        doNotAdvertise: doNotAdvertise,
      );
      await purgePackageCache(package);
    }
    // TODO: figure out why the services do not exit.
    exit(0);
  });
}

Future _read(String packageName) async {
  final p = (await dbService
          .lookup([dbService.emptyKey.append(Package, id: packageName)]))
      .single as Package;
  if (p == null) {
    throw Exception('Package $packageName does not exist.');
  }
  final flags = <String>[];
  if (p.isDiscontinued) {
    flags.add('discontinued');
  }
  if (p.doNotAdvertise) {
    flags.add('do-not-advertise');
  }
  final label = flags.isEmpty ? '-' : flags.join(', ');
  print('Package $packageName: $label');
}

Future _set(String packageName, {String discontinued, String doNotAdvertise}) {
  return dbService.withTransaction((Transaction tx) async {
    final p =
        (await tx.lookup([dbService.emptyKey.append(Package, id: packageName)]))
            .single as Package;
    if (p == null) {
      throw Exception('Package $packageName does not exist.');
    }
    if (discontinued != null) {
      p.isDiscontinued = discontinued == 'set';
    }
    if (doNotAdvertise != null) {
      p.doNotAdvertise = doNotAdvertise == 'set';
    }
    tx.queueMutations(inserts: [p]);
    await tx.commit();
    print(
        'Package $packageName: isDiscontinued=${p.isDiscontinued} doNotAdverise=${p.doNotAdvertise}');
    await AnalyzerClient()
        .triggerAnalysis(packageName, p.latestVersion, <String>{});
  });
}
