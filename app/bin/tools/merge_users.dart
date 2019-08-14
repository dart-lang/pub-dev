// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:gcloud/db.dart';

import 'package:pub_dartlang_org/account/models.dart';
import 'package:pub_dartlang_org/package/models.dart';
import 'package:pub_dartlang_org/history/models.dart';
import 'package:pub_dartlang_org/service/entrypoint/tools.dart';

final _argParser = ArgParser()
  ..addOption('source-user-id',
      help: 'The userId of the User that will be removed.')
  ..addOption('target-user-id',
      help:
          'The userId of the User that will take over the entries of the removed User.')
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.');

Future main(List<String> args) async {
  final argv = _argParser.parse(args);
  if (argv['help'] as bool == true) {
    print(
        'Usage: dart merge_users.dart --source-user-id [uuid] --target-user-id [uuid]');
    print(
        'Merges one user into another (moving the ownership over to a new one).');
    print(_argParser.usage);
    return;
  }

  final sourceUserId = argv['source-user-id'] as String;
  final targetUserId = argv['target-user-id'] as String;
  if (sourceUserId == null ||
      sourceUserId.isEmpty ||
      targetUserId == null ||
      targetUserId.isEmpty) {
    print('Both user-id parameter must be set.');
    print(_argParser.usage);
    exit(-1);
  }
  if (sourceUserId == targetUserId) {
    print('Use different user-ids.');
    exit(-1);
  }

  await withProdServices(() async {
    final sourceUser = (await dbService
            .lookup<User>([dbService.emptyKey.append(User, id: sourceUserId)]))
        .single;
    final targetUser = (await dbService
            .lookup<User>([dbService.emptyKey.append(User, id: targetUserId)]))
        .single;
    if (targetUser == null) {
      print('Target user does not exists.');
      exit(-1);
    }
    if (targetUser.oauthUserId == null) {
      print('Target user does not have oauth user id.');
    }
    print(
        'Transferring ownership from ${sourceUser.email} to ${targetUser.email}.');
    print('Please say "yes" if you still want to continue, CTRL+C to abort:');
    final answer = stdin.readLineSync().toLowerCase();
    if (answer != 'y' && answer != 'yes') {
      exit(1);
    }

    print('Querying Packages...');
    final pkgQuery = dbService.query<Package>()
      ..filter('uploaders =', sourceUserId);
    final packages = await pkgQuery.run().toList();

    print('Querying PackageVersions...');
    final pvQuery = dbService.query<PackageVersion>()
      ..filter('uploader =', sourceUserId);
    final versions = await pvQuery.run().toList();

    print('Found: ${packages.length} packages and '
        '${versions.length} versions.');

    print('Querying History...');
    int historyCount = 0;
    await for (History history in dbService.query<History>().run()) {
      historyCount++;
      if (historyCount % 1000 == 0) {
        print(' .. $historyCount');
      }
      if (!history.eventJson.contains(sourceUserId)) continue;
      print(
          'Updating History [${history.packageName}/${history.packageVersion}/${history.id}]');
      await dbService.withTransaction((tx) async {
        final h = (await tx.lookup<History>([history.key])).single;
        final event = h.historyEvent;
        final newEvent = event.migrateUser(
            sourceUserId, sourceUser.email, targetUserId, targetUser.email);
        if (event == newEvent) {
          await tx.rollback();
        } else {
          h.historyEvent = newEvent;
          tx.queueMutations(inserts: [h]);
          await tx.commit();
        }
      });
    }

    for (Package package in packages) {
      await dbService.withTransaction((tx) async {
        print('Updating package:${package.name} uploaders...');
        final p = (await tx.lookup<Package>([package.key])).single;
        p.addUploader(targetUserId);
        p.removeUploader(sourceUserId);
        if (p.uploaders.isEmpty) {
          throw StateError('Uploaders must not become empty.');
        }
        tx.queueMutations(inserts: [p]);
        await tx.commit();
      });
    }

    for (PackageVersion version in versions) {
      await dbService.withTransaction((tx) async {
        print('Updating ${version.qualifiedVersionKey} uploader...');
        final pv = (await tx.lookup<PackageVersion>([version.key])).single;
        pv.uploader = targetUserId;
        tx.queueMutations(inserts: [pv]);
        await tx.commit();
      });
    }

    print('Deleting User: $sourceUserId...');
    final deleteKeys = <Key>[sourceUser.key];
    if (sourceUser.oauthUserId != null) {
      deleteKeys.add(
          dbService.emptyKey.append(OAuthUserID, id: sourceUser.oauthUserId));
    }
    await dbService.commit(deletes: deleteKeys);
  });

  // not sure what is hanging
  exit(0);
}
