// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/admin/actions/actions.dart';
import 'package:pub_dev/publisher/backend.dart';

final publisherMembersList = AdminAction(
  name: 'publisher-members-list',
  summary: 'List all members of a publisher',
  description: '''
Get information about a publisher and list all its members.
''',
  options: {
    'publisher': 'Publisher for which to list members, eg `dart.dev`',
  },
  invoke: (options) async {
    final publisherId = options['publisher'] ??
        (throw InvalidInputException('Missing --publisher argument.'));

    final publisher = await publisherBackend.lookupPublisher(publisherId);
    if (publisher == null) {
      throw NotFoundException.resource(publisherId);
    }
    final members = await publisherBackend.listPublisherMembers(publisherId);

    return {
      'publisher': publisher.publisherId,
      'description': publisher.description,
      'website': publisher.websiteUrl,
      'contact': publisher.contactEmail,
      'created': publisher.created?.toIso8601String(),
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
