// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:args/args.dart';

import 'package:pub_dev/package/backend.dart';

final _argParser = ArgParser()
  ..addOption('concurrency',
      abbr: 'c', defaultsTo: '1', help: 'Number of concurrent processing.')
  ..addOption('package', abbr: 'p', help: 'The package to update.')
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.');

Future<String> executeUpdatePackageVersions(List<String> args) async {
  final argv = _argParser.parse(args);
  if (argv['help'] as bool) {
    return 'Ensures Package.latestVersion / latestPreviewVersion / latestPrereleaseVersion is up-to-date.'
        'Usage: <tool> --package [pkg] -- updates package\n'
        '${_argParser.usage}';
  }

  final concurrency = int.parse(argv['concurrency'] as String);
  final package = argv['package'] as String?;

  if (package != null) {
    final stat = await packageBackend.updatePackageVersions(package);
    return stat ? 'Updated.' : 'No change.';
  } else {
    final stat =
        await packageBackend.updateAllPackageVersions(concurrency: concurrency);
    return 'Updated $stat packages.';
  }
}
