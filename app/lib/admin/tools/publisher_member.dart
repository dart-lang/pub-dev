// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:_pub_shared/data/publisher_api.dart';
import 'package:pub_dev/account/agent.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/consent_backend.dart';
import 'package:pub_dev/publisher/backend.dart';
import 'package:pub_dev/shared/configuration.dart';

Future<String> executePublisherMember(List<String> args) async {
  if (args.length != 1) {
    return 'Tool to check publisher member info.\n'
        '  <tools-command> <publisherId> - list current members\n';
  }
  final publisherId = args.single;

  final members = await publisherBackend.listPublisherMembers(publisherId);
  return members.map((e) => '${e.userId} ${e.email} ${e.role}\n').join();
}

Future<String> executePublisherInviteMember(List<String> args) async {
  if (args.length != 2) {
    print(args);
    return 'Tool to invite publisher member as new admin.\n'
        '  <tools-command> <publisherId> <email> - send invite to new admin\n';
  }
  final publisherId = args[0].toLowerCase();
  final invitedEmail = args[1].toLowerCase();

  final authenticatedAgent =
      await requireAuthenticatedAdmin(AdminPermission.executeTool);
  await publisherBackend.verifyPublisherMemberInvite(
      publisherId, InviteMemberRequest(email: invitedEmail));
  await consentBackend.invitePublisherMember(
    authenticatedAgent: SupportAgent(),
    activeUser: await accountBackend.userForServiceAccount(authenticatedAgent),
    publisherId: publisherId,
    invitedUserEmail: invitedEmail,
  );

  return '$invitedEmail has been invited.';
}
