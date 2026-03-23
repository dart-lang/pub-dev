// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/admin/actions/actions.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/publisher/backend.dart';
import 'package:pub_dev/publisher/models.dart';
import 'package:pub_dev/shared/datastore.dart';

final publisherDelete = AdminAction(
  name: 'publisher-delete',
  options: {'publisher': 'name of publisher to delete'},
  summary: 'Deletes publisher <publisher>.',
  description: '''
Deletes publisher <publisher>.

The publisher must have no packages. If not the operation will fail.

All member-info will be lost.

The publisher can be regenerated later (no tombstoning).
''',
  invoke: (args) async {
    final publisherId = args['publisher'];
    if (publisherId == null) {
      throw InvalidInputException('Missing `publisher` argument');
    }

    final packagesQuery = dbService.query<Package>()
      ..filter('publisherId =', publisherId);
    final packages = await packagesQuery.run().toList();
    if (packages.isNotEmpty) {
      throw NotAcceptableException(
        'Publisher "$publisherId" cannot be deleted, as it has package(s): '
        '${packages.map((e) => e.name!).join(', ')}.',
      );
    }

    int? memberCount;
    final memberIds = <String>[];
    await withRetryTransaction(dbService, (tx) async {
      final key = dbService.emptyKey.append(Publisher, id: publisherId);
      final publisher = await tx.lookupOrNull<Publisher>(key);
      final membersQuery = tx.query<PublisherMember>(key);
      final members = await membersQuery.run().toList();
      memberCount = members.length;
      if (publisher != null) {
        tx.delete(key);
      }
      for (final m in members) {
        memberIds.add(m.userId!);
        tx.delete(m.key);
      }
    });

    await purgePublisherCache(publisherId);
    for (final userId in memberIds) {
      await purgeAccountCache(userId: userId);
    }

    return {
      'message': 'Publisher and all members deleted.',
      'publisherId': publisherId,
      'members-count': memberCount,
    };
  },
);
