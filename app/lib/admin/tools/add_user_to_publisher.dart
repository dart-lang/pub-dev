// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:args/args.dart';
import 'package:clock/clock.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/audit/models.dart';
import 'package:pub_dev/publisher/backend.dart';
import 'package:pub_dev/publisher/models.dart';
import 'package:pub_dev/shared/datastore.dart';

final _argParser = ArgParser()
  ..addOption('user', help: 'The e-mail address of the user to be added.')
  ..addOption('publisher-id',
      help: 'The ID of the publisher the user should be added to.')
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.')
  ..addOption('admin', help: 'email of pub administrator who authorized this');

Future<String> executeAddUserToPublisher(List<String> args) async {
  final argv = _argParser.parse(args);
  final publisherId = argv['publisher-id'] as String?;
  final userEmail = argv['user'] as String?;
  final adminEmail = argv['admin'] as String?;

  if (argv['help'] as bool ||
      publisherId == null ||
      userEmail == null ||
      adminEmail == null) {
    return 'Adds a user to a publisher.';
  }
  final publisher = await publisherBackend.getPublisher(publisherId);

  if (publisher == null) {
    return 'No such publisher.';
  }
  final users = await accountBackend.lookupUsersByEmail(userEmail);
  if (users.isEmpty) {
    return 'User with e-mail address $userEmail not found.';
  }
  if (users.length > 1) {
    return 'More than one user with e-mail address $userEmail found.';
  }
  final user = users.single;
  final admins = await accountBackend.lookupUsersByEmail(userEmail);
  if (admins.isEmpty) {
    return 'Admin with e-mail address $adminEmail not found.';
  }
  if (admins.length > 1) {
    return 'More than one admin with e-mail address $adminEmail found.';
  }
  final admin = admins.single;

  final now = clock.now().toUtc();
  await withRetryTransaction(dbService, (tx) async {
    final p = await tx.lookupOrNull<Publisher>(publisher.key);
    if (p == null) {
      return;
    }
    tx.queueMutations(inserts: [
      PublisherMember()
        ..parentKey = p.key
        ..id = user.userId
        ..created = now
        ..updated = now
        ..role = PublisherMemberRole.admin,
      AuditLogRecord.publisherMemberAdded(
        activeUser: admin,
        memberToAdd: user,
        publisherId: publisherId,
      )
    ]);
  });
  return '';
}
