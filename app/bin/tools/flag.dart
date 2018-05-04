// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:appengine/appengine.dart';
import 'package:args/args.dart';
import 'package:gcloud/db.dart';

import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/service_utils.dart';
import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/package_memcache.dart';

final _argParser = new ArgParser(allowTrailingOptions: true)
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
  if (argv.rest.isEmpty) {
    _printUsage();
    exit(1);
  }

  final String package = argv.rest.single;
  final isRead = argv['discontinued'] == null;

  await withProdServices(() async {
    if (isRead) {
      await _read(package);
    } else {
      await _set(
        package,
        discontinued: argv['discontinued'],
        doNotAdvertise: argv['do-not-advertise'],
      );
      await _clearCaches(package);
    }
    // TODO: figure out why the services do not exit.
    exit(0);
  });
}

Future _read(String packageName) async {
  final Package p = (await dbService
          .lookup([dbService.emptyKey.append(Package, id: packageName)]))
      .single;
  if (p == null) {
    throw new Exception('Package $packageName does not exist.');
  }
  final flags = <String>[];
  if (p.isDiscontinued ?? false) {
    flags.add('discontinued');
  }
  if (p.doNotAdvertise ?? false) {
    flags.add('do-not-advertise');
  }
  final label = flags.isEmpty ? '-' : flags.join(', ');
  print('Package $packageName: $label');
}

Future _set(String packageName, {String discontinued, String doNotAdvertise}) {
  return dbService.withTransaction((Transaction tx) async {
    final Package p =
        (await tx.lookup([dbService.emptyKey.append(Package, id: packageName)]))
            .single;
    if (p == null) {
      throw new Exception('Package $packageName does not exist.');
    }
    if (discontinued != null) {
      p.isDiscontinued = discontinued == 'set';
    }
    if (doNotAdvertise != null) {
      p.doNotAdvertise = doNotAdvertise == 'set';
    }
    tx.queueMutations(inserts: [p]);
    await tx.commit();
    print('Package $packageName: isDiscontinued=${p.isDiscontinued}');
    await new AnalyzerClient()
        .triggerAnalysis(packageName, p.latestVersion, new Set());
  });
}

Future _clearCaches(String packageName) async {
  final pkgCache = new AppEnginePackageMemcache(memcacheService);
  await pkgCache.invalidateUIPackagePage(packageName);
  await pkgCache.invalidatePackageData(packageName);
}
