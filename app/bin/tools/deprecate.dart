// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:appengine/appengine.dart';
import 'package:gcloud/db.dart';

import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/service_utils.dart';
import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/package_memcache.dart';

void _printUsage() {
  print('Usage:');
  print('    ${Platform.script} read  <package>');
  print('    ${Platform.script} set   <package>');
  print('    ${Platform.script} clear <package>');
}

Future main(List<String> arguments) async {
  if (arguments.length != 2) {
    _printUsage();
    exit(1);
  }

  final String command = arguments[0];
  final String package = arguments[1];

  await withProdServices(() async {
    if (command == 'read') {
      await _read(package);
    } else if (command == 'set') {
      await _set(package, true);
      await _clearCaches(package);
    } else if (command == 'clear') {
      await _set(package, false);
      await _clearCaches(package);
    } else {
      _printUsage();
      exit(1);
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
  final isDeprecated = p.isDeprecated ?? false;
  final label = isDeprecated ? 'deprecated' : '-';
  print('Package $packageName: $label');
}

Future _set(String packageName, bool value) {
  return dbService.withTransaction((Transaction tx) async {
    final Package p =
        (await tx.lookup([dbService.emptyKey.append(Package, id: packageName)]))
            .single;
    if (p == null) {
      throw new Exception('Package $packageName does not exist.');
    }
    p.isDeprecated = value;
    tx.queueMutations(inserts: [p]);
    await tx.commit();
    print('Package $packageName: isDeprecated=$value');
    await new AnalyzerClient()
        .triggerAnalysis(packageName, p.latestVersion, new Set());
  });
}

Future _clearCaches(String packageName) async {
  final pkgCache = new AppEnginePackageMemcache(memcacheService);
  await pkgCache.invalidateUIPackagePage(packageName);
  await pkgCache.invalidatePackageData(packageName);
}
