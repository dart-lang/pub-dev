// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:gcloud/db.dart';

import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/service_utils.dart';
import 'package:pub_dartlang_org/history/backend.dart';
import 'package:pub_dartlang_org/history/models.dart';
import 'package:pub_dartlang_org/shared/package_memcache.dart';

Future main(List<String> arguments) async {
  if (arguments.length < 2 ||
      (!(arguments.length == 2 && arguments[0] == 'list') &&
          !(arguments.length == 3))) {
    print('Usage:');
    print('   ${Platform.script} list   <package>');
    print('   ${Platform.script} add    <package> <email-to-add>');
    print('   ${Platform.script} remove <package> <email-to-add>');
    exit(1);
  }

  final String command = arguments[0];
  final String package = arguments[1];
  final String uploader = arguments.length == 3 ? arguments[2] : null;

  await withProdServices(() async {
    registerHistoryBackend(new HistoryBackend(dbService));
    if (command == 'list') {
      await listUploaders(package);
    } else if (command == 'add') {
      await addUploader(package, uploader);
      await _clearCache(package);
    } else if (command == 'remove') {
      await removeUploader(package, uploader);
      await _clearCache(package);
    }
  });

  // TODO(kustermann): Remove this after Issue 61 is fixed.
  exit(0);
}

Future listUploaders(String packageName) async {
  return dbService.withTransaction((Transaction T) async {
    final Package package =
        (await T.lookup([dbService.emptyKey.append(Package, id: packageName)]))
            .first;
    if (package == null) {
      throw new Exception('Package $packageName does not exist.');
    }
    final uploaders = package.uploaderEmails;
    print('Current uploaders: $uploaders');
  });
}

Future addUploader(String packageName, String uploader) async {
  return dbService.withTransaction((Transaction T) async {
    final Package package =
        (await T.lookup([dbService.emptyKey.append(Package, id: packageName)]))
            .first;
    if (package == null) {
      throw new Exception('Package $packageName does not exist.');
    }
    final uploaders = package.uploaderEmails;
    print('Current uploaders: $uploaders');
    if (uploaders.contains(uploader)) {
      throw new Exception('Uploader $uploader already exists');
    }
    package.uploaderEmails.add(uploader);
    T.queueMutations(inserts: [package]);
    await T.commit();
    print('Uploader $uploader added to list of uploaders');

    historyBackend.storeEvent(new UploaderChanged(
      packageName: packageName,
      currentUserEmail: null, // TODO: get system account's email
      addedUploaderEmails: [uploader],
    ));
  });
}

Future removeUploader(String packageName, String uploader) async {
  return dbService.withTransaction((Transaction T) async {
    final Package package =
        (await T.lookup([dbService.emptyKey.append(Package, id: packageName)]))
            .first;
    if (package == null) {
      throw new Exception('Package $packageName does not exist.');
    }
    final uploaders = package.uploaderEmails;
    print('Current uploaders: $uploaders');
    if (!uploaders.contains(uploader)) {
      throw new Exception('Uploader $uploader does not exist');
    }
    package.uploaderEmails.remove(uploader);
    if (package.uploaderEmails.isEmpty) {
      throw new Exception('Would remove last uploader');
    }
    T.queueMutations(inserts: [package]);
    await T.commit();
    print('Uploader $uploader removed from list of uploaders');

    historyBackend.storeEvent(new UploaderChanged(
      packageName: packageName,
      currentUserEmail: null, // TODO: get system account's email
      removedUploaderEmails: [uploader],
    ));
  });
}

Future _clearCache(String package) async {
  final cache = new AppEnginePackageMemcache();
  await cache.invalidateUIPackagePage(package);
  await cache.invalidatePackageData(package);
}
