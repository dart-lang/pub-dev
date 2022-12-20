// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:args/args.dart';
import 'package:clock/clock.dart';

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/audit/models.dart';
import 'package:pub_dev/publisher/models.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/exceptions.dart';

final _argParser = ArgParser()
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.')
  ..addOption('publisher', help: 'name of publisher to create')
  ..addOption('member', help: 'email of user to add')
  ..addOption('admin', help: 'email of pub administrator who authorized this');

Future<String> executeCreatePublisher(List<String> args) async {
  final argv = _argParser.parse(args);

  if (argv['help'] as bool) {
    return 'Create a publisher using admin rights.\n${_argParser.usage}';
  }

  final publisherId = argv['publisher'] as String?;
  final userEmail = argv['member'] as String?;
  final adminEmail = argv['admin'] as String?;
  if (publisherId == null || userEmail == null || adminEmail == null) {
    return '--publisher, --member and --admin is required!\n${_argParser.usage}';
  }

  final users = await accountBackend.lookupUsersByEmail(userEmail);
  if (users.isEmpty) {
    return 'ERROR: unknown user: $userEmail';
  }
  if (users.length > 1) {
    return 'ERROR: more than one user: $userEmail';
  }
  final user = users.single;
  final admins = await accountBackend.lookupUsersByEmail(adminEmail);
  if (admins.isEmpty) {
    return 'ERROR: unknown user: $adminEmail';
  }
  if (admins.length > 1) {
    return 'ERROR: more than one user: $adminEmail';
  }
  final admin = admins.single;

  // Create the publisher
  final now = clock.now().toUtc();
  return await withRetryTransaction(dbService, (tx) async {
    final key = dbService.emptyKey.append(Publisher, id: publisherId);
    final p = await tx.lookupOrNull<Publisher>(key);
    if (p != null) {
      // Check that publisher is the same as what we would create.
      if (p.created!.isBefore(now.subtract(Duration(minutes: 10))) ||
          p.updated!.isBefore(now.subtract(Duration(minutes: 10))) ||
          p.contactEmail != user.email ||
          p.description != '' ||
          p.websiteUrl != defaultPublisherWebsite(publisherId)) {
        throw ConflictException.publisherAlreadyExists(publisherId);
      }
      // Avoid creating the same publisher again, this end-point is idempotent
      // if we just do nothing here.
      return 'Nothing to do.';
    }

    // Create publisher
    tx.queueMutations(inserts: [
      Publisher.init(
        parentKey: dbService.emptyKey,
        publisherId: publisherId,
        contactEmail: user.email,
      ),
      PublisherMember()
        ..parentKey = dbService.emptyKey.append(Publisher, id: publisherId)
        ..id = user.userId
        ..userId = user.userId
        ..created = now
        ..updated = now
        ..role = PublisherMemberRole.admin,
      AuditLogRecord.publisherCreated(
        user: admin,
        publisherId: publisherId,
      ),
    ]);
    return 'Publisher created.';
  });
}
