// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:uuid/uuid.dart';

import 'package:pub_dartlang_org/account/models.dart';
import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/service_utils.dart';

final _uuid = Uuid();

Future main(List<String> args) async {
  final emailFirstUsed = <String, DateTime>{};
  final allEmails = Set<String>();
  final emailToUuuid = <String, String>{};
  final emailsWithMultipleUuid = Set<String>();
  final packagesToMigrate = <Key>[];
  final versionsToMigrate = <Key>[];

  int counter = 0;
  void incCounter(debugFn()) {
    counter++;
    if (counter % 1000 == 0) {
      print(' ... [$counter] (${debugFn()})');
    }
  }

  await withProdServices(() async {
    counter = 0;
    print('Scanning Users...');
    await for (User user in dbService.query<User>().run()) {
      // keep track of multiple emails
      if (emailsWithMultipleUuid.contains(user.email) ||
          emailToUuuid.containsKey(user.email)) {
        emailToUuuid.remove(user.email);
        emailsWithMultipleUuid.add(user.email);
      } else {
        emailToUuuid[user.email] = user.userId;
      }
      incCounter(() => user.id);
    }
    print(
        '${emailsWithMultipleUuid.length} e-mail address have multiple Users.');
    print('${emailToUuuid.length} e-mail -> User mapping.');

    counter = 0;
    print('Scanning Packages...');
    final pkgQuery = dbService.query<Package>();
    await for (Package p in pkgQuery.run()) {
      if (p.uploaders.isEmpty) {
        packagesToMigrate.add(p.key);
      }
      allEmails.addAll(p.uploaderEmails);
      incCounter(() => p.name);
    }
    print('${allEmails.length} current uploader emails found.');
    print('${packagesToMigrate.length} packages to migrate.');

    counter = 0;
    print('Scanning PackageVersion...');
    final pvQuery = dbService.query<PackageVersion>();
    await for (PackageVersion pv in pvQuery.run()) {
      if (pv.uploader == null) {
        versionsToMigrate.add(pv.key);
      }
      allEmails.add(pv.uploaderEmail);
      if (emailFirstUsed.containsKey(pv.uploaderEmail)) {
        final date = emailFirstUsed[pv.uploaderEmail];
        if (date.isAfter(pv.created)) {
          emailFirstUsed[pv.uploaderEmail] = pv.created;
        }
      } else {
        emailFirstUsed[pv.uploaderEmail] = pv.created;
      }
      incCounter(() => pv.package);
    }
    print('${emailFirstUsed.length} historical uploader emails found.');
    print('${versionsToMigrate.length} versions to migrate.');

    counter = 0;
    final emailsToCreate = Set<String>.from(allEmails)
      ..removeAll(emailToUuuid.keys) // existing
      ..removeAll(emailsWithMultipleUuid); // conflicting
    print('Creating Users... [${emailsToCreate.length}]');
    for (String email in emailsToCreate) {
      final id = _uuid.v4().toString();
      final firstUse = emailFirstUsed[email] ?? DateTime.now().toUtc();
      final user = User()
        ..parentKey = dbService.emptyKey
        ..id = id
        ..email = email
        ..created = firstUse;
      await dbService.commit(inserts: [user]);

      emailToUuuid[email] = id;

      incCounter(() => email);
    }

    counter = 0;
    print('Migrating Packages... [${packagesToMigrate.length}]');
    for (Key key in packagesToMigrate) {
      await dbService.withTransaction((tx) async {
        final p = (await tx.lookup<Package>([key])).single;
        p.uploaders =
            p.uploaderEmails.map((email) => emailToUuuid[email]).toList();
        if (p.uploaders.any((s) => s == null)) {
          print('UNABLE TO MIGRATE PACKAGE: ${p.name}.');
          await tx.rollback();
        } else {
          tx.queueMutations(inserts: [p]);
          await tx.commit();
        }
      });
    }

    counter = 0;
    print('Migrating PackageVersions... [${versionsToMigrate.length}]');
    for (Key key in versionsToMigrate) {
      await dbService.withTransaction((tx) async {
        final pv = (await tx.lookup<PackageVersion>([key])).single;
        pv.uploader = emailToUuuid[pv.uploaderEmail];
        if (pv.uploader == null) {
          print(
              'UNABLE TO MIGRATE PACKAGE VERSION: ${pv.package} ${pv.version}.');
          await tx.rollback();
        } else {
          tx.queueMutations(inserts: [pv]);
          await tx.commit();
        }
      });
    }
  });
}
