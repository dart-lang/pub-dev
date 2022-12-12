// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:args/args.dart';
import 'package:clock/clock.dart';

import 'package:pub_dev/job/backend.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/datastore.dart';

final _argParser = ArgParser()
  ..addOption('package', help: 'The package to update.')
  ..addFlag('discontinued', help: 'The `isDiscontinued` value to set.')
  ..addOption('replaced-by', help: 'The `replacedBy` value to set.')
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.');

Future<String> executeSetPackageDiscontinued(List<String> args) async {
  final argv = _argParser.parse(args);
  final packageName = argv['package'] as String?;
  final discontinued = argv['discontinued'] as bool?;
  final replacedBy = argv['replaced-by'] as String?;

  if (argv['help'] as bool || packageName == null || discontinued == null) {
    return 'Sets the `isDiscontinued` and `replacedBy` fields for a `package`.\n'
        '  <tools-command> --package <package> --discontinued --replaced-by <otherpkg>\n'
        '${_argParser.usage}';
  }

  final package = (await packageBackend.lookupPackage(packageName));
  if (package == null) {
    return 'Package $packageName not found';
  }
  if (package.isDiscontinued == discontinued &&
      package.replacedBy == replacedBy) {
    return 'No update needed.';
  }
  if (replacedBy != null) {
    final rp = await packageBackend.lookupPackage(replacedBy);
    if (rp == null) {
      return '`$replacedBy` not found.';
    }
  }
  await withRetryTransaction(dbService, (tx) async {
    final pkg = await tx.lookupValue<Package>(package.key);
    pkg.isDiscontinued = discontinued;
    pkg.replacedBy = replacedBy;
    pkg.updated = clock.now().toUtc();
    tx.insert(pkg);
  });
  await purgePackageCache(packageName);
  await jobBackend.trigger(JobService.analyzer, packageName,
      version: package.latestVersion);
  return 'Done.';
}
