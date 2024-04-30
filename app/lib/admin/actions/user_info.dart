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
  'userId': 'e55b9604-933f-4492-bf55-66cb6c57d7b0',
  'email': 'admin@pub.dev',
  'packages': ['flutter_titanium', 'oxygen'],
  'publishers': ['example.com'],
  'moderated': false,
  'created': '2024-04-30T07:32:19.000041Z',
  'deleted': false
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

    User? user;
    if (looksLikeUserId(userIdOrEmail!)) {
      user = await accountBackend.lookupUserById(userIdOrEmail);
    } else {
      final users = await accountBackend.lookupUsersByEmail(userIdOrEmail);
      InvalidInputException.check(users.length == 1,
          'Expected a single User, got ${users.length}: ${users.map((e) => e.userId).join(', ')}.');
      user = users.single;
    }
    if (user == null) {
      throw InvalidInputException('Unable to locate user.');
    }

    final publishers =
        await publisherBackend.listPublishersForUser(user.userId);

    final packages = await packageBackend
        .streamPackagesWhereUserIsUploader(user.userId)
        .toList();

    return {
      'userId': user.userId,
      'email': user.email,
      'packages': packages,
      'publishers':
          (publishers.publishers ?? []).map((d) => d.publisherId).toList(),
      'moderated': user.isModerated,
      if (user.isModerated) 'moderatedAt': user.moderatedAt,
      'created': user.created?.toIso8601String(),
      'deleted': user.isDeleted,
    };
  },
);
