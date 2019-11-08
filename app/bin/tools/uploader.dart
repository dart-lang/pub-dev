// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:gcloud/db.dart';

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/history/backend.dart';
import 'package:pub_dev/history/models.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';
import 'package:pub_dev/shared/email.dart';

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
    if (command == 'list') {
      await listUploaders(package);
    } else if (command == 'add') {
      await addUploader(package, uploader);
      await purgePackageCache(package);
    } else if (command == 'remove') {
      await removeUploader(package, uploader);
      await purgePackageCache(package);
    }
  });

  exit(0);
}

Future listUploaders(String packageName) async {
  return dbService.withTransaction((Transaction T) async {
    final package =
        (await T.lookup([dbService.emptyKey.append(Package, id: packageName)]))
            .first as Package;
    if (package == null) {
      throw Exception('Package $packageName does not exist.');
    }
    final uploaderEmails =
        await accountBackend.getEmailsOfUserIds(package.uploaders);
    print('Current uploaders: $uploaderEmails');
  });
}

Future addUploader(String packageName, String uploaderEmail) async {
  return dbService.withTransaction((Transaction T) async {
    final package =
        (await T.lookup([dbService.emptyKey.append(Package, id: packageName)]))
            .first as Package;
    if (package == null) {
      throw Exception('Package $packageName does not exist.');
    }
    final uploaderEmails =
        await accountBackend.getEmailsOfUserIds(package.uploaders);
    print('Current uploaders: $uploaderEmails');
    final user = await accountBackend.lookupOrCreateUserByEmail(uploaderEmail);
    if (package.containsUploader(user.userId)) {
      throw Exception('Uploader $uploaderEmail already exists');
    }
    package.addUploader(user.userId);
    T.queueMutations(inserts: [package]);
    await T.commit();
    print('Uploader $uploaderEmail added to list of uploaders');

    final pubUser =
        await accountBackend.lookupOrCreateUserByEmail(pubDartlangOrgEmail);
    historyBackend.storeEvent(UploaderChanged(
      packageName: packageName,
      currentUserId: pubUser.userId,
      currentUserEmail: pubDartlangOrgEmail,
      addedUploaderEmails: [uploaderEmail],
    ));
  });
}

Future removeUploader(String packageName, String uploaderEmail) async {
  return dbService.withTransaction((Transaction T) async {
    final package =
        (await T.lookup([dbService.emptyKey.append(Package, id: packageName)]))
            .first as Package;
    if (package == null) {
      throw Exception('Package $packageName does not exist.');
    }

    final uploaderEmails =
        await accountBackend.getEmailsOfUserIds(package.uploaders);
    print('Current uploaders: $uploaderEmails');
    final user = await accountBackend.lookupOrCreateUserByEmail(uploaderEmail);
    if (!package.containsUploader(user.userId)) {
      throw Exception('Uploader $uploaderEmail does not exist');
    }
    if (package.uploaderCount <= 1) {
      throw Exception('Would remove last uploader');
    }
    package.removeUploader(user.userId);
    T.queueMutations(inserts: [package]);
    await T.commit();
    print('Uploader $uploaderEmail removed from list of uploaders');

    final pubUser =
        await accountBackend.lookupOrCreateUserByEmail(pubDartlangOrgEmail);
    historyBackend.storeEvent(UploaderChanged(
      packageName: packageName,
      currentUserId: pubUser.userId,
      currentUserEmail: pubDartlangOrgEmail,
      removedUploaderEmails: [uploaderEmail],
    ));
  });
}
