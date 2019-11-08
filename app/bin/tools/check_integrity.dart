// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:args/args.dart';
import 'package:gcloud/db.dart';
import 'package:logging/logging.dart';

import 'package:pub_dev/shared/integrity.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';

final _argParser = ArgParser()
  ..addOption('concurrency',
      abbr: 'c', defaultsTo: '1', help: 'Number of concurrent processing.')
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.');

Future main(List<String> args) async {
  final argv = _argParser.parse(args);
  if (argv['help'] as bool == true) {
    print('Usage: dart check_integrity.dart');
    print(
        'Checks the integrity of the Datastore entries (e.g. all references are valid).');
    print(_argParser.usage);
    return;
  }

  final concurrency = int.parse(argv['concurrency'] as String);

  Logger.root.onRecord.listen((r) {
    print(
        '${r.time.toIso8601String()} [${r.level.toString().toUpperCase()}] ${r.message}');
  });

  await withProdServices(() async {
    final checker = IntegrityChecker(dbService, concurrency: concurrency);
    final problems = await checker.check();
    print('\nProblems detected: ${problems.length}\n');
    for (String line in problems) {
      print(line);
    }
  });
}
