// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
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

Future<String> executeSetPackagePublisher(List<String> args) async {
  final argv = _argParser.parse(args);
  final packageName = argv['package'] as String?;
  final publisherId = argv['publisher-id'] as String?;

  if (argv['help'] as bool || packageName == null || publisherId == null) {
    return 'Sets a new `publisherId` for a `package`.\n'
        '  <tools-command> --package <package> --publisher-id <publisherId>\n'
        '${_argParser.usage}';
  }

  final package = (await packageBackend.lookupPackage(packageName))!;
  final publisher = await publisherBackend.lookupPublisher(publisherId);
  if (publisher == null) {
    return 'No such publisher.';
  }
  final currentPublisherId = package.publisherId;
  if (currentPublisherId == publisherId) {
    return 'No update needed.';
  }
  await withRetryTransaction(dbService, (tx) async {
    final pkg = await tx.lookupValue<Package>(package.key);
    pkg.publisherId = publisherId;
    pkg.updated = clock.now().toUtc();
    tx.insert(pkg);
  });
  await purgePublisherCache(publisherId: publisherId);
  triggerPackagePostUpdates(
    packageName,
    skipReanalysis: true,
    skipVersionsExport: true,
  );
  if (currentPublisherId != null) {
    await purgePublisherCache(publisherId: currentPublisherId);
  }
  return 'Done.';
}
