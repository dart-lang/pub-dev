// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:pub_dev/publisher/models.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:test/test.dart';
import 'package:typed_sql/typed_sql.dart';

/// Expects that the SQL rows of [publisherId] (and its members) match the
/// Datastore entities, or that none of them exist when the publisher is gone.
Future<void> expectPublisherInSqlMatchesDatastore(String publisherId) async {
  final p = await dbService.lookupOrNull<Publisher>(
    dbService.emptyKey.append(Publisher, id: publisherId),
  );
  final members = p == null
      ? const <PublisherMember>[]
      : await dbService
            .query<PublisherMember>(ancestorKey: p.key)
            .run()
            .toList();
  final row = await primaryDatabase.withRetry(
    (db) => db.publishers.byKey(publisherId).fetch(),
  );
  final memberRows = await primaryDatabase.withRetry(
    (db) => db.publisherMembers
        .where((m) => m.publisherId.equalsValue(publisherId))
        .fetch(),
  );

  if (p == null) {
    expect(row, isNull, reason: 'publisher $publisherId');
    expect(memberRows, isEmpty, reason: 'members of $publisherId');
    return;
  }
  expect(row, isNotNull, reason: 'publisher $publisherId');
  expect(
    {
      'description': row!.description,
      'websiteUrl': row.websiteUrl,
      'contactEmail': row.contactEmail,
      'createdAt': _micros(row.createdAt),
      'updatedAt': _micros(row.updatedAt),
      'isAbandoned': row.isAbandoned,
      'isModerated': row.isModerated,
      'moderatedAt': _micros(row.moderatedAt),
    },
    {
      'description': p.description,
      'websiteUrl': p.websiteUrl,
      'contactEmail': p.contactEmail,
      'createdAt': _micros(p.created),
      'updatedAt': _micros(p.updated),
      'isAbandoned': p.isAbandoned,
      'isModerated': p.isModerated,
      'moderatedAt': _micros(p.moderatedAt),
    },
    reason: 'publisher $publisherId',
  );
  expect(
    {
      for (final m in memberRows)
        m.userId: {
          'createdAt': _micros(m.createdAt),
          'updatedAt': _micros(m.updatedAt),
          'role': m.role,
        },
    },
    {
      for (final m in members)
        m.userId!: {
          'createdAt': _micros(m.created),
          'updatedAt': _micros(m.updated),
          'role': m.role,
        },
    },
    reason: 'members of $publisherId',
  );
}

int? _micros(DateTime? value) => value?.microsecondsSinceEpoch;
