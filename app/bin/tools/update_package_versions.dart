// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:args/args.dart';
import 'package:pub_dev/package/backend.dart';

import 'package:pub_dev/service/entrypoint/tools.dart';

final _argParser = ArgParser()
  ..addOption('concurrency',
      abbr: 'c', defaultsTo: '1', help: 'Number of concurrent processing.')
  ..addOption('package', abbr: 'p', help: 'The package to update.')
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.');

Future main(List<String> args) async {
  final argv = _argParser.parse(args);
  if (argv['help'] as bool == true) {
    print('Usage: dart update_package_versions.dart');
    print('Ensures Package.latestVersion is up-to-date.');
    print('Ensures Package.latestPreviewVersion is up-to-date.');
    print('Ensures Package.latestPrereleaseVersion is up-to-date.');
    print(_argParser.usage);
    return;
  }

  final concurrency = int.parse(argv['concurrency'] as String);
  final package = argv['package'] as String;

  await withToolRuntime(() async {
    if (package != null) {
      final stat = await packageBackend.updatePackageVersions(package);
      print(stat);
    } else {
      final stat = await packageBackend.updateAllPackageVersions(
          concurrency: concurrency);
      print(stat);
    }
  });
}
