// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../account/backend.dart';

import 'actions.dart';

final userSessionMigrate = AdminAction(
  name: 'user-session-migrate',
  summary:
      'Copy UserSession entities between the Datastore and the SQL database.',
  description: '''
Action that copies `UserSession` entities between the Datastore and the SQL database.

By default it copies from Datastore into the SQL database:
  --reverse=false (default)

Set `--reverse=true` to copy from the SQL database back into Datastore:
  --reverse=true

In both directions the entry with the newer `expires` timestamp wins.
The action is safe to run repeatedly and in either order.
''',
  options: {
    'reverse': 'true/false to copy SQL -> Datastore instead (default: false)',
  },
  invoke: (options) async {
    final reverseString = options['reverse'] ?? 'false';
    InvalidInputException.checkAnyOf(reverseString, 'reverse', [
      'true',
      'false',
    ]);
    final reverse = reverseString == 'true';

    final result = reverse
        ? await accountBackend.copyUserSessionsFromSqlToDatastore()
        : await accountBackend.copyUserSessionsFromDatastoreToSql();

    return {
      'reverse': reverse,
      'scanned': result.scanned,
      'updated': result.updated,
    };
  },
);
