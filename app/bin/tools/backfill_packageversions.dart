// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:args/args.dart';

import 'package:pub_dev/service/entrypoint/tools.dart';
import 'package:pub_dev/tool/backfill/backfill_packageversions.dart';

final _argParser = ArgParser()
  ..addOption('concurrency',
      abbr: 'c', defaultsTo: '1', help: 'Number of concurrent processing.')
  ..addOption('package', abbr: 'p', help: 'The package to backfill.')
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.');

Future main(List<String> args) async {
  final argv = _argParser.parse(args);
  if (argv['help'] as bool == true) {
    print('Usage: dart backfill_packageversions.dart');
    print(
        'Ensures a matching PackageVersionPubspec entity exists for each PackageVersion.');
    print(
        'Ensures a matching PackageVersionInfo entity exists for each PackageVersion.');
    print(
        'Ensures that PackageVersionAsset entities exists for each PackageVersion.');
    print(_argParser.usage);
    return;
  }

  final concurrency = int.parse(argv['concurrency'] as String);
  final package = argv['package'] as String;

  await withToolRuntime(() async {
    if (package != null) {
      final stat = await backfillAllVersionsOfPackage(package);
      print(stat);
    } else {
      final stat = await backfillAllVersionsOfPackages(concurrency);
      print(stat);
    }
  });
}
