// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/account/agent.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/models.dart';

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
    'user': 'The user-id or the email of the user to be moderated',
    'state':
        'Set moderated state true / false. Returns current state if omitted.',
  },
  invoke: (options) async {
    final userIdOrEmail = options['user'];
    InvalidInputException.check(
      userIdOrEmail != null && userIdOrEmail.isNotEmpty,
      'user must be given',
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
      await accountBackend.updateModeratedFlag(user!.userId, valueToSet);
      user2 = await accountBackend.lookupUserById(user.userId);
    }

    return {
      'userId': user!.userId,
      'before': {
        'isModerated': user.isModerated,
        'moderatedAt': user.moderatedAt?.toIso8601String(),
      },
      if (user2 != null)
        'after': {
          'isModerated': user2.isModerated,
          'moderatedAt': user2.moderatedAt?.toIso8601String(),
        },
    };
  },
);
