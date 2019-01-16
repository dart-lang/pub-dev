// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:args/args.dart';
import 'package:gcloud/db.dart';
import 'package:pool/pool.dart';
import 'package:pub_semver/pub_semver.dart';

import 'package:pub_dartlang_org/frontend/service_utils.dart';
import 'package:pub_dartlang_org/job/backend.dart';

Future main(List<String> args) async {
  final ArgParser parser = new ArgParser()
    ..addOption('runtime-version', help: 'The runtime version to set.')
    ..addOption('concurrency',
        defaultsTo: '10', help: 'The concurrency of the updates.')
    ..addFlag('reset',
        defaultsTo: false, help: 'Trigger re-processing of the jobs.');
  final argResults = parser.parse(args);
  final runtimeVersion = argResults['runtime-version'] as String;
  final int concurrency = int.parse(argResults['concurrency'] as String);
  final reset = argResults['reset'] as bool;

  if (runtimeVersion == null || runtimeVersion.isEmpty) {
    throw new Exception('--runtime-version must be set');
  }
  // check whether it can be parsed
  new Version.parse(runtimeVersion);

  final pool = new Pool(concurrency);
  final futures = <Future>[];

  Future update(Key key) async {
    await dbService.withTransaction((tx) async {
      final job = (await tx.lookup([key]))[0] as Job;
      job.runtimeVersion = runtimeVersion;
      job.lockedUntil = new DateTime.now();
      job.processingKey = null;
      if (reset) {
        job.state = JobState.available;
      }
      tx.queueMutations(inserts: [job]);
      await tx.commit();
    });
  }

  await withProdServices(() async {
    registerJobBackend(new JobBackend(dbService));

    final query = dbService.query<Job>();
    await for (Job job in query.run()) {
      if (reset || job.runtimeVersion != runtimeVersion) {
        futures.add(pool.withResource(() => update(job.key)));
      }
    }

    await Future.wait(futures);
  });
  await pool.close();
}
