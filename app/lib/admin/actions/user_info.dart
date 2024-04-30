// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../account/agent.dart';
import '../../account/backend.dart';
import '../../account/models.dart';
import '../../package/backend.dart';
import '../../publisher/backend.dart';

import 'actions.dart';

final userInfo = AdminAction(
  name: 'user-info',
  summary:
      'List info about a user, including all the packages and publishers that a user is an uploader on.',
  description: '''
Retrieves info about a user.

Output is on this form:
```
{
  'users': [
    {
      'userId': '1c385f28-3a0c-4967-9d74-418bed3ab8b8',
      'email': 'admin@pub.dev',
      'packages': ['flutter_titanium', 'oxygen'],
      'publishers': ['example.com'],
      'moderated': false,
      'created': '2024-04-30T08:16:00.065419Z',
      'deleted': false
    }
  ]
}
```
''',
  options: {
    'user': 'The user-id or the email of the user to inspect',
  },
  invoke: (options) async {
    final userIdOrEmail = options['user'];
    InvalidInputException.check(
      userIdOrEmail != null && userIdOrEmail.isNotEmpty,
      'user must be given',
    );

    final List<User> users;
    if (looksLikeUserId(userIdOrEmail!)) {
      final user = await accountBackend.lookupUserById(userIdOrEmail);
      users = [if (user != null) user];
    } else {
      users = await accountBackend.lookupUsersByEmail(userIdOrEmail);
    }
    if (users.isEmpty) {
      throw InvalidInputException('Unable to locate user.');
    }
    final result = <dynamic>[];
    for (final user in users) {
      final publishers =
          await publisherBackend.listPublishersForUser(user.userId);

      final packages = await packageBackend
          .streamPackagesWhereUserIsUploader(user.userId)
          .toList();

      result.add({
        'userId': user.userId,
        'email': user.email,
        'packages': packages,
        'publishers':
            (publishers.publishers ?? []).map((d) => d.publisherId).toList(),
        'moderated': user.isModerated,
        if (user.isModerated) 'moderatedAt': user.moderatedAt,
        'created': user.created?.toIso8601String(),
        'deleted': user.isDeleted,
      });
    }
    return {'users': result};
  },
);
