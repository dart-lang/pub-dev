// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/publisher/backend.dart';
import 'package:pub_dev/publisher/models.dart';
import 'package:pub_dev/shared/datastore.dart';

Future<String> executeRemovePublisherAndBlockAllMembers(
    List<String> args) async {
  if (args.isEmpty ||
      args.length > 2 ||
      (args.length == 2 && args[1] != 'delete')) {
    return 'Remove publisher and blocks all members.\n'
        '  <tools-command> <publisherId> # list publisher data\n'
        '  <tools-command> <publisherId> delete # remove publisher and block members\n';
  }
  final publisherId = args.first;
  final isDelete = args.length == 2 && args[1] == 'delete';

  final publisher = (await publisherBackend.getPublisher(publisherId))!;
  final members = await publisherBackend.listPublisherMembers(publisherId);

  final output = StringBuffer()
    ..writeln('Publisher:    ${publisher.publisherId}')
    ..writeln('Description:  ${publisher.description!.replaceAll('\n', ' ')}')
    ..writeln('Website:      ${publisher.websiteUrl}')
    ..writeln('Contact:      ${publisher.contactEmail}')
    ..writeln('Created on:   ${publisher.created}')
    ..writeln('Members:');
  for (final m in members) {
    output.writeln(' - ${m.role} ${m.email}');
  }

  if (!isDelete) return output.toString();

  for (final m in members) {
    await accountBackend.updateBlockedFlag(m.userId, true);
  }

  final publisherKey = dbService.emptyKey.append(Publisher, id: publisherId);
  await withRetryTransaction(dbService, (tx) async {
    tx.delete(publisherKey);
    for (final m in members) {
      tx.delete(publisherKey.append(PublisherMember, id: m.userId));
    }
  });
  output.writeln('Deleted.');
  return output.toString();
}
