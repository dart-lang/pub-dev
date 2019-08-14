// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:isolate';
import 'dart:math' as math;

import 'package:gcloud/db.dart' as db;
import 'package:logging/logging.dart';

import '../../analyzer/handlers.dart';
import '../../analyzer/pana_runner.dart';
import '../../job/backend.dart';
import '../../job/job.dart';
import '../../scorecard/backend.dart';
import '../../shared/handler_helpers.dart';
import '../../shared/popularity_storage.dart';
import '../../shared/scheduler_stats.dart';

import '../services.dart';

import '_gae_setup.dart';
import '_isolate.dart';

final Logger logger = Logger('pub.analyzer');
final _random = math.Random.secure();

Future main() async {
  Future workerSetup() async {
    await initFlutterSdk(logger);
  }

  await startIsolates(
    logger: logger,
    frontendEntryPoint: _frontendMain,
    workerSetup: workerSetup,
    workerEntryPoint: _workerMain,
  );
}

Future _frontendMain(FrontendEntryMessage message) async {
  setupServiceIsolate();

  final statsConsumer = ReceivePort();
  registerSchedulerStatsStream(statsConsumer.cast<Map>());
  message.protocolSendPort.send(FrontendProtocolMessage(
    statsConsumerPort: statsConsumer.sendPort,
  ));

  await withServices(() async {
    await runHandler(logger, analyzerServiceHandler);
  });
}

Future _workerMain(WorkerEntryMessage message) async {
  setupServiceIsolate();

  message.protocolSendPort.send(WorkerProtocolMessage());

  await withServices(() async {
    await popularityStorage.init();
    final jobProcessor = AnalyzerJobProcessor();
    final jobMaintenance = JobMaintenance(db.dbService, jobProcessor);

    Timer.periodic(const Duration(minutes: 15), (_) async {
      message.statsSendPort.send(await jobBackend.stats(JobService.analyzer));
    });

    // Run ScoreCard GC in the next 6 hours (randomized wait to reduce race).
    Timer(Duration(minutes: _random.nextInt(360)), () {
      scoreCardBackend.deleteOldEntries();
    });

    jobBackend.scheduleOldDataGC();
    await jobMaintenance.run();
  });
}
