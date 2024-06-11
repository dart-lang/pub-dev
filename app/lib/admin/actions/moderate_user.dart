// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';

import '../../account/agent.dart';
import '../../account/backend.dart';
import '../../account/models.dart';
import '../../package/backend.dart';
import '../../package/models.dart';
import '../../publisher/backend.dart';
import '../../shared/datastore.dart';

import '../backend.dart';
import '../models.dart';

import 'actions.dart';

final moderateUser = AdminAction(
  name: 'moderate-user',
  summary:
      'Set the moderated flag on a user (making user invisible and unable to login).',
  description: '''
Set the moderated flag on a user (updating the flag and the timestamp). The
moderated user will not be able to sign-in or be authenticated via JWT token,
and actions that they may be able to do will be blocked because of that.
The active web sessions of the user will be expired.
''',
  options: {
    'case': 'The ModerationCase.caseId that this action is part of.',
    'user': 'The user-id or the email of the user to be moderated',
    'reason': 'The reason for user moderation.',
    'state':
        'Set moderated state true / false. Returns current state if omitted.',
    'message': 'Optional message to store.'
  },
  invoke: (options) async {
    final caseId = options['case'];

    final userIdOrEmail = options['user'];
    InvalidInputException.check(
      userIdOrEmail != null && userIdOrEmail.isNotEmpty,
      'user must be given',
    );

    final moderatedReason = options['reason'];
    final message = options['message'];

    final refCase =
        await adminBackend.loadAndVerifyModerationCaseForAdminAction(
      caseId,
      status: ModerationStatus.pending,
    );

    User? user;
    if (looksLikeUserId(userIdOrEmail!)) {
      user = await accountBackend.lookupUserById(userIdOrEmail);
    } else {
      final users = await accountBackend.lookupUsersByEmail(userIdOrEmail);
      InvalidInputException.check(users.length == 1,
          'Expected a single User, got ${users.length}: ${users.map((e) => e.userId).join(', ')}.');
      user = users.single;
    }
    InvalidInputException.check(user != null, 'Unable to locate user.');

    final state = options['state'];
    bool? valueToSet;
    switch (state) {
      case 'true':
        valueToSet = true;
        break;
      case 'false':
        valueToSet = false;
        break;
    }

    User? user2;
    if (valueToSet != null) {
      await accountBackend.updateModeratedFlag(
        user!.userId,
        valueToSet,
        refCaseKey: refCase?.key,
        moderatedReason: moderatedReason,
        message: message,
      );
      user2 = await accountBackend.lookupUserById(user.userId);

      if (valueToSet) {
        await for (final p
            in packageBackend.streamPackagesWhereUserIsUploader(user.userId)) {
          await withRetryTransaction(dbService, (tx) async {
            final key = dbService.emptyKey.append(Package, id: p);
            final pkg = await tx.lookupOrNull<Package>(key);
            if (pkg == null || pkg.isDiscontinued || pkg.uploaderCount != 1) {
              return;
            }
            pkg.isDiscontinued = true;
            pkg.updated = clock.now().toUtc();
            tx.insert(pkg);
          });
        }

        final publishers =
            await publisherBackend.listPublishersForUser(user.userId);
        for (final e in publishers.publishers!) {
          final p = await publisherBackend.getPublisher(e.publisherId);
          if (p == null) {
            continue;
          }
          // Only restrict publishers where the user was a single active admin.
          // Note: at this point the User.isModerated flag is already set.
          final members =
              await publisherBackend.listPublisherMembers(e.publisherId);
          var nonBlockedCount = 0;
          for (final member in members) {
            final mu = await accountBackend.lookupUserById(member.userId);
            if (mu?.isVisible ?? false) {
              nonBlockedCount++;
            }
          }
          if (nonBlockedCount > 0) {
            continue;
          }

          final query = dbService.query<Package>()
            ..filter('publisherId =', e.publisherId);
          await for (final p in query.run()) {
            if (p.isDiscontinued) continue;
            await withRetryTransaction(dbService, (tx) async {
              final pkg = await tx.lookupOrNull<Package>(p.key);
              if (pkg == null || pkg.isDiscontinued) {
                return;
              }
              pkg.isDiscontinued = true;
              pkg.updated = clock.now().toUtc();
              tx.insert(pkg);
            });
          }
        }
      }
    }

    return {
      'userId': user!.userId,
      'before': {
        'isModerated': user.isModerated,
        'moderatedAt': user.moderatedAt?.toIso8601String(),
        'moderatedReason': user.moderatedReason,
      },
      if (user2 != null)
        'after': {
          'isModerated': user2.isModerated,
          'moderatedAt': user2.moderatedAt?.toIso8601String(),
          'moderatedReason': user2.moderatedReason,
        },
    };
  },
);
