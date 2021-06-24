// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.9

import 'dart:async';
import 'dart:io';

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/publisher/backend.dart';
import 'package:pub_dev/publisher/models.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';
import 'package:pub_dev/shared/datastore.dart';

void _printHelp() {
  print('Remove publisher and blocks all members.');
  print(
      '  dart bin/tools/remove_publisher_and_block_all_members.dart <publisherId>');
}

Future main(List<String> args) async {
  if (args.isEmpty || args.length > 1) {
    _printHelp();
    return;
  }
  final publisherId = args.single;

  await withToolRuntime(() async {
    final publisher = await publisherBackend.getPublisher(publisherId);
    final members = await publisherBackend.listPublisherMembers(publisherId);

    print('Publisher:    ${publisher.publisherId}');
    print('Description:  ${publisher.description.replaceAll('\n', ' ')}');
    print('Website:      ${publisher.websiteUrl}');
    print('Contact:      ${publisher.contactEmail}');
    print('Created on:   ${publisher.created}');
    print('Members:');
    for (final m in members) {
      print(' - ${m.role} ${m.email}');
    }
    print('');
    print('Are you sure to remove the publisher and block all members?');
    print('');
    print('Type YES to continue:');
    final confirm = stdin.readLineSync();
    if (confirm != 'YES') {
      print('Aborted.');
      return;
    }

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
  });
}
