// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/publisher_api.dart';

import '../../account/backend.dart';
import '../../account/consent_backend.dart';
import '../../publisher/backend.dart';
import '../../shared/configuration.dart';
import 'actions.dart';

final publisherMemberInvite = AdminAction(
  name: 'publisher-member-invite',
  summary: 'Invite a new member to a publisher',
  description: '''
Sends an invite to <email> to become a member of <publisher>.
''',
  options: {
    'publisher': 'Publisher for which to list members, eg `dart.dev`',
    'email': 'email to send invitation to',
  },
  invoke: (options) async {
    final publisherId =
        options['publisher'] ??
        (throw InvalidInputException('Missing --publisher argument.'));

    final invitedEmail =
        options['email'] ??
        (throw InvalidInputException('Missing --email argument.'));

    final publisher = await publisherBackend.lookupPublisher(publisherId);
    if (publisher == null) {
      throw NotFoundException.resource(publisherId);
    }

    final authenticatedAgent = await requireAuthenticatedAdmin(
      AdminPermission.invokeAction,
    );

    await publisherBackend.verifyPublisherMemberInvite(
      publisherId,
      InviteMemberRequest(email: invitedEmail),
    );
    await consentBackend.invitePublisherMember(
      authenticatedAgent: authenticatedAgent,
      publisherId: publisherId,
      invitedUserEmail: invitedEmail,
    );

    return {
      'message': 'Sent invitation',
      'publisher': publisher.publisherId,
      'email': invitedEmail,
    };
  },
);
