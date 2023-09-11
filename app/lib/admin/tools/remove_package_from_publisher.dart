// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:args/args.dart';
import 'package:clock/clock.dart';

import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/publisher/backend.dart';
import 'package:pub_dev/shared/datastore.dart';

final _argParser = ArgParser()
  ..addOption('package', help: 'The package to update.')
  ..addOption('publisher-id', help: 'The `publisherId` to set.')
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.');

Future<String> executeRemovePackageFromPublisher(List<String> args) async {
  final argv = _argParser.parse(args);
  final packageName = argv['package'] as String?;

  if (argv['help'] as bool || packageName == null) {
    return 'Removes <package> from its current publisher, and makes that publisher\s owners uploaders`.\n'
        '  <tools-command> --package <package>\n'
        '${_argParser.usage}';
  }

  final package = (await packageBackend.lookupPackage(packageName))!;
  final currentPublisherId = package.publisherId;
  if (currentPublisherId == null) {
    return 'Package $package is not currently in a publisher';
  }
  final currentPublisherMembers =
      (await publisherBackend.listPublisherMembers(currentPublisherId));

  await withRetryTransaction(dbService, (tx) async {
    final pkg = await tx.lookupValue<Package>(package.key);
    pkg.publisherId = null;
    pkg.uploaders = currentPublisherMembers.map((e) => e.userId).toList();
    pkg.updated = clock.now().toUtc();
    tx.insert(pkg);
  });
  await purgePackageCache(packageName);
  await purgePublisherCache(publisherId: currentPublisherId);
  return 'Done.';
}
