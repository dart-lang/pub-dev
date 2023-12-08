// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/admin/actions/actions.dart';
import 'package:pub_dev/publisher/backend.dart';

final publisherMembersList = AdminAction(
  name: 'publisher-members-list',
  summary: 'List all members a publisher',
  description: '''
Get information about publisher and list all members.
''',
  options: {
    'publisher': 'Publisher for which to list members',
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

    return {
      'publisher': publisher.publisherId,
      'description': publisher.description,
      'website': publisher.websiteUrl,
      'contact': publisher.contactEmail,
      'created': publisher.created,
      'members': members
          .map((m) => {
                'email': m.email,
                'role': m.role,
                'userId': m.userId,
              })
          .toList(),
    };
  },
);
