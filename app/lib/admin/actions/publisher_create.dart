// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/admin/actions/actions.dart';
import 'package:pub_dev/audit/models.dart';
import 'package:pub_dev/publisher/models.dart';
import 'package:pub_dev/shared/datastore.dart';

final publisherCreate = AdminAction(
    name: 'publisher-create',
    options: {
      'publisher': 'name of publisher to create',
      'member-email': 'email of user to add',
    },
    summary:
        'Creates a new publisher <publisher> and adds <member-email> as the single member.',
    description: '''
Creates a new publisher <publisher> and adds <member-email> as the single member.

This should generally only be done with PM approval as it skips actual domain verification.
''',
    invoke: (args) async {
      final publisherId = args['publisher'];
      final userEmail = args['member-email'];
      if (publisherId == null) {
        throw InvalidInputException('Missing --publisher argument.');
      }
      if (userEmail == null) {
        throw InvalidInputException('Missing --member-email argument.');
      }
      final users = await accountBackend.lookupUsersByEmail(userEmail);
      if (users.isEmpty) {
        throw InvalidInputException('Unknown user: $userEmail');
      }
      if (users.length > 1) {
        throw InvalidInputException('more than one user: $userEmail');
      }
      final user = users.single;

      // Create the publisher
      final now = clock.now().toUtc();
      await withRetryTransaction(dbService, (tx) async {
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
          return {
            'message': 'Publisher already exists.',
            'publisherId': publisherId,
          };
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
          await AuditLogRecord.publisherCreated(
            user: user,
            publisherId: publisherId,
          ),
        ]);
      });
      return {
        'message': 'Publisher created.',
        'publisherId': publisherId,
        'member-email': userEmail,
      };
    });
