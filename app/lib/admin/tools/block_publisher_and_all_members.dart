// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/publisher/backend.dart';
import 'package:pub_dev/publisher/models.dart';
import 'package:pub_dev/shared/datastore.dart';

Future<String> executeBlockPublisherAndAllMembers(List<String> args) async {
  if (args.isEmpty ||
      args.length != 2 ||
      (args[0] != 'block' && args[0] != 'list')) {
    return 'Remove publisher and blocks all members.\n'
        '  <tools-command> list <publisherId> # list publisher data\n'
        '  <tools-command> block <publisherId> # block publisher and all members\n';
  }
  final command = args[0];
  final publisherId = args[1];

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

  if (command == 'list') {
    return output.toString();
  } else if (command == 'block') {
    for (final m in members) {
      await accountBackend.updateBlockedFlag(m.userId, true);
    }

    final publisherKey = dbService.emptyKey.append(Publisher, id: publisherId);
    await withRetryTransaction(dbService, (tx) async {
      final p = await tx.lookupValue<Publisher>(publisherKey);
      p.markForBlocked();
      tx.insert(p);
    });
    output.writeln('Blocked.');
    return output.toString();
  } else {
    return 'Unknown command: $command.';
  }
}
