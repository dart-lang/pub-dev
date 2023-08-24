// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/admin/actions/actions.dart';
import 'package:pub_dev/publisher/backend.dart';
import 'package:pub_dev/publisher/models.dart';
import 'package:pub_dev/shared/datastore.dart';

final publisherBlock = AdminAction(
  name: 'publisher-block',
  summary: 'Block publisher and block all members',
  description: '''
Get information about publisher and list all members.
''',
  options: {
    'publisher': 'Publisher to be blocked',
  },
  invoke: (options) async {
    final publisherId = options['publisher']!;
    InvalidInputException.check(
      publisherId.isNotEmpty,
      'publisher must be given',
    );

    final publisher = await publisherBackend.getPublisher(publisherId);
    if (publisher == null) {
      throw NotFoundException.resource(publisherId);
    }
    final members = await publisherBackend.listPublisherMembers(publisherId);

    for (final m in members) {
      await accountBackend.updateBlockedFlag(m.userId, true);
    }

    final publisherKey = dbService.emptyKey.append(Publisher, id: publisherId);
    await withRetryTransaction(dbService, (tx) async {
      final p = await tx.lookupValue<Publisher>(publisherKey);
      p.markForBlocked();
      tx.insert(p);
    });

    return {
      'publisher': publisher.publisherId,
      'description': publisher.description,
      'website': publisher.websiteUrl,
      'contact': publisher.contactEmail,
      'created': publisher.created,
      'blocked': true,
      'members': members
          .map((m) => {
                'email': m.email,
                'role': m.role,
                'userId': m.userId,
                'blocked': true,
              })
          .toList(),
    };
  },
);
