// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:typed_sql/typed_sql.dart';

import 'actions.dart';

final packageReservationList = AdminAction(
  name: 'package-reservation-list',
  summary: 'Lists all ReservedPackage entities.',
  description: '''
Returns the list of all ReservedPackage entities and the allowed emails.
''',
  options: {},
  invoke: (options) async {
    final rows = await primaryDatabase.withRetry(
      (db) => db.reservedPackages
          .orderBy((r) => [(r.name, Order.ascending)])
          .fetch(),
    );

    return {
      'packages': rows
          .map((rp) => {'name': rp.name, 'emails': rp.emails})
          .toList(),
    };
  },
);
