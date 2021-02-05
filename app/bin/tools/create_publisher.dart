// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:args/args.dart';

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/audit/models.dart';
import 'package:pub_dev/publisher/models.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/exceptions.dart';

final _argParser = ArgParser()
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.')
  ..addOption('publisher', help: 'name of publisher to create')
  ..addOption('member', help: 'email of user to add')
  ..addOption('admin', help: 'email of pub administrator who authorized this');

/// Sets the private key value.
Future main(List<String> args) async {
  final argv = _argParser.parse(args);

  if (argv['help'] as bool == true) {
    print('Create a publisher using admin rights.');
    print(_argParser.usage);
    return;
  }

  final publisherId = argv['publisher'] as String;
  final userEmail = argv['member'] as String;
  final adminEmail = argv['admin'] as String;
  if (publisherId == null || userEmail == null || adminEmail == null) {
    print('--publisher, --member and --admin is required!');
    print(_argParser.usage);
    return;
  }

  await withToolRuntime(() async {
    final users = await accountBackend.lookupUsersByEmail(userEmail);
    if (users.isEmpty) {
      print('ERROR: unknown user: $userEmail');
      return;
    }
    if (users.length > 1) {
      print('ERROR: more than one user: $userEmail');
      return;
    }
    final user = users.single;
    final admins = await accountBackend.lookupUsersByEmail(adminEmail);
    if (admins.isEmpty) {
      print('ERROR: unknown user: $adminEmail');
      return;
    }
    if (admins.length > 1) {
      print('ERROR: more than one user: $adminEmail');
      return;
    }

    // Create the publisher
    final now = DateTime.now().toUtc();
    await withRetryTransaction(dbService, (tx) async {
      final key = dbService.emptyKey.append(Publisher, id: publisherId);
      final p = await tx.lookupValue<Publisher>(key, orElse: () => null);
      if (p != null) {
        // Check that publisher is the same as what we would create.
        if (p.created.isBefore(now.subtract(Duration(minutes: 10))) ||
            p.updated.isBefore(now.subtract(Duration(minutes: 10))) ||
            p.contactEmail != user.email ||
            p.description != '' ||
            p.websiteUrl != _publisherWebsite(publisherId)) {
          throw ConflictException.publisherAlreadyExists(publisherId);
        }
        // Avoid creating the same publisher again, this end-point is idempotent
        // if we just do nothing here.
        return;
      }

      // Create publisher
      tx.queueMutations(inserts: [
        Publisher()
          ..parentKey = dbService.emptyKey
          ..id = publisherId
          ..created = now
          ..description = ''
          ..contactEmail = user.email
          ..updated = now
          ..websiteUrl = _publisherWebsite(publisherId)
          ..isAbandoned = false,
        PublisherMember()
          ..parentKey = dbService.emptyKey.append(Publisher, id: publisherId)
          ..id = user.userId
          ..userId = user.userId
          ..created = now
          ..updated = now
          ..role = PublisherMemberRole.admin,
        AuditLogRecord.publisherCreated(
          user: user,
          publisherId: publisherId,
        ),
      ]);
    });
  });
}

String _publisherWebsite(String domain) => 'https://$domain/';
