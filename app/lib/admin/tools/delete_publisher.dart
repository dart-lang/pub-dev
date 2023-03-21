// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:args/args.dart';

import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/publisher/models.dart';
import 'package:pub_dev/shared/datastore.dart';

final _argParser = ArgParser()
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.')
  ..addOption('publisher', help: 'name of publisher to delete');

Future<String> executeDeletePublisher(List<String> args) async {
  final argv = _argParser.parse(args);

  if (argv['help'] as bool) {
    return 'Delete a publisher using admin rights.\n'
        '- Can only delete publishers with no packages.\n'
        '- Will not leave a tombstone, the publisher can be recreated.\n'
        '${_argParser.usage}';
  }

  final publisherId = argv['publisher'] as String?;
  if (publisherId == null) {
    return '--publisher is required!\n${_argParser.usage}';
  }

  final packagesQuery = dbService.query<Package>()
    ..filter('publisherId =', publisherId);
  final packages = await packagesQuery.run().toList();
  if (packages.isNotEmpty) {
    return 'Publisher "$publisherId" cannot be deleted, as it has package(s): '
        '${packages.map((e) => e.name!).join(', ')}.';
  }

  final key = dbService.emptyKey.append(Publisher, id: publisherId);
  final membersQuery = dbService.query<PublisherMember>(ancestorKey: key);
  final members = await membersQuery.run().toList();

  await withRetryTransaction(dbService, (tx) async {
    final p = await tx.lookupOrNull<Publisher>(key);
    if (p != null) {
      tx.delete(key);
    }
    for (final m in members) {
      tx.delete(m.key);
    }
  });

  return 'Publisher and ${members.length} member(s) deleted.';
}
