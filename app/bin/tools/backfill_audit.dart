// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:args/args.dart';
import 'package:logging/logging.dart';

import 'package:pub_dev/service/entrypoint/tools.dart';
import 'package:pub_dev/tool/backfill/backfill_audit.dart';

final _logger = Logger('backfill_audit');

final _argParser = ArgParser()
  ..addOption('package', abbr: 'p', help: 'The package to backfill.')
  ..addOption('concurrency',
      defaultsTo: '1', abbr: 'c', help: 'The concurrency for packages.')
  ..addFlag('dry-run', abbr: 'n', help: 'Only scan Datastore.');

Future main(List<String> args) async {
  final argv = _argParser.parse(args);
  final package = argv['package'] as String?;
  final dryRun = argv['dry-run'] as bool?;
  final concurrency = int.parse(argv['concurrency'] as String);

  await withToolRuntime(() async {
    var count = 0;
    if (package != null) {
      count = await backfillAudit(package, dryRun);
    } else {
      count = await backfillAuditAll(concurrency, dryRun);
    }
    _logger.info('Total audit entities backfilled: $count');
  });
}
