// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:args/args.dart';
import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

import 'package:pub_dev/analyzer/pana_runner.dart';
import 'package:pub_dev/dartdoc/dartdoc_runner.dart';
import 'package:pub_dev/frontend/static_files.dart';
import 'package:pub_dev/job/job.dart';
import 'package:pub_dev/service/services.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/tool/test_profile/import_source.dart';
import 'package:pub_dev/tool/test_profile/importer.dart';
import 'package:pub_dev/tool/test_profile/models.dart';

import 'package:fake_pub_server/local_server_state.dart';

final _argParser = ArgParser()
  ..addOption('test-profile', help: 'The file to read the test profile from.')
  ..addFlag('analyze', help: 'Analyze the packages with pana and dartdoc.')
  ..addOption('data-file', help: 'The file to store the local state.');

Future<void> main(List<String> args) async {
  Logger.root.onRecord.listen((r) {
    print([
      r.time.toIso8601String(),
      r.toString(),
      r.error,
      r.stackTrace?.toString(),
    ].where((e) => e != null).join(' '));
  });

  final argv = _argParser.parse(args);
  final analyze = argv['analyze'] as bool;
  final profile = TestProfile.fromYaml(
    await File(argv['test-profile'] as String).readAsString(),
  );

  final archiveCachePath = p.join(
    resolveFakePubServerDirPath(),
    '.dart_tool',
    'pub-test-profile',
    'archives',
  );

  final state = LocalServerState(path: argv['data-file'] as String);

  await withFakeServices(
      configuration: Configuration.test(),
      datastore: state.datastore,
      storage: state.storage,
      fn: () async {
        // ignore: invalid_use_of_visible_for_testing_member
        await importProfile(
          profile: profile,
          source: ImportSource.fromPubDev(archiveCachePath: archiveCachePath),
        );

        if (analyze) {
          await _analyze();
        }
      });
  await state.save();
}

Future<void> _analyze() async {
  // pana
  await fork(() async {
    final jobProcessor = AnalyzerJobProcessor(aliveCallback: null);
    final jobMaintenance = JobMaintenance(dbService, jobProcessor);
    // ignore: invalid_use_of_visible_for_testing_member
    await jobMaintenance.scanUpdateAndRunOnce();
  });

  // dartdoc
  await fork(() async {
    final jobProcessor = DartdocJobProcessor(aliveCallback: null);
    final jobMaintenance = JobMaintenance(dbService, jobProcessor);
    // ignore: invalid_use_of_visible_for_testing_member
    await jobMaintenance.scanUpdateAndRunOnce();
  });
}
